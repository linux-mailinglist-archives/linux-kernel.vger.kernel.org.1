Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138442E255B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgLXIA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:00:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:39745 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgLXIA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:00:27 -0500
IronPort-SDR: AH1ZPfEHKAWAsPGDfIn20lGzRwTwEOCHkE1iQgrkqxdH8n6IYFM9vRY//cJnoPYYRSynxcpuGh
 SfwWeJ0qzmrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="176271860"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="176271860"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 23:59:41 -0800
IronPort-SDR: 3BdlrMucCn6F2y98AiTWvT6GlaJZKCRO4OFMWCC9oZFWMx4AQ9sDnU6lVG1ioJmdgG7xtRlEhi
 Fm1cS8Mi1JFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="339526085"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2020 23:59:39 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ksLX9-0000q3-7F; Thu, 24 Dec 2020 07:59:39 +0000
Date:   Thu, 24 Dec 2020 15:58:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.21a] BUILD SUCCESS
 ceb57fe529baff777d89a46bff3580926b3186ef
Message-ID: <5fe44a30.E9gJ//LYqIFIDkD5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.21a
branch HEAD: ceb57fe529baff777d89a46bff3580926b3186ef  torture: Break affinity of kthreads last running on outgoing CPU

elapsed time: 724m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
nds32                             allnoconfig
parisc                              defconfig
c6x                                 defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
sh                               alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                        neponset_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                         mv78xx0_defconfig
riscv                               defconfig
arm                        trizeps4_defconfig
arm                          prima2_defconfig
sparc                            alldefconfig
mips                       bmips_be_defconfig
powerpc                mpc7448_hpc2_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
sh                             sh03_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
m68k                            mac_defconfig
sh                                  defconfig
m68k                       bvme6000_defconfig
openrisc                    or1ksim_defconfig
mips                malta_kvm_guest_defconfig
s390                          debug_defconfig
mips                           mtx1_defconfig
sparc64                          alldefconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
xtensa                       common_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
mips                        nlm_xlp_defconfig
mips                         db1xxx_defconfig
sh                              ul2_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                             allmodconfig
arm                              zx_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                       omap2plus_defconfig
ia64                        generic_defconfig
sparc                       sparc32_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
arm                             pxa_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
alpha                               defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
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
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
