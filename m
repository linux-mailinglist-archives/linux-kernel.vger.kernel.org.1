Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D32E828C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 23:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLaWzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 17:55:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:40362 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgLaWzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 17:55:11 -0500
IronPort-SDR: ICsGwQe4YZUSFaf04lpdoDKgoeq1PBfA3f5kYchwgBFsA2IAOcGvrXmyoZkbC5CQpzQydIAJ40
 6zVry3/i5aPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="261500771"
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="261500771"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2020 14:54:30 -0800
IronPort-SDR: AkGaxX8WIPGRtSvWYnMPtan06JoxA+Gko1PCDk2OvitRIqVhQ8/BXhC7NaiCmrvzx+bEEJZl6f
 gqqTNvLvIJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="348444948"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Dec 2020 14:54:29 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kv6px-0005DW-6j; Thu, 31 Dec 2020 22:54:29 +0000
Date:   Fri, 01 Jan 2021 06:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 c769dcd423785703f17ca0a99925a7f9d84b3cbc
Message-ID: <5fee5696.Qqd4WwTsxzouknG9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/microcode
branch HEAD: c769dcd423785703f17ca0a99925a7f9d84b3cbc  x86/microcode: Make microcode_init() static

elapsed time: 724m

configs tested: 64
configs skipped: 64

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                         virt_defconfig
mips                            ar7_defconfig
arm64                               defconfig
powerpc                      ppc6xx_defconfig
c6x                        evmc6474_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
sh                           se7343_defconfig
xtensa                  cadence_csp_defconfig
c6x                        evmc6457_defconfig
powerpc                      pcm030_defconfig
x86_64                           alldefconfig
powerpc                     taishan_defconfig
arm                     am200epdkit_defconfig
powerpc                      makalu_defconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
powerpc                  iss476-smp_defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a016-20201231
i386                 randconfig-a015-20201231
i386                 randconfig-a014-20201231
i386                 randconfig-a012-20201231
i386                 randconfig-a011-20201231
i386                 randconfig-a013-20201231
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20201231
x86_64               randconfig-a006-20201231
x86_64               randconfig-a001-20201231
x86_64               randconfig-a002-20201231
x86_64               randconfig-a004-20201231
x86_64               randconfig-a003-20201231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
