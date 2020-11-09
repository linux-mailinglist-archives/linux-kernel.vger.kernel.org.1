Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439002AB49F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgKIKTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:19:10 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:19:09 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id qAK72300E4C55Sk01AK75L; Mon, 09 Nov 2020 11:19:07 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kc4GQ-000qXw-SL
        for linux-kernel@vger.kernel.org; Mon, 09 Nov 2020 11:19:06 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kc4GQ-009Y2h-Em
        for linux-kernel@vger.kernel.org; Mon, 09 Nov 2020 11:19:06 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.10-rc3
Date:   Mon,  9 Nov 2020 11:19:06 +0100
Message-Id: <20201109101906.2275768-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.10-rc3[1] compared to v5.9[2].

Summarized:
  - build errors: +1/-7
  - build warnings: +22/-22

JFYI, when comparing v5.10-rc3[1] to v5.10-rc2[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +2/-2

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f8394f232b1eab649ce2df5c5f15b0e528c92091/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3cea11cd5e3b00d91caf0b4730194039b45c5891/ (all 192 configs)


*** ERRORS ***

1 error regressions:
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
  + .config: warning: override: reassigning to symbol PPC_64K_PAGES:  => 13113
  + /kisskb/src/arch/nds32/kernel/setup.c: warning: unused variable 'region' [-Wunused-variable]:  => 247:26
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: (near initialization for 'nv12_metrics.CurrClock') [-Wmissing-braces]:  => 2539:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2539:2
  + /kisskb/src/drivers/media/pci/intel/ipu3/ipu3-cio2.h: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 22:28
  + /kisskb/src/drivers/media/platform/marvell-ccic/mmp-driver.c: warning: 'mmpcam_runtime_resume' defined but not used [-Wunused-function]:  => 310:12
  + /kisskb/src/drivers/media/platform/marvell-ccic/mmp-driver.c: warning: 'mmpcam_runtime_suspend' defined but not used [-Wunused-function]:  => 324:12
  + /kisskb/src/drivers/misc/habanalabs/common/command_buffer.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 512:44
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

22 warning improvements:
  - .config: warning: override: reassigning to symbol VIRTUALIZATION: 4103 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation: 435:1 => 
  - /kisskb/src/drivers/crypto/sa2ul.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 1486:33 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "in_be32" redefined: 37 => 
  - /kisskb/src/drivers/media/platform/fsl-viu.c: warning: "out_be32" redefined: 36 => 
  - /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: (near initialization for 'cs_counters.cs_counters') [-Wmissing-braces]: 282:9 => 
  - /kisskb/src/drivers/misc/habanalabs/common/habanalabs_ioctl.c: warning: missing braces around initializer [-Wmissing-braces]: 282:9 => 
  - /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 197:33 => 
  - /kisskb/src/drivers/net/ethernet/intel/ice/ice_flow.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 198:32 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: (near initialization for 'cfg.reg_val') [-Wmissing-braces]: 62:8, 103:8 => 
  - /kisskb/src/drivers/scsi/ufs/ufshcd-crypto.c: warning: missing braces around initializer [-Wmissing-braces]: 103:8, 62:8 => 
  - /kisskb/src/drivers/staging/media/tegra-vde/vde.c: warning: 'tegra_vde_runtime_suspend' defined but not used [-Wunused-function]: 916:12 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation: 482:1 => 
  - /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.15' uses dynamic stack allocation: 298:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.59' uses dynamic stack allocation: 2293:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.58' uses dynamic stack allocation: 1992:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.57' uses dynamic stack allocation: 2361:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation: 230:1 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'add_llc.hd') [-Wmissing-braces]: 1212:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'del_llc.hd') [-Wmissing-braces]: 1245:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: (near initialization for 'delllc.hd') [-Wmissing-braces]: 1317:9 => 
  - /kisskb/src/net/smc/smc_llc.c: warning: missing braces around initializer [-Wmissing-braces]: 1245:9, 1212:9, 1317:9 => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
