Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538262CC286
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbgLBQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgLBQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:36:31 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753DCC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:35:09 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id es6so973032qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hAyW+JiNSbp72nZBWsfmIBRqBtiOCYtYCN54NjZjGM=;
        b=KAmCkI3XgKwS7JrjNjdZixSGStpnUIsz+GAuDutpC16uLJxjKM5vZ7OdkDQVk1sw9U
         NegzZCzRgbgGy+fH/inFmM2HbgGW4E584g3f2OkY1IqOSG75YqdDEA5gUViIJDu4izfZ
         nSZzp3MtaFdYC4zitfa8xX1DoGZR4H3VOaDFmg37NcXRtLrBPWx55G0abBTm/YgpsGPT
         Sv9IGEXeqNvJr61wSOPEsl99SYVYhbk8nPpjHMM0Mt0cSA5sveO7C2qBCJ1Ih1o4BULU
         5LGBdQY29XB5mv30AiAAU+fTtU2DLFHTID6asouveENswHVa5sglFe1+dvr54oMNI/iS
         ZQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hAyW+JiNSbp72nZBWsfmIBRqBtiOCYtYCN54NjZjGM=;
        b=PvseEvHnEqcBpUKKz6ebdEL4xfqjzYPyAgEUeOl7H8mnOWzo7WFDNAGYbPLsfxGnA8
         1LN6T1GRw+yuHIsTe68/fcBXVG16oa9HCEVB+MN/f2nqbZTfQVDyOR/pWfgUzdqHhqc0
         kUcGr8114mYfSSmuKuJZuVkP/B1znoBDKnaMIHaKvQeo1OgSb8DHKcw6tl+K0yehmEVa
         AbE3cJy9Nh1BSuIh0WxlQFlUesYJOezhyJcqbJJt2/v59eO/UNWsCt2gAN1k3nGrwptI
         6CzvABa7a6Owcnt6yYYSRnuwmu/aOJ7PpCFNjbswCSqu5MT8G09Z8ftwpFBWgf7uf3f9
         1ppA==
X-Gm-Message-State: AOAM531TaQ7+ZyM1P2Phx0uTAcZE11p1l/6R8Y+85e4JN7WEQZunqyOH
        zfZSGIFZ/cyDSPmvKRcX2bU3/g==
X-Google-Smtp-Source: ABdhPJz+w3PD/20ZuVEbzMNHbrzOS0CXXEVsymIuorDzL/MwlGuCgFmrTe2bMzh8hjFdkNy+up2PkQ==
X-Received: by 2002:a0c:b3d6:: with SMTP id b22mr3263441qvf.10.1606926908608;
        Wed, 02 Dec 2020 08:35:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n21sm2246937qke.32.2020.12.02.08.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 08:35:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kkV5v-0056oY-G4; Wed, 02 Dec 2020 12:35:07 -0400
Date:   Wed, 2 Dec 2020 12:35:07 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, osalvador@suse.de, dan.j.williams@intel.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        mgorman@suse.de, willy@infradead.org, rientjes@google.com,
        jhubbard@nvidia.com
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201202163507.GL5487@ziepe.ca>
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202052330.474592-7-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 12:23:30AM -0500, Pavel Tatashin wrote:
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/gup.c b/mm/gup.c
> index 724d8a65e1df..1d511f65f8a7 100644
> +++ b/mm/gup.c
> @@ -1593,19 +1593,18 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  }
>  #endif
>  
> -#ifdef CONFIG_CMA
> -static long check_and_migrate_cma_pages(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long nr_pages,
> -					struct page **pages,
> -					struct vm_area_struct **vmas,
> -					unsigned int gup_flags)
> +static long check_and_migrate_movable_pages(struct mm_struct *mm,
> +					    unsigned long start,
> +					    unsigned long nr_pages,
> +					    struct page **pages,
> +					    struct vm_area_struct **vmas,
> +					    unsigned int gup_flags)
>  {
>  	unsigned long i;
>  	unsigned long step;
>  	bool drain_allow = true;
>  	bool migrate_allow = true;
> -	LIST_HEAD(cma_page_list);
> +	LIST_HEAD(page_list);
>  	long ret = nr_pages;
>  	struct migration_target_control mtc = {
>  		.nid = NUMA_NO_NODE,
> @@ -1623,13 +1622,12 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  		 */
>  		step = compound_nr(head) - (pages[i] - head);
>  		/*
> -		 * If we get a page from the CMA zone, since we are going to
> -		 * be pinning these entries, we might as well move them out
> -		 * of the CMA zone if possible.
> +		 * If we get a movable page, since we are going to be pinning
> +		 * these entries, try to move them out if possible.
>  		 */
> -		if (is_migrate_cma_page(head)) {
> +		if (is_migrate_movable(get_pageblock_migratetype(head))) {
>  			if (PageHuge(head))

It is a good moment to say, I really dislike how this was implemented
in the first place.

Scanning the output of gup just to do the is_migrate_movable() test is
kind of nonsense and slow. It would be better/faster to handle this
directly while gup is scanning the page tables and adding pages to the
list.

Now that this becoming more general, can you take a moment to see if a
better implementation could be possible?

Also, something takes care of the gup fast path too?

Jason
