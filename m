Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA828D816
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgJNBmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:42:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:27106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388567AbgJNBmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:42:49 -0400
IronPort-SDR: b+JwvJZ82QaJ448ETIBI1uzCaXbDcNBUdGIvwd2fALBe6OP71zKeNIhnPmbZoCvFFI3HFj1FtW
 hOK4P1ZZ3QvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="152952739"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="152952739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 18:42:47 -0700
IronPort-SDR: GRDxOgfEyvys4k9JQMT+vn2n43jLy+gJfzjdRNlnBnKU7aIu/CLdSjNQBQFhSs213SIvWsMCvi
 lPU2faMUEBfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="346373694"
Received: from lkp-server02.sh.intel.com (HELO c57e4c60a28b) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2020 18:42:46 -0700
Received: from kbuild by c57e4c60a28b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSVoT-00006m-SB; Wed, 14 Oct 2020 01:42:45 +0000
Date:   Wed, 14 Oct 2020 09:41:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 ab0a40ea88204e1291b56da8128e2845fec8ee88
Message-ID: <5f865767.XhtGyQAf4JgaGuNR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  objtool/core
branch HEAD: ab0a40ea88204e1291b56da8128e2845fec8ee88  perf build: Allow nested externs to enable BUILD_BUG() usage

elapsed time: 724m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
m68k                       m5249evb_defconfig
arc                            hsdk_defconfig
h8300                    h8300h-sim_defconfig
microblaze                    nommu_defconfig
mips                           rs90_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm8540_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          kfr2r09_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
ia64                             alldefconfig
powerpc                     tqm5200_defconfig
arc                             nps_defconfig
arm                       versatile_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                malta_qemu_32r6_defconfig
xtensa                    smp_lx200_defconfig
powerpc64                        alldefconfig
s390                                defconfig
arm                    vt8500_v6_v7_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
arm                        keystone_defconfig
m68k                           sun3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  mpc866_ads_defconfig
sh                            titan_defconfig
arm                            hisi_defconfig
powerpc                     ppa8548_defconfig
m68k                          atari_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
m68k                          multi_defconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
powerpc                      katmai_defconfig
arm                          iop32x_defconfig
powerpc                 mpc834x_itx_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
arc                          axs103_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7203_defconfig
powerpc                      ep88xc_defconfig
powerpc                 linkstation_defconfig
arm                          pxa168_defconfig
sh                     magicpanelr2_defconfig
sh                               allmodconfig
sh                          sdk7786_defconfig
mips                      pistachio_defconfig
sh                        sh7785lcr_defconfig
sh                        edosk7705_defconfig
powerpc                     tqm8541_defconfig
arc                        vdk_hs38_defconfig
powerpc                      makalu_defconfig
powerpc                      mgcoge_defconfig
arm                              zx_defconfig
powerpc                   currituck_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
arm                            dove_defconfig
sh                             shx3_defconfig
arm                          lpd270_defconfig
xtensa                generic_kc705_defconfig
c6x                        evmc6474_defconfig
ia64                             allmodconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                           h5000_defconfig
powerpc                     mpc5200_defconfig
powerpc                     mpc83xx_defconfig
c6x                              alldefconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         bcm2835_defconfig
powerpc                      pasemi_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a005-20201013
i386                 randconfig-a006-20201013
i386                 randconfig-a001-20201013
i386                 randconfig-a003-20201013
i386                 randconfig-a004-20201013
i386                 randconfig-a002-20201013
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
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
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
