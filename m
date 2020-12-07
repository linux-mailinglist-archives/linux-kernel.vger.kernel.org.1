Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05B2D1012
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLGMG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgLGMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:06:57 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0178EC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:06:16 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id 1Q6C2400C4C55Sk01Q6Ckl; Mon, 07 Dec 2020 13:06:12 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmFHQ-008giC-4x
        for linux-kernel@vger.kernel.org; Mon, 07 Dec 2020 13:06:12 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmFHP-005WJS-NG
        for linux-kernel@vger.kernel.org; Mon, 07 Dec 2020 13:06:11 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.10-rc7
Date:   Mon,  7 Dec 2020 13:06:11 +0100
Message-Id: <20201207120611.1315807-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.10-rc7[1] compared to v5.9[2].

Summarized:
  - build errors: +2/-7
  - build warnings: +22/-27

JFYI, when comparing v5.10-rc7[1] to v5.10-rc6[3], the summaries are:
  - build errors: +1/-0
  - build warnings: +1/-1

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0477e92881850d44910a7e94fc2c46f96faa131f/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b65054597872ce3aefbc6a666385eabdf9e288da/ (all 192 configs)


*** ERRORS ***

2 error regressions:
  + /kisskb/src/arch/powerpc/platforms/powermac/smp.c: error: implicit declaration of function 'cleanup_cpu_mmu_context' [-Werror=implicit-function-declaration]:  => 914:2
  + {standard input}: Error: inappropriate arguments for opcode 'adc':  => 170

7 error improvements:
  - error: modpost: "devm_ioremap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/iio/adc/adi-axi-adc.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!: N/A => 


*** WARNINGS ***

22 warning regressions:
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 12470, 12456 => 12733, 12728, 12742
  + .config: warning: override: reassigning to symbol PPC_64K_PAGES:  => 13119
  + /kisskb/src/arch/nds32/kernel/setup.c: warning: unused variable 'region' [-Wunused-variable]:  => 247:26
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: (near initialization for 'nv12_metrics.CurrClock') [-Wmissing-braces]:  => 2539:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2539:2
  + /kisskb/src/drivers/media/pci/intel/ipu3/ipu3-cio2.h: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 22:28
  + /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/sge.c: warning: (near initialization for 'buf[0]') [-Wmissing-braces]:  => 910:9
  + /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/sge.c: warning: missing braces around initializer [-Wmissing-braces]:  => 910:9
  + /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation:  => 441:1
  + /kisskb/src/drivers/net/ethernet/mscc/ocelot_vcap.c: warning: (near initialization for 'etype.value') [-Wmissing-braces]:  => 755:11
  + /kisskb/src/drivers/net/ethernet/mscc/ocelot_vcap.c: warning: missing braces around initializer [-Wmissing-braces]:  => 755:11
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation:  => 482:1
  + /kisskb/src/fs/btrfs/tree-checker.c: warning: (near initialization for 'ri.inode') [-Wmissing-braces]:  => 1056:9
  + /kisskb/src/fs/btrfs/tree-checker.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1056:9
  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.14' uses dynamic stack allocation:  => 295:1
  + /kisskb/src/kernel/rcu/tasks.h: warning: 'show_rcu_tasks_rude_gp_kthread' defined but not used [-Wunused-function]:  => 710:13
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.60' uses dynamic stack allocation:  => 2295:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.59' uses dynamic stack allocation:  => 1992:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.58' uses dynamic stack allocation:  => 2363:1
  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA:  => 58
  + arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA_PIIX:  => 59
  + warning: unmet direct dependencies detected for MFD_CORE:  => N/A

27 warning improvements:
  - .config: warning: override: reassigning to symbol VIRTUALIZATION: 4103 => 
  - /kisskb/src/arch/mips/include/asm/page.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 249:53 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation: 435:1 => 
  - /kisskb/src/drivers/crypto/sa2ul.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 1486:33 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined: 37 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined: 36 => 
  - /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: (near initialization for 'cs_counters.cs_counters') [-Wmissing-braces]: 282:9 => 
  - /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: missing braces around initializer [-Wmissing-braces]: 282:9 => 
  - /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 197:33 => 
  - /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 198:32 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: (near initialization for 'cfg.reg_val') [-Wmissing-braces]: 62:8, 103:8 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: missing braces around initializer [-Wmissing-braces]: 62:8, 103:8 => 
  - /kisskb/src/drivers/staging/media/tegra-vde/vde.c: warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]: 916:12 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation: 482:1 => 
  - /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.15' uses dynamic stack allocation: 298:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin' uses dynamic stack allocation: 283:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_backward' uses dynamic stack allocation: 275:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_forward' uses dynamic stack allocation: 269:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.59' uses dynamic stack allocation: 2293:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.58' uses dynamic stack allocation: 1992:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.57' uses dynamic stack allocation: 2361:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation: 230:1 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]: 1212:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]: 1245:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]: 1317:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: missing braces around initializer [-Wmissing-braces]: 1212:9, 1317:9, 1245:9 => 
  - warning: 148 bad relocations: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
