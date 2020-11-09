Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E362AC219
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgKIRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:23:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:37194 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731122AbgKIRXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:23:44 -0500
IronPort-SDR: dwTvp4Phcb3FWI/JUx/9pGkiZ+XtO43ZD/HJTOoGSq/vGLl0oOfI8g4OAC4eVuvKf/2ZjyOxoI
 cxa2RGfBXIXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="234004975"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="234004975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 09:23:43 -0800
IronPort-SDR: FoHAi7r8BRhvoMOL6dskCoYLgJV3mQ3qODpMIBxPzPTsUwkBmO917QJPpuPDbU7yiyspnlxp8Z
 okxn89rgxSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="355767420"
Received: from lkp-server01.sh.intel.com (HELO d0be80f1a028) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2020 09:23:41 -0800
Received: from kbuild by d0be80f1a028 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcAtI-0000Jl-RL; Mon, 09 Nov 2020 17:23:40 +0000
Date:   Tue, 10 Nov 2020 01:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm] BUILD SUCCESS b6ff30849ca723b78306514246b98ca5645d92f5
Message-ID: <5fa97ae3.nPG3uZhfy6fDWgYg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  lkmm
branch HEAD: b6ff30849ca723b78306514246b98ca5645d92f5  tools/memory-model: Label MP tests' producers and consumers

elapsed time: 836m

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
powerpc                    sam440ep_defconfig
powerpc                     pseries_defconfig
m68k                         amcore_defconfig
arm                         s5pv210_defconfig
xtensa                  audio_kc705_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
sh                           se7343_defconfig
mips                      pistachio_defconfig
mips                        bcm63xx_defconfig
arc                                 defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
arm                          collie_defconfig
sh                        sh7757lcr_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
m68k                        m5272c3_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
arm                          imote2_defconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                           corgi_defconfig
arm                          gemini_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a014-20201109
i386                 randconfig-a015-20201109
i386                 randconfig-a013-20201109
i386                 randconfig-a016-20201109
i386                 randconfig-a011-20201109
i386                 randconfig-a012-20201109
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
x86_64               randconfig-a012-20201109
x86_64               randconfig-a015-20201109
x86_64               randconfig-a013-20201109
x86_64               randconfig-a011-20201109
x86_64               randconfig-a014-20201109
x86_64               randconfig-a016-20201109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
