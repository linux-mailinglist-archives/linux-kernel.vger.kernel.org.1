Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA52D9D86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408475AbgLNRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408461AbgLNRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:21:33 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F19C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:20:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id b5so5441955pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxgnbNCbgMEa0r7IAN/P+PKPUNFiZwOOdxJlXkOUSKg=;
        b=JVC+pkoRUtVzq9MLoJl+0qZgA9lEGZEM+E8z3uLQDGwPeJqvBYA8MY9heekmU6VnHa
         4ORNR+esAEyRS3NgnZNX8fFb3tGKJ+04jlawRSuyq6//fwuE4RImDQTzQk7R6W+Stwfp
         dljsLyWZnw0ur7JMls876tSvXo6TJznHXFflm/fB84n56DWgZpMMB82AhSHa4AWDNFRn
         YvcqDxlaJ0H11P9cR3SSwI6fPTZIFpC2lx9pD2L3aGEe09QoidIXXPNO0YtpfhrcY5hv
         VCyiiNTbcy8yNSEmwdVU+eOyVksKzcZpMKufATbC/u3bG01dHn0sXUg53F7tUikvApEQ
         FxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxgnbNCbgMEa0r7IAN/P+PKPUNFiZwOOdxJlXkOUSKg=;
        b=Dp1mpptczVUwyKDPxBTLpniRuGcjeZQm9lArSimdKzEWP65pDCoEIx7+O2aFqR775V
         xeVVTTMnPRdj1jqPrGrOsO/uD5w2gCPShX/A17pwCycoxnU1S5QXb3rXWueH3WD2ALZ+
         WD1HY0ke2jJyzkA+TXYVdgcU1hhNwAHC7By40toeu0Hi9sYEHqmNje0YOwYUhhj47yee
         +HKEjoWei77Eww5r022SR5Wpx9Rpk54P1VuejUEwXTdI+ZLGYup3pFqnKPJR3n3o60E7
         en6rE8Q0Llwthc1jvJaE1kQUhZMZZeZThc5HF1Fcnzkdt5rRYhmuPCrNsY1kScv9AQW3
         c5Kg==
X-Gm-Message-State: AOAM530HnFwUgR/p9pE+JDMSAWbywljifoS6QoZY3bwjAskQNstgr8qA
        boySFGulB+oyQWf8ACrVr+QJQQbZyQVzdw==
X-Google-Smtp-Source: ABdhPJx0XtjViuZ6XRmwXr26g5eLMpQP2u+SKhjfgWGgQqwlB9Jsx3cAJMVki4JASiWp9R89cJ/0LA==
X-Received: by 2002:a17:90b:697:: with SMTP id m23mr26107424pjz.35.1607966452405;
        Mon, 14 Dec 2020 09:20:52 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id g33sm20788583pgm.74.2020.12.14.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 09:20:51 -0800 (PST)
Date:   Mon, 14 Dec 2020 09:20:45 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm: don't lose the higher 32 bits of tlbs_dirty
Message-ID: <X9ee7RzW+Dhv1aoW@google.com>
References: <20201213044913.15137-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213044913.15137-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In kvm_mmu_notifier_invalidate_range_start(), tlbs_dirty is used as:
> 	need_tlb_flush |= kvm->tlbs_dirty;
> with need_tlb_flush's type being int and tlbs_dirty's type being long.
> 
> It means that tlbs_dirty is always used as int and the higher 32 bits
> is useless. 

It's probably worth noting in the changelog that it's _extremely_ unlikely this
bug can cause problems in practice.  It would require encountering tlbs_dirty
on a 4 billion count boundary, and KVM would need to be using shadow paging or
be running a nested guest.

> We can just change need_tlb_flush's type to long to
> make full use of tlbs_dirty.

Hrm, this does solve the problem, but I'm not a fan of continuing to use an
integer variable as a boolean.  Rather than propagate tlbs_dirty to
need_tlb_flush, what if this bug fix patch checks tlbs_dirty directly, and then
a follow up patch converts need_tlb_flush to a bool and removes the unnecessary
initialization (see below).

E.g. the net result of both patches would be:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3abcb2ce5b7d..93b6986d3dfc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -473,7 +473,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
                                        const struct mmu_notifier_range *range)
 {
        struct kvm *kvm = mmu_notifier_to_kvm(mn);
-       int need_tlb_flush = 0, idx;
+       bool need_tlb_flush;
+       int idx;

        idx = srcu_read_lock(&kvm->srcu);
        spin_lock(&kvm->mmu_lock);
@@ -483,11 +484,10 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
         * count is also read inside the mmu_lock critical section.
         */
        kvm->mmu_notifier_count++;
-       need_tlb_flush = kvm_unmap_hva_range(kvm, range->start, range->end,
-                                            range->flags);
-       need_tlb_flush |= kvm->tlbs_dirty;
+       need_tlb_flush = !!kvm_unmap_hva_range(kvm, range->start, range->end,
+                                              range->flags);
        /* we've to flush the tlb before the pages can be freed */
-       if (need_tlb_flush)
+       if (need_tlb_flush || kvm->tlbs_dirty)
                kvm_flush_remote_tlbs(kvm);

        spin_unlock(&kvm->mmu_lock);

Cc: stable@vger.kernel.org
Fixes: a4ee1ca4a36e ("KVM: MMU: delay flush all tlbs on sync_page path")

> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  virt/kvm/kvm_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2541a17ff1c4..4e519a517e9f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -470,7 +470,8 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>  					const struct mmu_notifier_range *range)
>  {
>  	struct kvm *kvm = mmu_notifier_to_kvm(mn);
> -	int need_tlb_flush = 0, idx;
> +	long need_tlb_flush = 0;

need_tlb_flush doesn't need to be initialized here, it's explicitly set via the
call to kvm_unmap_hva_range().

> +	int idx;
>  
>  	idx = srcu_read_lock(&kvm->srcu);
>  	spin_lock(&kvm->mmu_lock);
> -- 
> 2.19.1.6.gb485710b
> 
