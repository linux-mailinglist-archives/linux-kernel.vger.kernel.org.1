Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7A286A94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgJGV7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:59:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:39857 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgJGV7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:59:55 -0400
IronPort-SDR: PLtz7bsK9LMqeZJfeclnqVsmvXlU4QDe+DmwiceOMpXZfXuFXK8ba1vu6AuJYxH7lDdLt5OjF4
 j7Xl+JLSEIAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="144501692"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="144501692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 14:59:55 -0700
IronPort-SDR: BYYjRDgubidjnsSdhpDcesiDZNmQPJAvoCe4LKkr5/9z14+N/s3NAHtMVAu944RMDsp3peGxId
 0JnVJj5KsXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="316426634"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2020 14:59:54 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQHTV-0001q3-C4; Wed, 07 Oct 2020 21:59:53 +0000
Date:   Thu, 08 Oct 2020 05:59:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f7f6d7dfbcc36ab8484e4bcfe842839621e54c2b
Message-ID: <5f7e3a4e.iuUQpUgiYNlI240u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: f7f6d7dfbcc36ab8484e4bcfe842839621e54c2b  Merge branch 'x86/platform'

elapsed time: 725m

configs tested: 171
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                    mvme5100_defconfig
sh                             espt_defconfig
powerpc                     mpc512x_defconfig
powerpc                     rainier_defconfig
sh                        apsh4ad0a_defconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
arm                       aspeed_g4_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      arches_defconfig
arm                         palmz72_defconfig
powerpc                     mpc5200_defconfig
arm                            zeus_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc8560_ads_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
riscv                             allnoconfig
h8300                            alldefconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm8555_defconfig
mips                            e55_defconfig
arc                          axs101_defconfig
arm                         lpc18xx_defconfig
alpha                            allyesconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
h8300                       h8s-sim_defconfig
powerpc                    ge_imp3a_defconfig
mips                      malta_kvm_defconfig
csky                             alldefconfig
parisc                generic-32bit_defconfig
sh                           se7705_defconfig
sh                               alldefconfig
arm                      footbridge_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                         mv78xx0_defconfig
mips                 decstation_r4k_defconfig
sh                        edosk7705_defconfig
s390                          debug_defconfig
s390                             alldefconfig
arm                      integrator_defconfig
c6x                        evmc6474_defconfig
powerpc                  mpc885_ads_defconfig
arm                            qcom_defconfig
arm                             rpc_defconfig
c6x                              alldefconfig
sh                        sh7757lcr_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                          sdk7786_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       aspeed_g5_defconfig
mips                     cu1000-neo_defconfig
sh                           se7619_defconfig
arm                         nhk8815_defconfig
arm                        clps711x_defconfig
arm                          ep93xx_defconfig
h8300                               defconfig
sh                              ul2_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
i386                 randconfig-a006-20201007
i386                 randconfig-a005-20201007
i386                 randconfig-a001-20201007
i386                 randconfig-a004-20201007
i386                 randconfig-a003-20201007
i386                 randconfig-a002-20201007
x86_64               randconfig-a012-20201007
x86_64               randconfig-a015-20201007
x86_64               randconfig-a014-20201007
x86_64               randconfig-a013-20201007
x86_64               randconfig-a011-20201007
x86_64               randconfig-a016-20201007
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005
x86_64               randconfig-a004-20201007
x86_64               randconfig-a002-20201007
x86_64               randconfig-a001-20201007
x86_64               randconfig-a005-20201007
x86_64               randconfig-a003-20201007
x86_64               randconfig-a006-20201007

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
