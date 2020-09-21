Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1A273218
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgIUSmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgIUSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:42:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8593C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:42:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so9822050pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GC8sasDcUUtfwQI8cKe8C4MyvaXt20t2jZSBkvmxcKE=;
        b=PJIO62ljOyN+1oeIjex1hvkPe/kAXRdHMt2EuQnA7LXWMDOfzFJMe9X1NF6dCxKuIh
         EhFxtVsOp5Dj9ZEIJWRwPrIwHfaaa+nrRPykZYIAImOwzeCkt2RIpZu/a8MFyx/1HUYu
         JPeseNB397GZY/NIsuxhnZcN+rfWQhgzOB3CbDYGMxzldcRBPGGrvGQLvcSbfPtCzSnN
         8IpqjPYrO7za6eiQMYDcaiwTFY5V0R0Up+iputxQPdeN3wyYPyeJeDCwnYfUzTuu39gr
         zSX+fTMi1+vbhHa3PM7rwXb3APyjh8XPjYeiQH8eQIRJUs0AbvMttuiUz20Vdld2OX3J
         Dteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GC8sasDcUUtfwQI8cKe8C4MyvaXt20t2jZSBkvmxcKE=;
        b=XqL9aru3P+a/rpPgNwqbEtpvk4EpFIWpoQIqnhsvt2fapV7MlUKdjXYpJgnJjpn2hL
         cV4iLFDLlLYkgTX9/SodIHBxDMsRS+W8iLVt1EPDHgfTk3n4Y8+AsN/JSUY/QTO8dtUx
         fcGsZ4faWfT01rB1NybyqaLnOMiufHzP9wItiWnGXYARQtfUId5jbTP8oGdxVxvpTHhR
         NyavUmO7Ym+w+OkrSYOEM0LPp6c2umH0P3GCwx7ESKxitXzeeEh9JmmiCWswh+0edORO
         Op+cEDVWt+Q6C+NMP+4GcCvMqsXzokinRENtG6Bbyc38YTM+O8X5teUInV+Vl00QrWvj
         PSAQ==
X-Gm-Message-State: AOAM531VjG6Ixuw4YEGDwilTyr7X2wBcDf7ramrkAOtJQoJ6rfB46dI7
        upag64LMuYqevIU0gQksUV4=
X-Google-Smtp-Source: ABdhPJyIYDaB5wxRnaHeVNF92ISZZsgvCaNReLLtTysYEz7UGmPMJ8HW/tA7CIa5ivCFQs4Qv4vx5Q==
X-Received: by 2002:aa7:8a46:0:b029:142:2501:398a with SMTP id n6-20020aa78a460000b02901422501398amr993477pfa.79.1600713752207;
        Mon, 21 Sep 2020 11:42:32 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id i25sm13004358pgi.9.2020.09.21.11.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 11:42:31 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Sep 2020 11:42:29 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/6] zsmalloc: switch from alloc_vm_area to get_vm_area
Message-ID: <20200921184229.GA422329@google.com>
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-2-hch@lst.de>
 <20200921174256.GA387368@google.com>
 <20200921181708.GA2067@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921181708.GA2067@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 08:17:08PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 10:42:56AM -0700, Minchan Kim wrote:
> > IIRC, the problem was runtime pte popluating needs GFP_KERNEL but
> > zs_map_object API runs under non-preemtible section.
> 
> Make sense.
> 
> > > -	area->vm = alloc_vm_area(PAGE_SIZE * 2, NULL);
> > > +	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
> > >  	if (!area->vm)
> > >  		return -ENOMEM;
> > >  	return 0;
> > 
> > I think it shoud work.
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 05789aa4af12..6a1e4d854593 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2232,7 +2232,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >  	arch_enter_lazy_mmu_mode();
> >  
> >  	do {
> > -		if (create || !pte_none(*pte)) {
> > +		if ((create || !pte_none(*pte)) && fn) {
> >  			err = fn(pte++, addr, data);
> >  			if (err)
> >  				break;
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 3e4fe3259612..9ef7daf3d279 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -1116,6 +1116,8 @@ static struct zspage *find_get_zspage(struct size_class *class)
> >  #ifdef CONFIG_ZSMALLOC_PGTABLE_MAPPING
> >  static inline int __zs_cpu_up(struct mapping_area *area)
> >  {
> > +	int ret;
> > +
> >  	/*
> >  	 * Make sure we don't leak memory if a cpu UP notification
> >  	 * and zs_init() race and both call zs_cpu_up() on the same cpu
> > @@ -1125,7 +1127,13 @@ static inline int __zs_cpu_up(struct mapping_area *area)
> >  	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
> >  	if (!area->vm)
> >  		return -ENOMEM;
> > -	return 0;
> > +
> > +	/*
> > +	 * Populate ptes in advance to avoid pte allocation with GFP_KERNEL
> > +	 * in non-preemtible context of zs_map_object.
> > +	 */
> > +	ret = apply_to_page_range(&init_mm, NULL, PAGE_SIZE * 2, NULL, NULL);
> > +	return ret;
> 
> I think this needs the addr from the vm area somewhere..

Yeah, let's assign the addres we got get_vm_area.

> 
> We probaby want to add a trivial helper to prefault an area instead of
> the open coded variant.

It seems zsmalloc is only customer the function so let's have the helper
when we see another customer.

If we don't have objection, I'd like to ask to Andrew fold this up.

---
 mm/memory.c   | 2 +-
 mm/zsmalloc.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 05789aa4af12..6a1e4d854593 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2232,7 +2232,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 	arch_enter_lazy_mmu_mode();
 
 	do {
-		if (create || !pte_none(*pte)) {
+		if ((create || !pte_none(*pte)) && fn) {
 			err = fn(pte++, addr, data);
 			if (err)
 				break;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3e4fe3259612..918c7b019b3d 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1125,7 +1125,13 @@ static inline int __zs_cpu_up(struct mapping_area *area)
 	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
 	if (!area->vm)
 		return -ENOMEM;
-	return 0;
+
+	/*
+	 * Populate ptes in advance to avoid pte allocation with GFP_KERNEL
+	 * in non-preemtible context of zs_map_object.
+	 */
+	return apply_to_page_range(&init_mm, (unsigned long)area->vm->addr,
+			PAGE_SIZE * 2, NULL, NULL);
 }
 
 static inline void __zs_cpu_down(struct mapping_area *area)
-- 
2.28.0.681.g6f77f65b4e-goog

