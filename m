Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6677822DB80
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGZDCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 23:02:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:32811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgGZDCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 23:02:34 -0400
IronPort-SDR: G2MCvPTLF7/kbgTRlz3/nJisx4QJ+xztHzl9BrvcQNF/k9x5HRC/72/8IbCkOYfqd2FwysC13Y
 6OOQY4J4Z0IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="235740689"
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="scan'208";a="235740689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 20:02:34 -0700
IronPort-SDR: K39epHAV9Oc3xNkoALTE/IuagtfEeW7mfQcJxy5ru7LFrecPbj7L/FwLD6QmKDkRT/Lz4+E5gA
 Wvts1Va1LMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="scan'208";a="311832804"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2020 20:02:33 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzWvo-0001GG-QK; Sun, 26 Jul 2020 03:02:32 +0000
Date:   Sun, 26 Jul 2020 11:01:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/timers] BUILD SUCCESS
 898ec52d2ba05915aaedcdb21bff2e944c883cb8
Message-ID: <5f1cf209.CGCgv8X97R387iq1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/timers
branch HEAD: 898ec52d2ba05915aaedcdb21bff2e944c883cb8  x86/xen/time: Set the X86_FEATURE_TSC_KNOWN_FREQ flag in xen_tsc_khz()

elapsed time: 721m

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
