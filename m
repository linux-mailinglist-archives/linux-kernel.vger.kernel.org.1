Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418422F5A44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbhANFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhANFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:22:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73B0C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:21:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r4so2319907pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dSai6iPBy5GOPDDnJmUw+Dep5lqLN0apCZM1NIECn6w=;
        b=Z9kw/dgGpDfKf6drcfBTl9HA7hYqlue69fbt8q81Hskf1Zt1m+/hcgNtdYUfC9ABGH
         rqjqSbr/e3NOqpzFUiB10YWLn65uTl7/ClX2fIYNDjDmEH/fQ2LowsXdbeOe7OHgIgpu
         w1kwu+nlr51EuFu9rC9YqBpvLSzIqxdlNh+dM269of29OOT/I8/EJ5eY1O80Iy1d84Uf
         jaYuI3NDGsJPEnafqFnxyzYFl+P0/xXCn2rrsJVeRggnLIFMgNboy/7YwnGMcVR308lJ
         CjNNBax0UoSoZQKc8PvGfgoIWzwzHrhBPBJ64iVFVN0Rx9ByqfO4jJGemlZziLtykF/M
         15mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dSai6iPBy5GOPDDnJmUw+Dep5lqLN0apCZM1NIECn6w=;
        b=R7p5TG1XrpCKL/Yx1BHbb9krvQcg8rEP2vaY3kikQRqt+H+2R/eJ78b1CRmFSnpKvj
         TCALqGB0gLLJ+bkdj3eNwM7HNx5muJlMJV8zhNRbXDm98xFdvTySr/+03pA8GC9Zr+GL
         MxYShhyH954jP3rbntiRCM3cvW+AeczwStc5aBNTiPD+CxfGi5fP7BMfVCZKUC1DRlSj
         5iE2jBYSlJV4UQBQ2B3fJ3JIHN0hPm+kZWYIhbOlRnHVtWzYLcZp7O2qEo5I4pPLHlEv
         fX8LJGtuR1vSlGsbRnoxR52jMXHSpbu3B/X60pGfMKZpAkVCWfa12NxzwnG2Ci46s7aD
         s7BA==
X-Gm-Message-State: AOAM5302jlZa+cUgKJTJXsVfkpYKSQgn6Rmx80a3MT2A7l8vUYWVKBkG
        2nqvf72EtzHIdmdmQnQokNxArmvYerb3hzKd
X-Google-Smtp-Source: ABdhPJzftb4hm1KpIPbHySW6VDs66gZk4k12vOhzyy3pxiqoAT9//sHcwcXIMGLCNEsyrT3stfkrUg==
X-Received: by 2002:a17:90b:8cb:: with SMTP id ds11mr3201447pjb.208.1610601699133;
        Wed, 13 Jan 2021 21:21:39 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n4sm4009507pfu.150.2021.01.13.21.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:21:38 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:21:38 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 21:21:37 PST (-0800)
Subject:     Re: [PATCH v5 0/5] Unify NUMA implementation between ARM64 & RISC-V
In-Reply-To: <CAOnJCUJq5e7W1UXkFFMkKje_BTedekoUT=32ia6t+Sc4UVDhEQ@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        catalin.marinas@arm.com, Jonathan.Cameron@huawei.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org,
        linux-arch@vger.kernel.org, liuzhengyuan@tj.kylinos.cn,
        bhe@redhat.com, anup@brainfault.org, daniel.lezcano@linaro.org,
        steven.price@arm.com, greentime.hu@sifive.com,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        anshuman.khandual@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rppt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-e9591590-a6e1-41b1-ae48-1987bba7c828@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 11:31:11 PST (-0800), atishp@atishpatra.org wrote:
