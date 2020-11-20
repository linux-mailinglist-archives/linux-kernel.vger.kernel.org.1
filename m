Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04AB2BB621
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgKTTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgKTTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:53:14 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D997C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:53:14 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n129so11145938iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxnkL7sBSNoqYoJigqom0+XD1YVRiqS6FwGLG7iJAO4=;
        b=rnN1fS4zx8lj60uqorsVrI3/bKsdKEpgfxSOWN01UgyAtOLtDXXzTzcw82y7Zwm2jj
         4t69K1Pf6kMgoVoH25M4P/QarFk9kkw/yUl2Nc1RM9B97YcnzYowzkrgorLOT0hmE+7f
         HTZq8pNl9P7i4UdG5dqVikedfi4RgHQtz6AmwvgDvnZQDB5l/TR24hX0yfZQDxFxbffz
         kEU+8CqQYPWFwmcqTeTQ+qh3f7CTXFHID/R5BPF3kkZJr1QgRO9bQz1x6jFnrN9oExvB
         Z+bOFim2X686YNJFfO8IQZfgMBjjNc8Zcr2SyO5Md8SRJTBcmk5UTqRMS4boS0ewTmJI
         dcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxnkL7sBSNoqYoJigqom0+XD1YVRiqS6FwGLG7iJAO4=;
        b=JV9a9drhYw8o/X9HZowj3sDtIAFDR0+SEqjdtwD17iIA8vN6FZ1iJ9Y1De73MONsJj
         3lNCy7TmyAXiYchB2Bdx6FAWuM6H4ACuxOUCgk8e/vsP/61/428+qCwwPIjOFTMSyDnx
         EdeCbmZb8P6kaW+15rjaJ+mewcxyhgrkgGiIkoWN6c1ME3MLF1JLwq95lhA6lyu8g5gL
         8rf3J1y5Fe8CCXivu+qlBc4cGSs1viwJOK0Lxubr+aM5oYIfRsyk+la4+I34Yz2lKOAi
         NNQPBRV/mXMpJRlJdWOJ0FuQhlwoumLAg5cJWVa9WJeXHelKWPQgBRf5DzW7tvuWM/l9
         KUSg==
X-Gm-Message-State: AOAM533+yPQOerjlKDP8q9jimLmG19bYLiKY8iqyJhUkel9dzCQIJjFf
        V+e40QI7zhGkz8a8hAHe3IlmfA==
X-Google-Smtp-Source: ABdhPJxSffGKpVjywoxuXIvCRu/AM8DhpUH1m+P2eYdFRYvfM6wAc7GXcabZRhXBoGj9LwhZ0yGeZQ==
X-Received: by 2002:a02:90ca:: with SMTP id c10mr21200448jag.115.1605901993088;
        Fri, 20 Nov 2020 11:53:13 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id k26sm1937993iom.32.2020.11.20.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:53:12 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:53:08 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: pgtable: Fix pte_accessible()
Message-ID: <20201120195308.GA1303870@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120143557.6715-2-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:35:52PM +0000, Will Deacon wrote:
> pte_accessible() is used by ptep_clear_flush() to figure out whether TLB
> invalidation is necessary when unmapping pages for reclaim. Although our
> implementation is correct according to the architecture, returning true
> only for valid, young ptes in the absence of racing page-table
> modifications, this is in fact flawed due to lazy invalidation of old
> ptes in ptep_clear_flush_young() where we elide the expensive DSB
> instruction for completing the TLB invalidation.
> 
> Rather than penalise the aging path, adjust pte_accessible() to return
> true for any valid pte, even if the access flag is cleared.

The chance of a system hitting reclaim is proportional to how long
it's been running, and that of having mapped but yet to be accessed
PTEs is reciprocal, so to speak. I don't reboot my devices everyday,
and therefore:

Acked-by: Yu Zhao <yuzhao@google.com>

> Cc: <stable@vger.kernel.org>
> Fixes: 76c714be0e5e ("arm64: pgtable: implement pte_accessible()")
> Reported-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 4ff12a7adcfd..1bdf51f01e73 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -115,8 +115,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
>  #define pte_valid_not_user(pte) \
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
> -#define pte_valid_young(pte) \
> -	((pte_val(pte) & (PTE_VALID | PTE_AF)) == (PTE_VALID | PTE_AF))
>  #define pte_valid_user(pte) \
>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER))
>  
> @@ -126,7 +124,7 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>   * remapped as PROT_NONE but are yet to be flushed from the TLB.
>   */
>  #define pte_accessible(mm, pte)	\
> -	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid_young(pte))
> +	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
>  
>  /*
>   * p??_access_permitted() is true for valid user mappings (subject to the
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
