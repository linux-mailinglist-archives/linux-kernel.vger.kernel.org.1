Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09926D741
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIQI6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:58:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:26458 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgIQI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:58:29 -0400
IronPort-SDR: ZorQ1sjcU+t09FxYElDPz0ytegG5heFaU5pz3Wgc2jtfT6OcEfw8CS/P8/HQE9qNIx4thBJWw3
 m9GaBTGfDGmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="160583550"
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="160583550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 01:58:26 -0700
IronPort-SDR: 6mceYQLmUXxkOEmKnrjsjZUn/go8Z0KA4lh5ycJkVeZckn4gciJkI7rZl4tjEUgC0ev5xjqVlX
 HMvcRg/GvEsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="344208885"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2020 01:58:24 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIpkF-0000Vc-Gb; Thu, 17 Sep 2020 08:58:23 +0000
Date:   Thu, 17 Sep 2020 16:57:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.10a] BUILD REGRESSION
 ccb38b2f3e160fbfecedbd0c80bde97a7dfcbdec
Message-ID: <5f6324f3.M/lstAiJtUsyxgyd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.10a
branch HEAD: ccb38b2f3e160fbfecedbd0c80bde97a7dfcbdec  rcutorture: Make grace-period kthread report match RCU flavor being tested

Error/Warning in current branch:

