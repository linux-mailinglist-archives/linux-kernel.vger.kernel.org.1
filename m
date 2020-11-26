Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983422C4EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbgKZGb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:31:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:14504 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388013AbgKZGb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:31:56 -0500
IronPort-SDR: TWy6+K17kdmClJqEuvWSsj74zZcdkPhQzHO8A7yZb+DWvOJCqdCNhsyO0zDtk3ne7WC/cuj8th
 1x0jxT9JZUMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="256952957"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="256952957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 22:31:55 -0800
IronPort-SDR: wDi28NAoucIVvvsLGvF4OUIIBbzyj9gvvhH+ycN3oBONf68V+tJqVS1qC5rv0UqsUce+mt3sIj
 sqfV7OYNU6Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="333275880"
Received: from lkp-server01.sh.intel.com (HELO dd79da36dde1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2020 22:31:54 -0800
Received: from kbuild by dd79da36dde1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiAor-00005Z-L3; Thu, 26 Nov 2020 06:31:53 +0000
Date:   Thu, 26 Nov 2020 14:31:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d33e4f0afdb2a1eb2890e0ea2ba4bb9101d92da5
Message-ID: <5fbf4bc0.ekVqoEx7ewsb2Uqi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d33e4f0afdb2a1eb2890e0ea2ba4bb9101d92da5  torture: Make torture.sh refscale runs use verbose_batched module parameter

elapsed time: 727m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     cu1830-neo_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
arm                          pxa910_defconfig
powerpc                      ppc44x_defconfig
riscv                            allyesconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
m68k                           sun3_defconfig
arm                          pxa168_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     loongson1c_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
sh                          rsk7201_defconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
arm                            lart_defconfig
arm                        realview_defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
arm                            qcom_defconfig
m68k                        mvme147_defconfig
arm                            dove_defconfig
sh                   rts7751r2dplus_defconfig
mips                         rt305x_defconfig
mips                        workpad_defconfig
arm                          ixp4xx_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
powerpc                     tqm8540_defconfig
microblaze                          defconfig
sh                         ecovec24_defconfig
powerpc                     tqm8541_defconfig
mips                      pic32mzda_defconfig
arm                        neponset_defconfig
s390                       zfcpdump_defconfig
sh                               j2_defconfig
arm64                            alldefconfig
mips                      bmips_stb_defconfig
sh                           se7206_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc64e_defconfig
arm                         cm_x300_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                   lite5200b_defconfig
h8300                    h8300h-sim_defconfig
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
