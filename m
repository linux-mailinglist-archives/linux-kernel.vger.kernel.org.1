Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9B288C33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbgJIPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:07:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:4114 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388736AbgJIPHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:07:10 -0400
IronPort-SDR: TSD9uurRQx6ejuTAa7nZM3MdRgHt8ea46l36S+/P2CRoe6jlZCFZ5MYaf/fxb2YlQIooLeVClP
 OjmwhsjiJ1ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="165609781"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="165609781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 08:06:51 -0700
IronPort-SDR: 9IbSfeWULkCTDbIyswZfTRns3NSj7R0iFyNnN0P+8wkHv0KXjyq9tTMac6m4rhwPoohAp7BDf8
 cWen5++SCaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="528961187"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2020 08:06:49 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQtyr-0000aO-9M; Fri, 09 Oct 2020 15:06:49 +0000
Date:   Fri, 09 Oct 2020 23:06:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/clang-ft] BUILD SUCCESS WITH WARNING
 de6b606b07e40c037ed4f83b53ee541692a78c6e
Message-ID: <5f807c69.E84k6chcpqON0+DM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-next/clang-ft
branch HEAD: de6b606b07e40c037ed4f83b53ee541692a78c6e  include: jhash/signal: Fix fall-through warnings for Clang

Warning in current branch:

drivers/ata/pata_cmd64x.c:466:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/polaris10_smumgr.c:2275:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:8316:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:8343:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/gpu/drm/radeon/radeon_fb.c:170:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/cec/core/cec-pin.c:421:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/cec/usb/pulse8/pulse8-cec.c:393:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/dvb-frontends/af9013.c:601:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/dvb-frontends/m88ds3103.c:910:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/i2c/ov9640.c:542:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c:50:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/test-drivers/vicodec/vicodec-core.c:1314:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/test-drivers/vivid/vivid-vbi-gen.c:302:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/tuners/fc0011.c:254:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/dvb-usb-v2/af9015.c:47:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/gspca/mr97310a.c:514:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/gspca/ov519.c:2008:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/gspca/sunplus.c:555:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/gspca/xirlink_cit.c:1413:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/gspca/zc3xx.c:6770:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/pwc/pwc-v4l.c:558:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/siano/smsusb.c:434:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/media/usb/uvc/uvc_video.c:1513:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/mmc/host/sdhci-of-arasan.c:837:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/mtd/chips/cfi_cmdset_0002.c:981:1: warning: non-void function does not return a value in all control paths [-Wreturn-type]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:6318:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/ethernet/broadcom/bnxt/bnxt.c:2099:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/ethernet/micrel/ksz884x.c:5836:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/atmel/at76c50x-usb.c:436:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/atmel/atmel.c:1231:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/intel/iwlegacy/4965-mac.c:548:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/intel/iwlegacy/common.c:2682:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/ray_cs.c:881:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/net/wireless/ti/wlcore/main.c:2232:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/scsi/aic94xx/aic94xx_scb.c:724:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/scsi/aic94xx/aic94xx_sds.c:722:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/scsi/aic94xx/aic94xx_task.c:319:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/scsi/bfa/bfa_ioc.c:3303:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/video/fbdev/xilinxfb.c:244:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r014-20201009
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v10_0.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-ethernet-broadcom-bnx2x-bnx2x_main.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-ethernet-micrel-ksz884x.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-atmel-at76c5-usb.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-atmel-atmel.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-intel-iwlegacy-common.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-intel-iwlegacy-mac.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-ray_cs.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-net-wireless-ti-wlcore-main.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-scsi-aic94xx-aic94xx_scb.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-scsi-aic94xx-aic94xx_sds.c:warning:unannotated-fall-through-between-switch-labels
|   `-- drivers-scsi-aic94xx-aic94xx_task.c:warning:unannotated-fall-through-between-switch-labels
|-- arm64-randconfig-r032-20201009
|   |-- drivers-gpu-drm-amd-amdgpu-..-powerplay-smumgr-polaris10_smumgr.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-gpu-drm-amd-amdgpu-gfx_v10_0.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-gpu-drm-radeon-radeon_fb.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-dvb-frontends-af9013.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-i2c-ov9640.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-i2c-s5c73m3-s5c73m3-ctrls.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-test-drivers-vivid-vivid-vbi-gen.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-tuners-fc0011.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-dvb-usb-v2-af9015.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-sunplus.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-siano-smsusb.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-mmc-host-sdhci-of-arasan.c:warning:unannotated-fall-through-between-switch-labels
|   `-- drivers-video-fbdev-xilinxfb.c:warning:unannotated-fall-through-between-switch-labels
|-- riscv-randconfig-r004-20201009
|   `-- drivers-mtd-chips-cfi_cmdset_0002.c:warning:non-void-function-does-not-return-a-value-in-all-control-paths
|-- riscv-randconfig-r032-20201009
|   `-- drivers-media-test-drivers-vicodec-vicodec-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a001-20201009
|   |-- drivers-media-cec-usb-pulse8-pulse8-cec.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-mr97310a.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-ov519.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-sunplus.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-xirlink_cit.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-gspca-zc3xx.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-usb-pwc-pwc-v4l.c:warning:unannotated-fall-through-between-switch-labels
|   `-- drivers-media-usb-uvc-uvc_video.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a002-20201009
|   `-- drivers-ata-pata_cmd64x.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a003-20201009
|   |-- drivers-media-cec-core-cec-pin.c:warning:unannotated-fall-through-between-switch-labels
|   |-- drivers-media-dvb-frontends-m88ds3103.c:warning:unannotated-fall-through-between-switch-labels
|   `-- drivers-media-test-drivers-vivid-vivid-vbi-gen.c:warning:unannotated-fall-through-between-switch-labels
`-- x86_64-randconfig-a005-20201009
    |-- drivers-net-ethernet-broadcom-bnx2x-bnx2x_main.c:warning:unannotated-fall-through-between-switch-labels
    |-- drivers-net-ethernet-broadcom-bnxt-bnxt.c:warning:unannotated-fall-through-between-switch-labels
    `-- drivers-scsi-bfa-bfa_ioc.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 723m

configs tested: 132
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
s390                                defconfig
mips                   sb1250_swarm_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         bigsur_defconfig
arm                       imx_v6_v7_defconfig
arm                  colibri_pxa300_defconfig
arm                          moxart_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
h8300                       h8s-sim_defconfig
arm                       mainstone_defconfig
arm                        shmobile_defconfig
arm                          ixp4xx_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                          allyesconfig
powerpc                  mpc885_ads_defconfig
parisc                           alldefconfig
arc                      axs103_smp_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
mips                      loongson3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                         lpc18xx_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                          pxa168_defconfig
arm                         cm_x300_defconfig
powerpc                      pcm030_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
powerpc                      katmai_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
c6x                        evmc6472_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      walnut_defconfig
sparc                            allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