ERROR: modpost: "show_rcu_tasks_rude_gp_kthread" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "show_rcu_tasks_trace_gp_kthread" [kernel/rcu/rcutorture.ko] undefined!
kernel/rcu/rcutorture.c:698:20: error: 'show_rcu_tasks_classic_gp_kthread' undeclared here (not in a function)
kernel/rcu/rcutorture.c:768:20: error: 'show_rcu_tasks_rude_gp_kthread' undeclared here (not in a function)
kernel/rcu/rcutorture.c:807:20: error: 'show_rcu_tasks_trace_gp_kthread' undeclared here (not in a function)
kernel/rcu/tasks.h:1212:2: error: implicit declaration of function 'show_rcu_tasks_generic_gp_kthread'; did you mean 'show_rcu_tasks_classic_gp_kthread'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:1218:20: error: static declaration of 'show_rcu_tasks_trace_gp_kthread' follows non-static declaration
kernel/rcu/tasks.h:574:2: error: implicit declaration of function 'show_rcu_tasks_generic_gp_kthread' [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:574:2: error: implicit declaration of function 'show_rcu_tasks_generic_gp_kthread'; did you mean 'show_rcu_tasks_classic_gp_kthread'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:599:20: error: static declaration of 'show_rcu_tasks_classic_gp_kthread' follows non-static declaration
kernel/rcu/tasks.h:703:2: error: implicit declaration of function 'show_rcu_tasks_generic_gp_kthread' [-Werror,-Wimplicit-function-declaration]
kernel/rcu/tasks.h:703:2: error: implicit declaration of function 'show_rcu_tasks_generic_gp_kthread'; did you mean 'show_rcu_tasks_classic_gp_kthread'? [-Werror=implicit-function-declaration]
kernel/rcu/tasks.h:708:13: error: static declaration of 'show_rcu_tasks_rude_gp_kthread' follows non-static declaration

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r005-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- alpha-randconfig-r015-20200916
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- alpha-randconfig-s032-20200916
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- arc-axs103_smp_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arc-defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arc-nps_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arc-randconfig-r022-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arc-randconfig-r031-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arc-randconfig-s032-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-allmodconfig
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- arm-axm55xx_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-efm32_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-imote2_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-integrator_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-pcm027_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm-randconfig-p001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arm-randconfig-r013-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arm-randconfig-r026-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arm-randconfig-r035-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- arm-trizeps4_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- arm64-defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- c6x-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- c6x-randconfig-c003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- c6x-randconfig-c004-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- c6x-randconfig-r021-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- c6x-randconfig-r024-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- c6x-randconfig-r033-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- c6x-randconfig-r034-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- c6x-randconfig-r035-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- h8300-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- h8300-randconfig-r012-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- h8300-randconfig-r014-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- h8300-randconfig-r025-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- h8300-randconfig-r031-20200916
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- i386-randconfig-a003-20200917
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- i386-randconfig-a004-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-a006-20200916
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- i386-randconfig-a012-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-a013-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- i386-randconfig-a014-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-a016-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-c001-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- i386-randconfig-c003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-r015-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-r031-20200917
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- i386-randconfig-r033-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-s001-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- i386-randconfig-s002-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- ia64-randconfig-r026-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- m68k-allmodconfig
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- m68k-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- m68k-randconfig-r001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- m68k-randconfig-r001-20200917
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- m68k-randconfig-r004-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- m68k-randconfig-r011-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- microblaze-randconfig-c004-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- microblaze-randconfig-r011-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- microblaze-randconfig-r013-20200916
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- microblaze-randconfig-r025-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- microblaze-randconfig-r032-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- microblaze-randconfig-r032-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- mips-allmodconfig
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- mips-cu1830-neo_defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- mips-randconfig-c003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- mips-randconfig-r006-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nds32-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nds32-defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- nds32-randconfig-r003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nds32-randconfig-r034-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nios2-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nios2-randconfig-r001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nios2-randconfig-r006-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- nios2-randconfig-r022-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- nios2-randconfig-r023-20200916
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- nios2-randconfig-r035-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- openrisc-randconfig-p001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- openrisc-randconfig-r006-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- openrisc-randconfig-r031-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- openrisc-randconfig-r035-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- openrisc-randconfig-s031-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- parisc-randconfig-p001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- parisc-randconfig-r013-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|-- parisc-randconfig-r016-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- parisc-randconfig-r024-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- parisc-randconfig-r031-20200916
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- parisc-randconfig-r032-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- powerpc-allmodconfig
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- powerpc-randconfig-r034-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- powerpc64-randconfig-r003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- riscv-allmodconfig
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- riscv-defconfig
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- riscv-randconfig-r013-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- riscv-randconfig-r022-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- riscv-randconfig-r032-20200916
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- riscv-randconfig-s031-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- s390-defconfig
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- s390-randconfig-p002-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- s390-randconfig-r005-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- sh-allmodconfig
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_classic_gp_kthread-undeclared-here-(not-in-a-function)
|   |-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_rude_gp_kthread-undeclared-here-(not-in-a-function)
|   `-- kernel-rcu-rcutorture.c:error:show_rcu_tasks_trace_gp_kthread-undeclared-here-(not-in-a-function)
|-- sh-randconfig-c003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sh-randconfig-p001-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- sparc-randconfig-r005-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sparc-randconfig-r032-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sparc64-randconfig-p002-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sparc64-randconfig-r016-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sparc64-randconfig-r022-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- sparc64-randconfig-r024-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- sparc64-randconfig-r034-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-kexec
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a001-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-randconfig-a002-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a003-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-randconfig-a006-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-randconfig-a011-20200917
|   |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a013-20200917
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-m001-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-randconfig-r002-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-s021-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_classic_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-s022-20200916
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-randconfig-s031-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- x86_64-rhel
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- x86_64-rhel-7.6-kselftests
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-rhel-8.3
|   |-- ERROR:show_rcu_tasks_rude_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:show_rcu_tasks_trace_gp_kthread-kernel-rcu-rcutorture.ko-undefined
|-- xtensa-allyesconfig
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- xtensa-randconfig-r015-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
|-- xtensa-randconfig-r016-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- xtensa-randconfig-r026-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread
`-- xtensa-randconfig-r026-20200917
    `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread

clang_recent_errors
|-- arm-randconfig-r004-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread-Werror-Wimplicit-function-declaration
|-- arm-randconfig-r031-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- powerpc-randconfig-r012-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- powerpc-randconfig-r021-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a001-20200917
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a003-20200917
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a004-20200917
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a005-20200917
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a012-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a013-20200916
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
|-- x86_64-randconfig-a014-20200916
|   `-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread-Werror-Wimplicit-function-declaration
|-- x86_64-randconfig-a015-20200916
|   |-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_rude_gp_kthread-follows-non-static-declaration
|   `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration
`-- x86_64-randconfig-r002-20200917
    |-- kernel-rcu-tasks.h:error:implicit-declaration-of-function-show_rcu_tasks_generic_gp_kthread-Werror-Wimplicit-function-declaration
    `-- kernel-rcu-tasks.h:error:static-declaration-of-show_rcu_tasks_trace_gp_kthread-follows-non-static-declaration

elapsed time: 987m

configs tested: 134
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     decstation_defconfig
mips                      malta_kvm_defconfig
sh                        sh7763rdp_defconfig
arm                          pcm027_defconfig
powerpc                  storcenter_defconfig
mips                         cobalt_defconfig
m68k                             alldefconfig
sh                   sh7724_generic_defconfig
mips                          malta_defconfig
m68k                          sun3x_defconfig
sh                        edosk7705_defconfig
powerpc                      chrp32_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
powerpc                    sam440ep_defconfig
arm                         axm55xx_defconfig
arm                         at91_dt_defconfig
powerpc                     kilauea_defconfig
arm                          imote2_defconfig
parisc                           allyesconfig
powerpc                  mpc885_ads_defconfig
nios2                            allyesconfig
arm                           sama5_defconfig
sh                ecovec24-romimage_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arc                             nps_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
powerpc                  mpc866_ads_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
alpha                               defconfig
arc                      axs103_smp_defconfig
powerpc                   lite5200b_defconfig
sh                           se7343_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                          iss_defconfig
ia64                            zx1_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
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
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
