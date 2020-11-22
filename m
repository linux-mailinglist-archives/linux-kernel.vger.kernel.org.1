Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D962BC686
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKVPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 10:38:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:1743 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbgKVPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:38:06 -0500
IronPort-SDR: MerRfNhLMcfjLIUHJnGgi9A7DS3fid+1jQsltxybvVSFtvV4MGybiY+T1cKZKwQA3fqc9zP91z
 pbAXVnNExY7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="169084445"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="169084445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 07:38:06 -0800
IronPort-SDR: pU/D3UOZqvU8L4FtN+vZ2B4AyUK+XpYo0PS2rDMBNVSJ8d2v8TX15cqKxOp1AqsEHBK1lRApsy
 8oLSq4bTge2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="361150665"
Received: from lkp-server01.sh.intel.com (HELO ce8054c7261d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2020 07:38:05 -0800
Received: from kbuild by ce8054c7261d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgrRE-0000Ar-Ge; Sun, 22 Nov 2020 15:38:04 +0000
Date:   Sun, 22 Nov 2020 23:37:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 bd5fc4f66b3e1df8fe9fb7756f408dedd4495877
Message-ID: <5fba85d7.zf/iOiQW0JCKFi+c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: bd5fc4f66b3e1df8fe9fb7756f408dedd4495877  rcu: Record kvfree_call_rcu() call stack for KASAN

elapsed time: 1282m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
powerpc                      cm5200_defconfig
powerpc                    ge_imp3a_defconfig
nios2                         10m50_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
arm                          lpd270_defconfig
arm                     eseries_pxa_defconfig
powerpc                    amigaone_defconfig
mips                         mpc30x_defconfig
sh                           sh2007_defconfig
mips                      maltaaprp_defconfig
arm                         cm_x300_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                   bluestone_defconfig
m68k                          amiga_defconfig
arm                        keystone_defconfig
mips                     cu1830-neo_defconfig
sh                           se7712_defconfig
arm                       cns3420vb_defconfig
m68k                             allmodconfig
mips                        nlm_xlp_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201122
i386                 randconfig-a003-20201122
i386                 randconfig-a002-20201122
i386                 randconfig-a005-20201122
i386                 randconfig-a001-20201122
i386                 randconfig-a006-20201122
x86_64               randconfig-a006-20201122
x86_64               randconfig-a003-20201122
x86_64               randconfig-a004-20201122
x86_64               randconfig-a005-20201122
x86_64               randconfig-a001-20201122
x86_64               randconfig-a002-20201122
i386                 randconfig-a012-20201122
i386                 randconfig-a013-20201122
i386                 randconfig-a011-20201122
i386                 randconfig-a016-20201122
i386                 randconfig-a014-20201122
i386                 randconfig-a015-20201122
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
x86_64               randconfig-a015-20201122
x86_64               randconfig-a011-20201122
x86_64               randconfig-a014-20201122
x86_64               randconfig-a016-20201122
x86_64               randconfig-a012-20201122
x86_64               randconfig-a013-20201122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
