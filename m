Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98F42809B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgJAVwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgJAVwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:52:45 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361932177B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589165;
        bh=CZSDnfsc4bKGWbay4OeT0o0Nf5AYRw6kPxnuiRiXHEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tPhfYbW4KVb5UscT8JmRXmNI2LddTKtVfJsHtmfrgMTmX3BwsXZ2bWlSfb6wdmrUZ
         kaU+Q2hjoDQdJeHnyrK/EnZ7Nppavmh1FKK6sliOgeyBcyoWLCqFLFMli6eoudEVmS
         GEkltt66FC2BhHP4iqzMdWVHso8F2JOF+/6MgpEc=
Received: by mail-wr1-f41.google.com with SMTP id o5so317323wrn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 14:52:45 -0700 (PDT)
X-Gm-Message-State: AOAM532focvXYJ0f/TKnGtMsl52ZyYuMUkz8FoeuuzdCOT88D4c6tvrV
        1uAhLn+i0cnsUGRto9tD2APqWVbH4hoZMDxs+tr8bA==
X-Google-Smtp-Source: ABdhPJxICP1vF2QFoDulgzxcCPbMNbJyiVHkmZhVSw1F+MMSWVhPUtGuRF16fYlRwSUO2ttWdFL24ctQoESYbaySsjo=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr11029398wrb.70.1601589163746;
 Thu, 01 Oct 2020 14:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-8-krisman@collabora.com>
In-Reply-To: <20201001205819.27879-8-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 14:52:32 -0700
X-Gmail-Original-Message-ID: <CALCETrW74MjC2-MRkRrp3uGOhapH_1zG5GCBkPsLFXs+jPXNOg@mail.gmail.com>
Message-ID: <CALCETrW74MjC2-MRkRrp3uGOhapH_1zG5GCBkPsLFXs+jPXNOg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] x86: Use current USER_CS to setup correct context
 on vmx entry
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> vmx_prepare_switch_to_guest shouldn't use is_64bit_mm, which has a
> very specific use in uprobes.  Use the user_64bit_mode helper instead.
> This reduces the usage of is_64bit_mm, which is awkward, since it relies
> on the personality at load time, which is fine for uprobes, but doesn't
> seem fine here.
>
> I tested this by running VMs with 64 and 32 bits payloads from 64/32
> programs.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 7b2a068f08c1..b5aafd9e5f5d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1172,7 +1172,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>         savesegment(es, host_state->es_sel);
>
>         gs_base = cpu_kernelmode_gs_base(cpu);
> -       if (likely(is_64bit_mm(current->mm))) {
> +       if (likely(user_64bit_mode(current_pt_regs()))) {
>                 current_save_fsgs();
>                 fs_sel = current->thread.fsindex;
>                 gs_sel = current->thread.gsindex;

I disagree with this one.  This whole code path is nonsense.  Can you
just remove the condition entirely and use the 64-bit path
unconditionally?
]
