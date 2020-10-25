Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D3298351
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 20:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418451AbgJYTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 15:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418418AbgJYTJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 15:09:09 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C29322260;
        Sun, 25 Oct 2020 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603652948;
        bh=ddZPlRqimDU7rLmpMhXbvcFt4mtSB1kneJwidpS5uPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vRYoT5LyFwn/q/sz2HWHGF270bB/S51nax4AnxJMRmBlrRExFv/DILuauxfgVynMz
         Ez6EbZ4vSpOe7R99yfmwyCwIOEoI3NOJfh15aFGqKx4Qa0hdRWv7zyfR8ahPjIvO5e
         alxd0EOirg9UEbC+NLsd4hbhPMbO2C6P5yfYSuus=
Date:   Sun, 25 Oct 2020 12:09:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: bio_alloc never fails when set GFP_NOIO, GFP_KERNEL
Message-Id: <20201025120907.699d178b9d27be114e338680@linux-foundation.org>
In-Reply-To: <20201021031128.14100-1-tian.xianting@h3c.com>
References: <20201021031128.14100-1-tian.xianting@h3c.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 11:11:28 +0800 Xianting Tian <tian.xianting@h3c.com> wrote:

> bio_alloc with __GFP_DIRECT_RECLAIM(which is included in GFP_NOIO,
> GFP_KERNEL) never fails, as stated in the comments of bio_alloc_bioset.
> 
> So we can remove multiple unneeded null checks of bio_alloc and simplify
> the code.
> 
> We have done it in fs/ext4/readpage.c, fs/ext4/page-io.c, fs/direct-io.c,
> and so forth.
> 

(cc Jens)

> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -30,18 +30,20 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>  				struct page *page, bio_end_io_t end_io)
>  {
>  	struct bio *bio;
> +	struct block_device *bdev;
>  
> +	/*
> +	 * bio_alloc will _always_ be able to allocate a bio if
> +	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
> +	 */
>  	bio = bio_alloc(gfp_flags, 1);
> -	if (bio) {
> -		struct block_device *bdev;
> +	bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
> +	bio_set_dev(bio, bdev);
> +	bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
> +	bio->bi_end_io = end_io;
>  
> -		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
> -		bio_set_dev(bio, bdev);
> -		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
> -		bio->bi_end_io = end_io;
> +	bio_add_page(bio, page, thp_size(page), 0);
>  
> -		bio_add_page(bio, page, thp_size(page), 0);
> -	}
>  	return bio;
>  }
>  
> @@ -351,19 +353,13 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
>  
>  	ret = 0;
>  	bio = get_swap_bio(GFP_NOIO, page, end_write_func);
> -	if (bio == NULL) {
> -		set_page_dirty(page);
> -		unlock_page(page);
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>  	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
>  	bio_associate_blkg_from_page(bio, page);
>  	count_swpout_vm_event(page);
>  	set_page_writeback(page);
>  	unlock_page(page);
>  	submit_bio(bio);
> -out:
> +
>  	return ret;
>  }
>  
> @@ -416,11 +412,6 @@ int swap_readpage(struct page *page, bool synchronous)
>  
>  	ret = 0;
>  	bio = get_swap_bio(GFP_KERNEL, page, end_swap_bio_read);
> -	if (bio == NULL) {
> -		unlock_page(page);
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>  	disk = bio->bi_disk;
>  	/*
>  	 * Keep this task valid during swap readpage because the oom killer may

I'm reluctant to remove these checks - yours is a fairly subtle
discovery and things might change in the future.  Intentionally or
otherwise!
