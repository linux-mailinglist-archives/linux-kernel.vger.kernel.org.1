Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F382850E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgJFRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:36:21 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC29C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 10:36:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x62so9001264oix.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mazb5p/CVINtUGXj46lnFOxfjQtw41l3/+VIi18FkLw=;
        b=E/PxT/QY9txUSAaodb4r9PU1yFxoQB8DUFXg7mPwcRbdpYpMNWJsJemOTSHPhrdR9w
         pVN7xGtz5uShbPDtIqGfccYEXA71CJ3ijXoKu70FQjCdt3xsNz6aHH+YaroUlrbxfkZE
         oFo0YTjKAtwO/Ig5OS/QEW9iPlOvE9p29P7/Kd9Py5KbvnFKusWfav03RsDOHuCubYpg
         1JVymeyRhermYVz3C0u5VZa0PuDL7W0IfW+4TkmQi7JSSmctqWlrcr2oIY8q1lhy5FIN
         27dm9BoU9WVGMHYe5dSNc93XDVB4x1FWYsPpA+sEbMhoVsNiSWVQWLCFsGjD7/Kd9mMP
         7DWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mazb5p/CVINtUGXj46lnFOxfjQtw41l3/+VIi18FkLw=;
        b=kvZmMZ0CbX+1HNXrc47nw//RGHC9EIwr0SSWo/9KGia7SHyepW8nPz/FZDLmwjemTl
         KNBFZeQZeb6CzBsDt6YIM+PrvDfnfOIHiqwcoQtzw+j+kuYsI/NZMEhZi4nIfuqAWCL/
         h7SOgNW+yOMqNN6UiSLydiOINaMlbux3EnnqZyljDfMPHK9lnzex7txa93/JUc1pi5JB
         06TfI3PthpD5OYZ29eQxCVPKKDH/v/nswFTswQpz9n1UpgeEgtoadOWSAgrTBdp+qwA2
         xKhRrdHK8Yoabknys9rJqa/VuJo01iRPoVn0UNrYs/tNM9wOIsNfPyXwny1nO8NpjTwT
         gxjw==
X-Gm-Message-State: AOAM531c+hcxoR3uzt2jhDsA71JIelqZomY6oX4YBV9wWXOR9+x0xRKH
        7THZqbDyyMNkrmeawCX8Wc3ZkwK3/04gr1s8xBM+Pw==
X-Google-Smtp-Source: ABdhPJyKZ1uYnyMjkzt69ciMheqHv/JFAvfxq8TFacleYotNjpffENQEBZV1uIVcpJwo1DjZrIhsZwzpNhn96/r0e8I=
X-Received: by 2002:aca:5b05:: with SMTP id p5mr3259808oib.6.1602005780792;
 Tue, 06 Oct 2020 10:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200812175129.12172-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200812175129.12172-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 6 Oct 2020 10:36:09 -0700
Message-ID: <CALMp9eTc9opgQ4pU92wmKSM6gUv6AEKZRqSnv_Q+rzixOLOZiw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Morph notification vector IRQ on nested
 VM-Enter to pending PI
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 10:51 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On successful nested VM-Enter, check for pending interrupts and convert
> the highest priority interrupt to a pending posted interrupt if it
> matches L2's notification vector.  If the vCPU receives a notification
> interrupt before nested VM-Enter (assuming L1 disables IRQs before doing
> VM-Enter), the pending interrupt (for L1) should be recognized and
> processed as a posted interrupt when interrupts become unblocked after
> VM-Enter to L2.
>
> This fixes a bug where L1/L2 will get stuck in an infinite loop if L1 is
> trying to inject an interrupt into L2 by setting the appropriate bit in
> L2's PIR and sending a self-IPI prior to VM-Enter (as opposed to KVM's
> method of manually moving the vector from PIR->vIRR/RVI).  KVM will
> observe the IPI while the vCPU is in L1 context and so won't immediately
> morph it to a posted interrupt for L2.  The pending interrupt will be
> seen by vmx_check_nested_events(), cause KVM to force an immediate exit
> after nested VM-Enter, and eventually be reflected to L1 as a VM-Exit.
> After handling the VM-Exit, L1 will see that L2 has a pending interrupt
> in PIR, send another IPI, and repeat until L2 is killed.
>
> Note, posted interrupts require virtual interrupt deliveriy, and virtual
> interrupt delivery requires exit-on-interrupt, ergo interrupts will be
> unconditionally unmasked on VM-Enter if posted interrupts are enabled.
>
> Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processing")
> Cc: stable@vger.kernel.org
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
I don't think this is the best fix.

I believe the real problem is the way that external and posted
interrupts are handled in vmx_check_nested_events().

First of all, I believe that the existing call to
vmx_complete_nested_posted_interrupt() at the end of
vmx_check_nested_events() is far too aggressive. Unless I am missing
something in the SDM, posted interrupt processing is *only* triggered
when the notification vector is received in VMX non-root mode. It is
not triggered on VM-entry.

Looking back one block, we have:

if (kvm_cpu_has_interrupt(vcpu) && !vmx_interrupt_blocked(vcpu)) {
    if (block_nested_events)
        return -EBUSY;
    if (!nested_exit_on_intr(vcpu))
        goto no_vmexit;
    nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT, 0, 0);
    return 0;
}

If nested_exit_on_intr() is true, we should first check to see if
"acknowledge interrupt on exit" is set. If so, we should acknowledge
the interrupt right here, with a call to kvm_cpu_get_interrupt(),
rather than deep in the guts of nested_vmx_vmexit(). If the vector we
get is the notification vector from VMCS12, then we should call
vmx_complete_nested_posted_interrupt(). Otherwise, we should call
nested_vmx_vmexit(EXIT_REASON_EXTERNAL_INTERRUPT) as we do now.

Furthermore, vmx_complete_nested_posted_interrupt() should write to
the L1 EOI register, as indicated in step 4 of the 7-step sequence
detailed in section 29.6 of the SDM, volume 3. It skips this step
today.
