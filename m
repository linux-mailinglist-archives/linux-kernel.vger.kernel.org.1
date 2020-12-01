Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF02C95B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgLADSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:18:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:2091 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLADSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:18:37 -0500
IronPort-SDR: AonZfNRcKh4ihiQkx6FqUOOQtVSpiXBmQqXgDwAubfUp56EEIq4ip/1+7FJe3yXh/7JyuQbUs+
 zVRcz/CJwvsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="236881667"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="236881667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:17:56 -0800
IronPort-SDR: O3ifYaxDP4u0svSEXDdOniBuuNtw3KCO5+WLNGbp1avQ3UGPhXRppq6QtGHDE2q0Bom1iglpt2
 tFeunU4AJe0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="367358791"
Received: from lkp-server01.sh.intel.com (HELO 70b44b587200) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2020 19:17:54 -0800
Received: from kbuild by 70b44b587200 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kjwAr-00005s-Ul; Tue, 01 Dec 2020 03:17:53 +0000
Date:   Tue, 01 Dec 2020 11:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 9ea69a55b3b9a71cded9726af591949c1138f235
Message-ID: <5fc5b5a8.WnYeHXykQvtVw7IY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  irq/urgent
branch HEAD: 9ea69a55b3b9a71cded9726af591949c1138f235  powerpc/pseries: Pass MSI affinity to irq_create_mapping()

elapsed time: 722m

configs tested: 161
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                           sama5_defconfig
sh                             espt_defconfig
sh                        edosk7705_defconfig
arm                      jornada720_defconfig
arm                       aspeed_g5_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig
sh                         ecovec24_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
powerpc                       maple_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
c6x                         dsk6455_defconfig
powerpc                      ppc64e_defconfig
openrisc                 simple_smp_defconfig
s390                       zfcpdump_defconfig
mips                           gcw0_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
s390                          debug_defconfig
powerpc                      ep88xc_defconfig
arm                            mmp2_defconfig
sh                   secureedge5410_defconfig
arm                         lpc32xx_defconfig
powerpc                     mpc5200_defconfig
mips                         tb0287_defconfig
arm                        mvebu_v7_defconfig
powerpc                 canyonlands_defconfig
mips                            gpr_defconfig
arc                        nsimosci_defconfig
arm                        clps711x_defconfig
arm                           corgi_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                          r7785rp_defconfig
powerpc                    sam440ep_defconfig
mips                        workpad_defconfig
arm                          gemini_defconfig
mips                     cu1000-neo_defconfig
ia64                        generic_defconfig
powerpc                     kilauea_defconfig
powerpc                    adder875_defconfig
sh                               j2_defconfig
powerpc                      katmai_defconfig
arc                           tb10x_defconfig
nios2                         10m50_defconfig
um                           x86_64_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                        fsp2_defconfig
mips                       capcella_defconfig
powerpc                      ppc44x_defconfig
arm                          imote2_defconfig
h8300                       h8s-sim_defconfig
powerpc                   bluestone_defconfig
powerpc                   lite5200b_defconfig
m68k                        m5272c3_defconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                       netwinder_defconfig
powerpc                     tqm8555_defconfig
mips                        nlm_xlp_defconfig
powerpc                   motionpro_defconfig
mips                             allyesconfig
riscv                               defconfig
sh                            hp6xx_defconfig
sh                          lboxre2_defconfig
arm                             pxa_defconfig
powerpc                 xes_mpc85xx_defconfig
xtensa                          iss_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       multi_v4t_defconfig
arc                              allyesconfig
m68k                        mvme16x_defconfig
mips                          rm200_defconfig
m68k                       bvme6000_defconfig
mips                     cu1830-neo_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     stx_gp3_defconfig
arm                          simpad_defconfig
arm                              zx_defconfig
arm                        realview_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     kmeter1_defconfig
mips                      maltasmvp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201130
i386                 randconfig-a002-20201130
i386                 randconfig-a003-20201130
i386                 randconfig-a005-20201130
i386                 randconfig-a006-20201130
i386                 randconfig-a001-20201130
x86_64               randconfig-a014-20201130
x86_64               randconfig-a015-20201130
x86_64               randconfig-a016-20201130
x86_64               randconfig-a011-20201130
x86_64               randconfig-a012-20201130
x86_64               randconfig-a013-20201130
i386                 randconfig-a013-20201130
i386                 randconfig-a012-20201130
i386                 randconfig-a011-20201130
i386                 randconfig-a016-20201130
i386                 randconfig-a015-20201130
i386                 randconfig-a014-20201130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20201130
x86_64               randconfig-a006-20201130
x86_64               randconfig-a005-20201130
x86_64               randconfig-a004-20201130
x86_64               randconfig-a001-20201130
x86_64               randconfig-a003-20201130

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
