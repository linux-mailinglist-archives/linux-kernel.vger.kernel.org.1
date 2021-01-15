Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B22F8267
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbhAORbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbhAORbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:31:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C11C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:30:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so5584913pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e4iNbSaLQouSoi2ExpAGatGG16APB7XlfIPRSEq48z4=;
        b=NjhRYse+Dv0G0pEtZJfNMACvCNU2k1bZFy3Aj4UihkW8tngtjB3w7xJUpChQd6VIbp
         yKU98i/BHVE4aRuWcHp5hFmIfkTKiccF1bBg7a+lt2+J+TohKPg+qkJ/uzxJNmkwsgei
         go6SsCMRap4Is5wxf0xvdhgUuLaigkJGULjWnBNIwDuR64EyOts1lDAGWpm0xDYvC36f
         E96ozRAiLfo8k8xFGmhJempGffltRrdnKYnaeH+XOOYLAheQ2kvzzo3bQVNLgMjSIT56
         MVa5AdwyBmMAeQH7RNU/7uQekaTPUx7l0w25UjgEZUgj8ofAznXFphJFhiBm/kyeyHwu
         PCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4iNbSaLQouSoi2ExpAGatGG16APB7XlfIPRSEq48z4=;
        b=Npkclly+xapVIw8x/T988O7/HXERa3sUOP/dclujn3Y/Ev9o8rmuaQPbftYha3F/NR
         I7UYjhlgwVOPHPyv4ukhT6Cqgz1TgTSILD/2vWbH0r0s739yE59B9LRdJCRcmM6dzxgX
         PL4Bkb7GYBNXUQc9Yt1z5EJVlTXBCNLcOdmniZEWVexlDwGow3i9U7u963b72tFfoB5g
         OV6uo3vVADHhO/hRrTBiIwKxtK5UXjdMpxcsjPNuEOobtPu+nKIo0+EYPCQs9kcRr2Z9
         Qef7hgO0Gr3UlmSd+V0wFmjs/tCN/N6PnTOyM4nMVYKvhFf4lpQ9oA254Y3VvbJR8sIW
         2wZA==
X-Gm-Message-State: AOAM530rm/UrxbGmxGKkSxeBCCYulhHizwpKGQdiryNTNlJvofbZqnmY
        ZfmtJiSZUXZ7g2IOoeswv/bJrA==
X-Google-Smtp-Source: ABdhPJyAPmp/B5kPb5BaLdZ0aPMrtnV+2PxsftX28KS94cBa4b4RQvAQacSbSNUKEA+DcC86f5jLSA==
X-Received: by 2002:a17:90b:1894:: with SMTP id mn20mr11751354pjb.100.1610731832726;
        Fri, 15 Jan 2021 09:30:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id l197sm8824100pfd.97.2021.01.15.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:30:31 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:30:24 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Fix HW_REF_CPU_CYCLES event
 pseudo-encoding in intel_arch_events[]
Message-ID: <YAHRMK5SmrmMx8hg@google.com>
References: <20201230081916.63417-1-like.xu@linux.intel.com>
 <1ff5381c-3057-7ca2-6f62-bbdcefd8e427@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff5381c-3057-7ca2-6f62-bbdcefd8e427@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021, Like Xu wrote:
> Ping ?
> 
> On 2020/12/30 16:19, Like Xu wrote:
> > The HW_REF_CPU_CYCLES event on the fixed counter 2 is pseudo-encoded as
> > 0x0300 in the intel_perfmon_event_map[]. Correct its usage.
> > 
> > Fixes: 62079d8a4312 ("KVM: PMU: add proper support for fixed counter 2")
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> > ---
> >   arch/x86/kvm/vmx/pmu_intel.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > index a886a47daebd..013e8d253dfa 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -29,7 +29,7 @@ static struct kvm_event_hw_type_mapping intel_arch_events[] = {
> >   	[4] = { 0x2e, 0x41, PERF_COUNT_HW_CACHE_MISSES },
> >   	[5] = { 0xc4, 0x00, PERF_COUNT_HW_BRANCH_INSTRUCTIONS },
> >   	[6] = { 0xc5, 0x00, PERF_COUNT_HW_BRANCH_MISSES },
> > -	[7] = { 0x00, 0x30, PERF_COUNT_HW_REF_CPU_CYCLES },
> > +	[7] = { 0x00, 0x03, PERF_COUNT_HW_REF_CPU_CYCLES },

In a follow up patch, would it be sane/appropriate to define these magic numbers
in asm/perf_event.h and share them between intel_perfmon_event_map and
intel_arch_events?  Without this patch, it's not at all obvious that these are
intended to align with the Core (arch?) event definitions.

> >   };
> >   /* mapping between fixed pmc index and intel_arch_events array */
> 
