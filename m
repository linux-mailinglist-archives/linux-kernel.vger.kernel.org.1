Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E386D22DA32
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 00:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGYWXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 18:23:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:31854 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgGYWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:23:46 -0400
IronPort-SDR: s8O6QvN1bNC2cNlX/71aRPcxwGwG18j+UUvxj3f1EpZORjn3bX5ixD1ywvZpBsja4yIOvTWgS4
 I1WfoURR0hLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="150849117"
X-IronPort-AV: E=Sophos;i="5.75,395,1589266800"; 
   d="scan'208";a="150849117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 15:23:46 -0700
IronPort-SDR: h9Qojf8D9MfQXQM9zzfzKzo/npd2Og6vc+nL4Tgw5gZSwLJEqVXUOue2rKF+18NGb7DW+f8ptn
 e/bW8bQCss0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,395,1589266800"; 
   d="scan'208";a="363709669"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2020 15:23:45 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzSa0-00019H-RM; Sat, 25 Jul 2020 22:23:44 +0000
Date:   Sun, 26 Jul 2020 06:23:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 4b8e0328e56e177663645a96ea4c5c0401ecd78f
Message-ID: <5f1cb0e8.Xdf9Dsv5i16pY99J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 4b8e0328e56e177663645a96ea4c5c0401ecd78f  x86/mm: Remove the unused mk_kernel_pgd() #define

elapsed time: 725m

configs tested: 10
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
