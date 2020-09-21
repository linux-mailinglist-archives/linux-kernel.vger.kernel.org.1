Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1799E2730FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIURnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbgIURnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:43:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:43:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u13so9692059pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QtMGv9Az8n8/1NHjLi6o0NjvgH4+/FeF5Ci7mHb3HKk=;
        b=C7h6inMmXViVfdzLNOvFuTTw5gDP/PsNQbK7XEZloBeiZ8TI/21zMOjn7CNA+2JpdR
         fcqHDQGOwu00JGZ24OItIms+ocEi5vn4ArXzVIiiv3IsrWX58V+/xvf5GAM6uWt45WHV
         J5uOcJSwwSsyQG3DI06e7LXhdO9u9oPEpVS+RmLizgAmeHXs0yGsQU1nOXkBOVIfgxKA
         R2QFqMXS/jWK8IGcmqN0UiZJVAO1wKzNqskrF4+I7n3VyZXcnkek4EZphD0W4XzFqzOv
         ok0cZ2Pc39gKnqlEn4+P3Rhkp0HO3HdeqOVIlHDzJsQPR318T1EvvNwcSWIeqku82piy
         vqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QtMGv9Az8n8/1NHjLi6o0NjvgH4+/FeF5Ci7mHb3HKk=;
        b=MSoC0+UiDqlc+7MjWFYvOj2WXiUPDz7pT1vrZhL1rCfUXKVdF6NQXxFkAWtVPi881A
         dZfRUVrGV7DTy/aKeLbfjALYFzRdfq2SjgMbrX0O+2/U1pJ6NY2cAURrxG57HjetTqaE
         bRIyPtAlag5o1Lgg6hKJE1rBO/hSQyVDICqKRFtRT6nWCBa1GiJxUScTSN1VLbzkR+sm
         9Ml7UznJb6akHB+22xRnI6vt6PFOLNa/QbK38NXWLr2J8lj4kEbgOK69MovMIWeMI05g
         3/WDDhfO3RCO7DqEayZWV6j/c6JYFXMUpYiR7Fjf5vQcc92MjxEyDj8y17Oxj2FJ67rv
         1IRA==
X-Gm-Message-State: AOAM532GrtjSeUqKLZYRBN9vYabV+Re5f83Vnr4clPxItM4mPxsP9cLP
        9UnaSA6tmJaMdn4IBiJGKcQ=
X-Google-Smtp-Source: ABdhPJz3bQvQ0y+Tkl35pFZsVWVp7/jEG6xMj1AV8L7OC4sV/ELLhXdmGbDdT9tBGrtDXWjgu18MoQ==
X-Received: by 2002:a17:902:8695:b029:d2:29b:991a with SMTP id g21-20020a1709028695b02900d2029b991amr1034190plo.80.1600710179810;
        Mon, 21 Sep 2020 10:42:59 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id ca6sm123394pjb.53.2020.09.21.10.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:42:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Sep 2020 10:42:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
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
Message-ID: <20200921174256.GA387368@google.com>
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918163724.2511-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:37:19PM +0200, Christoph Hellwig wrote:
> There is no obvious reason why zsmalloc needs to pre-fault the PTEs
> given that it later uses map_kernel_range to just like vmap().

IIRC, the problem was runtime pte popluating needs GFP_KERNEL but
zs_map_object API runs under non-preemtible section.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/zsmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index c36fdff9a37131..3e4fe3259612fd 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1122,7 +1122,7 @@ static inline int __zs_cpu_up(struct mapping_area *area)
>  	 */
>  	if (area->vm)
>  		return 0;
> -	area->vm = alloc_vm_area(PAGE_SIZE * 2, NULL);
> +	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
>  	if (!area->vm)
>  		return -ENOMEM;
>  	return 0;

I think it shoud work.

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
index 3e4fe3259612..9ef7daf3d279 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1116,6 +1116,8 @@ static struct zspage *find_get_zspage(struct size_class *class)
 #ifdef CONFIG_ZSMALLOC_PGTABLE_MAPPING
 static inline int __zs_cpu_up(struct mapping_area *area)
 {
+	int ret;
+
 	/*
 	 * Make sure we don't leak memory if a cpu UP notification
 	 * and zs_init() race and both call zs_cpu_up() on the same cpu
@@ -1125,7 +1127,13 @@ static inline int __zs_cpu_up(struct mapping_area *area)
 	area->vm = get_vm_area(PAGE_SIZE * 2, 0);
 	if (!area->vm)
 		return -ENOMEM;
-	return 0;
+
+	/*
+	 * Populate ptes in advance to avoid pte allocation with GFP_KERNEL
+	 * in non-preemtible context of zs_map_object.
+	 */
+	ret = apply_to_page_range(&init_mm, NULL, PAGE_SIZE * 2, NULL, NULL);
+	return ret;
 }
 
 static inline void __zs_cpu_down(struct mapping_area *area)

