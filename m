Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0C2C4F50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgKZHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:23:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:42790 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgKZHXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:23:02 -0500
IronPort-SDR: nG7t3hMbfk1SLOaU6YI4YJqwHd/XgiQQWRzQz90zXu9RShgOpnnw6Qq/aFQtb6w2sk7Bth8R1G
 8Tq1t/z2MbtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="172403906"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="172403906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 23:23:01 -0800
IronPort-SDR: 5FOTELpGo6jJiSrJTrPgItKILckslt4zCLySCSSRPivV0OQyqeCuvQgojzWnMbL/VyVrDh8hGL
 SKc1TNSh+Uxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="371053254"
Received: from lkp-server01.sh.intel.com (HELO dd79da36dde1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2020 23:23:00 -0800
Received: from kbuild by dd79da36dde1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiBcJ-00007P-N0; Thu, 26 Nov 2020 07:22:59 +0000
Date:   Thu, 26 Nov 2020 15:22:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 33fc379df76b4991e5ae312f07bcd6820811971e
Message-ID: <5fbf579d.+Ij9+SSFaH0crMWw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 33fc379df76b4991e5ae312f07bcd6820811971e  x86/speculation: Fix prctl() when spectre_v2_user={seccomp,prctl},ibpb

elapsed time: 722m

configs tested: 91
configs skipped: 53

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
arm                            lart_defconfig
arm                        realview_defconfig
mips                         rt305x_defconfig
mips                        workpad_defconfig
arm                          ixp4xx_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
powerpc                     tqm8540_defconfig
microblaze                          defconfig
sh                         ecovec24_defconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc64e_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
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
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
