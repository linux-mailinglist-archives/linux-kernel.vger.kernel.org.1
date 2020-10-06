Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2908E284B48
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgJFMEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:04:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:3819 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgJFMEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:04:32 -0400
IronPort-SDR: JaoeKIuvknhE2vrU+4xqA8vMbqTXMV8fG3+nv9u/bSxI2i430c6Nu2tIhedWpserL+xvK2kIlD
 dsF+zSEBuXDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164602859"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="164602859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 05:04:16 -0700
IronPort-SDR: vNui34zX2gjcef2r7zgeTKIxh80xpIQ/R6fxQeY40HRDf1rOk6Mzy10ThXZayHdwtIar0YmBOh
 b4Pr9LtjzPHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="297069990"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2020 05:04:14 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPlhW-0001BT-6p; Tue, 06 Oct 2020 12:04:14 +0000
Date:   Tue, 06 Oct 2020 20:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/phm_phase] BUILD SUCCESS
 badb214dbade4055c9f34a098d0619b677ed666a
Message-ID: <5f7c5d36.6PStUZp2HRxAz7IM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/drm/amd/pm/phm_phase
branch HEAD: badb214dbade4055c9f34a098d0619b677ed666a  drm/amd/pm: Replace one-element array with flexible-array in struct phm_phase_shedding_limits_table

elapsed time: 724m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                                  defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          collie_defconfig
mips                           ci20_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
sh                        apsh4ad0a_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
c6x                        evmc6474_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                             allmodconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
c6x                         dsk6455_defconfig
powerpc                     sequoia_defconfig
arm                            dove_defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
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
i386                 randconfig-a006-20201006
i386                 randconfig-a005-20201006
i386                 randconfig-a001-20201006
i386                 randconfig-a004-20201006
i386                 randconfig-a003-20201006
i386                 randconfig-a002-20201006
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
