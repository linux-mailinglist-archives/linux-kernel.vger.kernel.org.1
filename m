Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2252DD1AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgLQMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:46:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:45748 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbgLQMqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:46:02 -0500
IronPort-SDR: VzhFuDmP64ehdTfcklnqHgX7XqMmHDvEHKokI/yMr1bcg3g+XjmvEfsNSZUDh9Js7tZ1y7wD5P
 VcHj6pizRiSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162292041"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="162292041"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 04:45:18 -0800
IronPort-SDR: F1SBFvV84CcXr+VLQBKZbsTxJnm3F48V0pkLQ+T9BIKUIwi2Cl8OMfde9eMFFrFotdOun8hlAz
 LdH1xvQGWmhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="413362861"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Dec 2020 04:45:17 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpsej-0001Cf-1w; Thu, 17 Dec 2020 12:45:17 +0000
Date:   Thu, 17 Dec 2020 20:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 ba8ea8e7dd6e1662e34e730eadfc52aa6816f9dd
Message-ID: <5fdb52aa.xYlR/qB/YeTvu728%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  timers/urgent
branch HEAD: ba8ea8e7dd6e1662e34e730eadfc52aa6816f9dd  tick/sched: Remove bogus boot "safety" check

elapsed time: 728m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
mips                           jazz_defconfig
powerpc                      arches_defconfig
powerpc                   currituck_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                       h8s-sim_defconfig
powerpc                      walnut_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
mips                malta_kvm_guest_defconfig
alpha                            alldefconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
arm                          pxa910_defconfig
sh                          rsk7264_defconfig
arm                         assabet_defconfig
sh                            hp6xx_defconfig
sh                     magicpanelr2_defconfig
powerpc                      pasemi_defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
sh                            shmin_defconfig
riscv                               defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arc                        vdk_hs38_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                     edosk2674_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
c6x                        evmc6474_defconfig
arm                         axm55xx_defconfig
arm                             mxs_defconfig
sh                         microdev_defconfig
powerpc                  storcenter_defconfig
ia64                            zx1_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
ia64                          tiger_defconfig
powerpc                      ppc6xx_defconfig
arc                      axs103_smp_defconfig
c6x                                 defconfig
powerpc                   motionpro_defconfig
arc                           tb10x_defconfig
i386                                defconfig
alpha                               defconfig
sh                        edosk7705_defconfig
powerpc                       maple_defconfig
sh                          sdk7786_defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc44x_defconfig
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
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a001-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
