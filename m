Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94CF281002
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgJBJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:42:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:18231 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJBJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:42:18 -0400
IronPort-SDR: hNVOUPnY1O+GkGv6Sl6JWp87VNmPVZ+bWL7KMvx9z1nRYQ2L1cq7gCKCxJtGqXY8JAZiN/vr0O
 AroItOuraM+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162191410"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="162191410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 02:42:13 -0700
IronPort-SDR: 8CzjP854QtaMnAx0h+nUTj2wd4tJGMjseChHy62wH8EC6l0/oWYIidJl7ur9FAgvGZyah9rOp5
 0F/seoqvbymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="515852512"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2020 02:42:12 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOHZr-0000vu-Ih; Fri, 02 Oct 2020 09:42:11 +0000
Date:   Fri, 02 Oct 2020 17:41:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/block/scsi_ioctl] BUILD SUCCESS
 dda6248343d5c5502dfb754555c8d1892a469e5c
Message-ID: <5f76f5d0.qJ4t/HWuRzSW7bTa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/block/scsi_ioctl
branch HEAD: dda6248343d5c5502dfb754555c8d1892a469e5c  block: scsi_ioctl: Avoid the use of one-element arrays

elapsed time: 725m

configs tested: 124
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
arm                              alldefconfig
riscv                             allnoconfig
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
arm                           h3600_defconfig
sparc64                          alldefconfig
arm                        cerfcube_defconfig
powerpc                      ppc40x_defconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
mips                          ath25_defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
h8300                     edosk2674_defconfig
sh                                  defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                  audio_kc705_defconfig
microblaze                      mmu_defconfig
powerpc                          allmodconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
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
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
