Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8E280C84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 05:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbgJBDfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 23:35:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:39591 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387502AbgJBDfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 23:35:17 -0400
IronPort-SDR: bQ72P516C8BPiC0ZQ4r+v04DjzvwqoJSsQh/GNMBOHnWyBjcN5KJxO0kGVODGAn4+hK7jPlSS6
 V9zFM+lmugZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150702134"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="150702134"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 20:35:17 -0700
IronPort-SDR: +/pVT8HrZXNAkDWl6ovhsGgtAT4QRfGBpDfI2SvcZDCwYgxF7WvYqbcBu2FVNUta5xBbyp2kr9
 Ze0IINKf0Veg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="308883798"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2020 20:35:16 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOBql-0000q3-BH; Fri, 02 Oct 2020 03:35:15 +0000
Date:   Fri, 02 Oct 2020 11:34:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e
Message-ID: <5f769fdb.tHRntpDwOqxKwQKL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/misc
branch HEAD: f94c91f7ba3ba7de2bc8aa31be28e1abb22f849e  x86/nmi: Fix nmi_handle() duration miscalculation

elapsed time: 724m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
m68k                          hp300_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
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
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                             allyesconfig
microblaze                          defconfig
sh                           se7722_defconfig
c6x                        evmc6457_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     taishan_defconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
arm                           spitz_defconfig
h8300                               defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
m68k                         apollo_defconfig
sh                         apsh4a3a_defconfig
powerpc                  storcenter_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
arm                          imote2_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
microblaze                      mmu_defconfig
powerpc                          allmodconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
powerpc                    mvme5100_defconfig
s390                             alldefconfig
arm                          pxa910_defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a012-20201001
x86_64               randconfig-a015-20201001
x86_64               randconfig-a014-20201001
x86_64               randconfig-a013-20201001
x86_64               randconfig-a011-20201001
x86_64               randconfig-a016-20201001
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a004-20201001
x86_64               randconfig-a001-20201001
x86_64               randconfig-a002-20201001
x86_64               randconfig-a003-20201001
x86_64               randconfig-a005-20201001
x86_64               randconfig-a006-20201001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
