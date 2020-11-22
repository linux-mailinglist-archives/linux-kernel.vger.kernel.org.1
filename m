Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7C2BFC8A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKVWld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:41:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:3505 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgKVWlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:41:31 -0500
IronPort-SDR: ArDJ+cCUnRkvdDJ1iiV5BLEDAaK0MeGrDrO5hiR51qVAU+Po60REV4kfIokIwfuutO5g2nzukz
 U/MkZA9iYbIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="169105857"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="169105857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 14:41:30 -0800
IronPort-SDR: ESw51V0hCnH2onAVFZOscV74teVLMMDcGbEmnudZlivEyGFdABXqeC3p/QpIbo7aqMVWOSHSKV
 nK70x7CDnH3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="546192981"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2020 14:41:29 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgy2y-0000IJ-Rj; Sun, 22 Nov 2020 22:41:28 +0000
Date:   Mon, 23 Nov 2020 06:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9ea041b5e564b909207110a9edc04b287507756c
Message-ID: <5fbae8dd.GuRYvPcdUo1eeljQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 9ea041b5e564b909207110a9edc04b287507756c  Merge branch 'ras/core'

elapsed time: 723m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                malta_kvm_guest_defconfig
powerpc                 mpc8272_ads_defconfig
c6x                        evmc6678_defconfig
arm                           spitz_defconfig
arm                          lpd270_defconfig
arm                         cm_x300_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                   bluestone_defconfig
m68k                          amiga_defconfig
arm                        keystone_defconfig
powerpc                 mpc8540_ads_defconfig
c6x                                 defconfig
arm                         palmz72_defconfig
arm                         vf610m4_defconfig
alpha                               defconfig
mips                         tb0287_defconfig
powerpc                     pseries_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a004-20201122
i386                 randconfig-a003-20201122
i386                 randconfig-a002-20201122
i386                 randconfig-a005-20201122
i386                 randconfig-a001-20201122
i386                 randconfig-a006-20201122
i386                 randconfig-a012-20201122
i386                 randconfig-a013-20201122
i386                 randconfig-a011-20201122
i386                 randconfig-a016-20201122
i386                 randconfig-a014-20201122
i386                 randconfig-a015-20201122
x86_64               randconfig-a006-20201122
x86_64               randconfig-a003-20201122
x86_64               randconfig-a004-20201122
x86_64               randconfig-a005-20201122
x86_64               randconfig-a001-20201122
x86_64               randconfig-a002-20201122
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
x86_64               randconfig-a015-20201122
x86_64               randconfig-a011-20201122
x86_64               randconfig-a014-20201122
x86_64               randconfig-a016-20201122
x86_64               randconfig-a012-20201122
x86_64               randconfig-a013-20201122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
