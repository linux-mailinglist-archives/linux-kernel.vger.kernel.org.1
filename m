Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E727A44D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI0Vvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:51:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:65497 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgI0Vvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:51:31 -0400
IronPort-SDR: 5YkjTbbboUTcRKwHTay8yVODMTeMV+31YZlL1CtKISUS45U1vYsb+tdcWNMfEsorqoCrMFbizO
 zt9F22UcBZbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159257766"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="159257766"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 14:38:27 -0700
IronPort-SDR: z6F3RObXWRtKf0UIvM4Cym4VR0AbmZGw8oQ4KsV43/KSvo1RBVhJGg+vPv3Th7EqJP+whzxEhe
 VlJ7CIitbsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="384225228"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2020 14:38:25 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMeNE-000061-WB; Sun, 27 Sep 2020 21:38:25 +0000
Date:   Mon, 28 Sep 2020 05:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/hyperv] BUILD SUCCESS
 dfc53baae3c6a165a35735b789e3e083786271d6
Message-ID: <5f71064a.VwRFgayV7e8fvQa9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/hyperv
branch HEAD: dfc53baae3c6a165a35735b789e3e083786271d6  x86/hyperv: Remove aliases with X64 in their name

elapsed time: 720m

configs tested: 69
configs skipped: 50

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                             alldefconfig
powerpc                 mpc832x_rdb_defconfig
m68k                         apollo_defconfig
sh                          sdk7780_defconfig
ia64                                defconfig
mips                           rs90_defconfig
arm64                               defconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
sh                        sh7757lcr_defconfig
arc                                 defconfig
powerpc                     sequoia_defconfig
i386                                defconfig
arm                           tegra_defconfig
arm                         orion5x_defconfig
m68k                             allyesconfig
x86_64                           allyesconfig
arc                         haps_hs_defconfig
arc                             nps_defconfig
c6x                        evmc6474_defconfig
mips                      maltaaprp_defconfig
sh                          urquell_defconfig
powerpc                      ppc6xx_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
