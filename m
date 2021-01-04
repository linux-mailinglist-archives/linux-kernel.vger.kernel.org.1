Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAE82E9E02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbhADTOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:14:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:51898 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhADTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:14:51 -0500
IronPort-SDR: D22KAMuJPRSdeNmjyULV6QFHVFApkbWhRV45VCEX6T7qW4HdbhRIa7LX15xVud01e+H3NG/S6e
 8rijYrGAX2eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177149537"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="177149537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 11:14:09 -0800
IronPort-SDR: 43h9BjKxfIDW/FWeVJJcP7gONZ3kWtXF89uwnPKThBxKPjKfYh3ZhVQtXmB/ZTsssz73Rh+C3R
 Llzo4ANfonWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="462046335"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2021 11:14:08 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kwVIt-0007iu-Uo; Mon, 04 Jan 2021 19:14:07 +0000
Date:   Tue, 05 Jan 2021 03:13:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 300da924c996f9b727ddde11865fc0e098c34223
Message-ID: <5ff368d1.0WooqglckxUeiUKx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 300da924c996f9b727ddde11865fc0e098c34223  Merge branch 'x86/microcode'

elapsed time: 724m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc866_ads_defconfig
powerpc                      pcm030_defconfig
um                           x86_64_defconfig
arm                             rpc_defconfig
sh                             sh03_defconfig
arm                       aspeed_g5_defconfig
arm64                            alldefconfig
arm                      pxa255-idp_defconfig
h8300                               defconfig
sh                           se7721_defconfig
mips                           ip27_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arm                             ezx_defconfig
sh                         ap325rxa_defconfig
m68k                        mvme16x_defconfig
arm                   milbeaut_m10v_defconfig
mips                         mpc30x_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  cadence_csp_defconfig
arm                          prima2_defconfig
powerpc                     sequoia_defconfig
m68k                            mac_defconfig
xtensa                  nommu_kc705_defconfig
parisc                generic-32bit_defconfig
arm                         lpc32xx_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
s390                                defconfig
powerpc                     akebono_defconfig
arm                       imx_v4_v5_defconfig
mips                          ath79_defconfig
arm                        mini2440_defconfig
xtensa                          iss_defconfig
m68k                        stmark2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210104
x86_64               randconfig-a004-20210104
x86_64               randconfig-a001-20210104
x86_64               randconfig-a005-20210104
x86_64               randconfig-a002-20210104
x86_64               randconfig-a003-20210104
i386                 randconfig-a005-20210104
i386                 randconfig-a002-20210104
i386                 randconfig-a003-20210104
i386                 randconfig-a001-20210104
i386                 randconfig-a006-20210104
i386                 randconfig-a004-20210104
i386                 randconfig-a016-20210104
i386                 randconfig-a011-20210104
i386                 randconfig-a013-20210104
i386                 randconfig-a014-20210104
i386                 randconfig-a015-20210104
i386                 randconfig-a012-20210104
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210104
x86_64               randconfig-a012-20210104
x86_64               randconfig-a011-20210104
x86_64               randconfig-a016-20210104
x86_64               randconfig-a014-20210104
x86_64               randconfig-a015-20210104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
