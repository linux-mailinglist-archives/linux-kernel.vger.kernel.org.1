Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58297280FB2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbgJBJSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:18:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:2235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbgJBJSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:18:08 -0400
IronPort-SDR: wYOlRKnWyZ1uO/2RN8nnUf/MoTLZXV9Fz0s1SohASrfudeivxfl9m/VHSb36ZvIXVSXigNYr8V
 A6XCnG8ckAeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="247692752"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="247692752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 02:18:08 -0700
IronPort-SDR: fs8njxlx2pD3M9TWE3ldp9y8WApYhOgTZKCFizbk8hoAzWikKX+okPZS3haPIKX6LS3neobbbc
 DWDArrg2pM/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="515109562"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2020 02:18:07 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOHCY-0000vN-PJ; Fri, 02 Oct 2020 09:18:06 +0000
Date:   Fri, 02 Oct 2020 17:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount] BUILD SUCCESS
 dd976fbf8c705ca5cfcb00438f4a4f818e98fb43
Message-ID: <5f76f02b.uAPqLerhh4XiIrqw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount
branch HEAD: dd976fbf8c705ca5cfcb00438f4a4f818e98fb43  EXP Revert "KVM: Check the allocation of pv cpu mask"

elapsed time: 723m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
mips                malta_kvm_guest_defconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
xtensa                    smp_lx200_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                          simpad_defconfig
xtensa                generic_kc705_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
powerpc                     mpc512x_defconfig
riscv                               defconfig
arm                           h3600_defconfig
sparc64                          alldefconfig
arm                        cerfcube_defconfig
powerpc                      ppc40x_defconfig
sh                           se7722_defconfig
c6x                        evmc6457_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     taishan_defconfig
powerpc                         ps3_defconfig
powerpc                       ebony_defconfig
arm                         palmz72_defconfig
powerpc                      acadia_defconfig
h8300                            alldefconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
mips                          ath25_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
powerpc                      pcm030_defconfig
powerpc                       eiger_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                  audio_kc705_defconfig
microblaze                      mmu_defconfig
powerpc                          allmodconfig
c6x                        evmc6678_defconfig
nios2                               defconfig
riscv                            alldefconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
arc                                 defconfig
mips                     cu1000-neo_defconfig
arm                        magician_defconfig
powerpc                   currituck_defconfig
powerpc64                        alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
