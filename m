Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15122704E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIRTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:18:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:18:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so6618287wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgLhkSl4Ln4PgVmRRlV8CSWEEibzB6LTYIniaCt7hTI=;
        b=VMLSvgaHAfiPg2fsN2PsLRp8GVoZuqSO27V2nQONT7+riIaAsuuHn+IDJR1AHKqwGO
         apv6JIQ5eDc4gk+YAKW3BireX5SpIPeuHhINh4DbHScfEI4LKeYKwejzXdRbzgU9TUAU
         oOzDuL6BQLF3Sysi/aeGimISg8m+vtrOukOwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgLhkSl4Ln4PgVmRRlV8CSWEEibzB6LTYIniaCt7hTI=;
        b=ndk1evjdtLLgtif+4dl4oC3EItedsvUt6p7WYrGHYDMAUCXj8xNhN2MwpaaUs3IAmR
         nKxWiTaaBOtYqGMJz+azf9wXrS/TlaiRyZUfoT0/dY5nF9O4mS7B2fIguYmRydkMKndz
         DP9YiwSfhI7rYGMD+5VYHbrwGalnY4NlRSrJOMhOdOxL3+Dk/YRJCOluhOrm2A4lfRC/
         T9O8+7gbXBiOXkt2Hb+upHRe9FCz3oKbXFsBww4qZajkiKlU1QRsnwtOT/7ZLZp+Ce1N
         8DG4ZAg1SxHr6+uCy9aOVukJ62DiAm08xfWDdVyxmAmL8fZEa0m0RBG5QHOTbEFPq+FV
         C3UA==
X-Gm-Message-State: AOAM531J/lwmKqzKCPC/RzeXVc6LEAMdubeGK7an6yZ2D+sQZS25tdqP
        2a8pDtRi7DTr9Ians8Z0DDBZTL69knQWhHcC9eGd
X-Google-Smtp-Source: ABdhPJznH4owndgyTEbnLHdIMANVTk03bWNnDTTvYelqcq7gacsp8Tq1XD304rhxw4WWFZb4ib7m3g7lb62RKeVOhPk=
X-Received: by 2002:a05:600c:2cc1:: with SMTP id l1mr16649341wmc.78.1600456719035;
 Fri, 18 Sep 2020 12:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200912013441.9730-1-atish.patra@wdc.com> <20200914090448.00001f7f@Huawei.com>
 <CAOnJCULGNha6aZaWZDn8zX3MZHn1H=uCrnNjpiqE11meRQz5eQ@mail.gmail.com> <20200918170514.00002e44@Huawei.com>
In-Reply-To: <20200918170514.00002e44@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 18 Sep 2020 12:18:27 -0700
Message-ID: <CAOnJCUJ=JSv2=H6J9+Q8svAhdvUM1DS5YC+Gjkhf66K6NvxH8g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 9:06 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 14 Sep 2020 12:33:59 -0700
> Atish Patra <atishp@atishpatra.org> wrote:
>
> > On Mon, Sep 14, 2020 at 1:07 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 11 Sep 2020 18:34:36 -0700
> > > Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > >
> > > Hi Atish,
> > >
> > > I'm not seeing a change log from v1.  Putting one in makes it easier
> > > for people who reviewed v1 to remember what to look for when looking
> > > at v2.
> > >
> >
> > My bad. I usually add a change log in the header patch but forgot this time.
> > I will send out a v3 soon and update those.
> >
> > Thanks for reviewing the patches.
>
> Hi Atish,
>
> I just noticed this was also not sent to <linux-arm-kernel@lists.infradead.org>
> which will rather cut down on the relevant audience!  Add that list to the
> cc for v3.
>
Ah yes. Thanks for noticing that. I am surprised that
get-maintainers.pl did not add linux-arm-kernel mailing list
for this series.

Anyways, I will include that in v3 which I was about to send :).

