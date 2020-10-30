Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91BB29F995
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgJ3AU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:20:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:40829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ3AU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:20:27 -0400
IronPort-SDR: /U5KvOOXVA3/1T9DZx/6Uxc8A2ep2OXwxanwPrDdJp6vLwZdAMSnOM9T28/LOa8Z+jS6OXwR0m
 cuk7NPhL72bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165950849"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="165950849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 17:20:27 -0700
IronPort-SDR: Biv11nAzXJCuU/95ujjqg86b81zComIr55z0q98iLMDRCjOiwyPNOUwgqzYi3JLGB909VC7tYd
 Lz7PxHTWePQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="526930637"
Received: from lkp-server01.sh.intel.com (HELO c01187be935a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2020 17:20:26 -0700
Received: from kbuild by c01187be935a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYI9Z-0000JN-Iy; Fri, 30 Oct 2020 00:20:25 +0000
Date:   Fri, 30 Oct 2020 08:20:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS WITH WARNING
 2e008ffe426f927b1697adb4ed10c1e419927ae4
Message-ID: <5f9b5c32.yUku70RbqO7CrK4w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/apic
branch HEAD: 2e008ffe426f927b1697adb4ed10c1e419927ae4  x86/kvm: Enable 15-bit extension when KVM_FEATURE_MSI_EXT_DEST_ID detected

Warning in current branch:

arch/x86/kernel/apic/io_apic.c:1243:61: sparse: sparse: invalid access past the end of 'entry' (4 8)

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s002-20201029
    `-- arch-x86-kernel-apic-io_apic.c:sparse:sparse:invalid-access-past-the-end-of-entry-(-)

elapsed time: 1167m

configs tested: 146
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
mips                       capcella_defconfig
m68k                        m5272c3_defconfig
sh                     sh7710voipgw_defconfig
m68k                          amiga_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
xtensa                           alldefconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
parisc                           alldefconfig
arm                           u8500_defconfig
arm                          pxa3xx_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
mips                           ip32_defconfig
sh                           sh2007_defconfig
sh                           se7780_defconfig
powerpc                    sam440ep_defconfig
arc                        vdk_hs38_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         at91_dt_defconfig
sh                         apsh4a3a_defconfig
mips                        nlm_xlr_defconfig
arm                             pxa_defconfig
powerpc                   lite5200b_defconfig
arm                        realview_defconfig
arm                             ezx_defconfig
arm                          collie_defconfig
arm                           efm32_defconfig
sh                           se7206_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
powerpc                 mpc8313_rdb_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
mips                        bcm47xx_defconfig
m68k                           sun3_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
nios2                         3c120_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
m68k                       bvme6000_defconfig
sh                              ul2_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
arm                          prima2_defconfig
c6x                              alldefconfig
mips                malta_kvm_guest_defconfig
arm                              zx_defconfig
ia64                          tiger_defconfig
mips                       rbtx49xx_defconfig
c6x                        evmc6457_defconfig
mips                malta_qemu_32r6_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
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
x86_64               randconfig-a001-20201029
x86_64               randconfig-a002-20201029
x86_64               randconfig-a003-20201029
x86_64               randconfig-a006-20201029
x86_64               randconfig-a005-20201029
x86_64               randconfig-a004-20201029
i386                 randconfig-a002-20201029
i386                 randconfig-a005-20201029
i386                 randconfig-a003-20201029
i386                 randconfig-a001-20201029
i386                 randconfig-a004-20201029
i386                 randconfig-a006-20201029
i386                 randconfig-a016-20201029
i386                 randconfig-a014-20201029
i386                 randconfig-a015-20201029
i386                 randconfig-a013-20201029
i386                 randconfig-a012-20201029
i386                 randconfig-a011-20201029
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
x86_64               randconfig-a011-20201029
x86_64               randconfig-a013-20201029
x86_64               randconfig-a016-20201029
x86_64               randconfig-a015-20201029
x86_64               randconfig-a012-20201029
x86_64               randconfig-a014-20201029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
