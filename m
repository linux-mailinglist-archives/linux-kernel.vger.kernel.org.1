Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4009F25E15C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIDSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 14:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgIDSJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:09:40 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3D12074A;
        Fri,  4 Sep 2020 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599242980;
        bh=N8LVGiLGeSISjLSKzJzoAVbjyLXQ1OkgiG0m6g34uxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NZP8LJ1O2HOiR53LSId8DQCa3O5d4LfVHPeAWWirXzQ2FJxZbYWjkULFLShHkaWEd
         sXoXjjTMeK9UqVWDRUNv1XVc20QtWDsq/akjiTk59zZks7AdssQFCHYaUDDBT7BZQQ
         Wcj3bE7beghhYl5ay+Qe28wEJFB4x+81SrX7s1vU=
Date:   Fri, 4 Sep 2020 11:09:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Subject: Re: [PATCH RFC] mm: Let readahead submit larger batches of pages in
 case of ra->ra_pages == 0
Message-Id: <20200904110938.d9a2cb53a58e67a15c960f47@linux-foundation.org>
In-Reply-To: <20200904144807.31810-1-huobean@gmail.com>
References: <20200904144807.31810-1-huobean@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Sep 2020 16:48:07 +0200 Bean Huo <huobean@gmail.com> wrote:

> From: Bean Huo <beanhuo@micron.com>
> 
> Current generic_file_buffered_read() will break up the larger batches of pages
> and read data in single page length in case of ra->ra_pages == 0. This patch is
> to allow it to pass the batches of pages down to the device if the supported
> maximum IO size >= the requested size.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2062,6 +2062,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  	struct file *filp = iocb->ki_filp;
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> +	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
>  	struct file_ra_state *ra = &filp->f_ra;
>  	loff_t *ppos = &iocb->ki_pos;
>  	pgoff_t index;
> @@ -2098,9 +2099,14 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		if (!page) {
>  			if (iocb->ki_flags & IOCB_NOIO)
>  				goto would_block;
> -			page_cache_sync_readahead(mapping,
> -					ra, filp,
> -					index, last_index - index);
> +
> +			if (!ra->ra_pages && bdi->io_pages >= last_index - index)
> +				__do_page_cache_readahead(mapping, filp, index,
> +							  last_index - index, 0);
> +			else
> +				page_cache_sync_readahead(mapping, ra, filp,
> +							  index,
> +							  last_index - index);
>  			page = find_get_page(mapping, index);
>  			if (unlikely(page == NULL))
>  				goto no_cached_page;

I assume this is a performance patch.  What are the observed changes in
behaviour?

What is special about ->ra_pages==0?  Wouldn't this optimization still
be valid if ->ra_pages==2?

Doesn't this defeat the purpose of having ->ra_pages==0?
