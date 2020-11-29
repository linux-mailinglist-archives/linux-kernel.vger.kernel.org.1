Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242C42C7BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 00:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgK2XMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 18:12:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:60165 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgK2XMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 18:12:52 -0500
IronPort-SDR: OvId0Jh7CePkakjAyeCY/iKeklhycBWcahCRyCoxv5Y5cHo0GcfNxCJf4m/e7wqEfrVp3f93S3
 ksk00WCkbhPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="171775440"
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="171775440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 15:12:12 -0800
IronPort-SDR: LQ+1gjr2xmz8TUAqWwoUmZMrCyfpnxEfVJzJGsrHuaUpxt0N7a/GdFvrKqtcUdauigk8EtnT5W
 WXqjl5/17iPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,379,1599548400"; 
   d="scan'208";a="315010321"
Received: from lkp-server01.sh.intel.com (HELO 3082e074203f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2020 15:12:09 -0800
Received: from kbuild by 3082e074203f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kjVrV-0000I1-6Z; Sun, 29 Nov 2020 23:12:09 +0000
Date:   Mon, 30 Nov 2020 07:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bd4d2b7839cffa929d076cfb62562f5edb8e1b14
Message-ID: <5fc42a8f.A0B1of7wacDPYOKF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: bd4d2b7839cffa929d076cfb62562f5edb8e1b14  Merge branch 'linus'

elapsed time: 723m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5275evb_defconfig
arm                         lpc32xx_defconfig
xtensa                              defconfig
mips                        vocore2_defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1c_defconfig
powerpc64                        alldefconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      pcm030_defconfig
powerpc                    gamecube_defconfig
arm                  colibri_pxa270_defconfig
arm                         hackkit_defconfig
powerpc                       eiger_defconfig
mips                      pistachio_defconfig
powerpc                     kilauea_defconfig
mips                           ip22_defconfig
arm                        trizeps4_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a004-20201129
i386                 randconfig-a003-20201129
i386                 randconfig-a002-20201129
i386                 randconfig-a005-20201129
i386                 randconfig-a001-20201129
i386                 randconfig-a006-20201129
x86_64               randconfig-a015-20201129
x86_64               randconfig-a011-20201129
x86_64               randconfig-a016-20201129
x86_64               randconfig-a014-20201129
x86_64               randconfig-a012-20201129
x86_64               randconfig-a013-20201129
i386                 randconfig-a012-20201129
i386                 randconfig-a013-20201129
i386                 randconfig-a011-20201129
i386                 randconfig-a016-20201129
i386                 randconfig-a014-20201129
i386                 randconfig-a015-20201129
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
x86_64               randconfig-a003-20201129
x86_64               randconfig-a006-20201129
x86_64               randconfig-a004-20201129
x86_64               randconfig-a005-20201129
x86_64               randconfig-a002-20201129
x86_64               randconfig-a001-20201129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
