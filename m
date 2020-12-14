Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F72DA357
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408155AbgLNWY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407404AbgLNWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:24:26 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25434C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:23:46 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c12so13113497pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p1KDe5qKFc3I0RLE7gJdRSGCO/jqX7vEgzIvZpcJt+s=;
        b=cS0PxhPtmNPHmJrDaMiQ9Ma6JCyY4EZXN7kW9nU2iz1ahSWClF1Uc+GwnsXNNKQfo+
         z+lA8JSs+Z7YuzQQFsrfaVnzeGNWeMQyGLhVVW0uSRyUoB2YOkHlOT7Y8QIRxg/6YkVZ
         XaFi9+3GzVlKLoD1/Al9dIpyOOTJbW1pq/KPoAO9z25JfZRBMRL4ZgzXhwVMVAIL8Y8j
         8/U6Zg3/rqVl9XNNT2AKEQtFESJ+nHJZGrnVeT3wuJPiXqjjZ/BVZgNaG93fTMk5G/MI
         4nvw1luC4o+nSfo2zYeI8nAAkp1dpmOfww096UztoMwhjIGZxQOREZ+ikfBs9POnp++5
         QxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1KDe5qKFc3I0RLE7gJdRSGCO/jqX7vEgzIvZpcJt+s=;
        b=RiHJOXogyFOVBwxcbc9JgIJ0r4cpU+c2VnBCwx7WRKtMRNRwLuA9FNd+Fi4t/CDvTL
         eqEa3ukjyARnzBngFWvPfK3cpx4xEkjoMLFtdeQW1YvcOED+5VEs2sWcjZAQF4dIiMh9
         eIr5pU6cGPR8DavsBcV/ZbrZ02/Ovsn+D8sWNnuUurF+mQJIVa8J6dzodYJ6WEbmK6n7
         hrp8H69tS5UgJq6BzL1YxmPrJx+v16oegiMiXD0Dtbb2xPtUUJ02/GM5Dt925oHQK60s
         Px+59mvJ8mHYWpXEZP9wV/R0iFqvqlmIrHM8dUTy5TLPGM35nEprvWepKfuLJbXSwu+Z
         XRNw==
X-Gm-Message-State: AOAM531zDLUThcIa8ijOdKAKvzrDAmRPvdRxGKSoYNheftjn7SQLANoF
        ZxKBdk0VszBsAXSp5XQditowuw==
X-Google-Smtp-Source: ABdhPJwgjPztZTuT2cOmPux07aMyIMZismtlM2YG31OV49wYBHD4tCwgoQJmN1SCKdYUIHSwAzc3Tg==
X-Received: by 2002:a62:7ac4:0:b029:19d:b6ee:c64c with SMTP id v187-20020a627ac40000b029019db6eec64cmr25675640pfc.3.1607984625450;
        Mon, 14 Dec 2020 14:23:45 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id t7sm21529982pgs.5.2020.12.14.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:23:44 -0800 (PST)
Date:   Mon, 14 Dec 2020 14:23:38 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
Message-ID: <X9fl6rTd3sWROl1N@google.com>
References: <20201214174127.1398114-1-michael.roth@amd.com>
 <X9e/L3YTAT/N+ljh@google.com>
 <20201214220213.np7ytcxmm6xcyllm@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214220213.np7ytcxmm6xcyllm@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020, Michael Roth wrote:
> On Mon, Dec 14, 2020 at 11:38:23AM -0800, Sean Christopherson wrote:
> > > +	asm volatile(__ex("vmsave")
> > > +		     : : "a" (page_to_pfn(sd->save_area) << PAGE_SHIFT)
> > 
> > I'm pretty sure this can be page_to_phys().
> > 
> > > +		     : "memory");
> > 
> > I think we can defer this until we're actually planning on running the guest,
> > i.e. put this in svm_prepare_guest_switch().
> 
> One downside to that is that we'd need to do the VMSAVE on every
> iteration of vcpu_run(), as opposed to just once when we enter from
> userspace via KVM_RUN.

That can, and should, be optimized away.  Sorry I didn't make that clear.  The
below will yield high level symmetry with VMX, which I like.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 523df10fb979..057661723a5c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1399,6 +1399,7 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)

        avic_vcpu_put(vcpu);

+       svm->host_state_saved = false;
        ++vcpu->stat.host_state_reload;
        if (sev_es_guest(svm->vcpu.kvm)) {
                sev_es_vcpu_put(svm);
@@ -3522,6 +3523,12 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)

 static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
+       struct vcpu_svm *svm = to_svm(vcpu);
+
+       if (!svm->host_state_saved) {
+               svm->need_host_state_save = true;
+               vmsave();
+       }
 }


> It ends up being a similar situation to Andy's earlier suggestion of moving
> VMLOAD just after vmexit, but in that case we were able to remove an MSR
> write to MSR_GS_BASE, which cancelled out the overhead, but in this case I
> think it could only cost us extra.
>
> It looks like the SEV-ES patches might land before this one, and those
> introduce similar handling of VMSAVE in svm_vcpu_load(), so I think it
> might also create some churn there if we take this approach and want to
> keep the SEV-ES and non-SEV-ES handling similar.

Hmm, I'll make sure to pay attention to that when I review the SEV-ES patches,
which I was hoping to get to today, but that's looking unlikely at this point.
