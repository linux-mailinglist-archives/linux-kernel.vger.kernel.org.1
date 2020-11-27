Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3562C6D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgK0WTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:19:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:21532 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731681AbgK0WSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:18:11 -0500
IronPort-SDR: G1QBZRUwNjUs1jVdkiVy0fvOIzkxQrGxV4ig7Seo7RFWONdW5Sk2eOSyubU+SWKB6GWj5QdK3U
 tDRPYX/rGPKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9818"; a="159485610"
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="159485610"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 14:17:57 -0800
IronPort-SDR: qgx7WSv30RbFMFSp33BU5zNFv85jT2eU5P6q/aG25icSzLDsmAo3ii66Rr/raLfBDgsyVnOkFk
 QXEJuJXVUtpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,375,1599548400"; 
   d="scan'208";a="366218920"
Received: from lkp-server01.sh.intel.com (HELO b5888d13d5a5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2020 14:17:56 -0800
Received: from kbuild by b5888d13d5a5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kim3v-0000BT-Fd; Fri, 27 Nov 2020 22:17:55 +0000
Date:   Sat, 28 Nov 2020 06:17:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 a787bdaff83a085288b6fc607afb4bb648da3cc9
Message-ID: <5fc17adf.eR/LzrbMqhbo8NCd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/core
branch HEAD: a787bdaff83a085288b6fc607afb4bb648da3cc9  Merge branch 'linus' into sched/core, to resolve semantic conflict

elapsed time: 723m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
arm                         lubbock_defconfig
ia64                      gensparse_defconfig
mips                          ath79_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rm200_defconfig
arm                   milbeaut_m10v_defconfig
mips                      pistachio_defconfig
arm                         lpc18xx_defconfig
m68k                        m5407c3_defconfig
mips                     cu1000-neo_defconfig
x86_64                           alldefconfig
nds32                               defconfig
riscv                    nommu_virt_defconfig
powerpc                      ppc40x_defconfig
arm                            dove_defconfig
arm                      jornada720_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      malta_kvm_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                           h5000_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      tqm8xx_defconfig
mips                           ip27_defconfig
powerpc64                           defconfig
arm                          ep93xx_defconfig
mips                          ath25_defconfig
microblaze                      mmu_defconfig
m68k                       m5208evb_defconfig
arm                           h3600_defconfig
sh                        edosk7760_defconfig
powerpc                    klondike_defconfig
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
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
