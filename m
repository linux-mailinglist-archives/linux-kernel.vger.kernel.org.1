Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1E2932EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbgJTCEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:04:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:56062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbgJTCEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:04:10 -0400
IronPort-SDR: enBjD8AHWOITpC+kj0kMpf7JM3gK7daqoT23yP0VlCqzlrBG3zwgpUtlOqTNCnyrkACGs7YiTY
 MObEUVMjFxIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="166364078"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="166364078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 19:04:09 -0700
IronPort-SDR: 6mkq58W9huRY4bB6MhFkGY1k9uZtuqvTmitsxVuQ7jFKEdBpcQmwb4c9ORbtbt7ZxGhm91aKp+
 QA1AiwSTM8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="465750502"
Received: from lkp-server01.sh.intel.com (HELO 88424da292e0) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 19:04:08 -0700
Received: from kbuild by 88424da292e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUh0R-0000LZ-I3; Tue, 20 Oct 2020 02:04:07 +0000
Date:   Tue, 20 Oct 2020 10:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2d3e8c9424c9dc938188a34d38d01865809fa434
Message-ID: <5f8e4579.YTdRbBEYKE+g3mAV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 2d3e8c9424c9dc938188a34d38d01865809fa434  Merge branch 'linus'

elapsed time: 724m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                    xip_kc705_defconfig
mips                            ar7_defconfig
arm                            mmp2_defconfig
powerpc                      ppc64e_defconfig
mips                        nlm_xlr_defconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
parisc                generic-32bit_defconfig
arm                     am200epdkit_defconfig
arc                     haps_hs_smp_defconfig
mips                      malta_kvm_defconfig
powerpc                  storcenter_defconfig
sh                     sh7710voipgw_defconfig
mips                malta_qemu_32r6_defconfig
m68k                             allmodconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                    sam440ep_defconfig
mips                           ip27_defconfig
sh                         apsh4a3a_defconfig
powerpc                     tqm8540_defconfig
sh                         ecovec24_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
openrisc                    or1ksim_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
mips                        bcm47xx_defconfig
mips                           ip32_defconfig
sh                           se7780_defconfig
xtensa                generic_kc705_defconfig
powerpc                     redwood_defconfig
mips                           jazz_defconfig
arm                        multi_v5_defconfig
powerpc                        cell_defconfig
arm                              alldefconfig
mips                         tb0287_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
h8300                            alldefconfig
alpha                            alldefconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
mips                       lemote2f_defconfig
arm                           sunxi_defconfig
arm                        realview_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
powerpc                         ps3_defconfig
sh                          rsk7269_defconfig
arm                             rpc_defconfig
arm                        mvebu_v7_defconfig
m68k                        mvme147_defconfig
powerpc                    socrates_defconfig
c6x                        evmc6678_defconfig
arm                           spitz_defconfig
powerpc                     skiroot_defconfig
arm                            zeus_defconfig
powerpc                      katmai_defconfig
mips                    maltaup_xpa_defconfig
arm                           tegra_defconfig
powerpc                  mpc866_ads_defconfig
arm                           sama5_defconfig
mips                        nlm_xlp_defconfig
powerpc                   currituck_defconfig
arm                      integrator_defconfig
powerpc                  iss476-smp_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
mips                             allmodconfig
mips                         mpc30x_defconfig
alpha                               defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
arm                         palmz72_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
sh                        edosk7705_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201019
x86_64               randconfig-a002-20201019
x86_64               randconfig-a006-20201019
x86_64               randconfig-a003-20201019
x86_64               randconfig-a005-20201019
x86_64               randconfig-a001-20201019
i386                 randconfig-a006-20201019
i386                 randconfig-a005-20201019
i386                 randconfig-a001-20201019
i386                 randconfig-a003-20201019
i386                 randconfig-a004-20201019
i386                 randconfig-a002-20201019
i386                 randconfig-a015-20201019
i386                 randconfig-a013-20201019
i386                 randconfig-a016-20201019
i386                 randconfig-a012-20201019
i386                 randconfig-a011-20201019
i386                 randconfig-a014-20201019
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
x86_64               randconfig-a016-20201019
x86_64               randconfig-a015-20201019
x86_64               randconfig-a012-20201019
x86_64               randconfig-a013-20201019
x86_64               randconfig-a011-20201019
x86_64               randconfig-a014-20201019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
