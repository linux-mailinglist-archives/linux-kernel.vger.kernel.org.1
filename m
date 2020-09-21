Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD0A271DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIUI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:27:21 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:27:20 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id WYTG2300J4C55Sk06YTG8H; Mon, 21 Sep 2020 10:27:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kKHAK-0004El-Ru
        for linux-kernel@vger.kernel.org; Mon, 21 Sep 2020 10:27:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kKHAK-0007dp-Pr
        for linux-kernel@vger.kernel.org; Mon, 21 Sep 2020 10:27:16 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.9-rc6
Date:   Mon, 21 Sep 2020 10:27:16 +0200
Message-Id: <20200921082716.29247-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.9-rc6[1] compared to v5.8[2].

Summarized:
  - build errors: +6/-7
  - build warnings: +63/-38

JFYI, when comparing v5.9-rc6[1] to v5.9-rc5[3], the summaries are:
  - build errors: +3/-5
  - build warnings: +1/-16

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ba4f184e126b751d1bffad5897f263108befc780/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/856deb866d16e29bd65952e0289066f6078af773/ (all 192 configs)


*** ERRORS ***

6 error regressions:
  + /kisskb/src/drivers/dax/super.c: error: redefinition of 'dax_supported':  => 325:6
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 676:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 640:2
  + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!:  => N/A
  + error: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!:  => N/A

7 error improvements:
  - /kisskb/src/arch/powerpc/include/asm/mmu.h: error: unknown type name 'next_tlbcam_idx': 139:22 => 
  - /kisskb/src/arch/sparc/include/asm/trap_block.h: error: 'NR_CPUS' undeclared here (not in a function): 54:39 => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x28), (.fixup+0x10), (.fixup+0x1c), (.fixup+0x4), (.fixup+0x34) => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.ko] undefined!: N/A => 


*** WARNINGS ***

63 warning regressions:
  + /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p64' from incompatible pointer type:  => 67:44
  + /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p8' from incompatible pointer type:  => 69:43
  + /kisskb/src/arch/arm/mach-omap1/board-ams-delta.c: warning: 'ams_delta_camera_power' defined but not used [-Wunused-function]:  => 462:12
  + /kisskb/src/drivers/acpi/processor_idle.c: warning: no return statement in function returning non-void [-Wreturn-type]:  => 179:1
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: (near initialization for 'ad.enc_eng') [-Wmissing-braces]:  => 1569:9, 957:9, 1845:9, 939:9, 1601:9, 1585:9, 1858:9, 971:9, 919:9
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 1486:33
  + /kisskb/src/drivers/crypto/sa2ul.c: warning: missing braces around initializer [-Wmissing-braces]:  => 919:9, 971:9, 1585:9, 1858:9, 1601:9, 1569:9, 957:9, 939:9, 1845:9
  + /kisskb/src/drivers/gpio/gpio-omap.c: warning: 'omap_gpio_resume' defined but not used [-Wunused-function]:  => 1531:12
  + /kisskb/src/drivers/gpio/gpio-omap.c: warning: 'omap_gpio_suspend' defined but not used [-Wunused-function]:  => 1519:12
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 2342:11, 2527:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2342:11, 2527:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 4094:11, 4138:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: missing braces around initializer [-Wmissing-braces]: 2714:8, 2712:8 => 4094:11, 2763:8, 4138:11, 2765:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]:  => 36:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 36:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1795:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1795:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1200:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1200:9
  + /kisskb/src/drivers/gpu/drm/rockchip/cdn-dp-core.c: warning: 'cdn_dp_resume' defined but not used [-Wunused-function]:  => 1124:12
  + /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]:  => 667:9
  + /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 667:9
  + /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: (near initialization for 'cs_counters.cs_counters') [-Wmissing-braces]:  => 282:9
  + /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: missing braces around initializer [-Wmissing-braces]:  => 282:9
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 => 92:0, 92
  + /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: (near initialization for 'cfg.reg_val') [-Wmissing-braces]:  => 62:8, 103:8
  + /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: missing braces around initializer [-Wmissing-braces]:  => 103:8, 62:8
  + /kisskb/src/drivers/staging/media/tegra-vde/vde.c: warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]:  => 916:12
  + /kisskb/src/drivers/tty/serial/sh-sci.c: warning: unused variable 'sport' [-Wunused-variable]:  => 2677:19
  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.15' uses dynamic stack allocation:  => 298:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation:  => 8696:1
  + /kisskb/src/kernel/rcu/tasks.h: warning: 'show_rcu_tasks_classic_gp_kthread' defined but not used [-Wunused-function]:  => 593:13
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1616 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 236:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1584 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1393:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.59' uses dynamic stack allocation:  => 2297:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.58' uses dynamic stack allocation:  => 1996:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.57' uses dynamic stack allocation:  => 2365:1
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3570): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3588): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35b8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35d0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3600): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3618): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3630): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3648): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3660): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3678): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3690): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36a8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36c0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x36d8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x134): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x14c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x164): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x17c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x194): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1ac): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1c4): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A
  + warning: 140 bad relocations:  => N/A

38 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 122:3, 137:3, 79:22 => 79:22, 122:3
  - /kisskb/src/arch/mips/include/asm/page.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 249:53 => 
  - /kisskb/src/arch/powerpc/kernel/head_40x.S: Warning: invalid register expression: 623 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 388, 385 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh2a/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 385, 388 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh3/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 385, 388 => 
  - /kisskb/src/arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S: Warning: overflow in branch to syscall_exit_work; converted into longer instruction sequence: 385, 388 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_resume_noirq' defined but not used [-Wunused-function]: 611:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_resume' defined but not used [-Wunused-function]: 638:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_suspend' defined but not used [-Wunused-function]: 629:12 => 
  - /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_suspend_noirq' defined but not used [-Wunused-function]: 601:12 => 
  - /kisskb/src/drivers/net/phy/mdio-cavium.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 113:48, 114:37 => 
  - /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 48:3 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 46:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread16' discards 'const' qualifier from pointer target type: 46:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 51:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type: 51:18 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]: 41:17 => 
  - /kisskb/src/drivers/sh/clk/cpg.c: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type: 41:17 => 
  - /kisskb/src/include/linux/compiler_attributes.h: warning: statement will never be executed [-Wswitch-unreachable]: 201:41 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1384 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1393:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.57' uses dynamic stack allocation: 2230:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.56' uses dynamic stack allocation: 1929:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.55' uses dynamic stack allocation: 2298:1 => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
