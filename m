Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C3231766
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 03:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgG2Brc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 21:47:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:30261 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgG2Brb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:47:31 -0400
IronPort-SDR: D/XYOS2B35gEdIqen0AFylxLApDPeP+fz01l/hzY3VgJk22o+LgHMyrAbTaZ4K7dzeOeldejBh
 GOwnXXsmw3yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151326225"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="151326225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 18:47:29 -0700
IronPort-SDR: buweFr5FXr4/wTlV5YC7qLAkiGV9FFRoWmrr2Zj2m8xiK0wIq4Jp90yg5jDZ3MfVW3CESDyZyn
 9NEDaro4wMXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="364702365"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2020 18:47:28 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0bBn-0001A6-IU; Wed, 29 Jul 2020 01:47:27 +0000
Date:   Wed, 29 Jul 2020 09:47:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 21a6ee14a8f277766618ef07154432b46528113e
Message-ID: <5f20d51a.xjfwIJj4SuCWbefb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/core
branch HEAD: 21a6ee14a8f277766618ef07154432b46528113e  sched: Remove duplicated tick_nohz_full_enabled() check

elapsed time: 724m

configs tested: 76
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            qcom_defconfig
powerpc                      ep88xc_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
arm                     davinci_all_defconfig
nios2                            alldefconfig
arm                         vf610m4_defconfig
m68k                            mac_defconfig
sh                          lboxre2_defconfig
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
powerpc                             defconfig
i386                 randconfig-a003-20200728
i386                 randconfig-a004-20200728
i386                 randconfig-a005-20200728
i386                 randconfig-a002-20200728
i386                 randconfig-a006-20200728
i386                 randconfig-a001-20200728
x86_64               randconfig-a014-20200728
x86_64               randconfig-a012-20200728
x86_64               randconfig-a015-20200728
x86_64               randconfig-a016-20200728
x86_64               randconfig-a013-20200728
x86_64               randconfig-a011-20200728
i386                 randconfig-a016-20200728
i386                 randconfig-a012-20200728
i386                 randconfig-a013-20200728
i386                 randconfig-a014-20200728
i386                 randconfig-a011-20200728
i386                 randconfig-a015-20200728
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
