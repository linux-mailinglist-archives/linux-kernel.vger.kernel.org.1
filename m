Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB79C2C7796
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 06:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgK2FLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 00:11:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:61701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgK2FLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 00:11:54 -0500
IronPort-SDR: kPZ4C/Uwf59cLHAVqp3LBu6+JLTFoEp1RVzQtLOElkpjm0EXBn3lAxMn0T/FsttnQmx9W5okfQ
 5YXdpxd13X3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="172615969"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="172615969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 21:11:13 -0800
IronPort-SDR: lZ1gs3dXuWqYGLMz3JWByPR7nNPzWrJwC2dl6cZt6sXTIyPEofrGl59I19JnNwGT6Y0t45wXZQ
 e/emOsAECGuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="344638787"
Received: from lkp-server01.sh.intel.com (HELO b5888d13d5a5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2020 21:11:12 -0800
Received: from kbuild by b5888d13d5a5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kjEzP-0000d7-SO; Sun, 29 Nov 2020 05:11:11 +0000
Date:   Sun, 29 Nov 2020 13:10:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 5ca88db79d8d7d8fa645caa17173592ca22003b2
Message-ID: <5fc32d51.odWTK7omnrilTIyx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 5ca88db79d8d7d8fa645caa17173592ca22003b2  torture: Add --kcsan-kmake-arg to torture.sh for KCSAN

elapsed time: 722m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
powerpc                   motionpro_defconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
arm                          prima2_defconfig
sh                          landisk_defconfig
nios2                         10m50_defconfig
ia64                        generic_defconfig
m68k                       m5275evb_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
arm                       omap2plus_defconfig
sh                          r7785rp_defconfig
mips                       capcella_defconfig
mips                        nlm_xlp_defconfig
powerpc                     pq2fads_defconfig
arm                        shmobile_defconfig
arm                          exynos_defconfig
powerpc                        cell_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201129
i386                 randconfig-a003-20201129
i386                 randconfig-a002-20201129
i386                 randconfig-a005-20201129
i386                 randconfig-a001-20201129
i386                 randconfig-a006-20201129
x86_64               randconfig-a015-20201129
x86_64               randconfig-a011-20201129
x86_64               randconfig-a016-20201129
x86_64               randconfig-a014-20201129
x86_64               randconfig-a012-20201129
x86_64               randconfig-a013-20201129
i386                 randconfig-a012-20201129
i386                 randconfig-a013-20201129
i386                 randconfig-a011-20201129
i386                 randconfig-a016-20201129
i386                 randconfig-a014-20201129
i386                 randconfig-a015-20201129
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
x86_64               randconfig-a003-20201129
x86_64               randconfig-a006-20201129
x86_64               randconfig-a004-20201129
x86_64               randconfig-a005-20201129
x86_64               randconfig-a002-20201129
x86_64               randconfig-a001-20201129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
