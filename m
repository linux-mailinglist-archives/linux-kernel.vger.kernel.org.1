Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2109C2F7196
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbhAOE2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbhAOE2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:28:37 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:27:57 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i5so5234782pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IVfRIn1IdZ+KIcgM9dwizuMXg0VbaK10nYcks4c118g=;
        b=LYgZX8A7YJ6usUkGmKQv229XwoIAMetEVhcAo7KYiiMLOM6iphXZ/Kfvrv2tSK8i2I
         VpnwoXVBFztYlVjviTV7svlCIhOlFJrzGOozBaBmjayQQ5rLpOqzTl/gjV7E/N+JgEQC
         Yje6ODuDxgZfQE16sdPuwDYQ8I8+zlfWK1hm/GluYGh3vv396Zm1v0qpLfE1C/reFLDT
         61zKbelznRrg8uzeFNF4m8SWO9QJXOYxBzjCMaJtbXsthpUvjuG+pyxhXOqLk5hw3KAo
         GOdL5qEUxrVhWf6Xa7c24Y3KYxa/IzmtBsTqrm0r03vz1Md62ubpAr9pmAMzpH+0aI3e
         /r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IVfRIn1IdZ+KIcgM9dwizuMXg0VbaK10nYcks4c118g=;
        b=bTFsXgnHyytkYlci9WMCt80FtJm4KMcPdxu/nnjEQr4f7Zt9JW2cOHvtegLE/9yFqC
         p8favE5/LEWbyZ7Biw7Uc6/XojEWStxFhcWLgTnY7rioe3LR40qCLSrvND1igGSfTsBN
         zJ36iMiEeoYDoucTLpAw/XdTMr8i+Iqa60v5w+rokcDd0Nb2hIIcUoCfNYtEieHApgGF
         yfNY8XiQiUM7gccPOM8U5x3zH+0FJz2YI/pxjqpbHd+Dc+pyPsFD2Frtlu92rNc88gPa
         uXlbJ1xAGz2aOwPlPVSOmrD6VIeNVKzm8c4YAHHyfJJkYVCISmg47QuHxTEduiwfxrjW
         5OAA==
X-Gm-Message-State: AOAM532DxSU8tl6IbHbj0Je/Ro7QO9WfDG8/HJd8E1CK68LA1Lna/Wzs
        p9R53i8no+aNQ7k9Yt1YqBkGYpmgsY3SIw==
X-Google-Smtp-Source: ABdhPJyiI7SCE5lAYjhhqCvEfXCUTlAyrsPviSY+OiVDYIWCkh+vYsu2nxZ8zkux0ybCSgVeVhdRzA==
X-Received: by 2002:aa7:87d2:0:b029:1a5:43da:b93c with SMTP id i18-20020aa787d20000b02901a543dab93cmr10561798pfo.6.1610684876521;
        Thu, 14 Jan 2021 20:27:56 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id bx17sm6899802pjb.12.2021.01.14.20.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 20:27:55 -0800 (PST)
