Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FF2BC298
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 00:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKUXHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 18:07:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:17659 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgKUXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 18:07:45 -0500
IronPort-SDR: 0lhRhyXCuaNndn6vmTYZ+7rmGAfnkNXudo9IfE8Hy3IGpd8D0EtExaf8jrLfV0dCU+9/o0aMSY
 QU4Nr6pAGWOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="235761185"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="235761185"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 15:07:44 -0800
IronPort-SDR: 3wdcbp8RwqW9XNOdyk5V7C0hVdkOb5umIduN9DN3Gt5ipTByU4YV1AhrJGxQvXak0LTdjkQ/Rg
 O4vrjyyu9/tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="312453919"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2020 15:07:43 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgbyo-0000SV-RF; Sat, 21 Nov 2020 23:07:42 +0000
Date:   Sun, 22 Nov 2020 07:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 4a24d80b8c3e9f89d6a6a7b89bd057c463b638d3
Message-ID: <5fb99d9a.SpVzqkoCbC0EU2Fs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 4a24d80b8c3e9f89d6a6a7b89bd057c463b638d3  x86/mce, cper: Pass x86 CPER through the MCA handling chain

elapsed time: 720m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           efm32_defconfig
sh                          rsk7203_defconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
powerpc                    gamecube_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                          rv32_defconfig
arm                         hackkit_defconfig
mips                      fuloong2e_defconfig
arm                          simpad_defconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
alpha                               defconfig
mips                           ip32_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
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
i386                 randconfig-a004-20201121
i386                 randconfig-a003-20201121
i386                 randconfig-a002-20201121
i386                 randconfig-a005-20201121
i386                 randconfig-a001-20201121
i386                 randconfig-a006-20201121
x86_64               randconfig-a015-20201121
x86_64               randconfig-a011-20201121
x86_64               randconfig-a014-20201121
x86_64               randconfig-a016-20201121
x86_64               randconfig-a012-20201121
x86_64               randconfig-a013-20201121
i386                 randconfig-a012-20201121
i386                 randconfig-a013-20201121
i386                 randconfig-a011-20201121
i386                 randconfig-a016-20201121
i386                 randconfig-a014-20201121
i386                 randconfig-a015-20201121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201121
x86_64               randconfig-a003-20201121
x86_64               randconfig-a004-20201121
x86_64               randconfig-a005-20201121
x86_64               randconfig-a002-20201121
x86_64               randconfig-a001-20201121

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
