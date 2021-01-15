Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555302F80D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbhAOQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhAOQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:31:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC9C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:30:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ce17so3192129pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UXWjedEjFBpd0ETx4D8fuLmVJJOBO/kw+OGnzhqNPfA=;
        b=syOg2Xve/Imvla+hFDquTJQBVj8iHRvLqIHXKJVYrnfQhlkSSfqNzmfWQgR3NElKof
         usFUfPJQYBnL9rsacetClCFeoms0QM6aSn6C6G0kH4rySSrG+PtWVI5MmW2ZVKEFFJHg
         MSKRHANsL87WhmwEuNoSZq+trDJVihfFOKt2rDFHTdlMjqNIZQyexC3AsRwlhcor7KgV
         Q83bhwAraMZ0GQUY89rMzm3QBvKKuUoeSMV/YUhX9VIp5VsGd7rTKNdbKhmckvzIhxO5
         bJmdc4cNDPt11H/O8dhowH3IUmfI+pftaykHYgF2Sbedq+T3XD1+ZYyqYrH14WINBPWH
         3YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UXWjedEjFBpd0ETx4D8fuLmVJJOBO/kw+OGnzhqNPfA=;
        b=Y3Z6craG//gGlBDAl4gcQRvbmRWVAioOYWxCNV9huWZKj82rWgaTbIt5h8O6LFI4GC
         CwLNRmvVploFDCkS7uF02swdBDYb4zOTalWmbjZQsVPcpFTTYnaRyj4bNoGwrSat+qIa
         UTIiW3eQQhwAFq1nJ3l5v634b6wxl4DVCf2tPuqcB+Hc32zMdBB2m2YP1bmnXcQHaDkd
         LbKB5w49v0cGuIN1WPyhw1LonZOPzjVn+D/EX8R+kUbimdLz3QbRpGJnpnIVb1ylR1Ps
         9OtTMaLyTW+o8jmiBOCYu65g48yK4FyLertRaU6jl8MVVbLZX9cisf3OzAk6zvH+OKho
         N/Qg==
X-Gm-Message-State: AOAM530GZVbAqvkHzjG55b/7CUEAPjm+s8m3M1cAc1H3eAw1o+8qwNwB
        sMgXejxCp5A76w719NBED9sWog==
X-Google-Smtp-Source: ABdhPJyplLE2AazKwwF6nguhU89IPISE77JMp50HCtK81+tq5BQLT13FUbnWA8VpUIwVMNwS+JQ0Ug==
X-Received: by 2002:a17:90b:100e:: with SMTP id gm14mr11427480pjb.179.1610728232493;
        Fri, 15 Jan 2021 08:30:32 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id p3sm8328522pjg.53.2021.01.15.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:30:31 -0800 (PST)
Date:   Fri, 15 Jan 2021 08:30:24 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 2/3] KVM: nVMX: add kvm_nested_vmlaunch_resume
 tracepoint
Message-ID: <YAHDIJMACMBnboIZ@google.com>
References: <20210114205449.8715-1-mlevitsk@redhat.com>
 <20210114205449.8715-3-mlevitsk@redhat.com>
 <YADeT8+fssKw3SSi@google.com>
 <18c386f2-a588-6324-fcde-d13b66f66d4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c386f2-a588-6324-fcde-d13b66f66d4f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021, Paolo Bonzini wrote:
> On 15/01/21 01:14, Sean Christopherson wrote:
> > > +	trace_kvm_nested_vmlaunch_resume(kvm_rip_read(vcpu),
> > Hmm, won't this RIP be wrong for the migration case?  I.e. it'll be L2, not L1
> > as is the case for the "true" nested VM-Enter path.
> 
> It will be the previous RIP---might as well be 0xfffffff0 depending on what
> userspace does.  I don't think you can do much better than that, using
> vmcs12->host_rip would be confusing in the SMM case.
> 
> > > +					 vmx->nested.current_vmptr,
> > > +					 vmcs12->guest_rip,
> > > +					 vmcs12->vm_entry_intr_info_field);
> > The placement is a bit funky.  I assume you put it here so that calls from
> > vmx_set_nested_state() also get traced.  But, that also means
> > vmx_pre_leave_smm() will get traced, and it also creates some weirdness where
> > some nested VM-Enters that VM-Fail will get traced, but others will not.
> > 
> > Tracing vmx_pre_leave_smm() isn't necessarily bad, but it could be confusing,
> > especially if the debugger looks up the RIP and sees RSM.  Ditto for the
> > migration case.
> 
> Actually tracing vmx_pre_leave_smm() is good, and pointing to RSM makes
> sense so I'm not worried about that.

Ideally there would something in the tracepoint to differentiate the various
cases.  Not that the RSM/migration cases will pop up often, but I think it's an
easily solved problem that could avoid confusion.

What if we captured vmx->nested.smm.guest_mode and from_vmentry, and explicitly
record what triggered the entry?

	TP_printk("from: %s rip: 0x%016llx vmcs: 0x%016llx nrip: 0x%016llx intr_info: 0x%08x",
		  __entry->vmenter ? "VM-Enter" : __entry->smm ? "RSM" : "SET_STATE",
		  __entry->rip, __entry->vmcs, __entry->nested_rip,
		  __entry->entry_intr_info

Side topic, can we have an "official" ruling on whether KVM tracepoints should
use colons and/or commas? And probably same question for whether or not to
prepend zeros.  E.g. kvm_entry has "vcpu %u, rip 0x%lx" versus "rip: 0x%016llx
vmcs: 0x%016llx".  It bugs me that we're so inconsistent.
