Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D442AE87F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 06:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKKFyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 00:54:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:4731 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKFyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 00:54:37 -0500
IronPort-SDR: oAoyxaDKb5lLoA9vij80RSX4of3hCEf/crfwRzhlWgYslq96D7exelPgPBouoHtgHpJFvxHQps
 PNqjHFeRNSKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170208106"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170208106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:54:35 -0800
IronPort-SDR: gJm5aeSWw8sn7jKDK6b59XaJyXKxBjJGN1/EwogcIPe+l1heICjsxVwboEs2bLmpXRUIAzrDRB
 bB9oWiWIoezw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="323159367"
Received: from lkp-server02.sh.intel.com (HELO 898ef09051d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2020 21:54:34 -0800
Received: from kbuild by 898ef09051d7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcj5V-00000V-EN; Wed, 11 Nov 2020 05:54:33 +0000
Date:   Wed, 11 Nov 2020 13:54:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 aec8da04e4d71afdd4ab3025ea34a6517435f363
Message-ID: <5fab7c84.Z4sXCon33yRsgylu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/apic
branch HEAD: aec8da04e4d71afdd4ab3025ea34a6517435f363  x86/ioapic: Correct the PCI/ISA trigger type selection

elapsed time: 726m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            pleb_defconfig
h8300                    h8300h-sim_defconfig
sh                             shx3_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                      pxa255-idp_defconfig
arm                           efm32_defconfig
arm                          iop32x_defconfig
arm                        cerfcube_defconfig
h8300                               defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
c6x                                 defconfig
xtensa                           alldefconfig
sh                         apsh4a3a_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
sh                            migor_defconfig
mips                        maltaup_defconfig
arm                        magician_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
parisc                              defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
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
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
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
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
