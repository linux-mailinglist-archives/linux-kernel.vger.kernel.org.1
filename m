Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C27867E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgIYL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:58:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:4472 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgIYL6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:58:42 -0400
IronPort-SDR: LeB+fhTvlUtD3OFyjCnGTu/AW9KO0zVoErjn0fMeWnO8Ha6xgpkGZA9rkzOM8Oq/gMpY4fsHtO
 u5M6x4Uj7+7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162401100"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="162401100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 04:56:29 -0700
IronPort-SDR: 2lpOUM+NtzC5YjEeHPixZwiuS/ur7Lxc2szvArJHpqg6qk6IvBLdABLNcex9EwEYb+khrtpBQz
 nXjFP7mwbgPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="487440210"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2020 04:56:27 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLmKx-000059-84; Fri, 25 Sep 2020 11:56:27 +0000
Date:   Fri, 25 Sep 2020 19:55:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS WITH WARNING
 516c2f87d0d1204a9ea1b36298283f74056a7eab
Message-ID: <5f6ddabc.UcKD4O0BUx8/14vJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 516c2f87d0d1204a9ea1b36298283f74056a7eab  EXP rcu/segcblist: Remove useless rcupdate.h include

Warning in current branch:

kernel/rcu/rcutorture.c:1507:13: warning: no previous prototype for 'rcu_nocb_cpu_offload' [-Wmissing-prototypes]
kernel/rcu/rcutorture.c:1507:13: warning: no previous prototype for function 'rcu_nocb_cpu_offload' [-Wmissing-prototypes]
kernel/rcu/rcutorture.c:1508:13: warning: no previous prototype for 'rcu_nocb_cpu_deoffload' [-Wmissing-prototypes]
kernel/rcu/rcutorture.c:1508:13: warning: no previous prototype for function 'rcu_nocb_cpu_deoffload' [-Wmissing-prototypes]
kernel/rcu/tree_stall.h:260:12: sparse: sparse: context imbalance in 'rcu_print_task_stall' - different lock contexts for basic block

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- alpha-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- alpha-randconfig-r024-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- alpha-randconfig-r031-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- alpha-randconfig-r034-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arc-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arc-randconfig-p002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arm-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arm-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arm-randconfig-r002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- arm64-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- c6x-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- c6x-randconfig-r004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- c6x-randconfig-r014-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- c6x-randconfig-r031-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- h8300-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- h8300-randconfig-r021-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- h8300-randconfig-r032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- h8300-randconfig-r033-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-a003-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-a004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-a006-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-a012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-a014-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-c001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-p001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-r016-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-s001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-s031-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- i386-randconfig-s032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- ia64-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- ia64-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- ia64-randconfig-r004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- ia64-randconfig-r025-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- m68k-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- m68k-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- m68k-randconfig-r013-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- m68k-randconfig-r022-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- m68k-randconfig-s032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- microblaze-randconfig-r011-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- microblaze-randconfig-r033-20200923
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- mips-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- mips-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- mips-randconfig-r006-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- mips-randconfig-r031-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nds32-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nds32-randconfig-p001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nds32-randconfig-r004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nds32-randconfig-r012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nds32-randconfig-r021-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nios2-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- nios2-randconfig-r015-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- openrisc-randconfig-c004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- openrisc-randconfig-r004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- openrisc-randconfig-r021-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- openrisc-randconfig-r025-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- parisc-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- parisc-randconfig-r001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- parisc-randconfig-r006-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- parisc-randconfig-r026-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- parisc-randconfig-r033-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-randconfig-p002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-randconfig-r011-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-randconfig-r012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-randconfig-r013-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc-randconfig-r025-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc64-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc64-randconfig-p002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- powerpc64-randconfig-r013-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- riscv-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- riscv-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- s390-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- s390-defconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- s390-randconfig-c004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- s390-randconfig-r023-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- s390-randconfig-s032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|   `-- kernel-rcu-tree_stall.h:sparse:sparse:context-imbalance-in-rcu_print_task_stall-different-lock-contexts-for-basic-block
|-- sh-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sh-randconfig-s032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-allmodconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-c003-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-p002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r001-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r003-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r006-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-r036-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-s031-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc-randconfig-s032-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc64-randconfig-c004-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- sparc64-randconfig-r013-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-a012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-a014-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-a015-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-a016-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-c002-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-r012-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-r014-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-r021-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-s021-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-randconfig-s022-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|   `-- kernel-rcu-tree_stall.h:sparse:sparse:context-imbalance-in-rcu_print_task_stall-different-lock-contexts-for-basic-block
|-- x86_64-rhel
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- x86_64-rhel-8.3
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- xtensa-allyesconfig
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
|-- xtensa-randconfig-r023-20200925
|   |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
|   `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload
`-- xtensa-randconfig-r032-20200925
    |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_deoffload
    `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-rcu_nocb_cpu_offload

clang_recent_errors
`-- riscv-randconfig-r036-20200923
    |-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-function-rcu_nocb_cpu_deoffload
    `-- kernel-rcu-rcutorture.c:warning:no-previous-prototype-for-function-rcu_nocb_cpu_offload

elapsed time: 726m

configs tested: 144
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
arm                           h5000_defconfig
powerpc                     tqm8540_defconfig
arc                          axs103_defconfig
powerpc                  mpc885_ads_defconfig
i386                                defconfig
mips                           ci20_defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
powerpc                   bluestone_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         hackkit_defconfig
um                           x86_64_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
arc                              alldefconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
arm                           sunxi_defconfig
arm                          imote2_defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
s390                             allyesconfig
sh                          sdk7786_defconfig
arm                          tango4_defconfig
mips                           mtx1_defconfig
m68k                          atari_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
mips                           ip22_defconfig
mips                        nlm_xlp_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
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
x86_64               randconfig-a005-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
