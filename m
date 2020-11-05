Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65A2A7B52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgKEKKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:10:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:49424 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEKKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:10:19 -0500
IronPort-SDR: r8LPEIA4Pq8Asme+vJX4Ohniv4cUnAOFi13f4nIVC5qbbhSVBn0AcIeYnf9S/XbnfcCN3bQF8E
 PkU0YE3FJbfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="165849571"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="165849571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 02:10:18 -0800
IronPort-SDR: UwFGO+gdZLk6fxTXYqBAgua4dF8AXsXi+T+4pFu1+fvF36qwqtw9kRYF+PrEBytP//qzyda100
 GR6/eTyshljQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="354224534"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 02:10:14 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kacDd-0001JR-ID; Thu, 05 Nov 2020 10:10:13 +0000
Date:   Thu, 05 Nov 2020 18:10:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS WITH WARNING
 b6be002bcd1dd1dedb926abf3c90c794eacb77dc
Message-ID: <5fa3cf7f.0eZy6+L6znxMFXGG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/entry
branch HEAD: b6be002bcd1dd1dedb926abf3c90c794eacb77dc  x86/entry: Move nmi entry/exit into common code

Warning in current branch:

kernel/entry/common.c:142 handle_signal_work() warn: bitwise AND condition is false here

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20201104
    `-- kernel-entry-common.c-handle_signal_work()-warn:bitwise-AND-condition-is-false-here

elapsed time: 724m

configs tested: 164
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                        vexpress_defconfig
mips                          ath25_defconfig
arm                            u300_defconfig
sh                         microdev_defconfig
c6x                              alldefconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7269_defconfig
sh                   secureedge5410_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
m68k                       m5208evb_defconfig
mips                             allmodconfig
parisc                           alldefconfig
powerpc               mpc834x_itxgp_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
alpha                            allyesconfig
mips                         tb0226_defconfig
xtensa                              defconfig
powerpc                    sam440ep_defconfig
mips                         db1xxx_defconfig
arm                            pleb_defconfig
arm                        mvebu_v7_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                                defconfig
mips                       capcella_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                    ge_imp3a_defconfig
mips                     loongson1c_defconfig
arm                        multi_v5_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
i386                             allyesconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
powerpc                     taishan_defconfig
arm                          ep93xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                      katmai_defconfig
m68k                       bvme6000_defconfig
sh                     sh7710voipgw_defconfig
arm                         orion5x_defconfig
arm                     davinci_all_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
mips                       lemote2f_defconfig
riscv                            allmodconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  iss476-smp_defconfig
arm                          moxart_defconfig
m68k                             allmodconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
arm                         mv78xx0_defconfig
sh                            shmin_defconfig
m68k                          multi_defconfig
arm                          gemini_defconfig
powerpc                     asp8347_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8548_defconfig
powerpc                     ksi8560_defconfig
arc                     nsimosci_hs_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
x86_64               randconfig-a004-20201105
x86_64               randconfig-a003-20201105
x86_64               randconfig-a005-20201105
x86_64               randconfig-a002-20201105
x86_64               randconfig-a006-20201105
x86_64               randconfig-a001-20201105
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
