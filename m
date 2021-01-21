Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CD02FF12E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbhAUPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731809AbhAUPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611243880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIh5k/fhbTxiWAeuGiZaG1qBhmQZt7HVOvEtIRa9PWs=;
        b=TnnC3a5Vx3AFWgJBaBtnqxyEIRNJlBdArHqBE4ruG3evHAWzwcEPWQXxQwCS3Z3BJpHDoL
        Y+LAcqIRGtJkp7mzdk2WnSRUAj2UJTaLKyMPLmKJ7D158aJgtJ4R4wOsIU4jU95syUhbNv
        kSwP9RYwCIHeXlN6C3V1L3hcxQQgxfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-Jws5e97TOcGxpaZDpxuS6w-1; Thu, 21 Jan 2021 10:44:31 -0500
X-MC-Unique: Jws5e97TOcGxpaZDpxuS6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DF63801817;
        Thu, 21 Jan 2021 15:44:30 +0000 (UTC)
Received: from trippy.localdomain (ovpn-119-10.rdu2.redhat.com [10.10.119.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6719C39A50;
        Thu, 21 Jan 2021 15:44:29 +0000 (UTC)
Message-ID: <20dff5cfdc4ca3aad9fb55e43a716630ba50a939.camel@redhat.com>
Subject: Re: [PATCH 1/5] c6x: remove architecture
From:   Mark Salter <msalter@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Date:   Thu, 21 Jan 2021 10:44:29 -0500
In-Reply-To: <20210120124812.2800027-2-arnd@kernel.org>
References: <20210120124812.2800027-1-arnd@kernel.org>
         <20210120124812.2800027-2-arnd@kernel.org>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-20 at 13:48 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The c6x architecture was added to the kernel in 2011 at a time when
> running Linux on DSPs was widely seen as the logical evolution.
> It appears the trend has gone back to running Linux on Arm based SoCs
> with DSP, using a better supported software ecosystem, and having better
> real-time behavior for the DSP code. An example of this is TI's own
> Keystone2 platform.
> 
> The upstream kernel port appears to no longer have any users. Mark
> Salter remained avaialable to review patches, but mentioned that
> he no longer has access to working hardware himself. Without any
> users, it's best to just remove the code completely to reduce the
> work for cross-architecture code changes.
> 
> Many thanks to Mark for maintaining the code for the past ten years.
> 
> Link: https://lore.kernel.org/lkml/41dc7795afda9f776d8cd0d3075f776cf586e97c.camel@redhat.com/
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/c6x/clocks.txt        |  40 -
>  .../devicetree/bindings/c6x/dscr.txt          | 127 ---
>  .../devicetree/bindings/c6x/emifa.txt         |  62 --
>  Documentation/devicetree/bindings/c6x/soc.txt |  28 -
>  .../ti,c64x+megamod-pic.txt                   | 103 ---
>  .../bindings/timer/ti,c64x+timer64.txt        |  25 -
>  MAINTAINERS                                   |   8 -
>  arch/c6x/Kconfig                              | 113 ---
>  arch/c6x/Kconfig.debug                        |  10 -
>  arch/c6x/Makefile                             |  60 --
>  arch/c6x/boot/Makefile                        |  11 -
>  arch/c6x/boot/dts/Makefile                    |  16 -
>  arch/c6x/boot/dts/dsk6455.dts                 |  57 --
>  arch/c6x/boot/dts/evmc6457.dts                |  43 -
>  arch/c6x/boot/dts/evmc6472.dts                |  68 --
>  arch/c6x/boot/dts/evmc6474.dts                |  53 --
>  arch/c6x/boot/dts/evmc6678.dts                |  78 --
>  arch/c6x/boot/dts/tms320c6455.dtsi            |  97 ---
>  arch/c6x/boot/dts/tms320c6457.dtsi            |  69 --
>  arch/c6x/boot/dts/tms320c6472.dtsi            | 135 ----
>  arch/c6x/boot/dts/tms320c6474.dtsi            |  90 ---
>  arch/c6x/boot/dts/tms320c6678.dtsi            | 147 ----
>  arch/c6x/configs/dsk6455_defconfig            |  42 -
>  arch/c6x/configs/evmc6457_defconfig           |  39 -
>  arch/c6x/configs/evmc6472_defconfig           |  40 -
>  arch/c6x/configs/evmc6474_defconfig           |  40 -
>  arch/c6x/configs/evmc6678_defconfig           |  40 -
>  arch/c6x/include/asm/Kbuild                   |   5 -
>  arch/c6x/include/asm/asm-offsets.h            |   1 -
>  arch/c6x/include/asm/bitops.h                 |  95 ---
>  arch/c6x/include/asm/bug.h                    |  20 -
>  arch/c6x/include/asm/cache.h                  |  94 ---
>  arch/c6x/include/asm/cacheflush.h             |  45 --
>  arch/c6x/include/asm/checksum.h               |  34 -
>  arch/c6x/include/asm/clock.h                  | 145 ----
>  arch/c6x/include/asm/cmpxchg.h                |  63 --
>  arch/c6x/include/asm/delay.h                  |  64 --
>  arch/c6x/include/asm/dscr.h                   |  30 -
>  arch/c6x/include/asm/elf.h                    | 117 ---
>  arch/c6x/include/asm/flat.h                   |  19 -
>  arch/c6x/include/asm/ftrace.h                 |   6 -
>  arch/c6x/include/asm/hardirq.h                |  17 -
>  arch/c6x/include/asm/irq.h                    |  50 --
>  arch/c6x/include/asm/irqflags.h               |  68 --
>  arch/c6x/include/asm/linkage.h                |  31 -
>  arch/c6x/include/asm/megamod-pic.h            |  10 -
>  arch/c6x/include/asm/mmu_context.h            |   6 -
>  arch/c6x/include/asm/module.h                 |  20 -
>  arch/c6x/include/asm/page.h                   |   9 -
>  arch/c6x/include/asm/pgtable.h                |  66 --
>  arch/c6x/include/asm/processor.h              | 114 ---
>  arch/c6x/include/asm/procinfo.h               |  24 -
>  arch/c6x/include/asm/ptrace.h                 |  32 -
>  arch/c6x/include/asm/sections.h               |  12 -
>  arch/c6x/include/asm/setup.h                  |  31 -
>  arch/c6x/include/asm/soc.h                    |  35 -
>  arch/c6x/include/asm/special_insns.h          |  60 --
>  arch/c6x/include/asm/string.h                 |  18 -
>  arch/c6x/include/asm/switch_to.h              |  30 -
>  arch/c6x/include/asm/syscall.h                |  75 --
>  arch/c6x/include/asm/syscalls.h               |  46 --
>  arch/c6x/include/asm/thread_info.h            |  94 ---
>  arch/c6x/include/asm/timer64.h                |   7 -
>  arch/c6x/include/asm/timex.h                  |  30 -
>  arch/c6x/include/asm/tlb.h                    |   7 -
>  arch/c6x/include/asm/traps.h                  |  33 -
>  arch/c6x/include/asm/uaccess.h                |  97 ---
>  arch/c6x/include/asm/unaligned.h              | 104 ---
>  arch/c6x/include/asm/vmalloc.h                |   4 -
>  arch/c6x/include/uapi/asm/Kbuild              |   2 -
>  arch/c6x/include/uapi/asm/byteorder.h         |  13 -
>  arch/c6x/include/uapi/asm/ptrace.h            | 164 ----
>  arch/c6x/include/uapi/asm/setup.h             |   7 -
>  arch/c6x/include/uapi/asm/sigcontext.h        |  81 --
>  arch/c6x/include/uapi/asm/swab.h              |  55 --
>  arch/c6x/include/uapi/asm/unistd.h            |  29 -
>  arch/c6x/kernel/Makefile                      |  13 -
>  arch/c6x/kernel/asm-offsets.c                 | 123 ---
>  arch/c6x/kernel/c6x_ksyms.c                   |  62 --
>  arch/c6x/kernel/devicetree.c                  |  14 -
>  arch/c6x/kernel/entry.S                       | 736 ------------------
>  arch/c6x/kernel/head.S                        |  81 --
>  arch/c6x/kernel/irq.c                         | 127 ---
>  arch/c6x/kernel/module.c                      | 119 ---
>  arch/c6x/kernel/process.c                     | 151 ----
>  arch/c6x/kernel/ptrace.c                      | 139 ----
>  arch/c6x/kernel/setup.c                       | 476 -----------
>  arch/c6x/kernel/signal.c                      | 322 --------
>  arch/c6x/kernel/soc.c                         |  87 ---
>  arch/c6x/kernel/switch_to.S                   |  71 --
>  arch/c6x/kernel/sys_c6x.c                     |  71 --
>  arch/c6x/kernel/time.c                        |  63 --
>  arch/c6x/kernel/traps.c                       | 409 ----------
>  arch/c6x/kernel/vectors.S                     |  78 --
>  arch/c6x/kernel/vmlinux.lds.S                 | 151 ----
>  arch/c6x/lib/Makefile                         |   8 -
>  arch/c6x/lib/checksum.c                       |  11 -
>  arch/c6x/lib/csum_64plus.S                    | 414 ----------
>  arch/c6x/lib/divi.S                           |  41 -
>  arch/c6x/lib/divremi.S                        |  34 -
>  arch/c6x/lib/divremu.S                        |  75 --
>  arch/c6x/lib/divu.S                           |  86 --
>  arch/c6x/lib/llshl.S                          |  25 -
>  arch/c6x/lib/llshr.S                          |  26 -
>  arch/c6x/lib/llshru.S                         |  26 -
>  arch/c6x/lib/memcpy_64plus.S                  |  43 -
>  arch/c6x/lib/mpyll.S                          |  37 -
>  arch/c6x/lib/negll.S                          |  19 -
>  arch/c6x/lib/pop_rts.S                        |  20 -
>  arch/c6x/lib/push_rts.S                       |  19 -
>  arch/c6x/lib/remi.S                           |  52 --
>  arch/c6x/lib/remu.S                           |  70 --
>  arch/c6x/lib/strasgi.S                        |  77 --
>  arch/c6x/lib/strasgi_64plus.S                 |  27 -
>  arch/c6x/mm/Makefile                          |   6 -
>  arch/c6x/mm/dma-coherent.c                    | 173 ----
>  arch/c6x/mm/init.c                            |  65 --
>  arch/c6x/platforms/Kconfig                    |  21 -
>  arch/c6x/platforms/Makefile                   |  13 -
>  arch/c6x/platforms/cache.c                    | 444 -----------
>  arch/c6x/platforms/dscr.c                     | 595 --------------
>  arch/c6x/platforms/emif.c                     |  84 --
>  arch/c6x/platforms/megamod-pic.c              | 344 --------
>  arch/c6x/platforms/pll.c                      | 440 -----------
>  arch/c6x/platforms/plldata.c                  | 467 -----------
>  arch/c6x/platforms/timer64.c                  | 241 ------
>  drivers/bus/Kconfig                           |   2 +-
>  fs/Kconfig.binfmt                             |   2 +-
>  include/asm-generic/page.h                    |   4 -
>  129 files changed, 2 insertions(+), 11162 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/c6x/clocks.txt
>  delete mode 100644 Documentation/devicetree/bindings/c6x/dscr.txt
>  delete mode 100644 Documentation/devicetree/bindings/c6x/emifa.txt
>  delete mode 100644 Documentation/devicetree/bindings/c6x/soc.txt
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,c64x+megamod-pic.txt
>  delete mode 100644 Documentation/devicetree/bindings/timer/ti,c64x+timer64.txt
>  delete mode 100644 arch/c6x/Kconfig
>  delete mode 100644 arch/c6x/Kconfig.debug
>  delete mode 100644 arch/c6x/Makefile
>  delete mode 100644 arch/c6x/boot/Makefile
>  delete mode 100644 arch/c6x/boot/dts/Makefile
>  delete mode 100644 arch/c6x/boot/dts/dsk6455.dts
>  delete mode 100644 arch/c6x/boot/dts/evmc6457.dts
>  delete mode 100644 arch/c6x/boot/dts/evmc6472.dts
>  delete mode 100644 arch/c6x/boot/dts/evmc6474.dts
>  delete mode 100644 arch/c6x/boot/dts/evmc6678.dts
>  delete mode 100644 arch/c6x/boot/dts/tms320c6455.dtsi
>  delete mode 100644 arch/c6x/boot/dts/tms320c6457.dtsi
>  delete mode 100644 arch/c6x/boot/dts/tms320c6472.dtsi
>  delete mode 100644 arch/c6x/boot/dts/tms320c6474.dtsi
>  delete mode 100644 arch/c6x/boot/dts/tms320c6678.dtsi
>  delete mode 100644 arch/c6x/configs/dsk6455_defconfig
>  delete mode 100644 arch/c6x/configs/evmc6457_defconfig
>  delete mode 100644 arch/c6x/configs/evmc6472_defconfig
>  delete mode 100644 arch/c6x/configs/evmc6474_defconfig
>  delete mode 100644 arch/c6x/configs/evmc6678_defconfig
>  delete mode 100644 arch/c6x/include/asm/Kbuild
>  delete mode 100644 arch/c6x/include/asm/asm-offsets.h
>  delete mode 100644 arch/c6x/include/asm/bitops.h
>  delete mode 100644 arch/c6x/include/asm/bug.h
>  delete mode 100644 arch/c6x/include/asm/cache.h
>  delete mode 100644 arch/c6x/include/asm/cacheflush.h
>  delete mode 100644 arch/c6x/include/asm/checksum.h
>  delete mode 100644 arch/c6x/include/asm/clock.h
>  delete mode 100644 arch/c6x/include/asm/cmpxchg.h
>  delete mode 100644 arch/c6x/include/asm/delay.h
>  delete mode 100644 arch/c6x/include/asm/dscr.h
>  delete mode 100644 arch/c6x/include/asm/elf.h
>  delete mode 100644 arch/c6x/include/asm/flat.h
>  delete mode 100644 arch/c6x/include/asm/ftrace.h
>  delete mode 100644 arch/c6x/include/asm/hardirq.h
>  delete mode 100644 arch/c6x/include/asm/irq.h
>  delete mode 100644 arch/c6x/include/asm/irqflags.h
>  delete mode 100644 arch/c6x/include/asm/linkage.h
>  delete mode 100644 arch/c6x/include/asm/megamod-pic.h
>  delete mode 100644 arch/c6x/include/asm/mmu_context.h
>  delete mode 100644 arch/c6x/include/asm/module.h
>  delete mode 100644 arch/c6x/include/asm/page.h
>  delete mode 100644 arch/c6x/include/asm/pgtable.h
>  delete mode 100644 arch/c6x/include/asm/processor.h
>  delete mode 100644 arch/c6x/include/asm/procinfo.h
>  delete mode 100644 arch/c6x/include/asm/ptrace.h
>  delete mode 100644 arch/c6x/include/asm/sections.h
>  delete mode 100644 arch/c6x/include/asm/setup.h
>  delete mode 100644 arch/c6x/include/asm/soc.h
>  delete mode 100644 arch/c6x/include/asm/special_insns.h
>  delete mode 100644 arch/c6x/include/asm/string.h
>  delete mode 100644 arch/c6x/include/asm/switch_to.h
>  delete mode 100644 arch/c6x/include/asm/syscall.h
>  delete mode 100644 arch/c6x/include/asm/syscalls.h
>  delete mode 100644 arch/c6x/include/asm/thread_info.h
>  delete mode 100644 arch/c6x/include/asm/timer64.h
>  delete mode 100644 arch/c6x/include/asm/timex.h
>  delete mode 100644 arch/c6x/include/asm/tlb.h
>  delete mode 100644 arch/c6x/include/asm/traps.h
>  delete mode 100644 arch/c6x/include/asm/uaccess.h
>  delete mode 100644 arch/c6x/include/asm/unaligned.h
>  delete mode 100644 arch/c6x/include/asm/vmalloc.h
>  delete mode 100644 arch/c6x/include/uapi/asm/Kbuild
>  delete mode 100644 arch/c6x/include/uapi/asm/byteorder.h
>  delete mode 100644 arch/c6x/include/uapi/asm/ptrace.h
>  delete mode 100644 arch/c6x/include/uapi/asm/setup.h
>  delete mode 100644 arch/c6x/include/uapi/asm/sigcontext.h
>  delete mode 100644 arch/c6x/include/uapi/asm/swab.h
>  delete mode 100644 arch/c6x/include/uapi/asm/unistd.h
>  delete mode 100644 arch/c6x/kernel/Makefile
>  delete mode 100644 arch/c6x/kernel/asm-offsets.c
>  delete mode 100644 arch/c6x/kernel/c6x_ksyms.c
>  delete mode 100644 arch/c6x/kernel/devicetree.c
>  delete mode 100644 arch/c6x/kernel/entry.S
>  delete mode 100644 arch/c6x/kernel/head.S
>  delete mode 100644 arch/c6x/kernel/irq.c
>  delete mode 100644 arch/c6x/kernel/module.c
>  delete mode 100644 arch/c6x/kernel/process.c
>  delete mode 100644 arch/c6x/kernel/ptrace.c
>  delete mode 100644 arch/c6x/kernel/setup.c
>  delete mode 100644 arch/c6x/kernel/signal.c
>  delete mode 100644 arch/c6x/kernel/soc.c
>  delete mode 100644 arch/c6x/kernel/switch_to.S
>  delete mode 100644 arch/c6x/kernel/sys_c6x.c
>  delete mode 100644 arch/c6x/kernel/time.c
>  delete mode 100644 arch/c6x/kernel/traps.c
>  delete mode 100644 arch/c6x/kernel/vectors.S
>  delete mode 100644 arch/c6x/kernel/vmlinux.lds.S
>  delete mode 100644 arch/c6x/lib/Makefile
>  delete mode 100644 arch/c6x/lib/checksum.c
>  delete mode 100644 arch/c6x/lib/csum_64plus.S
>  delete mode 100644 arch/c6x/lib/divi.S
>  delete mode 100644 arch/c6x/lib/divremi.S
>  delete mode 100644 arch/c6x/lib/divremu.S
>  delete mode 100644 arch/c6x/lib/divu.S
>  delete mode 100644 arch/c6x/lib/llshl.S
>  delete mode 100644 arch/c6x/lib/llshr.S
>  delete mode 100644 arch/c6x/lib/llshru.S
>  delete mode 100644 arch/c6x/lib/memcpy_64plus.S
>  delete mode 100644 arch/c6x/lib/mpyll.S
>  delete mode 100644 arch/c6x/lib/negll.S
>  delete mode 100644 arch/c6x/lib/pop_rts.S
>  delete mode 100644 arch/c6x/lib/push_rts.S
>  delete mode 100644 arch/c6x/lib/remi.S
>  delete mode 100644 arch/c6x/lib/remu.S
>  delete mode 100644 arch/c6x/lib/strasgi.S
>  delete mode 100644 arch/c6x/lib/strasgi_64plus.S
>  delete mode 100644 arch/c6x/mm/Makefile
>  delete mode 100644 arch/c6x/mm/dma-coherent.c
>  delete mode 100644 arch/c6x/mm/init.c
>  delete mode 100644 arch/c6x/platforms/Kconfig
>  delete mode 100644 arch/c6x/platforms/Makefile
>  delete mode 100644 arch/c6x/platforms/cache.c
>  delete mode 100644 arch/c6x/platforms/dscr.c
>  delete mode 100644 arch/c6x/platforms/emif.c
>  delete mode 100644 arch/c6x/platforms/megamod-pic.c
>  delete mode 100644 arch/c6x/platforms/pll.c
>  delete mode 100644 arch/c6x/platforms/plldata.c
>  delete mode 100644 arch/c6x/platforms/timer64.c
> 
> diff --git a/Documentation/devicetree/bindings/c6x/clocks.txt b/Documentation/devicetree/bindings/c6x/clocks.txt
> deleted file mode 100644
> index a04f5fd30122..000000000000
> diff --git a/Documentation/devicetree/bindings/c6x/dscr.txt b/Documentation/devicetree/bindings/c6x/dscr.txt
> deleted file mode 100644
> index 92672235de57..000000000000
> diff --git a/Documentation/devicetree/bindings/c6x/emifa.txt b/Documentation/devicetree/bindings/c6x/emifa.txt
> deleted file mode 100644
> index 0ff6e9b9a13f..000000000000
> diff --git a/Documentation/devicetree/bindings/c6x/soc.txt b/Documentation/devicetree/bindings/c6x/soc.txt
> deleted file mode 100644
> index b1e4973b5769..000000000000
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,c64x+megamod-pic.txt b/Documentation/devicetree/bindings/interrupt-
> controller/ti,c64x+megamod-pic.txt
> deleted file mode 100644
> index ee3f9c351501..000000000000
> diff --git a/Documentation/devicetree/bindings/timer/ti,c64x+timer64.txt b/Documentation/devicetree/bindings/timer/ti,c64x+timer64.txt
> deleted file mode 100644
> index d96c1e283e73..000000000000
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb971f5f6f0c..7c3eadb185f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3837,14 +3837,6 @@ F:       drivers/irqchip/irq-csky-*
>  N:     csky
>  K:     csky
>  
> -C6X ARCHITECTURE
> -M:     Mark Salter <msalter@redhat.com>
> -M:     Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> -L:     linux-c6x-dev@linux-c6x.org
> -S:     Maintained
> -W:     http://www.linux-c6x.org/wiki/index.php/Main_Page
> -F:     arch/c6x/
> -
>  CA8210 IEEE-802.15.4 RADIO DRIVER
>  M:     Harry Morris <h.morris@cascoda.com>
>  L:     linux-wpan@vger.kernel.org
> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> deleted file mode 100644
> index bdeeac28b1be..000000000000
> diff --git a/arch/c6x/Kconfig.debug b/arch/c6x/Kconfig.debug
> deleted file mode 100644
> index c299e0d8eca3..000000000000
> diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
> deleted file mode 100644
> index b7aa854f7008..000000000000
> diff --git a/arch/c6x/boot/Makefile b/arch/c6x/boot/Makefile
> deleted file mode 100644
> index 842b7b0bfe80..000000000000
> diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
> deleted file mode 100644
> index f438285c3640..000000000000
> diff --git a/arch/c6x/boot/dts/dsk6455.dts b/arch/c6x/boot/dts/dsk6455.dts
> deleted file mode 100644
> index fa904f2916b5..000000000000
> diff --git a/arch/c6x/boot/dts/evmc6457.dts b/arch/c6x/boot/dts/evmc6457.dts
> deleted file mode 100644
> index 73e1d43b51ce..000000000000
> diff --git a/arch/c6x/boot/dts/evmc6472.dts b/arch/c6x/boot/dts/evmc6472.dts
> deleted file mode 100644
> index 4878b78919fa..000000000000
> diff --git a/arch/c6x/boot/dts/evmc6474.dts b/arch/c6x/boot/dts/evmc6474.dts
> deleted file mode 100644
> index d10746453217..000000000000
> diff --git a/arch/c6x/boot/dts/evmc6678.dts b/arch/c6x/boot/dts/evmc6678.dts
> deleted file mode 100644
> index 5e6c0961e7b2..000000000000
> diff --git a/arch/c6x/boot/dts/tms320c6455.dtsi b/arch/c6x/boot/dts/tms320c6455.dtsi
> deleted file mode 100644
> index 0b21cb30343b..000000000000
> diff --git a/arch/c6x/boot/dts/tms320c6457.dtsi b/arch/c6x/boot/dts/tms320c6457.dtsi
> deleted file mode 100644
> index e49f7ae19124..000000000000
> diff --git a/arch/c6x/boot/dts/tms320c6472.dtsi b/arch/c6x/boot/dts/tms320c6472.dtsi
> deleted file mode 100644
> index 9dd4b04e78ef..000000000000
> diff --git a/arch/c6x/boot/dts/tms320c6474.dtsi b/arch/c6x/boot/dts/tms320c6474.dtsi
> deleted file mode 100644
> index 0ef5333629a6..000000000000
> diff --git a/arch/c6x/boot/dts/tms320c6678.dtsi b/arch/c6x/boot/dts/tms320c6678.dtsi
> deleted file mode 100644
> index da1e3f2bf062..000000000000
> diff --git a/arch/c6x/configs/dsk6455_defconfig b/arch/c6x/configs/dsk6455_defconfig
> deleted file mode 100644
> index d764ea4cce7f..000000000000
> diff --git a/arch/c6x/configs/evmc6457_defconfig b/arch/c6x/configs/evmc6457_defconfig
> deleted file mode 100644
> index 05d0b4a25ab1..000000000000
> diff --git a/arch/c6x/configs/evmc6472_defconfig b/arch/c6x/configs/evmc6472_defconfig
> deleted file mode 100644
> index 8d81fcf86b0e..000000000000
> diff --git a/arch/c6x/configs/evmc6474_defconfig b/arch/c6x/configs/evmc6474_defconfig
> deleted file mode 100644
> index 8156a98f3958..000000000000
> diff --git a/arch/c6x/configs/evmc6678_defconfig b/arch/c6x/configs/evmc6678_defconfig
> deleted file mode 100644
> index c4f433c25b69..000000000000
> diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
> deleted file mode 100644
> index a4ef93a1f7ae..000000000000
> diff --git a/arch/c6x/include/asm/asm-offsets.h b/arch/c6x/include/asm/asm-offsets.h
> deleted file mode 100644
> index d370ee36a182..000000000000
> diff --git a/arch/c6x/include/asm/bitops.h b/arch/c6x/include/asm/bitops.h
> deleted file mode 100644
> index 50e618f38a11..000000000000
> diff --git a/arch/c6x/include/asm/bug.h b/arch/c6x/include/asm/bug.h
> deleted file mode 100644
> index 1a68676256ee..000000000000
> diff --git a/arch/c6x/include/asm/cache.h b/arch/c6x/include/asm/cache.h
> deleted file mode 100644
> index 0fa8bf77c954..000000000000
> diff --git a/arch/c6x/include/asm/cacheflush.h b/arch/c6x/include/asm/cacheflush.h
> deleted file mode 100644
> index 10922d528de6..000000000000
> diff --git a/arch/c6x/include/asm/checksum.h b/arch/c6x/include/asm/checksum.h
> deleted file mode 100644
> index 934918def632..000000000000
> diff --git a/arch/c6x/include/asm/clock.h b/arch/c6x/include/asm/clock.h
> deleted file mode 100644
> index 7b6c42a52ec9..000000000000
> diff --git a/arch/c6x/include/asm/cmpxchg.h b/arch/c6x/include/asm/cmpxchg.h
> deleted file mode 100644
> index 6eed628a9e7f..000000000000
> diff --git a/arch/c6x/include/asm/delay.h b/arch/c6x/include/asm/delay.h
> deleted file mode 100644
> index 455fc713ae54..000000000000
> diff --git a/arch/c6x/include/asm/dscr.h b/arch/c6x/include/asm/dscr.h
> deleted file mode 100644
> index f6b095c3d3f5..000000000000
> diff --git a/arch/c6x/include/asm/elf.h b/arch/c6x/include/asm/elf.h
> deleted file mode 100644
> index ca88acbf560b..000000000000
> diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
> deleted file mode 100644
> index 9e6544b51386..000000000000
> diff --git a/arch/c6x/include/asm/ftrace.h b/arch/c6x/include/asm/ftrace.h
> deleted file mode 100644
> index 3701958d3d1c..000000000000
> diff --git a/arch/c6x/include/asm/hardirq.h b/arch/c6x/include/asm/hardirq.h
> deleted file mode 100644
> index f37d07d31040..000000000000
> diff --git a/arch/c6x/include/asm/irq.h b/arch/c6x/include/asm/irq.h
> deleted file mode 100644
> index 9da4d1afd0d7..000000000000
> diff --git a/arch/c6x/include/asm/irqflags.h b/arch/c6x/include/asm/irqflags.h
> deleted file mode 100644
> index d6cd71c02629..000000000000
> diff --git a/arch/c6x/include/asm/linkage.h b/arch/c6x/include/asm/linkage.h
> deleted file mode 100644
> index 1ad615da6479..000000000000
> diff --git a/arch/c6x/include/asm/megamod-pic.h b/arch/c6x/include/asm/megamod-pic.h
> deleted file mode 100644
> index a0a6d596bf9b..000000000000
> diff --git a/arch/c6x/include/asm/mmu_context.h b/arch/c6x/include/asm/mmu_context.h
> deleted file mode 100644
> index d2659d0a3297..000000000000
> diff --git a/arch/c6x/include/asm/module.h b/arch/c6x/include/asm/module.h
> deleted file mode 100644
> index 9fc9f4a8ecc2..000000000000
> diff --git a/arch/c6x/include/asm/page.h b/arch/c6x/include/asm/page.h
> deleted file mode 100644
> index 40079899084d..000000000000
> diff --git a/arch/c6x/include/asm/pgtable.h b/arch/c6x/include/asm/pgtable.h
> deleted file mode 100644
> index 8a91ceda39fa..000000000000
> diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
> deleted file mode 100644
> index 1456f5e11de3..000000000000
> diff --git a/arch/c6x/include/asm/procinfo.h b/arch/c6x/include/asm/procinfo.h
> deleted file mode 100644
> index aaa3cb902c43..000000000000
> diff --git a/arch/c6x/include/asm/ptrace.h b/arch/c6x/include/asm/ptrace.h
> deleted file mode 100644
> index 7cbae382cf37..000000000000
> diff --git a/arch/c6x/include/asm/sections.h b/arch/c6x/include/asm/sections.h
> deleted file mode 100644
> index dc2f15eb3bde..000000000000
> diff --git a/arch/c6x/include/asm/setup.h b/arch/c6x/include/asm/setup.h
> deleted file mode 100644
> index 5496bccecaa0..000000000000
> diff --git a/arch/c6x/include/asm/soc.h b/arch/c6x/include/asm/soc.h
> deleted file mode 100644
> index 43f50159e59b..000000000000
> diff --git a/arch/c6x/include/asm/special_insns.h b/arch/c6x/include/asm/special_insns.h
> deleted file mode 100644
> index d233160aefd4..000000000000
> diff --git a/arch/c6x/include/asm/string.h b/arch/c6x/include/asm/string.h
> deleted file mode 100644
> index b290ead40f68..000000000000
> diff --git a/arch/c6x/include/asm/switch_to.h b/arch/c6x/include/asm/switch_to.h
> deleted file mode 100644
> index 36c5332fadae..000000000000
> diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
> deleted file mode 100644
> index 38f3e2284ecd..000000000000
> diff --git a/arch/c6x/include/asm/syscalls.h b/arch/c6x/include/asm/syscalls.h
> deleted file mode 100644
> index df3d05feb153..000000000000
> diff --git a/arch/c6x/include/asm/thread_info.h b/arch/c6x/include/asm/thread_info.h
> deleted file mode 100644
> index dd8913d57189..000000000000
> diff --git a/arch/c6x/include/asm/timer64.h b/arch/c6x/include/asm/timer64.h
> deleted file mode 100644
> index b850dfef1f79..000000000000
> diff --git a/arch/c6x/include/asm/timex.h b/arch/c6x/include/asm/timex.h
> deleted file mode 100644
> index f946ce297e13..000000000000
> diff --git a/arch/c6x/include/asm/tlb.h b/arch/c6x/include/asm/tlb.h
> deleted file mode 100644
> index 240ba0febb57..000000000000
> diff --git a/arch/c6x/include/asm/traps.h b/arch/c6x/include/asm/traps.h
> deleted file mode 100644
> index 7e1d31c47680..000000000000
> diff --git a/arch/c6x/include/asm/uaccess.h b/arch/c6x/include/asm/uaccess.h
> deleted file mode 100644
> index 585adf9201b7..000000000000
> diff --git a/arch/c6x/include/asm/unaligned.h b/arch/c6x/include/asm/unaligned.h
> deleted file mode 100644
> index d628cc170564..000000000000
> diff --git a/arch/c6x/include/asm/vmalloc.h b/arch/c6x/include/asm/vmalloc.h
> deleted file mode 100644
> index 26c6c6696bbd..000000000000
> diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
> deleted file mode 100644
> index e78470141932..000000000000
> diff --git a/arch/c6x/include/uapi/asm/byteorder.h b/arch/c6x/include/uapi/asm/byteorder.h
> deleted file mode 100644
> index ab61f867391c..000000000000
> diff --git a/arch/c6x/include/uapi/asm/ptrace.h b/arch/c6x/include/uapi/asm/ptrace.h
> deleted file mode 100644
> index 9b51110a0842..000000000000
> diff --git a/arch/c6x/include/uapi/asm/setup.h b/arch/c6x/include/uapi/asm/setup.h
> deleted file mode 100644
> index e90548cebec3..000000000000
> diff --git a/arch/c6x/include/uapi/asm/sigcontext.h b/arch/c6x/include/uapi/asm/sigcontext.h
> deleted file mode 100644
> index 4e5a9a260861..000000000000
> diff --git a/arch/c6x/include/uapi/asm/swab.h b/arch/c6x/include/uapi/asm/swab.h
> deleted file mode 100644
> index c407c0497718..000000000000
> diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
> deleted file mode 100644
> index 79b724c39d9b..000000000000
> diff --git a/arch/c6x/kernel/Makefile b/arch/c6x/kernel/Makefile
> deleted file mode 100644
> index fbe74174de87..000000000000
> diff --git a/arch/c6x/kernel/asm-offsets.c b/arch/c6x/kernel/asm-offsets.c
> deleted file mode 100644
> index 4a264ef87dcb..000000000000
> diff --git a/arch/c6x/kernel/c6x_ksyms.c b/arch/c6x/kernel/c6x_ksyms.c
> deleted file mode 100644
> index 5a39f52f9db4..000000000000
> diff --git a/arch/c6x/kernel/devicetree.c b/arch/c6x/kernel/devicetree.c
> deleted file mode 100644
> index a0c73f0545b2..000000000000
> diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
> deleted file mode 100644
> index fb154d19625b..000000000000
> diff --git a/arch/c6x/kernel/head.S b/arch/c6x/kernel/head.S
> deleted file mode 100644
> index fecbeef827bc..000000000000
> diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
> deleted file mode 100644
> index e4c53d185b62..000000000000
> diff --git a/arch/c6x/kernel/module.c b/arch/c6x/kernel/module.c
> deleted file mode 100644
> index 09b4c6bfe877..000000000000
> diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
> deleted file mode 100644
> index 9f4fd6a40a10..000000000000
> diff --git a/arch/c6x/kernel/ptrace.c b/arch/c6x/kernel/ptrace.c
> deleted file mode 100644
> index 3cdaa8cf0ed6..000000000000
> diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
> deleted file mode 100644
> index 9254c3b794a5..000000000000
> diff --git a/arch/c6x/kernel/signal.c b/arch/c6x/kernel/signal.c
> deleted file mode 100644
> index 862460c3b183..000000000000
> diff --git a/arch/c6x/kernel/soc.c b/arch/c6x/kernel/soc.c
> deleted file mode 100644
> index 8362f9390e03..000000000000
> diff --git a/arch/c6x/kernel/switch_to.S b/arch/c6x/kernel/switch_to.S
> deleted file mode 100644
> index b7f9f607042e..000000000000
> diff --git a/arch/c6x/kernel/sys_c6x.c b/arch/c6x/kernel/sys_c6x.c
> deleted file mode 100644
> index 600277f057cf..000000000000
> diff --git a/arch/c6x/kernel/time.c b/arch/c6x/kernel/time.c
> deleted file mode 100644
> index f3ec91a87f4f..000000000000
> diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
> deleted file mode 100644
> index 2b9121c755be..000000000000
> diff --git a/arch/c6x/kernel/vectors.S b/arch/c6x/kernel/vectors.S
> deleted file mode 100644
> index ad3dc006a6d3..000000000000
> diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
> deleted file mode 100644
> index ac99ba0864bf..000000000000
> diff --git a/arch/c6x/lib/Makefile b/arch/c6x/lib/Makefile
> deleted file mode 100644
> index e182004f82fe..000000000000
> diff --git a/arch/c6x/lib/checksum.c b/arch/c6x/lib/checksum.c
> deleted file mode 100644
> index dff2e2ec6e64..000000000000
> diff --git a/arch/c6x/lib/csum_64plus.S b/arch/c6x/lib/csum_64plus.S
> deleted file mode 100644
> index 57148866d8d3..000000000000
> diff --git a/arch/c6x/lib/divi.S b/arch/c6x/lib/divi.S
> deleted file mode 100644
> index d1764ae0b519..000000000000
> diff --git a/arch/c6x/lib/divremi.S b/arch/c6x/lib/divremi.S
> deleted file mode 100644
> index 575fc57a8a76..000000000000
> diff --git a/arch/c6x/lib/divremu.S b/arch/c6x/lib/divremu.S
> deleted file mode 100644
> index 5f6a6a2997ae..000000000000
> diff --git a/arch/c6x/lib/divu.S b/arch/c6x/lib/divu.S
> deleted file mode 100644
> index f0f6082944c2..000000000000
> diff --git a/arch/c6x/lib/llshl.S b/arch/c6x/lib/llshl.S
> deleted file mode 100644
> index 3272499618e0..000000000000
> diff --git a/arch/c6x/lib/llshr.S b/arch/c6x/lib/llshr.S
> deleted file mode 100644
> index 6bfaacd15e73..000000000000
> diff --git a/arch/c6x/lib/llshru.S b/arch/c6x/lib/llshru.S
> deleted file mode 100644
> index 103128f50770..000000000000
> diff --git a/arch/c6x/lib/memcpy_64plus.S b/arch/c6x/lib/memcpy_64plus.S
> deleted file mode 100644
> index 157a30486bfd..000000000000
> diff --git a/arch/c6x/lib/mpyll.S b/arch/c6x/lib/mpyll.S
> deleted file mode 100644
> index d07c13ec4fd4..000000000000
> diff --git a/arch/c6x/lib/negll.S b/arch/c6x/lib/negll.S
> deleted file mode 100644
> index 9ba434db5366..000000000000
> diff --git a/arch/c6x/lib/pop_rts.S b/arch/c6x/lib/pop_rts.S
> deleted file mode 100644
> index f129e32943c5..000000000000
> diff --git a/arch/c6x/lib/push_rts.S b/arch/c6x/lib/push_rts.S
> deleted file mode 100644
> index 40b0a4fe937c..000000000000
> diff --git a/arch/c6x/lib/remi.S b/arch/c6x/lib/remi.S
> deleted file mode 100644
> index 96a1335eac20..000000000000
> diff --git a/arch/c6x/lib/remu.S b/arch/c6x/lib/remu.S
> deleted file mode 100644
> index 428feb9c06c0..000000000000
> diff --git a/arch/c6x/lib/strasgi.S b/arch/c6x/lib/strasgi.S
> deleted file mode 100644
> index 715aeb200792..000000000000
> diff --git a/arch/c6x/lib/strasgi_64plus.S b/arch/c6x/lib/strasgi_64plus.S
> deleted file mode 100644
> index d10aa2dc3249..000000000000
> diff --git a/arch/c6x/mm/Makefile b/arch/c6x/mm/Makefile
> deleted file mode 100644
> index 19d05e972dd1..000000000000
> diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
> deleted file mode 100644
> index 03df07a831fc..000000000000
> diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
> deleted file mode 100644
> index a97e51a3e26d..000000000000
> diff --git a/arch/c6x/platforms/Kconfig b/arch/c6x/platforms/Kconfig
> deleted file mode 100644
> index f3a9ae6e0e82..000000000000
> diff --git a/arch/c6x/platforms/Makefile b/arch/c6x/platforms/Makefile
> deleted file mode 100644
> index b320f1c68884..000000000000
> diff --git a/arch/c6x/platforms/cache.c b/arch/c6x/platforms/cache.c
> deleted file mode 100644
> index fff027b72513..000000000000
> diff --git a/arch/c6x/platforms/dscr.c b/arch/c6x/platforms/dscr.c
> deleted file mode 100644
> index 4571615b589f..000000000000
> diff --git a/arch/c6x/platforms/emif.c b/arch/c6x/platforms/emif.c
> deleted file mode 100644
> index 6142ecc2cd88..000000000000
> diff --git a/arch/c6x/platforms/megamod-pic.c b/arch/c6x/platforms/megamod-pic.c
> deleted file mode 100644
> index 56189e50728c..000000000000
> diff --git a/arch/c6x/platforms/pll.c b/arch/c6x/platforms/pll.c
> deleted file mode 100644
> index 6fdf20d64dc7..000000000000
> diff --git a/arch/c6x/platforms/plldata.c b/arch/c6x/platforms/plldata.c
> deleted file mode 100644
> index a799e04edefe..000000000000
> diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
> deleted file mode 100644
> index 661f4c7c6ef6..000000000000
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 0c262c2aeaf2..e7f7eee6ee9a 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -80,7 +80,7 @@ config MOXTET
>  
>  config HISILICON_LPC
>         bool "Support for ISA I/O space on HiSilicon Hip06/7"
> -       depends on (ARM64 && ARCH_HISI) || (COMPILE_TEST && !ALPHA && !HEXAGON && !PARISC && !C6X)
> +       depends on (ARM64 && ARCH_HISI) || (COMPILE_TEST && !ALPHA && !HEXAGON && !PARISC)
>         depends on HAS_IOMEM
>         select INDIRECT_PIO if ARM64
>         help
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 885da6d983b4..647439c2c05a 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -45,7 +45,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>         bool "Kernel support for FDPIC ELF binaries"
>         default y if !BINFMT_ELF
> -       depends on (ARM || (SUPERH && !MMU) || C6X)
> +       depends on (ARM || (SUPERH && !MMU))
>         select ELFCORE
>         help
>           ELF FDPIC binaries are based on ELF, but allow the individual load
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index fe801f01625e..6fc47561814c 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -63,11 +63,7 @@ extern unsigned long memory_end;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> -#ifdef CONFIG_KERNEL_RAM_BASE_ADDRESS
> -#define PAGE_OFFSET            (CONFIG_KERNEL_RAM_BASE_ADDRESS)
> -#else
>  #define PAGE_OFFSET            (0)
> -#endif
>  
>  #ifndef ARCH_PFN_OFFSET
>  #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)

Thanks Arnd.

Acked-by: Mark Salter <msalter@redhat.com>



