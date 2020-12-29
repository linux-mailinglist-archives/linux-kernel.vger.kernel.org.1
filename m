Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12442E73FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2UrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:47:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:35872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2UrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:47:14 -0500
IronPort-SDR: mZhPyYyJXH2kLSCYanjut1P4RdtCtOVSj3cGuqGw/Xqg2s8M8lFlUhyoyq1YDb7Ibq3zifioVy
 QQRRVlU8SSDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="155739128"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="155739128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 12:46:34 -0800
IronPort-SDR: 44pwxcdy6Gf9KbvyVC9W1b/QTGZ5ejY0VtOIMY+DgLzXrCFB1/b7092ibZ2kfn5SzSL7mT7oTz
 y4OXzGlo3btw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="347511524"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 29 Dec 2020 12:46:33 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kuLt2-0003mI-Id; Tue, 29 Dec 2020 20:46:32 +0000
Date:   Wed, 30 Dec 2020 04:45:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1173fb292bae23f5e1a2bb6a95f4eca9b6725b30
Message-ID: <5feb9585.vU3H9AE/fZKezPEn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 1173fb292bae23f5e1a2bb6a95f4eca9b6725b30  Merge branch 'x86/build'

elapsed time: 722m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
riscv                               defconfig
arm                       mainstone_defconfig
arm                            qcom_defconfig
mips                           ip27_defconfig
mips                           mtx1_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
nds32                             allnoconfig
sh                           se7619_defconfig
sh                        sh7785lcr_defconfig
arm                        trizeps4_defconfig
sh                           se7722_defconfig
sh                          polaris_defconfig
powerpc                        fsp2_defconfig
arm                           omap1_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                    or1ksim_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      mgcoge_defconfig
sh                           se7712_defconfig
arm                       cns3420vb_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
powerpc                      ep88xc_defconfig
arm                        mvebu_v5_defconfig
ia64                          tiger_defconfig
arm                        multi_v5_defconfig
arm                     davinci_all_defconfig
arm                           corgi_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
mips                            ar7_defconfig
powerpc                      ppc64e_defconfig
c6x                              allyesconfig
mips                        nlm_xlp_defconfig
arm                      jornada720_defconfig
arm                          pxa3xx_defconfig
arm                           spitz_defconfig
arm                            dove_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                     decstation_defconfig
arm                            xcep_defconfig
powerpc                  storcenter_defconfig
ia64                        generic_defconfig
x86_64                           alldefconfig
arm                        vexpress_defconfig
ia64                         bigsur_defconfig
powerpc                     kmeter1_defconfig
sh                          landisk_defconfig
arm                         assabet_defconfig
xtensa                  cadence_csp_defconfig
arc                        nsimosci_defconfig
arm                            zeus_defconfig
sh                          r7780mp_defconfig
powerpc                 mpc8560_ads_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
powerpc                    adder875_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          iop32x_defconfig
powerpc                     mpc83xx_defconfig
mips                        vocore2_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     redwood_defconfig
powerpc                     powernv_defconfig
mips                        maltaup_defconfig
powerpc                       eiger_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a001-20201229
x86_64               randconfig-a006-20201229
x86_64               randconfig-a002-20201229
x86_64               randconfig-a004-20201229
x86_64               randconfig-a003-20201229
x86_64               randconfig-a005-20201229
i386                 randconfig-a002-20201229
i386                 randconfig-a005-20201229
i386                 randconfig-a004-20201229
i386                 randconfig-a006-20201229
i386                 randconfig-a003-20201229
i386                 randconfig-a001-20201229
i386                 randconfig-a014-20201229
i386                 randconfig-a012-20201229
i386                 randconfig-a011-20201229
i386                 randconfig-a016-20201229
i386                 randconfig-a015-20201229
i386                 randconfig-a013-20201229
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
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
