Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652C27081C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIRVXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:23:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:61232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIRVXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:23:15 -0400
IronPort-SDR: vU51fsCa0h/KJh0q4zBk8vh3VoY+iXHe9zsGsHkNJHg4mh7s8h9j/cgK9FtyXgluzjFDVVUCGl
 uoaLcISUfh/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="139533195"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="139533195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:23:12 -0700
IronPort-SDR: DHjsIMOqXG8PSpj+KHfSYC04dKpSl3POLk+eza5mCiWH+Jls/TPtZeYwhLuBTPo2I4/xfQln4+
 uh8CHrOim0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="339958614"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2020 14:23:11 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJNqY-0000hS-Vb; Fri, 18 Sep 2020 21:23:10 +0000
Date:   Sat, 19 Sep 2020 05:22:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 75d1cc0e05af579301ce4e49cf6399be4b4e6e76
Message-ID: <5f65250b.LSgObVllHPBfzIkC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 75d1cc0e05af579301ce4e49cf6399be4b4e6e76  x86/mm/pat: Don't flush cache if hardware enforces cache coherency across encryption domnains

elapsed time: 726m

configs tested: 104
configs skipped: 58

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
powerpc                      mgcoge_defconfig
parisc                generic-32bit_defconfig
m68k                        m5272c3_defconfig
sh                     magicpanelr2_defconfig
arm                         nhk8815_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
arm                  colibri_pxa300_defconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
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
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
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
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
