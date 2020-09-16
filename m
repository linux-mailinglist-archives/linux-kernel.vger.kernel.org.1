Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A4C26C38B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgIPOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 10:15:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:61357 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIPNlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 09:41:06 -0400
IronPort-SDR: o5bk9mBYw0QobTHAeKrhTMNiXQoQYNTtka6QUFoIlHTnk3Ja1+izXYz8VLzQSmhsgE7ItHbJR+
 fs2dL8tFRnTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="147127976"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="147127976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 03:53:24 -0700
IronPort-SDR: /MRqqEYBuPe2sosnPAUy+SYDj5OJ7As0+jzp8HpNAM1CaPsu4SYHiIqWVwsXbtuiHbLbrcSYmu
 XwpmvEmjV+JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="507127440"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2020 03:53:23 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIV3y-00004K-Ca; Wed, 16 Sep 2020 10:53:22 +0000
Date:   Wed, 16 Sep 2020 18:53:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 953bb62921006c65c5373b8d6e72c0a70f739d17
Message-ID: <5f61ee9a.oFJ0wBLwbUVmFMoZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 953bb62921006c65c5373b8d6e72c0a70f739d17  rcutorture: Make preemptible TRACE02 enable lockdep

elapsed time: 725m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      walnut_defconfig
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
c6x                         dsk6455_defconfig
powerpc                 canyonlands_defconfig
sh                               j2_defconfig
arm                          ixp4xx_defconfig
xtensa                              defconfig
mips                         cobalt_defconfig
sh                          rsk7264_defconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
arc                             nps_defconfig
arm                            dove_defconfig
sh                     sh7710voipgw_defconfig
arm                         socfpga_defconfig
sh                          r7785rp_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
microblaze                    nommu_defconfig
sh                           se7780_defconfig
i386                             alldefconfig
powerpc                     tqm5200_defconfig
m68k                        m5407c3_defconfig
mips                     loongson1c_defconfig
powerpc                       holly_defconfig
mips                      maltaaprp_defconfig
arm                         shannon_defconfig
arm                         ebsa110_defconfig
arm                          gemini_defconfig
arc                           tb10x_defconfig
powerpc                     tqm8560_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                       eiger_defconfig
arm                      integrator_defconfig
powerpc                 mpc834x_mds_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7751_defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  iss476-smp_defconfig
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
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
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

clang tested configs:
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
