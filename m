Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099AE2BB6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgKTUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgKTUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:22:58 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:22:58 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id f5so8764884ilj.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ght5uqwgVPL14mfxNWU5XxDISwt3Xgt2hIhAbuzfV8c=;
        b=ejkjlAjx11JYmEZSWguAJ4MVnj8U3xGHowplEv09FW1uySVng6ULKj4SlnbOqVdx5r
         swehtuAowp2YvJtI31szphdVFsF/yJrYb1a8OA13BJG6OMVq7qe69kr5UHhy0VB8WJee
         bH42WzoOFtnSQMgahkdo/7AR8vEXJFFrlEVfTy3Wt9gZfwPCyW96dJeVCNn975rr1HsL
         6IEGyvD4QOBSJjHGLIzbNRkWQ0ZrQ5r69CaetQUFN4KtCgnZA96bin7RdAZILZnQJ8Yi
         ziFcwqRLJQjT7nCy1YjV7ZDJ+XORppGfEAGYI6Bxl9Ra2xEti+FKKhdETr1l8HQKPP3O
         nm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ght5uqwgVPL14mfxNWU5XxDISwt3Xgt2hIhAbuzfV8c=;
        b=syMkwTMsXlg3H11Afijxso0HBcXX1M723AdBTpxg7kNiThi0onk+xNlWyaEhfq0EqM
         rEoIsmaNjRHXY5p7yHwgSD4qLsYi4LwijumK6JPAYOhbZk609SXfMHNjT5hhwXvWjRxO
         3yKVVFBMhNW3KWQDe9/EVfscAfh79YTYj6WhLopZbvE9hF0woqXscDuM3UDSStU2CvzD
         d3apuHBxYZtnvfK96hx+8L/uDfUDCDoRZ8SgeuepoAYTDRRoxBzQK7NaQ3EPUnbcBihq
         fVF6m+emmHGLgK739/Y6P/TszxvdqJj2lFDdjFlsLIEzKrf4xS0iesJ7ExhoT+F/TuC4
         V+Og==
X-Gm-Message-State: AOAM533WsB2iSbYgA7DXaFcvlUzMNWdiL39YIV7uf6JQBRQoNCGzNr71
        uCjAcBtJnKQ9YpSXpQctY8glQA==
X-Google-Smtp-Source: ABdhPJy13/cZN92z4k83AHU6mxhaf2RrSdMXtJT23PYPv818sQhjrZ5FfM+5aa6X7QRQly0YveKeEg==
X-Received: by 2002:a92:c089:: with SMTP id h9mr27376075ile.162.1605903777682;
        Fri, 20 Nov 2020 12:22:57 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id s71sm2659348ilb.17.2020.11.20.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:22:57 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:22:53 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201120202253.GB1303870@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120143557.6715-5-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> via the tlb_remove_*() functions. Consequently, the page-table modifications
> performed by clear_refs_write() in response to a write to
> /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> state we can end up with entries where pte_write() is false, yet a
> writable mapping remains in the TLB.

I don't think we need a TLB flush in this context, same reason as we
don't have one in copy_present_pte() which uses ptep_set_wrprotect()
to write-protect a src PTE.

ptep_modify_prot_start/commit() and ptep_set_wrprotect() guarantee
either the dirty bit is set (when a PTE is still writable) or a PF
happens (when a PTE has become r/o) when h/w page table walker races
with kernel that modifies a PTE using the two APIs.

> Fix this by calling tlb_remove_tlb_entry() for each entry being
> write-protected when cleating soft-dirty.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  fs/proc/task_mmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index cd03ab9087b0..3308292ee5c5 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1032,11 +1032,12 @@ enum clear_refs_types {
>  
>  struct clear_refs_private {
>  	enum clear_refs_types type;
> +	struct mmu_gather *tlb;
>  };
>  
>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  static inline void clear_soft_dirty(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *pte)
> +		unsigned long addr, pte_t *pte, struct mmu_gather *tlb)
>  {
>  	/*
>  	 * The soft-dirty tracker uses #PF-s to catch writes
> @@ -1053,6 +1054,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  		ptent = pte_wrprotect(old_pte);
>  		ptent = pte_clear_soft_dirty(ptent);
>  		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
>  	} else if (is_swap_pte(ptent)) {
>  		ptent = pte_swp_clear_soft_dirty(ptent);
>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
> @@ -1060,14 +1062,14 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
>  }
>  #else
>  static inline void clear_soft_dirty(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *pte)
> +		unsigned long addr, pte_t *pte, struct mmu_gather *tlb)
>  {
>  }
>  #endif
>  
>  #if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t *pmdp)
> +		unsigned long addr, pmd_t *pmdp, struct mmu_gather *tlb)
>  {
>  	pmd_t old, pmd = *pmdp;
>  
> @@ -1081,6 +1083,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  
>  		pmd = pmd_wrprotect(pmd);
>  		pmd = pmd_clear_soft_dirty(pmd);
> +		tlb_remove_pmd_tlb_entry(tlb, pmdp, addr);
>  
>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>  	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
> @@ -1090,7 +1093,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
>  }
>  #else
>  static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
> -		unsigned long addr, pmd_t *pmdp)
> +		unsigned long addr, pmd_t *pmdp, struct mmu_gather *tlb)
>  {
>  }
>  #endif
> @@ -1107,7 +1110,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>  	ptl = pmd_trans_huge_lock(pmd, vma);
>  	if (ptl) {
>  		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
> -			clear_soft_dirty_pmd(vma, addr, pmd);
> +			clear_soft_dirty_pmd(vma, addr, pmd, cp->tlb);
>  			goto out;
>  		}
>  
> @@ -1133,7 +1136,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>  		ptent = *pte;
>  
>  		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
> -			clear_soft_dirty(vma, addr, pte);
> +			clear_soft_dirty(vma, addr, pte, cp->tlb);
>  			continue;
>  		}
>  
> @@ -1212,7 +1215,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  	if (mm) {
>  		struct mmu_notifier_range range;
>  		struct clear_refs_private cp = {
> -			.type = type,
> +			.type	= type,
> +			.tlb	= &tlb,
>  		};
>  
>  		if (type == CLEAR_REFS_MM_HIWATER_RSS) {
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
