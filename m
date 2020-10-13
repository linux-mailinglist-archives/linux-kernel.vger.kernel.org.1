Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91C528C86E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbgJMGAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:00:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:29997 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbgJMGAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:00:02 -0400
IronPort-SDR: zLkZo16pDfd0Dvi4QwpAEjKhPi8en2Hj2BLTLBhFX9QpJZXfTvBKmS3+tChMfoa6b+NIGFXkn7
 kwzsxR5E8pig==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="153686624"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="153686624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 23:00:00 -0700
IronPort-SDR: ITH0Jyv0qZaszAmnSosp4ikdeQAawB36eCvEPagyJbM4rNsHoRYXAUYMA/sI2FtngJ41AruHZj
 +VXH5QxHiTuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="299448970"
Received: from lkp-server02.sh.intel.com (HELO b65d7201e80c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 22:59:58 -0700
Received: from kbuild by b65d7201e80c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSDLp-000015-Vw; Tue, 13 Oct 2020 05:59:57 +0000
Date:   Tue, 13 Oct 2020 13:59:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:master] BUILD SUCCESS
 a9863c90f5031a8fde56351f09fade3cec3ea4f0
Message-ID: <5f85423d.g/wSXH2pBPb+ni9u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  master
branch HEAD: a9863c90f5031a8fde56351f09fade3cec3ea4f0  Merge branch 'urezki-pcount.2020.10.01a' into HEAD

elapsed time: 720m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
mips                        omega2p_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
arm                       mainstone_defconfig
openrisc                 simple_smp_defconfig
h8300                            allyesconfig
csky                                defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
arm                              alldefconfig
xtensa                    xip_kc705_defconfig
sh                   secureedge5410_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
xtensa                  cadence_csp_defconfig
x86_64                           allyesconfig
mips                      fuloong2e_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                     tqm8548_defconfig
m68k                            q40_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       omap2plus_defconfig
arm                        realview_defconfig
mips                       lemote2f_defconfig
mips                         cobalt_defconfig
h8300                     edosk2674_defconfig
powerpc                      pcm030_defconfig
arm64                            alldefconfig
arm                             rpc_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
mips                            ar7_defconfig
arm                            mmp2_defconfig
arc                        vdk_hs38_defconfig
mips                      malta_kvm_defconfig
arc                            hsdk_defconfig
alpha                            allyesconfig
arm                           h5000_defconfig
powerpc                  mpc885_ads_defconfig
arc                           tb10x_defconfig
mips                          ath25_defconfig
parisc                           allyesconfig
sh                     sh7710voipgw_defconfig
nios2                         3c120_defconfig
mips                           ip27_defconfig
powerpc                     pq2fads_defconfig
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
alpha                               defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a014-20201012
x86_64               randconfig-a011-20201012
i386                 randconfig-a016-20201012
i386                 randconfig-a015-20201012
i386                 randconfig-a013-20201012
i386                 randconfig-a012-20201012
i386                 randconfig-a011-20201012
i386                 randconfig-a014-20201012
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012
x86_64               randconfig-a005-20201012
x86_64               randconfig-a006-20201012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
