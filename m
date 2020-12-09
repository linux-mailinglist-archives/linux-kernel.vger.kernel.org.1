Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DAC2D413F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgLILik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729339AbgLILik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607513833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMTe9C7qcftVcw8zf44iLqZBVP9hQiLfFpyxTSvwF5c=;
        b=bIk8SZpO3MvEoxj+mmFu5/fSOtM8pG9ZxP4gbNURlTRpjD9t5+335vvgX0tVcQP2ToQypQ
        jHSxBAv95MrM4oN6EhYljO02XNDFjVKxOk+c89HezAVGTedtU+lDO2+kaTAXTnGq2KNNVl
        PzZbffvNlvxPzhYgt/mPLBJ+kr4gZW4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-ygzw3gQkN_S9gwvSV8Xj2Q-1; Wed, 09 Dec 2020 06:37:11 -0500
X-MC-Unique: ygzw3gQkN_S9gwvSV8Xj2Q-1
Received: by mail-pf1-f199.google.com with SMTP id y2so902351pfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMTe9C7qcftVcw8zf44iLqZBVP9hQiLfFpyxTSvwF5c=;
        b=aLoVVwjspyQr3uOXV26lWUcrv6Z44wJpNvElfioyo8Knzr2dvG41yI8oqtP/x/cYz5
         /Fjkn2UkLaC4yGTx9No7Df9icCPH7d0TbVdTLYWMVY535kqaExSvKxWLjHRNbu3v2Jgn
         c+79dF4NOEABY7UdvoovrG7HTEqyN/+8JXH8X7IQ4XOFFWodgIaGRc1+L2AQ1MMA6Zw4
         pAe8dh/QvBcSWEDmlC1sd9RLFDBVC+37VKKJ2p0OolHubcE0oDgpdm1Lbwq9IiwkfREX
         jI4W+ApzQTgHobpo/QDR4+8O+N6jTh5tah3cQ33sl1PKkq/PHPuG3tUMWaVbbCj4I2lG
         5/9A==
X-Gm-Message-State: AOAM532Y58rB6Vngu68raA4sHTsvXZMPnRugJrwkwYZ2hk41tXJlTmXw
        w3G6G3ZKBbYxnnUR/QyxsyEjxLNlXXhYO9t4PwbassIbe9V/M3DJiCixiJJq+dUs/LJhHljpDXv
        f+bzxCzs5odOMf6CHo3jKFvd3
X-Received: by 2002:a63:5a52:: with SMTP id k18mr1586713pgm.407.1607513830120;
        Wed, 09 Dec 2020 03:37:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkrhAgNjRvpI+uz27vNND6MGzXsuOo53iWNCnYA8AUkRb5ViwDCwM2Ai865u+P15iUM9zcMg==
X-Received: by 2002:a63:5a52:: with SMTP id k18mr1586695pgm.407.1607513829922;
        Wed, 09 Dec 2020 03:37:09 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e31sm2307483pgb.16.2020.12.09.03.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:37:09 -0800 (PST)
Date:   Wed, 9 Dec 2020 19:36:58 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] erofs: force inplace I/O under low memory scenario
Message-ID: <20201209113658.GA115396@xiangao.remote.csb>
References: <20201208054600.16302-1-hsiangkao.ref@aol.com>
 <20201208054600.16302-1-hsiangkao@aol.com>
 <85f41db3-8d64-240a-7876-9f3b3dea29cb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85f41db3-8d64-240a-7876-9f3b3dea29cb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Dec 09, 2020 at 06:07:08PM +0800, Chao Yu wrote:
> On 2020/12/8 13:46, Gao Xiang wrote:

...

> >   	bool standalone = true;
> > +	gfp_t gfp = mapping_gfp_constraint(mc, GFP_KERNEL) & ~__GFP_DIRECT_RECLAIM;
> 
> Could be local as there is only one place uses it.

This line is somewhat too long, I have no idea how to deal
with it inlined properly... I think I might leave it as-is
or find a better way to fold in it without generating too
long lines....

