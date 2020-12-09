Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46FB2D3949
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 04:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgLIDhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 22:37:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:1427 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLIDhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:37:18 -0500
IronPort-SDR: HYDZp1Qucgr5Qzk/Bnjkbah6rTrjZgFyC/Y96IZYJMr6TGIGiIzuX8GANrcxGw4OL32Smtr6wk
 RJeFeyQzG9HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258721297"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="258721297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 19:36:37 -0800
IronPort-SDR: fUDnQiybMdWEkEik1h1xeS5ZsNCtycoeucoCN9cGmNq2bIvQh1iPcxjR3NFVsDx72vGkZcAkx7
 39KeV+l1Zo9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="370653648"
Received: from lkp-server01.sh.intel.com (HELO 4e633a5ce5ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2020 19:36:36 -0800
Received: from kbuild by 4e633a5ce5ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmqHL-00006p-IV; Wed, 09 Dec 2020 03:36:35 +0000
Date:   Wed, 09 Dec 2020 11:35:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 2521bfed6027330d9e0ab10a6b00eff01f45001c
Message-ID: <5fd04617.BwD6hmIFweJt8Gey%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 2521bfed6027330d9e0ab10a6b00eff01f45001c  Merge branch 'linus' into auto-latest

elapsed time: 725m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
sh                           se7721_defconfig
mips                        omega2p_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
powerpc                     kmeter1_defconfig
mips                      maltaaprp_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                               tinyconfig
i386                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
