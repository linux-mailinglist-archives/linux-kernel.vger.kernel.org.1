Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F99304F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhA0DPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbhAZT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:59:40 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:56:57 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d13so4614583plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hervW6EmeE0bUtuRL9vcYVnY7YSYLWn8MveytrZ0nZQ=;
        b=qrFAe65qFyZ/Jm3VFlx3HN6JJ5W2QGezVf/WAkrBTJt8+W0rW5mCG4WHo1TtBk76yl
         TPbyD86vbPHpohAbsIdxIdRdszyok8O0lfUzno/BLLHEnpZwlYg+b0Pb/uLFTdDhERbE
         e7uVM1jzFOJeKptrEvcXBCDU/eh6C8ErSgxVUiQ+Vk1lqoTsz5A0WVe5v6krnsvAeN9S
         4t2axDcO7gsj4wvEi7mQfupo86UVPvG3EZDn7QshQicPzvlAUY5ozEvZFKX1kjSQfGDB
         sCDj5H6bwYW7WLmTFacf5JDR0TxtAY/RqhxfVdc/oNKv9YQhgFyAhRKQmVxnmUR0cYAh
         xyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hervW6EmeE0bUtuRL9vcYVnY7YSYLWn8MveytrZ0nZQ=;
        b=CjB9GNC+pmxYlvB/jWbH2TFIRrf39X+nLI5X5sxFSqUfbkqADg9DkWmGQePJC/i2u7
         6pU7IuuqwAiF3tAb7UQgKBqUgOe/Ye8mWMCtoS+AcZCjEM1fIJx6+hJH78Yx9u1NSgyg
         3+Qai+dBHhTZf3L8odJxUNt9L8RR0ELaVXilhsjs9bdh5kLuGHrPU3Yh2M/Z8DXV1Qnz
         smUvnFRG7Fb01vKYZN9gvTASqjb0eRzqbk1Hwzr2cPvK+LFBxlDdPfzEpoIp+qasz5yF
         GGlLC9pkjL/5IDPcKkhD/KHP/TtoddtvohPIHJIVDjMlNGaB6J9CqaunYhRZnFTJGdG3
         QZKA==
X-Gm-Message-State: AOAM533asoufZHIEAw/vXjzjhiAdHlFps420+XX3hRZWzRS3CH1TADCN
        cPilMYrRIDMq9UbaDN0If0yaPQ==
X-Google-Smtp-Source: ABdhPJylmT3DEwnXCHQM9+FpzEzTz+Bt4NTcqMlNMvIbyUolctm2eugoRfQz7CbKlKcq8ip9OQepSw==
X-Received: by 2002:a17:902:c195:b029:de:30af:7d84 with SMTP id d21-20020a170902c195b02900de30af7d84mr7859787pld.15.1611691016989;
        Tue, 26 Jan 2021 11:56:56 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id d22sm2900575pjv.11.2021.01.26.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:56:56 -0800 (PST)
Date:   Tue, 26 Jan 2021 11:56:49 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 6/7] KVM: X86: Expose PKS to guest and userspace
Message-ID: <YBB0AT6xfObR7A5l@google.com>
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-7-chenyi.qiang@intel.com>
 <CALMp9eQ=QUZ04_26eXBGHqvQYnsN6JEgiV=ZSSrE395KLX-atA@mail.gmail.com>
 <20200930043634.GA29319@linux.intel.com>
 <c8f39e4e-75e1-8089-f8ef-9931ce14339f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f39e4e-75e1-8089-f8ef-9931ce14339f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021, Paolo Bonzini wrote:
> On 30/09/20 06:36, Sean Christopherson wrote:
> > > CR4.PKS is not in the list of CR4 bits that result in a PDPTE load.
> > > Since it has no effect on PAE paging, I would be surprised if it did
> > > result in a PDPTE load.
> > It does belong in the mmu_role_bits though;-)
> > 
> 
> Does it?  We don't support PKU/PKS for shadow paging, and it's always zero
> for EPT.  We only support enough PKU/PKS for emulation.

As proposed, yes.  The PKU/PKS mask is tracked on a per-mmu basis, e.g. computed
in update_pkr_bitmask() and consumed in permission_fault() during emulation.
Omitting CR4.PKS from the extended role could let KVM reuse an MMU with the
wrong pkr_mask.

That being said, I don't think it needs a dedicated bit.  IIUC, the logic is
PKU|PKS, with pkr_mask generation being PKU vs. PKS agnostic.  The role could do
the same and smush the bits together, e.g.

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3d6616f6f6ef..3bfca34f6ea2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -293,7 +293,7 @@ union kvm_mmu_extended_role {
                unsigned int cr0_pg:1;
                unsigned int cr4_pae:1;
                unsigned int cr4_pse:1;
-               unsigned int cr4_pke:1;
+               unsigned int cr4_pkr:1;
                unsigned int cr4_smap:1;
                unsigned int cr4_smep:1;
                unsigned int maxphyaddr:6;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 79166288ed03..2774b85a36d5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4448,7 +4448,8 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
        ext.cr4_smep = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
        ext.cr4_smap = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
        ext.cr4_pse = !!is_pse(vcpu);
-       ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
+       ext.cr4_pkr = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE) ||
+                     !!kvm_read_cr4_bits(vcpu, X86_CR4_PKS);
        ext.maxphyaddr = cpuid_maxphyaddr(vcpu);

        ext.valid = 1;


Another option would be to move the tracking out of the MMU, e.g. make pkr_mask
per-vCPU and recalculate when CR4 changes.  I think that would "just work", even
when nested VMs are in play?
