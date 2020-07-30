Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE994232A19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgG3Cde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 22:33:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:23972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgG3Cdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:33:32 -0400
IronPort-SDR: I5Pl6cmjvU333rRsb2H4lRSZgn1wDtIGioF9oxXFQh46MgFDSls3Ld+o9mG57QElXvTpoYvP57
 PqOTT3l4tPww==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="148992048"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="148992048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 19:33:28 -0700
IronPort-SDR: TPSMvZpC/YfBbA+3Jt05o4KAIy3223njP/L8vQOBWP3lTETA0zl2WArGC0KCT/NIqjkFsJi9lV
 aChjLvpUlw2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="scan'208";a="286708711"
Received: from lkp-server02.sh.intel.com (HELO 7eae361f48a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2020 19:33:29 -0700
Received: from kbuild by 7eae361f48a9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0yNs-000046-2m; Thu, 30 Jul 2020 02:33:28 +0000
Date:   Thu, 30 Jul 2020 10:32:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 fcd7c9c3c35aed58aba2eea6d375f0e5b03bd6d6
Message-ID: <5f223147.hONqADWU80JUsq8H%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  sched/core
branch HEAD: fcd7c9c3c35aed58aba2eea6d375f0e5b03bd6d6  arm, arm64: Fix selection of CONFIG_SCHED_THERMAL_PRESSURE

elapsed time: 720m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
x86_64               randconfig-a004-20200729
x86_64               randconfig-a005-20200729
x86_64               randconfig-a002-20200729
x86_64               randconfig-a006-20200729
x86_64               randconfig-a003-20200729
x86_64               randconfig-a001-20200729
i386                 randconfig-a003-20200729
i386                 randconfig-a004-20200729
i386                 randconfig-a005-20200729
i386                 randconfig-a002-20200729
i386                 randconfig-a006-20200729
i386                 randconfig-a001-20200729
i386                 randconfig-a016-20200729
i386                 randconfig-a012-20200729
i386                 randconfig-a013-20200729
i386                 randconfig-a014-20200729
i386                 randconfig-a011-20200729
i386                 randconfig-a015-20200729
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
