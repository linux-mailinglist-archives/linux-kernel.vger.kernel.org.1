Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FBC297A52
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 04:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbgJXCNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 22:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756727AbgJXCNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 22:13:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:13:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id f8so4009439oij.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0Ujqe4ZUZFtu/lYhqxeeV/BQscYr5R12aTQxmFkXZqQ=;
        b=RnL9+h3MHknkfWyccUeUFg+CuFhAHssEBLufs1jVN8iAXg7+elkF2mZSLEjRLAAp4I
         Fvqus6nnfgFlkX4FYfdqgPqe+/nAutGI8c2G1IAdi/kIvXRrWugrguUi/VM3oDI3vl8+
         goY8Nlvmw4piK+AIlMpVqTtOwhsyAMrr0mbOwoXLTHbLFIxdJSWNPGgr4CfzfL8FzC4q
         idUW6u00cHwfjTxnQV6srSNOVhvFWN+T4KkTf+Gpq9NrT41O0nGwROc/o4DJlHgTO4GZ
         yQ66Ic9cXdxyQPXL8d7f4fkuyLxbIxUd1Vmxx/PK1uMiLUU8efwDmznSvLQ0hOvUSFiX
         AZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0Ujqe4ZUZFtu/lYhqxeeV/BQscYr5R12aTQxmFkXZqQ=;
        b=pWhL5xSAOrBr+/5oLdt8AocYwdShilR0CdAqEgOvQlLPdSxy1URO6ouwURyGIaIgrQ
         f+070ecbv14uy9HQPHoA4ZrnRb3wO0GjAuNappGcIQ0S3T9sIkaRqqQc1UFNwnV8Rt7B
         fF5obDy0YK2FPlKjSt7VU5plC02uFCW5/dD2TZrEBuDoJU95X50pL/HFt/XnlS4/Dbke
         AP6YyMXX8nN8aptgulL7gBFsIntTGK8Gaa8bzPfwqmnmxERUlLijFybpDPURiQe/tNDf
         J0ceWo1AQbOuTZDAUr0au58i8IntQ7qHiQxuqtSVRzuYmIknJk5grw5jAPrNMIV6DkoR
         RPiA==
X-Gm-Message-State: AOAM533iai0cf7ofnV05v7cynhqs0qOvcrVkbQ5KpH1iPo3p9w8/znJM
        3puCeLQYdurjryf0OfPWwIu2DrcpEP8FJLQmpB5clA==
X-Google-Smtp-Source: ABdhPJylPkgfbyKnnnP8iIPPmlxSrfJUSjgIrcloB7NBlcY8qCf2tlR3+0iPpZ3lSJ8/DSepEaoAnPT/pTnbAUpD86U=
X-Received: by 2002:a05:6808:605:: with SMTP id y5mr4332428oih.172.1603505612450;
 Fri, 23 Oct 2020 19:13:32 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Fri, 23 Oct 2020 21:13:21 -0500
Message-ID: <CAEUSe7_bptXLQQt5TkUoVitnFbnAF-KkyqQpcZnYuKgSGuBpPw@mail.gmail.com>
Subject: kvm: x86-32 fails to link with tdp_mmu
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We found the following problem building torvalds/master, which
recently merged the for-linus tag from the KVM tree, when building
with gcc 7.3.0 and glibc 2.27 for x86 32-bits under OpenEmbedded:

|   LD      vmlinux.o
|   MODPOST vmlinux.symvers
|   MODINFO modules.builtin.modinfo
|   GEN     modules.builtin
|   LD      .tmp_vmlinux.kallsyms1
| arch/x86/kvm/mmu/tdp_mmu.o: In function `__handle_changed_spte':
| tdp_mmu.c:(.text+0x78a): undefined reference to `__umoddi3'
| /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/Mak=
efile:1164:
recipe for target 'vmlinux' failed
| make[1]: *** [vmlinux] Error 1
| /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/Mak=
efile:185:
recipe for target '__sub-make' failed
| make: *** [__sub-make] Error 2

This builds fine for x86 (64 bits) and arm (32/64 bits) with the same
toolchain. This also builds correctly (outside OpenEmbedded) with
gcc-8, gcc-9 and gcc-10 for: x86 (32/64 bits), arm (32/64 bits), MIPS,
and RISCV; and gcc-8 and gcc-9 for ARC.

We first noticed this when 0adc313c4f20 was pushed, but reverting
f9a705ad1c07 ("Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/virt/kvm/kvm") brought it back into
building.

A follow-up bisection led to faaf05b00aec ("kvm: x86/mmu: Support
zapping SPTEs in the TDP MMU"). In that commit, the problematic code
was:

        handle_changed_spte(kvm, as_id, iter->gfn, iter->old_spte, new_spte=
,
                            iter->level);

which was later changed by f8e144971c68 ("kvm: x86/mmu: Add access
tracking for tdp_mmu") to:

        __handle_changed_spte(kvm, as_id, iter->gfn, iter->old_spte, new_sp=
te,
                              iter->level);

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
