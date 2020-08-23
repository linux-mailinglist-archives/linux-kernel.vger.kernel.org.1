Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE0C24EAAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHWBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 21:10:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:29326 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgHWBKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 21:10:13 -0400
IronPort-SDR: Xpdc519I8YoXEKBI7adLVMeqASkqsCTMKgErRRewMP60XP2qt29KCKwJfms2h6AQiM9t+YEoCr
 rZD/pbe6J7xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9721"; a="240570446"
X-IronPort-AV: E=Sophos;i="5.76,342,1592895600"; 
   d="scan'208";a="240570446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 18:10:13 -0700
IronPort-SDR: SV4RKiZJw6LXxUkUB4xMIaziyOpvUhwFjKSI5AqvL0+NMdtmCjAwncpBZUv3W6yv30+LmxyFsB
 3vgjf6l3oMcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,342,1592895600"; 
   d="scan'208";a="311792232"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2020 18:10:12 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9eWR-0001uA-Jr; Sun, 23 Aug 2020 01:10:11 +0000
Date:   Sun, 23 Aug 2020 09:10:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 c31feed8461fb8648075ba9b53d9e527d530972f
Message-ID: <5f41c1ef.h/9RT8WqlolTHKyH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/misc
branch HEAD: c31feed8461fb8648075ba9b53d9e527d530972f  x86/msr: Make source of unrecognised MSR writes unambiguous

elapsed time: 723m

configs tested: 30
configs skipped: 47

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                 kfr2r09-romimage_defconfig
sh                          urquell_defconfig
parisc                           alldefconfig
mips                       capcella_defconfig
m68k                                defconfig
arm                           stm32_defconfig
arm                         mv78xx0_defconfig
arm                         s3c2410_defconfig
c6x                        evmc6474_defconfig
powerpc                  mpc885_ads_defconfig
mips                           jazz_defconfig
sh                           se7712_defconfig
arm                        mini2440_defconfig
mips                          ath79_defconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
