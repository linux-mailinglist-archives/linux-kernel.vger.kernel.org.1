Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1329CD46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJ1BiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:22 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42195 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832988AbgJ0XO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:14:28 -0400
Received: by mail-yb1-f195.google.com with SMTP id a12so2673469ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RKVzA+vjsz7qvsBhnvLWycI0EDYp3zJjS6r1quv/0I=;
        b=uSuWUfIQOOnvG4/9uPrMbn+WKtotJk+5aLhIdzmvRxKs8TtqZJOMVYqvqIw9zWpOPj
         sPnVPfk3Losq5Xu5ezACYwxFkhnL/7c3Jln9ChCRBdXLDgqI2TvJleZ3tF2+znFAW5hW
         YMqocqurj9ZB3e/tpfciWF6VkRtLGrSpLWGAtyJf/nM6r90610szaPSZwhShLikftUlg
         lrMSN0VPm9np2lgFP9ftmZ9kimMFc2tsQWpRdZN/mFT4oxlgZ0XcDYC7fYAb2g31L6w5
         pRJm8Vy9VQtXq/rSE5+LD7xC49/AjjfQMYfsfpa4Dy4XzFmb2B3zUBNGcEwV5vwNFZg7
         n2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RKVzA+vjsz7qvsBhnvLWycI0EDYp3zJjS6r1quv/0I=;
        b=X8ctr9yO8UlsdNb3HD+9sstyAvOxiW5SMJd+cyt0uBomlwh1j0sYb8TS9pyWPbO/ti
         ekZkZk8QWFtueW5CY+6pdW6pocGPWofwvOjJwWs3Lrdun2Zli0Mp86MBkPOd3lxkpswF
         qnwg0O1dS6Zw4927nMbfEgjP7BHmmRktZvUbybtkQhI+uyJISC0Iwe/goM4CwV9qxPLX
         Jh0r3gTmBy3Nuj6ROkmC4RLS37gOcDcCkJrxE/Sw8xTb8lARqYOOo7UTLKJRf+sGjV3l
         z631NRPyYkrkzEMYpVB79HHTZHhyJxlMkB349iQTyPYkC7kJQwm9ApRC83DkDaL74E1Q
         kXqw==
X-Gm-Message-State: AOAM532qiANFee9NN3Kz7KN2tYccVpcDsZJOAKV+0HRJkFy82V/gFr86
        W1R1WOa/Q7YWMZDZdqHSKxh7wC37xJPaNbmZSxGMCK6TmzZXnc6a
X-Google-Smtp-Source: ABdhPJykNKkdaTUUPhpLElFFruaXGw4Yr1aXQrjPmrHZDZI8pcEHEHrWY5WErPJrLv1tIl5q+kxLnjhKm1CgcYSdNE4=
X-Received: by 2002:a5b:ad1:: with SMTP id a17mr6326666ybr.85.1603840466816;
 Tue, 27 Oct 2020 16:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200907131613.12703-64-joro@8bytes.org> <159972972598.20229.12880317872521101289.tip-bot2@tip-bot2>
 <CAAYXXYx=Eq4gYfUqdO7u37VRD_GpPYFQgN=GZySmAMcDc2AM=g@mail.gmail.com>
In-Reply-To: <CAAYXXYx=Eq4gYfUqdO7u37VRD_GpPYFQgN=GZySmAMcDc2AM=g@mail.gmail.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Tue, 27 Oct 2020 16:14:15 -0700
Message-ID: <CAAYXXYw7ZKM+4ZCzn_apb4iy07R5VfcYeyus-kc0ETh_vkBkPg@mail.gmail.com>
Subject: Re: [tip: x86/seves] x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES
To:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     linux-tip-commits@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending in plain/text, sorry for double sending]

It seems to me that the kvm_sev_es_hcall_prepare is leaking more
information than it is needed. Is this an expected behavior?
-Erdem


>
> On Thu, Sep 10, 2020 at 2:39 AM tip-bot2 for Tom Lendacky <tip-bot2@linutronix.de> wrote:
>>
>> The following commit has been merged into the x86/seves branch of tip:
>>
>> Commit-ID:     99419b251e5427b89dbfae103d8a2f469efaa4b2
>> Gitweb:        https://git.kernel.org/tip/99419b251e5427b89dbfae103d8a2f469efaa4b2
>> Author:        Tom Lendacky <thomas.lendacky@amd.com>
>> AuthorDate:    Mon, 07 Sep 2020 15:16:04 +02:00
>> Committer:     Borislav Petkov <bp@suse.de>
>> CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00
>>
>> x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES
>>
>> Implement the callbacks to copy the processor state required by KVM to
>> the GHCB.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> [ jroedel@suse.de: - Split out of a larger patch
>>                    - Adapt to different callback functions ]
>> Co-developed-by: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Link: https://lkml.kernel.org/r/20200907131613.12703-64-joro@8bytes.org
>> ---
>>  arch/x86/kernel/kvm.c | 35 +++++++++++++++++++++++++++++------
>>  1 file changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 08320b0..0f95972 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -36,6 +36,8 @@
>>  #include <asm/hypervisor.h>
>>  #include <asm/tlb.h>
>>  #include <asm/cpuidle_haltpoll.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/svm.h>
>>
>>  DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
>>
>> @@ -746,13 +748,34 @@ static void __init kvm_init_platform(void)
>>         x86_platform.apic_post_init = kvm_apic_init;
>>  }
>>
>> +#if defined(CONFIG_AMD_MEM_ENCRYPT)
>> +static void kvm_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
>> +{
>> +       /* RAX and CPL are already in the GHCB */
>> +       ghcb_set_rbx(ghcb, regs->bx);
>> +       ghcb_set_rcx(ghcb, regs->cx);
>> +       ghcb_set_rdx(ghcb, regs->dx);
>> +       ghcb_set_rsi(ghcb, regs->si);
>> +}
>> +
>> +static bool kvm_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
>> +{
>> +       /* No checking of the return state needed */
>> +       return true;
>> +}
>> +#endif
>> +
>>  const __initconst struct hypervisor_x86 x86_hyper_kvm = {
>> -       .name                   = "KVM",
>> -       .detect                 = kvm_detect,
>> -       .type                   = X86_HYPER_KVM,
>> -       .init.guest_late_init   = kvm_guest_init,
>> -       .init.x2apic_available  = kvm_para_available,
>> -       .init.init_platform     = kvm_init_platform,
>> +       .name                           = "KVM",
>> +       .detect                         = kvm_detect,
>> +       .type                           = X86_HYPER_KVM,
>> +       .init.guest_late_init           = kvm_guest_init,
>> +       .init.x2apic_available          = kvm_para_available,
>> +       .init.init_platform             = kvm_init_platform,
>> +#if defined(CONFIG_AMD_MEM_ENCRYPT)
>> +       .runtime.sev_es_hcall_prepare   = kvm_sev_es_hcall_prepare,
>> +       .runtime.sev_es_hcall_finish    = kvm_sev_es_hcall_finish,
>> +#endif
>>  };
>>
>>  static __init int activate_jump_labels(void)
