Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A221D28D817
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgJNBm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:42:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:27106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJNBmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:42:49 -0400
IronPort-SDR: +n7gGZVsrJbTqtMxFdg59jcZ4Phk7PvKEtYW+l5hYMWjB0gEVcB6oCamcrgjkuMZuvaDSpf32w
 kSm3HK5VmyBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="152952738"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="152952738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 18:42:47 -0700
IronPort-SDR: DBnap5Mg8AT8hk1FqbHGd2erZYzds6PlI3ZXOR0UsDInzVfDHPErD8Ktnc6FKPRWJ+qzBgNga6
 3d+JQpB9dEug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="357228049"
Received: from lkp-server02.sh.intel.com (HELO c57e4c60a28b) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Oct 2020 18:42:46 -0700
Received: from kbuild by c57e4c60a28b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSVoT-00006j-L7; Wed, 14 Oct 2020 01:42:45 +0000
Date:   Wed, 14 Oct 2020 09:41:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 da912c29a4a552588cbfa895487d9d5523b6faa7
Message-ID: <5f865764.7bSAy4VaObwLO1Ug%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/urgent
branch HEAD: da912c29a4a552588cbfa895487d9d5523b6faa7  sched/features: Fix !CONFIG_JUMP_LABEL case

elapsed time: 724m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
ia64                             alldefconfig
powerpc                  mpc866_ads_defconfig
sh                            titan_defconfig
arm                            hisi_defconfig
powerpc                     ppa8548_defconfig
m68k                          atari_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
m68k                          multi_defconfig
arm                     davinci_all_defconfig
arm                          pxa3xx_defconfig
arm                            dove_defconfig
sh                             shx3_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                           h5000_defconfig
powerpc                     tqm8540_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
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
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
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
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
