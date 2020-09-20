Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A032712CF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgITH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 03:59:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:32914 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgITH7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 03:59:18 -0400
IronPort-SDR: Vt3jHHhrUsrooIgHboT8nzInP5g3J9Qzg9X5so/lWAy++q1GTMf7E/+2dpxSai39mf9WPjCMxT
 uaMrLMXmK1Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="245050244"
X-IronPort-AV: E=Sophos;i="5.77,282,1596524400"; 
   d="scan'208";a="245050244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 00:59:16 -0700
IronPort-SDR: Y30tpdpci8zdHDsOs7gcBhrl6wCUDjQ1zRdIzX8woBzO2DnwyVPsDNPqbFhXtiZrtQJnE3sS+r
 fbFa2iaPYfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,282,1596524400"; 
   d="scan'208";a="453506253"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2020 00:59:14 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJuFd-0001K4-8m; Sun, 20 Sep 2020 07:59:13 +0000
Date:   Sun, 20 Sep 2020 15:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 e1ebb2b49048c4767cfa0d8466f9c701e549fa5e
Message-ID: <5f670bc2.TJ1pVewDNZOPoqNt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: e1ebb2b49048c4767cfa0d8466f9c701e549fa5e  KVM: SVM: Don't flush cache if hardware enforces cache coherency across encryption domains

elapsed time: 721m

configs tested: 61
configs skipped: 65

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
parisc                generic-32bit_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
m68k                       m5208evb_defconfig
csky                             alldefconfig
powerpc                     tqm8555_defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
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
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