> Thanks,
>
> Jonathan
>
> > > Either here, or individual patches after the --- is fine.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
> > > > This series attempts to move the ARM64 numa implementation to common
> > > > code so that RISC-V can leverage that as well instead of reimplementing
> > > > it again.
> > > >
> > > > RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> > > > modified to reuse the common implementation to avoid duplication.
> > > >
> > > > [1] https://lkml.org/lkml/2020/1/10/233
> > > >
> > > > This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> > > > It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> > > > This patch series doesn't modify the maintainers list for the common code (arch_numa)
> > > > as I am not sure if somebody from ARM64 community or Greg should take up the
> > > > maintainership. Ganapatrao was the original author of the arm64 version.
> > > > I would be happy to update that in the next revision once it is decided.
> > > >
> > > > # numactl --hardware
> > > > available: 2 nodes (0-1)
> > > > node 0 cpus: 0 1 2 3
> > > > node 0 size: 486 MB
> > > > node 0 free: 470 MB
> > > > node 1 cpus: 4 5 6 7
> > > > node 1 size: 424 MB
> > > > node 1 free: 408 MB
> > > > node distances:
> > > > node   0   1
> > > >   0:  10  20
> > > >   1:  20  10
> > > > # numactl -show
> > > > policy: default
> > > > preferred node: current
> > > > physcpubind: 0 1 2 3 4 5 6 7
> > > > cpubind: 0 1
> > > > nodebind: 0 1
> > > > membind: 0 1
> > > >
> > > > For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> > > > to test the patches in Qemu and 2 socket OmniXtend FPGA.
> > > >
> > > > https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
> > > >
> > > > The patches are also available at
> > > >
> > > > https://github.com/atishp04/linux/tree/5.10_numa_unified_v2
> > > >
> > > > There may be some minor conflicts with Mike's cleanup series [2] depending on the
> > > > order in which these two series are being accepted. I can rebase on top his series
> > > > if required.
> > > >
> > > > [2] https://lkml.org/lkml/2020/8/18/754
> > > >
> > > > Atish Patra (4):
> > > > numa: Move numa implementation to common code
> > > > arm64, numa: Change the numa init function name to be generic
> > > > riscv: Separate memory init from paging init
> > > > riscv: Add numa support for riscv64 platform
> > > >
> > > > Greentime Hu (1):
> > > > riscv: Add support pte_protnone and pmd_protnone if
> > > > CONFIG_NUMA_BALANCING
> > > >
> > > > arch/arm64/Kconfig                            |  1 +
> > > > arch/arm64/include/asm/numa.h                 | 45 +----------------
> > > > arch/arm64/kernel/acpi_numa.c                 | 13 -----
> > > > arch/arm64/mm/Makefile                        |  1 -
> > > > arch/arm64/mm/init.c                          |  4 +-
> > > > arch/riscv/Kconfig                            | 31 +++++++++++-
> > > > arch/riscv/include/asm/mmzone.h               | 13 +++++
> > > > arch/riscv/include/asm/numa.h                 |  8 +++
> > > > arch/riscv/include/asm/pci.h                  | 14 ++++++
> > > > arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> > > > arch/riscv/kernel/setup.c                     | 11 ++++-
> > > > arch/riscv/kernel/smpboot.c                   | 12 ++++-
> > > > arch/riscv/mm/init.c                          | 10 +++-
> > > > drivers/base/Kconfig                          |  6 +++
> > > > drivers/base/Makefile                         |  1 +
> > > > .../mm/numa.c => drivers/base/arch_numa.c     | 29 +++++++++--
> > > > include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> > > > 17 files changed, 200 insertions(+), 69 deletions(-)
> > > > create mode 100644 arch/riscv/include/asm/mmzone.h
> > > > create mode 100644 arch/riscv/include/asm/numa.h
> > > > rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> > > > create mode 100644 include/asm-generic/numa.h
> > > >
> > > > --
> > > > 2.24.0
> > > >
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
>
>


-- 
Regards,
Atish
