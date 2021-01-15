Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E52F6F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbhAOA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbhAOA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:29:49 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60775C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:29:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so4881488pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aHGC4K/J47/7udv18Bsw07FnzQ7kruqMqX+H7kZA09c=;
        b=qszTxVFbaYHuSfeEZk5UKwngQw0DrQSp1UiqqIKVJjeNdvEYdSkt7eCd1bX9sceszX
         a8nRWMdzc7jEpJ+xnobZXvOYjI2xQfVK7B4vZxakdsA8S7m/caSSrTR6dvKfkAskdRo4
         0wmbF1va2tnuHGVuFKsgIUIAO/ZS+Dv4mIJ/cp+ABkABXDDrS6PBXQAx6HJ9dCspkpRc
         ye1xVYsbeKTmtMB2lq7aW486AQk1cxNFj5+LOQgYelyP65+U3X0IaE8LZjlV0lS17yeI
         PmLov5664UaEqKzN6IGhwIA87JDN3WZFP23sTc+nAdQMdNq59/9VMZ8wX6yApiMXadtG
         X56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHGC4K/J47/7udv18Bsw07FnzQ7kruqMqX+H7kZA09c=;
        b=dEjLTI5Qh6Mg9WH8AzmHf63CwDNJoucXj3h6xgMjik545YgiAqtprUthOlpMr3d/oZ
         lxvWR6ipOHyCcKbSzsob5k9vt5IEi+OBHxrLurvslBgn7rfl1wpvShdgqJc+XPY7ud4r
         5CWGpQbyliLBhjPDZshH2mJJIvIWl3TJMuDYwpHAPNOs/l5yWRwFwkodQwFAQVVaz8So
         hgiiNKSj1P7T/gNUILuWdkePhrILR8rkslUNgcgiwtVE5kzB3pGCpHtv0IDtxlTjrINE
         BmgkPUiN5VPk5xR+qthiYQPa64LqhCiH7lsblw6K/1Hq52+Vx+mGoSI0VaHaQ8r7OVJe
         hp9g==
X-Gm-Message-State: AOAM531IB5QAyKWXLWngeh9WG66EQ94YsvBijY8NkgDCm39fke2EzWAA
        7OQD7G7Fz2a6FBUAP1Mv8zTmww==
X-Google-Smtp-Source: ABdhPJzKcmTdc6/62NIioNRFHz8QtA/XsmZdkAJWQCcnQYHujsq/7+6bzpo8AWdryDxMhlLJPW9JHg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr10050106pgc.423.1610670548745;
        Thu, 14 Jan 2021 16:29:08 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id x7sm7094811pga.0.2021.01.14.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 16:29:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 16:29:01 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 3/3] KVM: VMX: read idt_vectoring_info a bit earlier
Message-ID: <YADhzRqE6QHmTOkx@google.com>
References: <20210114205449.8715-1-mlevitsk@redhat.com>
 <20210114205449.8715-4-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114205449.8715-4-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021, Maxim Levitsky wrote:
> This allows it to be printed correctly by the trace print

It'd be helpful to explicitly say which tracepoint, and explain that the value
is read by vmx_get_exit_info().  It's far from obvious how this gets consumed.

> that follows.
> 

Fixes: dcf068da7eb2 ("KVM: VMX: Introduce generic fastpath handler")

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2af05d3b05909..9b6e7dbf5e2bd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6771,6 +6771,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	}
>  
>  	vmx->exit_reason = vmcs_read32(VM_EXIT_REASON);
> +	vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);

Hrm, it probably makes sense to either do the VMREAD conditionally, or to
zero idt_vectoring_info in the vmx->fail path.  I don't care about the cycles
on VM-Exit consistency checks, just that this would hide that the field is valid
if and only if VM-Enter fully succeeded.  A third option would be to add a
comment saying that it's unnecessary if VM-Enter failed, but faster in the
common case to just do the VMREAD.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2af05d3b0590..3c172c05570a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6774,13 +6774,15 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
        if (unlikely((u16)vmx->exit_reason == EXIT_REASON_MCE_DURING_VMENTRY))
                kvm_machine_check();

+       if (likely(!(vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY)))
+               vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
+
        trace_kvm_exit(vmx->exit_reason, vcpu, KVM_ISA_VMX);

        if (unlikely(vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
                return EXIT_FASTPATH_NONE;

        vmx->loaded_vmcs->launched = 1;
-       vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);

        vmx_recover_nmi_blocking(vmx);
        vmx_complete_interrupts(vmx);


> +
>  	if (unlikely((u16)vmx->exit_reason == EXIT_REASON_MCE_DURING_VMENTRY))
>  		kvm_machine_check();
>  
> @@ -6780,7 +6782,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		return EXIT_FASTPATH_NONE;
>  
>  	vmx->loaded_vmcs->launched = 1;
> -	vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
>  
>  	vmx_recover_nmi_blocking(vmx);
>  	vmx_complete_interrupts(vmx);
> -- 
> 2.26.2
> 
