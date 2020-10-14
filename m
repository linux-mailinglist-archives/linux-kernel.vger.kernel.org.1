Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE43228D815
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbgJNBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:42:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:36774 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbgJNBmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:42:50 -0400
IronPort-SDR: 3dvQo5ThdygqjpSKZYRQcz8Z73wRXFLCfRub6lBgAg9+mhEvqZ8LX07KLMvc7HQ6uMu4u1YLIz
 FA+elZ3oa68w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145333304"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="145333304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 18:42:48 -0700
IronPort-SDR: H8VlWCoadkH8bRvpdkrrmsKwucwYfOh5LTQ6RM8sZX7h/PvXDBoxaKv2l5UReH3RNpUkn092uv
 uvIXN5yQmdiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="356464426"
Received: from lkp-server02.sh.intel.com (HELO c57e4c60a28b) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 18:42:46 -0700
Received: from kbuild by c57e4c60a28b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSVoT-00006g-Jl; Wed, 14 Oct 2020 01:42:45 +0000
Date:   Wed, 14 Oct 2020 09:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2c8a2700c3256eefe1e783a104b420af09424e54
Message-ID: <5f865769.kCMPLfRKR4ky1p03%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 2c8a2700c3256eefe1e783a104b420af09424e54  Merge branch 'objtool/core'

elapsed time: 724m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
sh                          kfr2r09_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
openrisc                 simple_smp_defconfig
m68k                          atari_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
m68k                          multi_defconfig
powerpc                      mgcoge_defconfig
arm                              zx_defconfig
powerpc                   currituck_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
arc                     haps_hs_smp_defconfig
sh                               alldefconfig
powerpc                          g5_defconfig
riscv                    nommu_virt_defconfig
m68k                            mac_defconfig
microblaze                          defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a005-20201013
i386                 randconfig-a006-20201013
i386                 randconfig-a001-20201013
i386                 randconfig-a003-20201013
i386                 randconfig-a004-20201013
i386                 randconfig-a002-20201013
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
