Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0BC2E7D24
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 00:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgL3XUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 18:20:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:63149 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgL3XUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 18:20:36 -0500
IronPort-SDR: vVeFzrhHLGMQ1JeC4MmXSXijckH0vGl+UJ1sdOYFk0kIp6spXhNQk7ptWI66ysMl8FT7umVPlz
 wn1j6WUFCB6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="155848492"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="155848492"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 15:19:55 -0800
IronPort-SDR: lUu9pvlD4WdbP7XJ3L5Ne0YrI4tA0EblaZWOmGjbPTUsUVkksFR0mK84DQh4RTMmrlASiCk2Fs
 YE7/acsBmXwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="419683797"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2020 15:19:54 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kukkz-0004ZQ-MJ; Wed, 30 Dec 2020 23:19:53 +0000
Date:   Thu, 31 Dec 2020 07:18:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ae0e95a3f49d2fe64920d6af3a85f409bb44e47b
Message-ID: <5fed0ae1.wO0eh9vRf82M15r+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: ae0e95a3f49d2fe64920d6af3a85f409bb44e47b  Merge branch 'x86/cleanups'

elapsed time: 725m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
nios2                            alldefconfig
parisc                generic-32bit_defconfig
powerpc                         wii_defconfig
mips                       rbtx49xx_defconfig
arm                        spear3xx_defconfig
arm                       imx_v4_v5_defconfig
arm                       omap2plus_defconfig
powerpc                      walnut_defconfig
c6x                              alldefconfig
arm                  colibri_pxa300_defconfig
mips                      fuloong2e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
sh                           se7722_defconfig
x86_64                           alldefconfig
powerpc                     ksi8560_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
parisc                           allyesconfig
powerpc                  iss476-smp_defconfig
arm                          moxart_defconfig
m68k                          atari_defconfig
arm                              zx_defconfig
sh                              ul2_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
powerpc                    mvme5100_defconfig
mips                          malta_defconfig
arm                            u300_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
powerpc                      ppc44x_defconfig
powerpc                     akebono_defconfig
h8300                       h8s-sim_defconfig
mips                     cu1830-neo_defconfig
m68k                          amiga_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      ppc40x_defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a005-20201230
i386                 randconfig-a006-20201230
i386                 randconfig-a004-20201230
i386                 randconfig-a003-20201230
i386                 randconfig-a002-20201230
i386                 randconfig-a001-20201230
x86_64               randconfig-a005-20201230
x86_64               randconfig-a001-20201230
x86_64               randconfig-a006-20201230
x86_64               randconfig-a002-20201230
x86_64               randconfig-a004-20201230
x86_64               randconfig-a003-20201230
i386                 randconfig-a016-20201230
i386                 randconfig-a014-20201230
i386                 randconfig-a012-20201230
i386                 randconfig-a015-20201230
i386                 randconfig-a011-20201230
i386                 randconfig-a013-20201230
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