> On Sat, Jan 9, 2021 at 12:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Sun, 13 Dec 2020 17:02:19 PST (-0800), atishp@atishpatra.org wrote:
>> > On Wed, Nov 18, 2020 at 4:39 PM Atish Patra <atish.patra@wdc.com> wrote:
>> >>
>> >> This series attempts to move the ARM64 numa implementation to common
>> >> code so that RISC-V can leverage that as well instead of reimplementing
>> >> it again.
>> >>
>> >> RISC-V specific bits are based on initial work done by Greentime Hu [1] but
>> >> modified to reuse the common implementation to avoid duplication.
>> >>
>> >> [1] https://lkml.org/lkml/2020/1/10/233
>> >>
>> >> This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
>> >> It would be great if somebody can test it on numa capable ARM64 hardware platforms.
>> >> This patch series doesn't modify the maintainers list for the common code (arch_numa)
>> >> as I am not sure if somebody from ARM64 community or Greg should take up the
>> >> maintainership. Ganapatrao was the original author of the arm64 version.
>> >> I would be happy to update that in the next revision once it is decided.
>> >>
>> >> # numactl --hardware
>> >> available: 2 nodes (0-1)
>> >> node 0 cpus: 0 1 2 3
>> >> node 0 size: 486 MB
>> >> node 0 free: 470 MB
>> >> node 1 cpus: 4 5 6 7
>> >> node 1 size: 424 MB
>> >> node 1 free: 408 MB
>> >> node distances:
>> >> node   0   1
>> >>   0:  10  20
>> >>   1:  20  10
>> >> # numactl -show
>> >> policy: default
>> >> preferred node: current
>> >> physcpubind: 0 1 2 3 4 5 6 7
>> >> cpubind: 0 1
>> >> nodebind: 0 1
>> >> membind: 0 1
>> >>
>> >> The patches are also available at
>> >> https://github.com/atishp04/linux/tree/5.11_numa_unified_v5
>> >>
>> >> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
>> >> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
>> >>
>> >> Testing:
>> >> RISC-V:
>> >> Tested in Qemu and 2 socket OmniXtend FPGA.
>> >>
>> >> ARM64:
>> >> 2 socket kunpeng920 (4 nodes around 250G a node)
>> >> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> >>
>> >> Changes from v4->v5:
>> >> 1. Added by Acked-by & Reviewed-by tags.
>> >> 2. Swapped patch 1 & 2 in v4 version.
>> >>
>> >> Changes from v3->v4:
>> >> 1. Removed redundant duplicate header.
>> >> 2. Added Reviewed-by tags.
>> >>
>> >> Changes from v2->v3:
>> >> 1. Added Acked-by/Reviewed-by tags.
>> >> 2. Replaced asm/acpi.h with linux/acpi.h
>> >> 3. Defined arch_acpi_numa_init as static.
>> >>
>> >> Changes from v1->v2:
>> >> 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
>> >> 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
>> >> 3. Fixed few typos.
>> >>
>> >> Atish Patra (4):
>> >> arm64, numa: Change the numa init functions name to be generic
>> >> numa: Move numa implementation to common code
>> >> riscv: Separate memory init from paging init
>> >> riscv: Add numa support for riscv64 platform
>> >>
>> >> Greentime Hu (1):
>> >> riscv: Add support pte_protnone and pmd_protnone if
>> >> CONFIG_NUMA_BALANCING
>> >>
>> >> arch/arm64/Kconfig                            |  1 +
>> >> arch/arm64/include/asm/numa.h                 | 48 +----------------
>> >> arch/arm64/kernel/acpi_numa.c                 | 12 -----
>> >> arch/arm64/mm/Makefile                        |  1 -
>> >> arch/arm64/mm/init.c                          |  4 +-
>> >> arch/riscv/Kconfig                            | 31 ++++++++++-
>> >> arch/riscv/include/asm/mmzone.h               | 13 +++++
>> >> arch/riscv/include/asm/numa.h                 |  8 +++
>> >> arch/riscv/include/asm/pci.h                  | 14 +++++
>> >> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
>> >> arch/riscv/kernel/setup.c                     | 11 +++-
>> >> arch/riscv/kernel/smpboot.c                   | 12 ++++-
>> >> arch/riscv/mm/init.c                          | 10 +++-
>> >> drivers/base/Kconfig                          |  6 +++
>> >> drivers/base/Makefile                         |  1 +
>> >> .../mm/numa.c => drivers/base/arch_numa.c     | 27 ++++++++--
>> >> include/asm-generic/numa.h                    | 52 +++++++++++++++++++
>> >> 17 files changed, 200 insertions(+), 72 deletions(-)
>> >> create mode 100644 arch/riscv/include/asm/mmzone.h
>> >> create mode 100644 arch/riscv/include/asm/numa.h
>> >> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (96%)
>> >> create mode 100644 include/asm-generic/numa.h
>> >>
>> >> --
>> >> 2.25.1
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>> >
>> > Hey Palmer,
>> > I did not see this series in for-next. Let me know if you need
>> > anything else to be done for this series.
>>
>> Sorry about that.  It's on for-next, with Randy's comment addressed.  There was
>> one merge conflict: we don't have resource_init() in for-next yet (which I
>> think means I missed something else).
>
> resource_init is changed to init_resource and moved to setup.c in the
> following patch which was merged in 5.11 MW.
> 00ab027a3b82 RISC-V: Add kernel image sections to the resource tree

Ah, great, for some reason I thought we hadn't merged those yet.

>> IDK if that's necessary for the NUMA
>> stuff, I just dropped it.  I haven't tested this yet.