Thanks,
Gao Xiang

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >   	if (clt->mode < COLLECT_PRIMARY_FOLLOWED)
> >   		return;
> > @@ -168,6 +175,7 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   	for (; pages < pcl->compressed_pages + clusterpages; ++pages) {
> >   		struct page *page;
> >   		compressed_page_t t;
> > +		struct page *newpage = NULL;
> >   		/* the compressed page was loaded before */
> >   		if (READ_ONCE(*pages))
> > @@ -179,7 +187,17 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   			t = tag_compressed_page_justfound(page);
> >   		} else if (type == DELAYEDALLOC) {
> >   			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
> > +		} else if (type == TRYALLOC) {
> > +			gfp |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> > +
> > +			newpage = erofs_allocpage(pagepool, gfp);
> > +			if (!newpage)
> > +				goto dontalloc;
> > +
> > +			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
> > +			t = tag_compressed_page_justfound(newpage);
> >   		} else {	/* DONTALLOC */
> > +dontalloc:
> >   			if (standalone)
> >   				clt->compressedpages = pages;
> >   			standalone = false;
> > @@ -189,8 +207,12 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
> >   		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
> >   			continue;
> > -		if (page)
> > +		if (page) {
> >   			put_page(page);
> > +		} else if (newpage) {
> > +			set_page_private(newpage, 0);
> > +			list_add(&newpage->lru, pagepool);
> > +		}
> >   	}
> >   	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
> > @@ -560,7 +582,7 @@ static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
> >   }
> >   static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > -				struct page *page)
> > +				struct page *page, struct list_head *pagepool)
> >   {
> >   	struct inode *const inode = fe->inode;
> >   	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
> > @@ -613,11 +635,12 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >   	/* preload all compressed pages (maybe downgrade role if necessary) */
> >   	if (should_alloc_managed_pages(fe, sbi->ctx.cache_strategy, map->m_la))
> > -		cache_strategy = DELAYEDALLOC;
> > +		cache_strategy = TRYALLOC;
> >   	else
> >   		cache_strategy = DONTALLOC;
> > -	preload_compressed_pages(clt, MNGD_MAPPING(sbi), cache_strategy);
> > +	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > +				 cache_strategy, pagepool);
> >   hitted:
> >   	/*
> > @@ -1011,6 +1034,16 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   	justfound = tagptr_unfold_tags(t);
> >   	page = tagptr_unfold_ptr(t);
> > +	/*
> > +	 * preallocated cached pages, which is used to avoid direct reclaim
> > +	 * otherwise, it will go inplace I/O path instead.
> > +	 */
> > +	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
> > +		WRITE_ONCE(pcl->compressed_pages[nr], page);
> > +		set_page_private(page, 0);
> > +		tocache = true;
> > +		goto out_tocache;
> > +	}
> >   	mapping = READ_ONCE(page->mapping);
> >   	/*
> > @@ -1073,7 +1106,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
> >   		cond_resched();
> >   		goto repeat;
> >   	}
> > -
> > +out_tocache:
> >   	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
> >   		/* turn into temporary page if fails */
> >   		set_page_private(page, Z_EROFS_SHORTLIVED_PAGE);
> > @@ -1282,7 +1315,7 @@ static int z_erofs_readpage(struct file *file, struct page *page)
> >   	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
> > -	err = z_erofs_do_read_page(&f, page);
> > +	err = z_erofs_do_read_page(&f, page, &pagepool);
> >   	(void)z_erofs_collector_end(&f.clt);
> >   	/* if some compressed cluster ready, need submit them anyway */
> > @@ -1336,7 +1369,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
> >   		/* traversal in reverse order */
> >   		head = (void *)page_private(page);
> > -		err = z_erofs_do_read_page(&f, page);
> > +		err = z_erofs_do_read_page(&f, page, &pagepool);
> >   		if (err)
> >   			erofs_err(inode->i_sb,
> >   				  "readahead error at page %lu @ nid %llu",
> > 
> 

