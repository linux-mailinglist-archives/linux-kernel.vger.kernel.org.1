Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D92F9CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbhARKQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389366AbhARJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:55:11 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9047BC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:53:59 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id J9tw240044C55Sk019twJQ; Mon, 18 Jan 2021 10:53:56 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1RER-004Xkx-Oz
        for linux-kernel@vger.kernel.org; Mon, 18 Jan 2021 10:53:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1RER-002ISf-5z
        for linux-kernel@vger.kernel.org; Mon, 18 Jan 2021 10:53:55 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.11-rc4
Date:   Mon, 18 Jan 2021 10:53:55 +0100
Message-Id: <20210118095355.547573-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.11-rc4[1] compared to v5.10[2].

Summarized:
  - build errors: +2/-3
  - build warnings: +33/-95

JFYI, when comparing v5.11-rc4[1] to v5.11-rc3[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +0/-0

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/19c329f6808995b142b3966301f217c831e7cf31/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2c85ebc57b3e1817b6ce1a6b703928e113a90442/ (all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7c53f6b671f4aba70ff15e1b05148b10d58c2837/ (all 192 configs)


*** ERRORS ***

2 error regressions:
  + /kisskb/src/include/linux/mmzone.h: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE:  => 1156:2
  + error: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!:  => N/A

3 error improvements:
  - /kisskb/src/arch/powerpc/platforms/powermac/smp.c: error: implicit declaration of function 'cleanup_cpu_mmu_context' [-Werror=implicit-function-declaration]: 914:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]: 676:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]: 640:2 => 


*** WARNINGS ***

33 warning regressions:
  + .config: warning: override: reassigning to symbol GCC_PLUGIN_CYC_COMPLEXITY:  => 4497, 4523
  + .config: warning: override: reassigning to symbol GCC_PLUGIN_LATENT_ENTROPY:  => 4499, 4525
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 12743, 12729 => 12880, 12897, 12884
  + .config: warning: override: reassigning to symbol PPC_64K_PAGES:  => 13260
  + /kisskb/src/arch/arm/mach-omap1/board-h2.c: warning: 'isp1301_gpiod_table' defined but not used [-Wunused-variable]:  => 347:34
  + /kisskb/src/arch/ia64/include/asm/sparsemem.h: warning: "PAGE_SHIFT" is not defined [-Wundef]:  => 14:40
  + /kisskb/src/arch/sh/kernel/traps.c: warning: unused variable 'cpu' [-Wunused-variable]:  => 183:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn20.c: warning: (near initialization for 'boot_options.bits') [-Wmissing-braces]:  => 326:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn20.c: warning: missing braces around initializer [-Wmissing-braces]:  => 326:8
  + /kisskb/src/drivers/pinctrl/nomadik/pinctrl-nomadik.c: warning: unused variable 'wake' [-Wunused-variable]:  => 952:8
  + /kisskb/src/drivers/rtc/rtc-rx6110.c: warning: 'rx6110_probe' defined but not used [-Wunused-function]:  => 314:12
  + /kisskb/src/drivers/soc/qcom/pdr_interface.c: warning: (near initialization for 'req.service_path') [-Wmissing-braces]:  => 572:9
  + /kisskb/src/drivers/soc/qcom/pdr_interface.c: warning: missing braces around initializer [-Wmissing-braces]:  => 572:9
  + /kisskb/src/include/linux/minmax.h: warning: comparison of distinct pointer types lacks a cast:  => 18:28
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 4200 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 4224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7432 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7440 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7456 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1348 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2262:1
  + /opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/../lib/gcc/aarch64-buildroot-linux-gnu/5.4.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 102:21, 170:24
  + /opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/../lib/gcc/aarch64-buildroot-linux-gnu/5.4.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 170:24, 102:21
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/config/mips/mips.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 2913:20
  + /opt/cross/kisskb/br-mipsel-o32-full-2016.08-613-ge98b4dd/bin/../lib/gcc/mipsel-buildroot-linux-uclibc/5.4.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 102:21, 170:24
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 170:24, 102:21
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/config/mips/mips.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 2791:20
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 102:21, 170:24
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/config/s390/s390.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 836:20
  + /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24

95 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 79:22, 122:3 => 
  - /kisskb/src/arch/parisc/kernel/pci-dma.c: warning: 'proc_pcxl_dma_show' defined but not used [-Wunused-function]: 338:12 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation: 175:1 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 51:1, 95:1 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 95:1 => 
  - /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 51:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1688 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 1662:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]: 846:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 846:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 1795:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]: 1795:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]: 1279:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 1279:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 1200:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]: 1200:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]: 451:15 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]: 451:15 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]: 258:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 258:9 => 
  - /kisskb/src/drivers/media/pci/intel/ipu3/ipu3-cio2.h: warning: large integer implicitly truncated to unsigned type [-Woverflow]: 22:28 => 
  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92:0, 92 => 92
  - /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation: 441:1 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709551584' to '-32' [-Woverflow]: 760:2 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in implicit constant conversion [-Woverflow]: 760:2 => 
  - /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation: 1092:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation: 317:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation: 331:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation: 590:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation: 216:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation: 282:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation: 359:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation: 303:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation: 85:1 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation: 482:1 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation: 2886:1 => 
  - /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation: 704:1 => 
  - /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2192 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.14' uses dynamic stack allocation: 295:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.24' uses dynamic stack allocation: 3667:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation: 1819:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation: 1439:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation: 1549:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation: 1580:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation: 1498:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation: 1517:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation: 1290:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation: 1480:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation: 1378:1 => 
  - /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation: 9116:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation: 8303:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation: 8600:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation: 7871:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation: 7649:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation: 8511:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation: 8012:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation: 7748:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation: 7268:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation: 8395:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation: 7555:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation: 8718:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation: 8791:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation: 8336:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation: 8466:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation: 10275:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation: 9430:1 => 
  - /kisskb/src/kernel/rcu/tasks.h: warning: 'show_rcu_tasks_rude_gp_kthread' defined but not used [-Wunused-function]: 710:13 => 
  - /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation: 281:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation: 300:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation: 517:1 => 
  - /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation: 331:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation: 2759:1 => 
  - /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation: 3073:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.60' uses dynamic stack allocation: 2295:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.59' uses dynamic stack allocation: 1992:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.58' uses dynamic stack allocation: 2363:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation: 1767:1 => 
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2942:1 => 
  - warning: unmet direct dependencies detected for MFD_CORE: N/A => 
  - warning: unmet direct dependencies detected for NEED_MULTIPLE_NODES: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
