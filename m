Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D835B29835D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418525AbgJYTYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418518AbgJYTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 15:24:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546ADC061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 12:24:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so3626330pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v0qMtD14nA7HrLM/MdCWb6JdQx3iF+CcKyq2qfja9yM=;
        b=hmjLI5PQcBXCIPYFwrcxxUyn+bgIfTT5+1VUIwMieE8zkTZfem26vmyWR4YX1M/giX
         dvWay5fp3eZthz10ozJ1y0/AbyD5Jd8BLlfTpCc/qEPANy1KAMyKvUKIycQppnGXJKrR
         aU57HbNxDrt/SgCcXslXpU7zkXvMA5m0kLXVaKgK2b9EFSYj67pWwMfruUwnqloyDGkq
         J2y8p7IASijC+JTKB+QAJPZFFtvrZQ3XXnkBnkiKnuAnnb+H/0D7ExliNgQ4iLNdeFBk
         3eorHoS3ooNfCzAZ8JGwuaMAiTNqwc4taevCMMUouogboNGIyRcau93d7MMGjqk9pmuX
         fWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v0qMtD14nA7HrLM/MdCWb6JdQx3iF+CcKyq2qfja9yM=;
        b=dFaZrjXWD7hoc6KDyZDiu0gjHsQt4ddrRgXtEPcqwFVFoYh4bapEgca3n0C9Bo9y1J
         m7bZLYAjyL9tSi1i9bN/toFYBt/7uKr7UgSrJjgAF9xFQIuSMvBzkpTxdkA5NsLQkcCU
         SALUtRJroX1kXdxMiwP79Z+Zlp+c4zBCIZc4e8Y7ftURH9wsPlGWU3WYRATD0Q6gxS/u
         jub9FWs6weKjT4eHG0NXQglqEUC6vy3cLOo52FCmwidtvP6llcHZzSjN7n/ho4VwLWV5
         F4IHHxKsMHBFfsW/pF3crI6EOoD3Bc2XNpJt1gd0rg41sTDICk1y1OsYsb3jHudxIOWh
         ilKQ==
X-Gm-Message-State: AOAM533wIgLeEf0+as5WG/MSzDiy7iPsoQggHaLI3yjqEbSasvg9eGMH
        0OYd/9Vz0/ydB5Fyf2lnHvjyH7QG0dXzsA==
X-Google-Smtp-Source: ABdhPJzzmw93U0N+QGMOqFiV/h0ffhblCS3IHUxDYgjlyEE9myUO6NMBDbnxhpz10IVfYfomSrgMzA==
X-Received: by 2002:a17:90a:ab86:: with SMTP id n6mr15996092pjq.82.1603653849636;
        Sun, 25 Oct 2020 12:24:09 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x2sm9718314pfc.133.2020.10.25.12.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 12:24:08 -0700 (PDT)
Subject: Re: [PATCH] mm: bio_alloc never fails when set GFP_NOIO, GFP_KERNEL
To:     Andrew Morton <akpm@linux-foundation.org>,
        Xianting Tian <tian.xianting@h3c.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201021031128.14100-1-tian.xianting@h3c.com>
 <20201025120907.699d178b9d27be114e338680@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <53ffff64-da56-7911-ff95-9201476de9e4@kernel.dk>
Date:   Sun, 25 Oct 2020 13:24:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025120907.699d178b9d27be114e338680@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/20 1:09 PM, Andrew Morton wrote:
> On Wed, 21 Oct 2020 11:11:28 +0800 Xianting Tian <tian.xianting@h3c.com> wrote:
> 
>> bio_alloc with __GFP_DIRECT_RECLAIM(which is included in GFP_NOIO,
>> GFP_KERNEL) never fails, as stated in the comments of bio_alloc_bioset.
>>
>> So we can remove multiple unneeded null checks of bio_alloc and simplify
>> the code.
>>
>> We have done it in fs/ext4/readpage.c, fs/ext4/page-io.c, fs/direct-io.c,
>> and so forth.
>>
> 
> (cc Jens)
> 
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -30,18 +30,20 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
>>  				struct page *page, bio_end_io_t end_io)
>>  {
>>  	struct bio *bio;
>> +	struct block_device *bdev;
>>  
>> +	/*
>> +	 * bio_alloc will _always_ be able to allocate a bio if
>> +	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
>> +	 */
>>  	bio = bio_alloc(gfp_flags, 1);
>> -	if (bio) {
>> -		struct block_device *bdev;
>> +	bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
>> +	bio_set_dev(bio, bdev);
>> +	bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>> +	bio->bi_end_io = end_io;
>>  
>> -		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
>> -		bio_set_dev(bio, bdev);
>> -		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
>> -		bio->bi_end_io = end_io;
>> +	bio_add_page(bio, page, thp_size(page), 0);
>>  
>> -		bio_add_page(bio, page, thp_size(page), 0);
>> -	}
>>  	return bio;
>>  }
>>  
>> @@ -351,19 +353,13 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
>>  
>>  	ret = 0;
>>  	bio = get_swap_bio(GFP_NOIO, page, end_write_func);
>> -	if (bio == NULL) {
>> -		set_page_dirty(page);
>> -		unlock_page(page);
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>>  	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
>>  	bio_associate_blkg_from_page(bio, page);
>>  	count_swpout_vm_event(page);
>>  	set_page_writeback(page);
>>  	unlock_page(page);
>>  	submit_bio(bio);
>> -out:
>> +
>>  	return ret;
>>  }
>>  
>> @@ -416,11 +412,6 @@ int swap_readpage(struct page *page, bool synchronous)
>>  
>>  	ret = 0;
>>  	bio = get_swap_bio(GFP_KERNEL, page, end_swap_bio_read);
>> -	if (bio == NULL) {
>> -		unlock_page(page);
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>>  	disk = bio->bi_disk;
>>  	/*
>>  	 * Keep this task valid during swap readpage because the oom killer may
> 
> I'm reluctant to remove these checks - yours is a fairly subtle
> discovery and things might change in the future.  Intentionally or
> otherwise!

On the block/bio side, it all boils down to the mempool backing of the
bio allocations. If __GFP_DIRECT_RECLAIM is set for that, then we'll
always wait on allocations for a bio. That is intentional, by design, to
guarantee forward progress. It used to be __GFP_WAIT based, but I guess
that changed at some point...

-- 
Jens Axboe

