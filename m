Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65B204E33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgFWJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:42:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732023AbgFWJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592905364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoBwKmjOvInG9MfmBsLrqKkfpaZqKCYNSmoYTUfOHHE=;
        b=W4imJMlVrdXnxVmceX+aEA5Vc0QjNCsiOIZ/YP4/e15mTqZa3dvrTqJ/Vi9YdJVop+Ad/F
        X77hWs09TzvvUVpIOtWeIFvLPBA6x9X8PKtpgyta+JyChwSyGbYYYSCUFZzAvBi1yGreuh
        xPFYNC5qVZGN9GyBGJnQ5L+aRMU6J4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Wx1_qQ-AMCSa3ZFrMk9Jsw-1; Tue, 23 Jun 2020 05:42:43 -0400
X-MC-Unique: Wx1_qQ-AMCSa3ZFrMk9Jsw-1
Received: by mail-wr1-f71.google.com with SMTP id y13so1448886wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QoBwKmjOvInG9MfmBsLrqKkfpaZqKCYNSmoYTUfOHHE=;
        b=WPb3ykm5vc1jvP2Bidut4/6CCZQ41N8tfdx/rEVNz20dxuPM9Vu6nMVuWSsB+PkCI4
         zDqpMkHMCZ4CtZ9WklXMEe80acpcWoVF9tlmvfnNZD1cy+orVAU1DrwkS3SZoPvo17DF
         KrqRcaioyICbC/872OPg89SgsPS6rZtR3s8NFZffF2cFnfOi/TbLxZ1tv0r8v45xrCZn
         GR5bsgRYYA/rOLDsJoqDWObR9cvSLejhMmbeSu8i9THxFRb+t5IToI762vuDKeLC1OWT
         CaIjHKTOAeJYHzk4znvjRhLq1kUFWsU53YgPMQ04+PjMgNLrTVa5gd89W77iIEzrLa3B
         HJoA==
X-Gm-Message-State: AOAM533mskYcjfT/lzXIP9Q6inkBkWBbj1BqASHltlDvDMMeUOEVubIc
        Eu/FD4qq341dHaNmy7eUBCBXWZC0ch2Q25C6xjoGiJZTnHk6tyYzW0QeaXPP9hr7wprqPO3QVxu
        tu/69u8YYBpX5Q25gAANBWq4d
X-Received: by 2002:adf:e908:: with SMTP id f8mr1064534wrm.3.1592905361581;
        Tue, 23 Jun 2020 02:42:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYpabjIXBcOB9eaiLhNkEzAaSPqokuBtil8iucj5gBxqX45bVu6WVMKG+2KSXPDnKUswgA9A==
X-Received: by 2002:adf:e908:: with SMTP id f8mr1064490wrm.3.1592905361326;
        Tue, 23 Jun 2020 02:42:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id 26sm1149131wmj.25.2020.06.23.02.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:42:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] clean up redundant 'kvm_run' parameters
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com,
        chenhuacai@gmail.com
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe463233-d094-fca5-b4e9-c1d97124fd69@redhat.com>
Date:   Tue, 23 Jun 2020 11:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20 06:35, Tianjia Zhang wrote:
> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.
> 
> This series of patches has completely cleaned the architecture of
> arm64, mips, ppc, and s390 (no such redundant code on x86). Due to
> the large number of modified codes, a separate patch is made for each
> platform. On the ppc platform, there is also a redundant structure
> pointer of 'kvm_run' in 'vcpu_arch', which has also been cleaned
> separately.

Tianjia, can you please refresh the patches so that each architecture
maintainer can pick them up?  Thanks very much for this work!

Paolo

> 
> ---
> v4 change:
>   mips: fixes two errors in entry.c.
> 
> v3 change:
>   Keep the existing `vcpu->run` in the function body unchanged.
> 
> v2 change:
>   s390 retains the original variable name and minimizes modification.
> 
> Tianjia Zhang (7):
>   KVM: s390: clean up redundant 'kvm_run' parameters
>   KVM: arm64: clean up redundant 'kvm_run' parameters
>   KVM: PPC: Remove redundant kvm_run from vcpu_arch
>   KVM: PPC: clean up redundant 'kvm_run' parameters
>   KVM: PPC: clean up redundant kvm_run parameters in assembly
>   KVM: MIPS: clean up redundant 'kvm_run' parameters
>   KVM: MIPS: clean up redundant kvm_run parameters in assembly
> 
>  arch/arm64/include/asm/kvm_coproc.h      |  12 +--
>  arch/arm64/include/asm/kvm_host.h        |  11 +--
>  arch/arm64/include/asm/kvm_mmu.h         |   2 +-
>  arch/arm64/kvm/handle_exit.c             |  36 +++----
>  arch/arm64/kvm/sys_regs.c                |  13 ++-
>  arch/mips/include/asm/kvm_host.h         |  32 +------
>  arch/mips/kvm/emulate.c                  |  59 ++++--------
>  arch/mips/kvm/entry.c                    |  21 ++---
>  arch/mips/kvm/mips.c                     |  14 +--
>  arch/mips/kvm/trap_emul.c                | 114 ++++++++++-------------
>  arch/mips/kvm/vz.c                       |  26 ++----
>  arch/powerpc/include/asm/kvm_book3s.h    |  16 ++--
>  arch/powerpc/include/asm/kvm_host.h      |   1 -
>  arch/powerpc/include/asm/kvm_ppc.h       |  27 +++---
>  arch/powerpc/kvm/book3s.c                |   4 +-
>  arch/powerpc/kvm/book3s.h                |   2 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c      |  12 +--
>  arch/powerpc/kvm/book3s_64_mmu_radix.c   |   4 +-
>  arch/powerpc/kvm/book3s_emulate.c        |  10 +-
>  arch/powerpc/kvm/book3s_hv.c             |  64 ++++++-------
>  arch/powerpc/kvm/book3s_hv_nested.c      |  12 +--
>  arch/powerpc/kvm/book3s_interrupts.S     |  17 ++--
>  arch/powerpc/kvm/book3s_paired_singles.c |  72 +++++++-------
>  arch/powerpc/kvm/book3s_pr.c             |  33 ++++---
>  arch/powerpc/kvm/booke.c                 |  39 ++++----
>  arch/powerpc/kvm/booke.h                 |   8 +-
>  arch/powerpc/kvm/booke_emulate.c         |   2 +-
>  arch/powerpc/kvm/booke_interrupts.S      |   9 +-
>  arch/powerpc/kvm/bookehv_interrupts.S    |  10 +-
>  arch/powerpc/kvm/e500_emulate.c          |  15 ++-
>  arch/powerpc/kvm/emulate.c               |  10 +-
>  arch/powerpc/kvm/emulate_loadstore.c     |  32 +++----
>  arch/powerpc/kvm/powerpc.c               |  72 +++++++-------
>  arch/powerpc/kvm/trace_hv.h              |   6 +-
>  arch/s390/kvm/kvm-s390.c                 |  23 +++--
>  virt/kvm/arm/arm.c                       |   6 +-
>  virt/kvm/arm/mmio.c                      |  11 ++-
>  virt/kvm/arm/mmu.c                       |   5 +-
>  38 files changed, 392 insertions(+), 470 deletions(-)
> 

