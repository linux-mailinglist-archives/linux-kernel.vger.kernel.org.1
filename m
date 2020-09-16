Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2926CD51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgIPU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:57:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgIPQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f48/ra56w9B62BBt1KxgQmjI18k2gbv7FH5W25ynCbY=;
        b=Jxejz/39hX8Etd2wKUwmvzfvHhM3k2eRMjkAYUxRnVrnzuinZb+0l6vrCE9ZEEQAOxnbfN
        1UKfXDSMiaSuCvC6j+91wYuPlG+xzZo1O9PQ39ZMCt4C8s5xVaNSavQCrqnNfgjmKB5JpT
        1HvFPmrLDpoUKhmbHeYijZXlHkH6I9Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-t2RRroz9NXW14a84qgs8pQ-1; Wed, 16 Sep 2020 10:33:16 -0400
X-MC-Unique: t2RRroz9NXW14a84qgs8pQ-1
Received: by mail-pl1-f199.google.com with SMTP id p24so3366331plq.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f48/ra56w9B62BBt1KxgQmjI18k2gbv7FH5W25ynCbY=;
        b=NNMJn0xzymioYXhqjv8KueQseHiSadaYqa7ItzcLxdz8ljHR1GysW91j2oNhokALRE
         sIQRzYx1XnXJ4edcRNy13taGeyxzcUOKufr1nIXr3e7Zb6KxPuYiJ5ZsnZAFIAwuajpm
         zqfB4cX9TZ9AZ06gVI/MfyAJ5fEaB9Q2MtIJ2SEN4RqtEBuCPDpDnAWVwGwSwRQZaEY0
         kZp7e5rf6Sok8iZYusP0pkl2Z3l1X7y6zfoadeu/HYZ8e6vYJ9pVbgxCPHTM9QUpyJ0V
         wWQsDn3YIcdwXRv1txaOwoo5I2o2IqLYH8iUC7Rjhp91ja72nH/pGXetsr3quFZn6QwW
         40JA==
X-Gm-Message-State: AOAM531B4knvgUbDhfQSwYbRZ9DRUkYTxa4/xTOEq5aDxXi6N6vMCH+c
        odCiDBh39mQmOox7t/MSXZlbt6CT46lrgwqLLnc3576XYtUcNIPzLmMHRj+HPx6m7H0fFGu6cHg
        qczT0YwFczI9y+gaeCmw8b5rd
X-Received: by 2002:a17:90b:3c7:: with SMTP id go7mr4171138pjb.97.1600266794908;
        Wed, 16 Sep 2020 07:33:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHH2Cu+A6m25LC2Er3YghzATjk7FFDZK//oX57Fg5jRTz7kqdKqb5euQfouEwGEccpx5K+FQ==
X-Received: by 2002:a17:90b:3c7:: with SMTP id go7mr4171115pjb.97.1600266794661;
        Wed, 16 Sep 2020 07:33:14 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c22sm14544442pgb.52.2020.09.16.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:33:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 22:33:04 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: remove unneeded parameter
Message-ID: <20200916143304.GA23176@xiangao.remote.csb>
References: <20200916140604.3799-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916140604.3799-1-chao@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Sep 16, 2020 at 10:06:04PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> In below call path, no page will be cached into @pagepool list
> or grabbed from @pagepool list:
> - z_erofs_readpage
>  - z_erofs_do_read_page
>   - preload_compressed_pages
>   - erofs_allocpage
> 
> Let's get rid of this unneeded parameter.

That would be unneeded after .readahead() is introduced recently
(so add_to_page_cache_lru() is also moved to mm code), so I agree
with you on it.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/erofs/utils.c |  2 +-
>  fs/erofs/zdata.c | 14 ++++++--------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
> index de9986d2f82f..7a6e5456b0b8 100644
> --- a/fs/erofs/utils.c
> +++ b/fs/erofs/utils.c
> @@ -11,7 +11,7 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
>  {
>  	struct page *page;
>  
> -	if (!list_empty(pool)) {
> +	if (pool && !list_empty(pool)) {
>  		page = lru_to_page(pool);
>  		DBG_BUGON(page_ref_count(page) != 1);
>  		list_del(&page->lru);
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 6c939def00f9..f218f58f4159 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -153,8 +153,7 @@ static DEFINE_MUTEX(z_pagemap_global_lock);
>  
>  static void preload_compressed_pages(struct z_erofs_collector *clt,
>  				     struct address_space *mc,
> -				     enum z_erofs_cache_alloctype type,
> -				     struct list_head *pagepool)
> +				     enum z_erofs_cache_alloctype type)
>  {
>  	const struct z_erofs_pcluster *pcl = clt->pcl;
>  	const unsigned int clusterpages = BIT(pcl->clusterbits);
> @@ -562,8 +561,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
>  }
>  
>  static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> -				struct page *page,
> -				struct list_head *pagepool)
> +				struct page *page)
>  {
>  	struct inode *const inode = fe->inode;
>  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> @@ -621,7 +619,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		cache_strategy = DONTALLOC;
>  
>  	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> -				 cache_strategy, pagepool);
> +				 cache_strategy);
>  
>  hitted:
>  	/*
> @@ -653,7 +651,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  	/* should allocate an additional staging page for pagevec */
>  	if (err == -EAGAIN) {
>  		struct page *const newpage =
> -			erofs_allocpage(pagepool, GFP_NOFS | __GFP_NOFAIL);
> +			erofs_allocpage(NULL, GFP_NOFS | __GFP_NOFAIL);

Could we use allocpage instead, so erofs_allocpage modification is unneeded as well :)

Thanks,
Gao Xiang

