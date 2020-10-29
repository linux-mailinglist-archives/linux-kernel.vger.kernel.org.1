Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E750629F879
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJ2WjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:39:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:6107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2WjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:39:01 -0400
IronPort-SDR: W61yPYyCLJfIsXQtYNoeCe56TcKvFgXmlzMiqnJ4dZxlnEGB0PVBqVgNISozCOhT6jN7mdnv6M
 4py7+8t+6i2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="156299501"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="156299501"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 15:39:00 -0700
IronPort-SDR: hgtOhztNeU8NIVQKA3XlI3yeoueATPSwP/zb6rpkIEDmHt9m20DeDdhx9BIiQVMsawLtrNdqtQ
 qpcjRcCI7Geg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="351114756"
Received: from lkp-server01.sh.intel.com (HELO c01187be935a) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2020 15:38:59 -0700
Received: from kbuild by c01187be935a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYGZO-0000I4-KN; Thu, 29 Oct 2020 22:38:58 +0000
Date:   Fri, 30 Oct 2020 06:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS WITH WARNING
 45ff510517f3b1354a3d9c273ad5e5e8d08312cb
Message-ID: <5f9b445a.IZ+SUCq2pxuDd5gR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/entry
branch HEAD: 45ff510517f3b1354a3d9c273ad5e5e8d08312cb  entry: Fixup irqentry_enter() comment

Warning in current branch:

kernel/entry/common.c:116 handle_signal_work() warn: bitwise AND condition is false here

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20201029
|   `-- kernel-entry-common.c-handle_signal_work()-warn:bitwise-AND-condition-is-false-here
`-- x86_64-randconfig-m001-20201029
    `-- kernel-entry-common.c-handle_signal_work()-warn:bitwise-AND-condition-is-false-here

elapsed time: 724m

configs tested: 117
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                         alldefconfig
powerpc                     powernv_defconfig
arm                             rpc_defconfig
m68k                       bvme6000_defconfig
csky                                defconfig
arm                          pxa910_defconfig
mips                           ip28_defconfig
arm                         bcm2835_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     pseries_defconfig
sparc64                          alldefconfig
arc                          axs103_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 linkstation_defconfig
mips                     cu1000-neo_defconfig
arc                           tb10x_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa168_defconfig
nios2                         3c120_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
ia64                      gensparse_defconfig
sh                           se7780_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
m68k                       m5475evb_defconfig
c6x                        evmc6678_defconfig
s390                             allyesconfig
sh                            shmin_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
arm                      integrator_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         ebsa110_defconfig
ia64                        generic_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
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
