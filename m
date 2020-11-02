Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55152A250C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgKBHQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:16:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:3816 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgKBHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:16:50 -0500
IronPort-SDR: xBfnod85Xhxp9ZPLWHffq7HvEeC9m7L4gI8TGZUbAN8YALNq8KvjvN+qD3dKurYqKg3Fdv6h3m
 2B8oYWHK+8fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="165341545"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="165341545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 23:16:48 -0800
IronPort-SDR: cxHxkZokrOtwLz2IcRzU2Yc09qpAJieMtTVqekAYPB//RwqWrgNHEHgzODtMRHCYogSAzdGk0k
 PsHtxiRfiI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="363147445"
Received: from lkp-server02.sh.intel.com (HELO 5575c2e0dde6) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2020 23:16:47 -0800
Received: from kbuild by 5575c2e0dde6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZU58-0000Ax-M0; Mon, 02 Nov 2020 07:16:46 +0000
Date:   Mon, 02 Nov 2020 15:16:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 17bb415fefedb74d2ff02656cf59e4e3ab92ee20
Message-ID: <5f9fb232.Q16ERIIz/g26wZqx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: 17bb415fefedb74d2ff02656cf59e4e3ab92ee20  Merge tag 'irqchip-fixes-5.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 722m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc837x_mds_defconfig
sh                        sh7785lcr_defconfig
nios2                            allyesconfig
riscv                    nommu_k210_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                             defconfig
powerpc                        cell_defconfig
nds32                               defconfig
parisc                generic-64bit_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
mips                      maltaaprp_defconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      malta_kvm_defconfig
sh                             espt_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      ppc44x_defconfig
mips                           ip28_defconfig
sh                          polaris_defconfig
powerpc64                           defconfig
openrisc                            defconfig
sh                            titan_defconfig
arm                        cerfcube_defconfig
i386                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          iop32x_defconfig
powerpc                      ppc40x_defconfig
h8300                     edosk2674_defconfig
m68k                       bvme6000_defconfig
sh                           sh2007_defconfig
ia64                             alldefconfig
mips                         cobalt_defconfig
microblaze                    nommu_defconfig
arm                          gemini_defconfig
sh                          sdk7780_defconfig
sparc                       sparc32_defconfig
powerpc                           allnoconfig
arm                             rpc_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                        icon_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20201101
x86_64               randconfig-a003-20201101
x86_64               randconfig-a005-20201101
x86_64               randconfig-a002-20201101
x86_64               randconfig-a006-20201101
x86_64               randconfig-a001-20201101
i386                 randconfig-a004-20201101
i386                 randconfig-a006-20201101
i386                 randconfig-a005-20201101
i386                 randconfig-a001-20201101
i386                 randconfig-a002-20201101
i386                 randconfig-a003-20201101
i386                 randconfig-a015-20201101
i386                 randconfig-a013-20201101
i386                 randconfig-a014-20201101
i386                 randconfig-a016-20201101
i386                 randconfig-a011-20201101
i386                 randconfig-a012-20201101
i386                 randconfig-a013-20201102
i386                 randconfig-a015-20201102
i386                 randconfig-a014-20201102
i386                 randconfig-a016-20201102
i386                 randconfig-a011-20201102
i386                 randconfig-a012-20201102
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
x86_64               randconfig-a012-20201101
x86_64               randconfig-a015-20201101
x86_64               randconfig-a013-20201101
x86_64               randconfig-a011-20201101
x86_64               randconfig-a014-20201101
x86_64               randconfig-a016-20201101
x86_64               randconfig-a004-20201102
x86_64               randconfig-a005-20201102
x86_64               randconfig-a003-20201102
x86_64               randconfig-a002-20201102
x86_64               randconfig-a006-20201102
x86_64               randconfig-a001-20201102

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
