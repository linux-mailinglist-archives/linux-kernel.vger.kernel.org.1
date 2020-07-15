Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E37220327
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 06:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgGOED6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 00:03:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:16538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgGOED5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:03:57 -0400
IronPort-SDR: 1gozmJFkDfBE6/grm2J2FhkOtSixaGExEvkG17tHw/aIT43idibwCaRBnMbobr4loioVT9Vsg5
 /EztT6dTHKMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="129167280"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="129167280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 21:03:57 -0700
IronPort-SDR: 0m64uQu+VTJ/7HQQC8ZTsSFyP/PQ5h9m3Pexj6k/mwsWLXgG9URk6zP600LqqydYJEPdjcWJKU
 p/VBTXzV2zrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="485586503"
Received: from lkp-server01.sh.intel.com (HELO aed10363631f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2020 21:03:56 -0700
Received: from kbuild by aed10363631f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvYeA-00000q-U5; Wed, 15 Jul 2020 04:03:54 +0000
Date:   Wed, 15 Jul 2020 12:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 e3beca48a45b5e0e6e6a4e0124276b8248dcc9bb
Message-ID: <5f0e7fe8.1ireByOWwdK/APGn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: e3beca48a45b5e0e6e6a4e0124276b8248dcc9bb  irqdomain/treewide: Keep firmware node unconditionally allocated

elapsed time: 727m

configs tested: 129
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arm                          tango4_defconfig
sh                            migor_defconfig
i386                             allyesconfig
arm                         s3c6400_defconfig
m68k                         amcore_defconfig
c6x                               allnoconfig
xtensa                generic_kc705_defconfig
mips                           ip27_defconfig
mips                  mips_paravirt_defconfig
c6x                        evmc6474_defconfig
powerpc                      pasemi_defconfig
sh                        dreamcast_defconfig
openrisc                         alldefconfig
m68k                        m5407c3_defconfig
arm                          ep93xx_defconfig
arm                          moxart_defconfig
sparc                               defconfig
mips                        maltaup_defconfig
mips                          rb532_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
arm                             pxa_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
sh                 kfr2r09-romimage_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
arm                  colibri_pxa270_defconfig
ia64                      gensparse_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200714
i386                 randconfig-a005-20200714
i386                 randconfig-a002-20200714
i386                 randconfig-a006-20200714
i386                 randconfig-a003-20200714
i386                 randconfig-a004-20200714
x86_64               randconfig-a012-20200714
x86_64               randconfig-a011-20200714
x86_64               randconfig-a016-20200714
x86_64               randconfig-a014-20200714
x86_64               randconfig-a013-20200714
x86_64               randconfig-a015-20200714
i386                 randconfig-a016-20200714
i386                 randconfig-a011-20200714
i386                 randconfig-a015-20200714
i386                 randconfig-a012-20200714
i386                 randconfig-a013-20200714
i386                 randconfig-a014-20200714
x86_64               randconfig-a005-20200715
x86_64               randconfig-a006-20200715
x86_64               randconfig-a002-20200715
x86_64               randconfig-a001-20200715
x86_64               randconfig-a003-20200715
x86_64               randconfig-a004-20200715
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
