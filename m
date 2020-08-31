Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB94257472
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 09:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgHaHlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 03:41:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:40133 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaHlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:41:47 -0400
IronPort-SDR: 4254C8aXT6dRX6qs7UNK+8/OKXyvlGtNt5OEMl0sMiZJJf5D4jo/ZKB0m0tCUFcnBWVc00jgZF
 9JMhJ18jGZ0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="221161349"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="221161349"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 00:41:47 -0700
IronPort-SDR: S9SelScZLG7eJP7rskUxGTRpHzlWM7DL6JqG7vohq36J50IAXKbcwd9Cop8AB6QREyxC+ldyYL
 2ywPqvQSZoEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="296842583"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Aug 2020 00:41:44 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kCeRj-0001A4-Dy; Mon, 31 Aug 2020 07:41:43 +0000
Date:   Mon, 31 Aug 2020 15:41:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 61aa9a0a5eae2100c171698bffabde8d5e9f694d
Message-ID: <5f4ca9ae.sBRer8M9Djmvpcbe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 61aa9a0a5eae2100c171698bffabde8d5e9f694d  x86/kvm: Expose TSX Suspend Load Tracking feature

elapsed time: 720m

configs tested: 27
configs skipped: 55

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
