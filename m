Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88B1A5BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 03:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 21:22:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:30655 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgDLBWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 21:22:11 -0400
IronPort-SDR: GFDhty0SoVP3Pf29nRru7lkHk+ZaE1fBdTV9DxUYahcrXQOWwA+RKPDA0i1gJfeJFYJIr1uwLT
 ObtbCtfRRKyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 18:22:10 -0700
IronPort-SDR: Gjf92eSK82jr/qQbFG8R9uw/bJCBIGWfD2QuPjgeosf3hzpJ36O5fpCo8rKlfmpx7ySX09jF8D
 QIZs66LiAvhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,372,1580803200"; 
   d="scan'208";a="252551950"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2020 18:22:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNRK4-0005Ty-Ql; Sun, 12 Apr 2020 09:22:08 +0800
Date:   Sun, 12 Apr 2020 09:21:28 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e6f8b6c12f03818baacc5f504fe83fa5e20771d6
Message-ID: <5e926d18.MOsH99BQt5InP/HZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: e6f8b6c12f03818baacc5f504fe83fa5e20771d6  KVM: VMX: Extend VMXs #AC interceptor to handle split lock #AC in guest

elapsed time: 559m

configs tested: 79
configs skipped: 102

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
ia64                             allmodconfig
m68k                           sun3_defconfig
c6x                              allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
alpha                randconfig-a001-20200412
m68k                 randconfig-a001-20200412
mips                 randconfig-a001-20200412
nds32                randconfig-a001-20200412
parisc               randconfig-a001-20200412
riscv                randconfig-a001-20200412
c6x                  randconfig-a001-20200412
h8300                randconfig-a001-20200412
microblaze           randconfig-a001-20200412
nios2                randconfig-a001-20200412
sparc64              randconfig-a001-20200412
x86_64               randconfig-b002-20200412
i386                 randconfig-b001-20200412
x86_64               randconfig-b001-20200412
x86_64               randconfig-b003-20200412
i386                 randconfig-b003-20200412
i386                 randconfig-b002-20200412
x86_64               randconfig-d001-20200412
x86_64               randconfig-d002-20200412
x86_64               randconfig-d003-20200412
i386                 randconfig-d001-20200412
i386                 randconfig-d002-20200412
i386                 randconfig-d003-20200412
x86_64               randconfig-e001-20200412
i386                 randconfig-e001-20200412
i386                 randconfig-e002-20200412
i386                 randconfig-e003-20200412
x86_64               randconfig-e003-20200412
x86_64               randconfig-e002-20200412
x86_64               randconfig-f001-20200412
x86_64               randconfig-f002-20200412
x86_64               randconfig-f003-20200412
i386                 randconfig-f001-20200412
i386                 randconfig-f002-20200412
i386                 randconfig-f003-20200412
x86_64               randconfig-g001-20200412
x86_64               randconfig-g002-20200412
x86_64               randconfig-g003-20200412
i386                 randconfig-g001-20200412
i386                 randconfig-g002-20200412
i386                 randconfig-g003-20200412
x86_64               randconfig-h001-20200412
i386                 randconfig-h003-20200412
i386                 randconfig-h002-20200412
i386                 randconfig-h001-20200412
x86_64               randconfig-h003-20200412
x86_64               randconfig-h002-20200412
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
