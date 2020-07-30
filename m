Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69B232AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 05:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgG3D5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 23:57:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:48121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3D5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:57:50 -0400
IronPort-SDR: llmqrGGLHEiLMHoMYOHxAMBcX770DIZZQrTocOoULs4FmGi9z+lziVm4XNCugfv0tO+3qDyqrG
 Vqa88zV0xu+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="213069616"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="213069616"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 20:57:49 -0700
IronPort-SDR: Ic61OUdkbxGr84mdP479D9eOre6HhyQ2F3Yl6ncWeyBNoAAW4ASIKAAKnqPc/RwG2W9oGWJAlH
 66erqmi8lb1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="434900962"
Received: from lkp-server01.sh.intel.com (HELO aff35d61a1e5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 20:57:47 -0700
Received: from kbuild by aff35d61a1e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0zhS-00002F-Uf; Thu, 30 Jul 2020 03:57:46 +0000
Date:   Thu, 30 Jul 2020 11:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bdd65589593edd79b6a12ce86b3b7a7c6dae5208
Message-ID: <5f224511.SeykquTcf4+ZK4eG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: bdd65589593edd79b6a12ce86b3b7a7c6dae5208  x86/i8259: Use printk_deferred() to prevent deadlock

elapsed time: 722m

configs tested: 65
configs skipped: 46

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
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
