Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3784C2D9185
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 02:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437381AbgLNBDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 20:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLNBDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 20:03:12 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81729C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 17:02:31 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k8so14343674ilr.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 17:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwoZAstNyItowRl75/JkfYhPz9GxjpG8UKmIVeiIkU4=;
        b=jg1VAG8Y9spbeNPm0HqZQYyzZbUThDGajQczBhxopY/eZ0ZfZOy1rtNtMpfTcUJN2e
         hcTDkndVSeCSv8XfUkk1ct333kRwrfVXn1wJ8rT8VTHfhE4vDaikBJeJ50nbAEiSjdAH
         Tc+fFmMLY5KDmELT+OGUNcqBKacXiC7mJb8ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwoZAstNyItowRl75/JkfYhPz9GxjpG8UKmIVeiIkU4=;
        b=SSALFu69TlT8xvTv9+MeP6GKh6zdwCC/BPHMCJhJVAC7nXK2qrb+0Fc9PQxCAnXak4
         Ap97YTroEXYE39I8UTiSFnsZlkOXgfDm1x3EWITa5rMfHcb5ILd5Xhwdlve+3NYEx4fa
         t23Ww4CIt5IY1zwpG/mQeIFK8QBNKoEfWDirxqe+PKBWASYM9dVwXokiqhcL7wUMMLkz
         in1vgm4sLtX661VajDPQSLEnGXB3vT3r9QmNxKMoWG1fmhRLCdXwHW8apMhYOa7HwUB4
         r0imsGRa6y4oQcdxH0QlpMyAAit3CTRaKUkL7mPtp8kvi7ALYW6ZAf7sZW3W3HSrAoMC
         UaHQ==
X-Gm-Message-State: AOAM530WgwNBT8cFRQejfnU2brGtwXKpqCqM3NVaV+AFzak7XkceQL5r
        gSs6s+Po9ROFX+LRPx7bus8zDHj2YdE/AgVwP5QS
X-Google-Smtp-Source: ABdhPJxwGY4W0ZwhqdX57uqaRtOvyYqqWikXmuAUulNParGeFaU61YIkG4qfuzXaAXRgstDfVpPKylEyEQP/pDhhDt0=
X-Received: by 2002:a92:6410:: with SMTP id y16mr31116431ilb.126.1607907750716;
 Sun, 13 Dec 2020 17:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20201119003829.1282810-1-atish.patra@wdc.com>
In-Reply-To: <20201119003829.1282810-1-atish.patra@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 13 Dec 2020 17:02:19 -0800
Message-ID: <CAOnJCULPCxhirYH8xCciKDNJ=zfWKwiOOfAoT8QQBOKqTuWuTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        Baoquan He <bhe@redhat.com>, Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 4:39 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> This series attempts to move the ARM64 numa implementation to common
> code so that RISC-V can leverage that as well instead of reimplementing
> it again.
>
> RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> modified to reuse the common implementation to avoid duplication.
>
> [1] https://lkml.org/lkml/2020/1/10/233
>
> This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> This patch series doesn't modify the maintainers list for the common code (arch_numa)
> as I am not sure if somebody from ARM64 community or Greg should take up the
> maintainership. Ganapatrao was the original author of the arm64 version.
> I would be happy to update that in the next revision once it is decided.
>
> # numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3
> node 0 size: 486 MB
> node 0 free: 470 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 424 MB
> node 1 free: 408 MB
> node distances:
> node   0   1
>   0:  10  20
>   1:  20  10
> # numactl -show
> policy: default
> preferred node: current
> physcpubind: 0 1 2 3 4 5 6 7
> cpubind: 0 1
> nodebind: 0 1
> membind: 0 1
>
> The patches are also available at
> https://github.com/atishp04/linux/tree/5.11_numa_unified_v5
>
> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
>
> Testing:
> RISC-V:
> Tested in Qemu and 2 socket OmniXtend FPGA.
>
> ARM64:
> 2 socket kunpeng920 (4 nodes around 250G a node)
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Changes from v4->v5:
> 1. Added by Acked-by & Reviewed-by tags.
> 2. Swapped patch 1 & 2 in v4 version.
>
> Changes from v3->v4:
> 1. Removed redundant duplicate header.
> 2. Added Reviewed-by tags.
>
> Changes from v2->v3:
> 1. Added Acked-by/Reviewed-by tags.
> 2. Replaced asm/acpi.h with linux/acpi.h
> 3. Defined arch_acpi_numa_init as static.
>
> Changes from v1->v2:
> 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
> 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
> 3. Fixed few typos.
>
> Atish Patra (4):
> arm64, numa: Change the numa init functions name to be generic
> numa: Move numa implementation to common code
> riscv: Separate memory init from paging init
> riscv: Add numa support for riscv64 platform
>
> Greentime Hu (1):
> riscv: Add support pte_protnone and pmd_protnone if
> CONFIG_NUMA_BALANCING
>
> arch/arm64/Kconfig                            |  1 +
> arch/arm64/include/asm/numa.h                 | 48 +----------------
> arch/arm64/kernel/acpi_numa.c                 | 12 -----
> arch/arm64/mm/Makefile                        |  1 -
> arch/arm64/mm/init.c                          |  4 +-
> arch/riscv/Kconfig                            | 31 ++++++++++-
> arch/riscv/include/asm/mmzone.h               | 13 +++++
> arch/riscv/include/asm/numa.h                 |  8 +++
> arch/riscv/include/asm/pci.h                  | 14 +++++
> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> arch/riscv/kernel/setup.c                     | 11 +++-
> arch/riscv/kernel/smpboot.c                   | 12 ++++-
> arch/riscv/mm/init.c                          | 10 +++-
> drivers/base/Kconfig                          |  6 +++
> drivers/base/Makefile                         |  1 +
> .../mm/numa.c => drivers/base/arch_numa.c     | 27 ++++++++--
> include/asm-generic/numa.h                    | 52 +++++++++++++++++++
> 17 files changed, 200 insertions(+), 72 deletions(-)
> create mode 100644 arch/riscv/include/asm/mmzone.h
> create mode 100644 arch/riscv/include/asm/numa.h
> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (96%)
> create mode 100644 include/asm-generic/numa.h
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Hey Palmer,
I did not see this series in for-next. Let me know if you need
anything else to be done for this series.

-- 
Regards,
Atish
