Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330032F82BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbhAORnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbhAORnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:43:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127EC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x12so5053841plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HHcrPMunMXLd4pGO1neHtBLweNEDPBq5DPbqA2qARP4=;
        b=X2Ksib9kXtDryNhSQ2hrFIt7jHXSUocyXuM3sn5o25k/6kIj16YW909qGlRcjBPsBH
         pm24WVQNJFcJqWbFSJ76NZPhJsP+LaVdZRdlSX+WHjgREmn+jUtg9qzukGXWDH9TqroB
         3tKkzH6EAA9nEMoxrKuB1RAo14QAVswlSM+ZHr7Mg89D36XwFMzBq/p3743nFi7UL20n
         ZH8dwyflEjKUXu1aSDsF1KQMbkeOTpZmR4hC8p2yhQwmtni5fEj7YVJX28pvfrjdrmTq
         YuFGxV6NP3ir2Q+wdfLnmvMHMBk1B2FofM031HEGQ+H07vPkWrwqPuum1FjYGJj1bYZ4
         oqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HHcrPMunMXLd4pGO1neHtBLweNEDPBq5DPbqA2qARP4=;
        b=KUq5jTULzTuQOx1WyF8UYEeu/Zai8J6nUhQZh4YOdsUPCo3cTdqOvgKC8qSmIWBToz
         0YJh0+Y2AHHAGlMaY9mQsS3c1Lca9uxkEr19wlRo7YqTMR+kgmGhfmdYctcps9+oLAlc
         AYqT18uhONP24Sgp/qcHfdBakGrvvhdNtQLjsPLIC3xF/Atk4J9s5QQUJeHvWzJYwQgY
         VgG9UOtzWPBWSSCxa4npHp2aEvPbbs7xnsH4/5+lh64qskY/bqAWapwpoiejSl7OBkX0
         0zehR6skYG0GXicK6dO7Q2Qe8ybZajsacIXRQG4sqH5d0QvWLAM4yfqPy222pTUbCF93
         snsQ==
X-Gm-Message-State: AOAM532kTlpHtDig0jA93K89lC7iHFaK37WsTySmw0VhclNWlMx7OdQf
        G3q6MGEAo9OXi0Ej0IMEMZJlbg==
X-Google-Smtp-Source: ABdhPJyGe1fBDfRzm2pWQF9LtOY7aTP9ZGtLusYGtA+MIr2vinxVAwQ9y1P1BY/3WFklEnP+5VTNig==
X-Received: by 2002:a17:90a:708b:: with SMTP id g11mr11390902pjk.23.1610732546469;
        Fri, 15 Jan 2021 09:42:26 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id r79sm8341027pfc.166.2021.01.15.09.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:42:25 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:42:19 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Xu, Like" <like.xu@intel.com>
Cc:     Like Xu <like.xu@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, eranian@google.com,
        kvm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi@firstfloor.org>, wei.w.wang@intel.com,
        luwei.kang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/17] perf: x86/ds: Handle guest PEBS overflow PMI
 and inject it to guest
Message-ID: <YAHT+zLiIg/oUygZ@google.com>
References: <20210104131542.495413-1-like.xu@linux.intel.com>
 <20210104131542.495413-5-like.xu@linux.intel.com>
 <YACTnkdi1rxfrRCg@google.com>
 <a0b5dc29-e63f-6ec9-a03f-6435cb3373c6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5dc29-e63f-6ec9-a03f-6435cb3373c6@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021, Xu, Like wrote:
> On 2021/1/15 2:55, Sean Christopherson wrote:
> > On Mon, Jan 04, 2021, Like Xu wrote:
> > > +	 * Note: KVM disables the co-existence of guest PEBS and host PEBS.
> > By "KVM", do you mean KVM's loading of the MSRs provided by intel_guest_get_msrs()?
> > Because the PMU should really be the entity that controls guest vs. host.  KVM
> > should just be a dumb pipe that handles the mechanics of how values are context
> > switch.
> 
> The intel_guest_get_msrs() and atomic_switch_perf_msrs()
> will work together to disable the co-existence of guest PEBS and host PEBS:
> 
> https://lore.kernel.org/kvm/961e6135-ff6d-86d1-3b7b-a1846ad0e4c4@intel.com/
> 
> +
> 
> static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
> ...
>     if (nr_msrs > 2 && (msrs[1].guest & msrs[0].guest)) {
>         msrs[2].guest = pmu->ds_area;
>         if (nr_msrs > 3)
>             msrs[3].guest = pmu->pebs_data_cfg;
>     }
> 
>    for (i = 0; i < nr_msrs; i++)
> ...

Yeah, that's exactly what I'm complaining about.  Splitting the logic for
determining the guest values is unnecessarily confusing, and as evidenced by the
PEBS_ENABLE bug, potentially fragile.  Perf should have full knowledge and
control of what values are loaded for the guest.  And, the above indexing magic
is nigh impossible to follow and _super_ fragile.

If we change .guest_get_msrs() to take a struct kvm_pmu pointer, then it can
generate the full set of guest values by grabbing ds_area and pebs_data_cfg.
Alternatively, .guest_get_msrs() could take the desired guest MSR values
directly (ds_area and pebs_data_cfg), but kvm_pmu is vendor agnostic, so I don't
see any reason to not just pass the pointer.
