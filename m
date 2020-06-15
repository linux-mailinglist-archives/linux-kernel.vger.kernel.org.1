Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4211F9003
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgFOHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgFOHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:35:37 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:35:36 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:2191:9276:807:82c1])
        by laurent.telenet-ops.be with bizsmtp
        id rKbZ2200d4zira501KbZg7; Mon, 15 Jun 2020 09:35:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jkjeX-0001HF-JH
        for linux-kernel@vger.kernel.org; Mon, 15 Jun 2020 09:35:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jkjeX-0000Tv-H4
        for linux-kernel@vger.kernel.org; Mon, 15 Jun 2020 09:35:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.8-rc1
Date:   Mon, 15 Jun 2020 09:35:33 +0200
Message-Id: <20200615073533.1809-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.8-rc1[1] compared to v5.7[2].

Summarized:
  - build errors: +4/-4
  - build warnings: +66/-42

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b3a9e3b9622ae10064826dccb4f7a52bd88c7407/ (192 out of 194 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162/ (all 194 configs)


*** ERRORS ***

4 error regressions:
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x1c), (.fixup+0x4), (.fixup+0x10), (.fixup+0x34)

4 error improvements:
  - error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: modpost: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 
  - error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 


*** WARNINGS ***

66 warning regressions:
  + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: warning: 'struct page' declared inside parameter list:  => 38:37
  + /kisskb/src/arch/sparc/include/asm/cacheflush_32.h: warning: its scope is only this definition or declaration, which is probably not what you want:  => 38:37
  + /kisskb/src/block/genhd.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1623:1
  + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 205:23
  + /kisskb/src/drivers/gpu/drm/drm_managed.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 67:23
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 10 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 10 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 9 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/infiniband/hw/mlx5/mlx5_ib.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 9 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 56:31
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_resume_noirq' defined but not used [-Wunused-function]:  => 611:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_resume' defined but not used [-Wunused-function]:  => 638:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_runtime_suspend' defined but not used [-Wunused-function]:  => 629:12
  + /kisskb/src/drivers/mailbox/imx-mailbox.c: warning: 'imx_mu_suspend_noirq' defined but not used [-Wunused-function]:  => 601:12
  + /kisskb/src/drivers/net/ethernet/intel/e1000e/netdev.c: warning: 'e1000e_check_me' defined but not used [-Wunused-function]:  => 137:13
  + /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 197:33
  + /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 198:32
  + /kisskb/src/drivers/scsi/dc395x.c: warning: value computed is not used [-Wunused-value]:  => 155:36
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation:  => 498:1
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct address_space' declared inside parameter list will not be visible outside of this definition or declaration:  => 52:50, 58:52
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct address_space' declared inside parameter list:  => 58:52, 52:50
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct mm_struct' declared inside parameter list will not be visible outside of this definition or declaration:  => 16:42, 22:46
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct mm_struct' declared inside parameter list:  => 22:46, 16:42
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration:  => 82:16, 75:17, 44:45
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct page' declared inside parameter list:  => 83:9, 75:17, 44:45
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct vm_area_struct' declared inside parameter list will not be visible outside of this definition or declaration:  => 36:44, 81:50, 74:45, 28:45
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: 'struct vm_area_struct' declared inside parameter list:  => 38:9, 30:10, 83:9, 75:17
  + /kisskb/src/include/asm-generic/cacheflush.h: warning: its scope is only this definition or declaration, which is probably not what you want:  => 16:42
  + /kisskb/src/include/linux/compiler_attributes.h: warning: statement will never be executed [-Wswitch-unreachable]:  => 200:41
  + /kisskb/src/include/linux/jump_label.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 10 has type 'size_t' [-Wformat=]:  => 471:59
  + /kisskb/src/include/linux/jump_label.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' [-Wformat=]:  => 471:59
  + /kisskb/src/include/linux/jump_label.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'size_t' [-Wformat=]:  => 471:59
  + /kisskb/src/include/linux/jump_label.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 9 has type 'size_t' [-Wformat=]:  => 471:59
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'unsigned int' [-Wformat=]:  => 5:18
  + /kisskb/src/include/linux/kern_levels.h: warning: format '%zd' expects argument of type 'signed size_t', but argument 2 has type 'ssize_t {aka int}' [-Wformat=]:  => 5:18
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.18' uses dynamic stack allocation:  => 3498:1
  + /kisskb/src/kernel/rcu/rcuperf.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 2 has type 'unsigned int' [-Wformat=]:  => 726:65
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.45' uses dynamic stack allocation:  => 2230:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.44' uses dynamic stack allocation:  => 1929:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.43' uses dynamic stack allocation:  => 2298:1
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]:  => 1145:9
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]:  => 1178:9
  + /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]:  => 1250:9
  + /kisskb/src/net/smc/smc_llc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1250:9, 1178:9, 1145:9
  + /kisskb/src/net/sunrpc/svcsock.c: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined [-Wundef]:  => 226:5
  + /kisskb/src/net/sunrpc/svcsock.c: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Wundef]:  => 226:5
  + /kisskb/src/samples/seccomp/user-trap.c: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]:  => 83:2, 50:2
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + warning: 136 bad relocations:  => N/A
  + warning: 148 bad relocations:  => N/A

42 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/amigahw.h: warning: this statement may fall through [-Wimplicit-fallthrough=]: 42:50 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 95:1 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 51:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1617:1 => 
  - /kisskb/src/drivers/android/binderfs.c: warning: (near initialization for 'device_info.name') [-Wmissing-braces]: 653:9 => 
  - /kisskb/src/drivers/android/binderfs.c: warning: missing braces around initializer [-Wmissing-braces]: 653:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'encoder_control.header') [-Wmissing-braces]: 116:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'pixel_clock.header') [-Wmissing-braces]: 342:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: missing braces around initializer [-Wmissing-braces]: 342:9, 116:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'PLAT_54186_wa.header') [-Wmissing-braces]: 781:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 368:9, 781:9 => 368:9
  - /kisskb/src/drivers/gpu/drm/bridge/tc358768.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 840:1 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: (near initialization for 'desc.ident') [-Wmissing-braces]: 5502:9 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: missing braces around initializer [-Wmissing-braces]: 5502:9 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation: 498:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.23' uses dynamic stack allocation: 3269:1 => 
  - /kisskb/src/lib/lz4/lz4hc_compress.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 579:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.42' uses dynamic stack allocation: 2203:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.41' uses dynamic stack allocation: 1910:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.40' uses dynamic stack allocation: 2271:1 => 
  - /kisskb/src/security/integrity/ima/ima_crypto.c: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 510:1 => 
  - modpost: WARNING: modpost: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [drivers/md/raid456.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp: N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1ac): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2b0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu(): N/A => 
  - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2bc): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu(): N/A => 
  - warning: 12 bad relocations: N/A => 
  - warning: unmet direct dependencies detected for SND_SOC_WM9712: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