Date:   Fri, 15 Jan 2021 09:57:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org
Subject: Re: [PATCH 00/18] drivers: Remove oprofile and dcookies
Message-ID: <20210115042753.ozc7tih64vgvh2zm@vireshk-i7>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+LKML (Not sure why the cover-letter didn't go to LKML but everything else).

On 14-01-21, 17:04, Viresh Kumar wrote:
> Hello,
> 
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove oprofile and dcookies (whose only user is oprofile) support from
> the kernel.
> 
> This was suggested here [1] earlier.
> 
> This is build/boot tested by kernel test robot (Intel) and Linaro's
> Tuxmake[2] for a lot of architectures and no failures were reported.
> 
> --
> Viresh
> 
> [1] https://lore.kernel.org/lkml/CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com/
> [2] https://lwn.net/Articles/841624/
> 
> Viresh Kumar (18):
>   arch: alpha: Remove CONFIG_OPROFILE support
>   arch: arm: Remove CONFIG_OPROFILE support
>   arch: arc: Remove CONFIG_OPROFILE support
>   arch: hexagon: Don't select HAVE_OPROFILE
>   arch: ia64: Remove CONFIG_OPROFILE support
>   arch: ia64: Remove rest of perfmon support
>   arch: microblaze: Remove CONFIG_OPROFILE support
>   arch: mips: Remove CONFIG_OPROFILE support
>   arch: parisc: Remove CONFIG_OPROFILE support
>   arch: powerpc: Stop building and using oprofile
>   arch: powerpc: Remove oprofile
>   arch: s390: Remove CONFIG_OPROFILE support
>   arch: sh: Remove CONFIG_OPROFILE support
>   arch: sparc: Remove CONFIG_OPROFILE support
>   arch: x86: Remove CONFIG_OPROFILE support
>   arch: xtensa: Remove CONFIG_OPROFILE support
>   drivers: Remove CONFIG_OPROFILE support
>   fs: Remove dcookies support
> 
>  Documentation/RCU/NMI-RCU.rst                 |    3 +-
>  .../admin-guide/kernel-parameters.txt         |   14 -
>  Documentation/kbuild/makefiles.rst            |    1 -
>  Documentation/process/magic-number.rst        |    1 -
>  .../it_IT/process/magic-number.rst            |    1 -
>  .../zh_CN/process/magic-number.rst            |    1 -
>  MAINTAINERS                                   |   11 -
>  arch/Kconfig                                  |   32 -
>  arch/alpha/Kconfig                            |    1 -
>  arch/alpha/Makefile                           |    1 -
>  arch/alpha/oprofile/Makefile                  |   20 -
>  arch/alpha/oprofile/common.c                  |  189 --
>  arch/alpha/oprofile/op_impl.h                 |   55 -
>  arch/alpha/oprofile/op_model_ev4.c            |  114 --
>  arch/alpha/oprofile/op_model_ev5.c            |  209 --
>  arch/alpha/oprofile/op_model_ev6.c            |  101 -
>  arch/alpha/oprofile/op_model_ev67.c           |  261 ---
>  arch/arc/Kconfig                              |    1 -
>  arch/arc/Makefile                             |    2 -
>  arch/arc/oprofile/Makefile                    |   10 -
>  arch/arc/oprofile/common.c                    |   23 -
>  arch/arm/Kconfig                              |    1 -
>  arch/arm/Makefile                             |    2 -
>  arch/arm/configs/bcm2835_defconfig            |    1 -
>  arch/arm/configs/cns3420vb_defconfig          |    1 -
>  arch/arm/configs/corgi_defconfig              |    1 -
>  arch/arm/configs/imx_v4_v5_defconfig          |    1 -
>  arch/arm/configs/keystone_defconfig           |    1 -
>  arch/arm/configs/multi_v5_defconfig           |    1 -
>  arch/arm/configs/mv78xx0_defconfig            |    1 -
>  arch/arm/configs/mvebu_v5_defconfig           |    1 -
>  arch/arm/configs/omap1_defconfig              |    1 -
>  arch/arm/configs/omap2plus_defconfig          |    1 -
>  arch/arm/configs/orion5x_defconfig            |    1 -
>  arch/arm/configs/pxa_defconfig                |    1 -
>  arch/arm/configs/qcom_defconfig               |    1 -
>  arch/arm/configs/socfpga_defconfig            |    1 -
>  arch/arm/configs/spitz_defconfig              |    1 -
>  arch/arm/configs/vexpress_defconfig           |    1 -
>  arch/arm/oprofile/Makefile                    |   14 -
>  arch/arm/oprofile/common.c                    |  132 --
>  arch/hexagon/Kconfig                          |    1 -
>  arch/ia64/Kconfig                             |    1 -
>  arch/ia64/Makefile                            |    1 -
>  arch/ia64/configs/bigsur_defconfig            |    1 -
>  arch/ia64/include/asm/hw_irq.h                |    1 -
>  arch/ia64/include/asm/perfmon.h               |  111 --
>  arch/ia64/include/uapi/asm/perfmon.h          |  178 --
>  .../include/uapi/asm/perfmon_default_smpl.h   |   84 -
>  arch/ia64/kernel/palinfo.c                    |   41 -
>  arch/ia64/kernel/perfmon_default_smpl.c       |  297 ---
>  arch/ia64/kernel/perfmon_generic.h            |   46 -
>  arch/ia64/kernel/perfmon_itanium.h            |    2 +-
>  arch/ia64/kernel/perfmon_mckinley.h           |  188 --
>  arch/ia64/kernel/perfmon_montecito.h          |  270 ---
>  arch/ia64/oprofile/Makefile                   |   10 -
>  arch/ia64/oprofile/backtrace.c                |  131 --
>  arch/ia64/oprofile/init.c                     |   28 -
>  arch/microblaze/Kconfig                       |    1 -
>  arch/microblaze/Makefile                      |    2 -
>  arch/microblaze/oprofile/Makefile             |   14 -
>  .../microblaze/oprofile/microblaze_oprofile.c |   22 -
>  arch/mips/Kconfig                             |    3 +-
>  arch/mips/Makefile                            |    1 -
>  arch/mips/configs/fuloong2e_defconfig         |    1 -
>  arch/mips/configs/ip32_defconfig              |    1 -
>  arch/mips/configs/lemote2f_defconfig          |    1 -
>  arch/mips/configs/mtx1_defconfig              |    1 -
>  arch/mips/configs/rs90_defconfig              |    1 -
>  .../include/asm/mach-loongson2ef/loongson.h   |    9 -
>  arch/mips/loongson2ef/fuloong-2e/irq.c        |    2 +-
>  arch/mips/loongson2ef/lemote-2f/irq.c         |    1 -
>  arch/mips/oprofile/Makefile                   |   18 -
>  arch/mips/oprofile/backtrace.c                |  177 --
>  arch/mips/oprofile/common.c                   |  147 --
>  arch/mips/oprofile/op_impl.h                  |   41 -
>  arch/mips/oprofile/op_model_loongson2.c       |  161 --
>  arch/mips/oprofile/op_model_loongson3.c       |  213 --
>  arch/mips/oprofile/op_model_mipsxx.c          |  479 -----
>  arch/parisc/Kconfig                           |    1 -
>  arch/parisc/Makefile                          |    2 -
>  arch/parisc/oprofile/Makefile                 |   10 -
>  arch/parisc/oprofile/init.c                   |   23 -
>  arch/powerpc/Kconfig                          |    1 -
>  arch/powerpc/Makefile                         |    2 -
>  arch/powerpc/configs/44x/akebono_defconfig    |    1 -
>  arch/powerpc/configs/44x/currituck_defconfig  |    1 -
>  arch/powerpc/configs/44x/fsp2_defconfig       |    1 -
>  arch/powerpc/configs/44x/iss476-smp_defconfig |    1 -
>  arch/powerpc/configs/cell_defconfig           |    1 -
>  arch/powerpc/configs/g5_defconfig             |    1 -
>  arch/powerpc/configs/maple_defconfig          |    1 -
>  arch/powerpc/configs/pasemi_defconfig         |    1 -
>  arch/powerpc/configs/pmac32_defconfig         |    1 -
>  arch/powerpc/configs/powernv_defconfig        |    1 -
>  arch/powerpc/configs/ppc64_defconfig          |    1 -
>  arch/powerpc/configs/ppc64e_defconfig         |    1 -
>  arch/powerpc/configs/ppc6xx_defconfig         |    1 -
>  arch/powerpc/configs/ps3_defconfig            |    1 -
>  arch/powerpc/configs/pseries_defconfig        |    1 -
>  arch/powerpc/include/asm/cputable.h           |   20 -
>  arch/powerpc/include/asm/oprofile_impl.h      |  135 --
>  arch/powerpc/include/asm/spu.h                |   33 -
>  arch/powerpc/kernel/cputable.c                |   67 -
>  arch/powerpc/kernel/dt_cpu_ftrs.c             |    2 -
>  arch/powerpc/oprofile/Makefile                |   19 -
>  arch/powerpc/oprofile/backtrace.c             |  120 --
>  arch/powerpc/oprofile/cell/pr_util.h          |  110 --
>  arch/powerpc/oprofile/cell/spu_profiler.c     |  248 ---
>  arch/powerpc/oprofile/cell/spu_task_sync.c    |  657 -------
>  arch/powerpc/oprofile/cell/vma_map.c          |  279 ---
>  arch/powerpc/oprofile/common.c                |  243 ---
>  arch/powerpc/oprofile/op_model_7450.c         |  207 --
>  arch/powerpc/oprofile/op_model_cell.c         | 1709 -----------------
>  arch/powerpc/oprofile/op_model_fsl_emb.c      |  380 ----
>  arch/powerpc/oprofile/op_model_pa6t.c         |  227 ---
>  arch/powerpc/oprofile/op_model_power4.c       |  438 -----
>  arch/powerpc/platforms/cell/Kconfig           |    5 -
>  arch/powerpc/platforms/cell/spu_notify.c      |   55 -
>  arch/powerpc/platforms/cell/spufs/run.c       |    4 +-
>  arch/powerpc/platforms/cell/spufs/sched.c     |    5 -
>  arch/powerpc/platforms/cell/spufs/spufs.h     |    1 -
>  arch/s390/Kconfig                             |    1 -
>  arch/s390/Makefile                            |    3 -
>  arch/s390/configs/debug_defconfig             |    1 -
>  arch/s390/configs/defconfig                   |    1 -
>  arch/s390/oprofile/Makefile                   |   10 -
>  arch/s390/oprofile/init.c                     |   37 -
>  arch/sh/Kconfig                               |    1 -
>  arch/sh/Makefile                              |    1 -
>  arch/sh/configs/espt_defconfig                |    1 -
>  arch/sh/configs/migor_defconfig               |    1 -
>  arch/sh/configs/r7780mp_defconfig             |    1 -
>  arch/sh/configs/r7785rp_defconfig             |    1 -
>  arch/sh/configs/rsk7201_defconfig             |    1 -
>  arch/sh/configs/rsk7203_defconfig             |    1 -
>  arch/sh/configs/rts7751r2d1_defconfig         |    1 -
>  arch/sh/configs/rts7751r2dplus_defconfig      |    1 -
>  arch/sh/configs/sdk7786_defconfig             |    1 -
>  arch/sh/configs/se7206_defconfig              |    1 -
>  arch/sh/configs/sh03_defconfig                |    1 -
>  arch/sh/configs/sh7724_generic_defconfig      |    1 -
>  arch/sh/configs/sh7763rdp_defconfig           |    1 -
>  arch/sh/configs/sh7770_generic_defconfig      |    1 -
>  arch/sh/configs/shx3_defconfig                |    1 -
>  arch/sh/oprofile/Makefile                     |   16 -
>  arch/sh/oprofile/backtrace.c                  |   80 -
>  arch/sh/oprofile/common.c                     |   64 -
>  arch/sparc/Kconfig                            |    1 -
>  arch/sparc/Makefile                           |    1 -
>  arch/sparc/configs/sparc64_defconfig          |    1 -
>  arch/sparc/oprofile/Makefile                  |   10 -
>  arch/sparc/oprofile/init.c                    |   87 -
>  arch/x86/Kconfig                              |    1 -
>  arch/x86/Makefile                             |    3 -
>  arch/x86/include/asm/nmi.h                    |    1 -
>  arch/x86/kernel/cpu/perfctr-watchdog.c        |   11 +-
>  arch/x86/oprofile/Makefile                    |   12 -
>  arch/x86/oprofile/backtrace.c                 |  127 --
>  arch/x86/oprofile/init.c                      |   38 -
>  arch/x86/oprofile/nmi_int.c                   |  780 --------
>  arch/x86/oprofile/op_counter.h                |   30 -
>  arch/x86/oprofile/op_model_amd.c              |  542 ------
>  arch/x86/oprofile/op_model_p4.c               |  723 -------
>  arch/x86/oprofile/op_model_ppro.c             |  245 ---
>  arch/x86/oprofile/op_x86_model.h              |   90 -
>  arch/xtensa/Kconfig                           |    1 -
>  arch/xtensa/Makefile                          |    1 -
>  arch/xtensa/configs/audio_kc705_defconfig     |    1 -
>  arch/xtensa/configs/generic_kc705_defconfig   |    1 -
>  arch/xtensa/configs/smp_lx200_defconfig       |    1 -
>  arch/xtensa/configs/xip_kc705_defconfig       |    1 -
>  arch/xtensa/kernel/stacktrace.c               |    2 +-
>  arch/xtensa/oprofile/Makefile                 |   10 -
>  arch/xtensa/oprofile/backtrace.c              |   27 -
>  arch/xtensa/oprofile/init.c                   |   26 -
>  drivers/oprofile/buffer_sync.c                |  591 ------
>  drivers/oprofile/buffer_sync.h                |   22 -
>  drivers/oprofile/cpu_buffer.c                 |  465 -----
>  drivers/oprofile/cpu_buffer.h                 |  121 --
>  drivers/oprofile/event_buffer.c               |  209 --
>  drivers/oprofile/event_buffer.h               |   40 -
>  drivers/oprofile/nmi_timer_int.c              |  157 --
>  drivers/oprofile/oprof.c                      |  286 ---
>  drivers/oprofile/oprof.h                      |   50 -
>  drivers/oprofile/oprofile_files.c             |  201 --
>  drivers/oprofile/oprofile_perf.c              |  328 ----
>  drivers/oprofile/oprofile_stats.c             |   84 -
>  drivers/oprofile/oprofile_stats.h             |   33 -
>  drivers/oprofile/oprofilefs.c                 |  300 ---
>  drivers/oprofile/timer_int.c                  |  122 --
>  fs/Makefile                                   |    1 -
>  fs/dcookies.c                                 |  356 ----
>  include/linux/dcookies.h                      |   69 -
>  include/linux/oprofile.h                      |  209 --
>  init/Kconfig                                  |    2 +-
>  kernel/sys.c                                  |    1 -
>  usr/include/Makefile                          |    2 -
>  198 files changed, 8 insertions(+), 15566 deletions(-)
>  delete mode 100644 arch/alpha/oprofile/Makefile
>  delete mode 100644 arch/alpha/oprofile/common.c
>  delete mode 100644 arch/alpha/oprofile/op_impl.h
>  delete mode 100644 arch/alpha/oprofile/op_model_ev4.c
>  delete mode 100644 arch/alpha/oprofile/op_model_ev5.c
>  delete mode 100644 arch/alpha/oprofile/op_model_ev6.c
>  delete mode 100644 arch/alpha/oprofile/op_model_ev67.c
>  delete mode 100644 arch/arc/oprofile/Makefile
>  delete mode 100644 arch/arc/oprofile/common.c
>  delete mode 100644 arch/arm/oprofile/Makefile
>  delete mode 100644 arch/arm/oprofile/common.c
>  delete mode 100644 arch/ia64/include/asm/perfmon.h
>  delete mode 100644 arch/ia64/include/uapi/asm/perfmon.h
>  delete mode 100644 arch/ia64/include/uapi/asm/perfmon_default_smpl.h
>  delete mode 100644 arch/ia64/kernel/perfmon_default_smpl.c
>  delete mode 100644 arch/ia64/kernel/perfmon_generic.h
>  delete mode 100644 arch/ia64/kernel/perfmon_mckinley.h
>  delete mode 100644 arch/ia64/kernel/perfmon_montecito.h
>  delete mode 100644 arch/ia64/oprofile/Makefile
>  delete mode 100644 arch/ia64/oprofile/backtrace.c
>  delete mode 100644 arch/ia64/oprofile/init.c
>  delete mode 100644 arch/microblaze/oprofile/Makefile
>  delete mode 100644 arch/microblaze/oprofile/microblaze_oprofile.c
>  delete mode 100644 arch/mips/oprofile/Makefile
>  delete mode 100644 arch/mips/oprofile/backtrace.c
>  delete mode 100644 arch/mips/oprofile/common.c
>  delete mode 100644 arch/mips/oprofile/op_impl.h
>  delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
>  delete mode 100644 arch/mips/oprofile/op_model_loongson3.c
>  delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
>  delete mode 100644 arch/parisc/oprofile/Makefile
>  delete mode 100644 arch/parisc/oprofile/init.c
>  delete mode 100644 arch/powerpc/include/asm/oprofile_impl.h
>  delete mode 100644 arch/powerpc/oprofile/Makefile
>  delete mode 100644 arch/powerpc/oprofile/backtrace.c
>  delete mode 100644 arch/powerpc/oprofile/cell/pr_util.h
>  delete mode 100644 arch/powerpc/oprofile/cell/spu_profiler.c
>  delete mode 100644 arch/powerpc/oprofile/cell/spu_task_sync.c
>  delete mode 100644 arch/powerpc/oprofile/cell/vma_map.c
>  delete mode 100644 arch/powerpc/oprofile/common.c
>  delete mode 100644 arch/powerpc/oprofile/op_model_7450.c
>  delete mode 100644 arch/powerpc/oprofile/op_model_cell.c
>  delete mode 100644 arch/powerpc/oprofile/op_model_fsl_emb.c
>  delete mode 100644 arch/powerpc/oprofile/op_model_pa6t.c
>  delete mode 100644 arch/powerpc/oprofile/op_model_power4.c
>  delete mode 100644 arch/powerpc/platforms/cell/spu_notify.c
>  delete mode 100644 arch/s390/oprofile/Makefile
>  delete mode 100644 arch/s390/oprofile/init.c
>  delete mode 100644 arch/sh/oprofile/Makefile
>  delete mode 100644 arch/sh/oprofile/backtrace.c
>  delete mode 100644 arch/sh/oprofile/common.c
>  delete mode 100644 arch/sparc/oprofile/Makefile
>  delete mode 100644 arch/sparc/oprofile/init.c
>  delete mode 100644 arch/x86/oprofile/Makefile
>  delete mode 100644 arch/x86/oprofile/backtrace.c
>  delete mode 100644 arch/x86/oprofile/init.c
>  delete mode 100644 arch/x86/oprofile/nmi_int.c
>  delete mode 100644 arch/x86/oprofile/op_counter.h
>  delete mode 100644 arch/x86/oprofile/op_model_amd.c
>  delete mode 100644 arch/x86/oprofile/op_model_p4.c
>  delete mode 100644 arch/x86/oprofile/op_model_ppro.c
>  delete mode 100644 arch/x86/oprofile/op_x86_model.h
>  delete mode 100644 arch/xtensa/oprofile/Makefile
>  delete mode 100644 arch/xtensa/oprofile/backtrace.c
>  delete mode 100644 arch/xtensa/oprofile/init.c
>  delete mode 100644 drivers/oprofile/buffer_sync.c
>  delete mode 100644 drivers/oprofile/buffer_sync.h
>  delete mode 100644 drivers/oprofile/cpu_buffer.c
>  delete mode 100644 drivers/oprofile/cpu_buffer.h
>  delete mode 100644 drivers/oprofile/event_buffer.c
>  delete mode 100644 drivers/oprofile/event_buffer.h
>  delete mode 100644 drivers/oprofile/nmi_timer_int.c
>  delete mode 100644 drivers/oprofile/oprof.c
>  delete mode 100644 drivers/oprofile/oprof.h
>  delete mode 100644 drivers/oprofile/oprofile_files.c
>  delete mode 100644 drivers/oprofile/oprofile_perf.c
>  delete mode 100644 drivers/oprofile/oprofile_stats.c
>  delete mode 100644 drivers/oprofile/oprofile_stats.h
>  delete mode 100644 drivers/oprofile/oprofilefs.c
>  delete mode 100644 drivers/oprofile/timer_int.c
>  delete mode 100644 fs/dcookies.c
>  delete mode 100644 include/linux/dcookies.h
>  delete mode 100644 include/linux/oprofile.h
> 
> 
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

-- 
viresh
