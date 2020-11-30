Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688842C8806
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgK3PcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgK3PcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:32:08 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF68C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:31:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x25so11139570qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U8nOrVaPuX5bihpcc78kkshqsob3zo9wigFFV5UIQ8s=;
        b=n1NlO+k6OaI0DsbSSo80XTYnquXpXq+Qn/eDOdnfypY/RctUmGTuxRJLMO2+pYHOqt
         EZ/VfMBnOLT47dZ+eawBc4SPmjIeqy89Spq3vxxtlltx7S9uzuNX5CZHAX6vK3XIgO+r
         +aVAQqgmmKb2kZss9gTtgE2W6TaNuqYE3WjQ9PqIeeTHEDiiJNFOdMyEgSTYp+dRVVyx
         JA6VM//OLDbFxtaO3KFl0x8rxkFMjSExRoINNLq1gvyL2YfF9k8MdxhANw7++aOQAhEe
         ke30+uwtL4TcSwfqQV9DMwfiZnwtPM7SrGjQykbAIa0J8e7aKSkcFGNEqRueWkuTWO2M
         UH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8nOrVaPuX5bihpcc78kkshqsob3zo9wigFFV5UIQ8s=;
        b=nrmxr9sFinNaY447DmnhC+KE5VRy4JjOyzxYt3qbU7LpHoKqN/SNO1yJ5Sv2LikVM5
         681U8os7wLr0SdcG4qonWdQ9uXwN9HBIhT0ukOWfTpsrneZSliSnfCJjH/90mGUgt9+3
         Jfil8E4bqx4uD8XC+/0uCaaKsEWZBG9AH2d6Eu4ucXsmc1M12vJZVkw8TRhrfZ3PE3KF
         xyD/JCGCmBAhpDX/0fRml8JTqJm18RQin57D5mUnzrCDld2Ealy1d5yVr0XcTwoU3q3J
         ouLIAriGRUcXxzQ9WMjb5uoEr49uUUbp+Xx7jgGD7YrJFxYY0GlJQvrfg5mEpl+5G1HI
         +66w==
X-Gm-Message-State: AOAM531IYbCOfXkTYeLGnUlw1KBmyHU7snW92ILHKvB1zxcDOLD5NvdU
        S+EkNJgWk2R1mbcNKUFBOt3mkw==
X-Google-Smtp-Source: ABdhPJx7gKRSYCvH2HyMkfzeCX3aFgKsSb6376UCt6J34b5E3+q/1dALMhmOskD6A8yu12/U4Pr00A==
X-Received: by 2002:a37:4658:: with SMTP id t85mr20664892qka.210.1606750281813;
        Mon, 30 Nov 2020 07:31:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n21sm15860261qke.32.2020.11.30.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:31:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kjl96-0044kf-5M; Mon, 30 Nov 2020 11:31:20 -0400
Date:   Mon, 30 Nov 2020 11:31:20 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Subject: Re: [RFC][PATCH 5/9] mm: Rename pmd_read_atomic()
Message-ID: <20201130153120.GZ5487@ziepe.ca>
References: <20201130112705.900705277@infradead.org>
 <20201130113603.079835817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130113603.079835817@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:27:10PM +0100, Peter Zijlstra wrote:
> There's no point in having the identical routines for PTE/PMD have
> different names.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>  include/linux/pgtable.h    |    7 +------
>  mm/hmm.c                   |    2 +-
>  mm/mapping_dirty_helpers.c |    2 +-
>  mm/mprotect.c              |    2 +-
>  mm/userfaultfd.c           |    2 +-
>  5 files changed, 5 insertions(+), 10 deletions(-)
> 
> +++ b/include/linux/pgtable.h
> @@ -1244,11 +1244,6 @@ static inline int pud_trans_unstable(pud
>  #endif
>  }
>  
> -static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> -{
> -	return pmdp_get_lockless(pmdp);
> -}
> -
>  #ifndef arch_needs_pgtable_deposit
>  #define arch_needs_pgtable_deposit() (false)
>  #endif
> @@ -1275,7 +1270,7 @@ static inline pmd_t pmd_read_atomic(pmd_
>   */
>  static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
>  {
> -	pmd_t pmdval = pmd_read_atomic(pmd);
> +	pmd_t pmdval = pmdp_get_lockless(pmd);
>  	/*
>  	 * The barrier will stabilize the pmdval in a register or on
>  	 * the stack so that it will stop changing under the code.
> +++ b/mm/hmm.c
> @@ -356,7 +356,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		 * huge or device mapping one and compute corresponding pfn
>  		 * values.
>  		 */
> -		pmd = pmd_read_atomic(pmdp);
> +		pmd = pmdp_get_lockless(pmdp);
>  		barrier();
>  		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
>  			goto again;

The pagewalk API doesn't call the functions with interrupts disabled,
doesn't this mean we hit this assertion?

+#if CONFIG_PGTABLE_LEVELS > 2
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+       pmd_t pmd;
+
+       lockdep_assert_irqs_disabled();
+

It is only holding the read side of the mmap_sem here

Jason
