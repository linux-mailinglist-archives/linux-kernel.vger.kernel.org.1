Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472172FC1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbhASUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:55:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:1588 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbhASUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:54:48 -0500
IronPort-SDR: hL+EB672LOhYQzA7+aBRcysFiJJxTge0ebQdAtVvHkJLYGmD6sdu+ippZx7YIlV0ebsGzg4J44
 8s88ZrqLiAWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="178217033"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="gz'50?scan'50,208,50";a="178217033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:53:54 -0800
IronPort-SDR: 8WCq7dKt0f/j0h4pk0S1EzH1iYMLcuQmuNECLqSjJphfS4fU3wiSTDHpLnEP3SEh3Pc8mPVs/m
 rRXdPnzOgA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="gz'50?scan'50,208,50";a="402499094"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2021 12:53:52 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1y0d-0005Lb-R8; Tue, 19 Jan 2021 20:53:51 +0000
Date:   Wed, 20 Jan 2021 04:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/android/binder.c:4585 (null)() warn: inconsistent indenting
Message-ID: <202101200413.7hpEOkgP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e2a199f6ccdc15cf111d68d212e2fd4ce65682e
commit: f3277cbfba763cd2826396521b9296de67cf1bbc binder: fix UAF when releasing todo list
date:   3 months ago
config: nds32-randconfig-m031-20210120 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/android/binder.c:4585 (null)() warn: inconsistent indenting
drivers/android/binder.c:4586 (null)() warn: ignoring unreachable code.

Old smatch warnings:
drivers/android/binder.c:2342 binder_transaction_buffer_release() warn: if();
drivers/android/binder.c:2401 binder_transaction_buffer_release() warn: inconsistent indenting
drivers/android/binder.c:2402 binder_transaction_buffer_release() warn: ignoring unreachable code.
drivers/android/binder.c:4593 (null)() warn: inconsistent indenting
drivers/android/binder.c:4599 (null)() warn: inconsistent indenting
drivers/android/binder.c:4610 (null)() warn: inconsistent indenting
drivers/android/binder.c:4616 (null)() warn: inconsistent indenting
drivers/android/binder.c:5170 binder_mmap() warn: if();

vim +4585 drivers/android/binder.c

355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4562  
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4563  static void binder_release_work(struct binder_proc *proc,
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4564  				struct list_head *list)
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4565  {
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4566  	struct binder_work *w;
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4567  	enum binder_work_type wtype;
10f62861b4a2f22c drivers/staging/android/binder.c Seunghun Lee       2014-05-01  4568  
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4569  	while (1) {
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4570  		binder_inner_proc_lock(proc);
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4571  		w = binder_dequeue_work_head_ilocked(list);
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4572  		wtype = w ? w->type : 0;
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4573  		binder_inner_proc_unlock(proc);
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4574  		if (!w)
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4575  			return;
72196393a5e3d28c drivers/android/binder.c         Todd Kjos          2017-06-29  4576  
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4577  		switch (wtype) {
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4578  		case BINDER_WORK_TRANSACTION: {
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4579  			struct binder_transaction *t;
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4580  
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4581  			t = container_of(w, struct binder_transaction, work);
fb2c445277e7b0b4 drivers/android/binder.c         Martijn Coenen     2017-11-13  4582  
fb2c445277e7b0b4 drivers/android/binder.c         Martijn Coenen     2017-11-13  4583  			binder_cleanup_transaction(t, "process died.",
fb2c445277e7b0b4 drivers/android/binder.c         Martijn Coenen     2017-11-13  4584  						   BR_DEAD_REPLY);
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30 @4585  		} break;
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29 @4586  		case BINDER_WORK_RETURN_ERROR: {
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4587  			struct binder_error *e = container_of(
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4588  					w, struct binder_error, work);
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4589  
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4590  			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4591  				"undelivered TRANSACTION_ERROR: %u\n",
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4592  				e->cmd);
26549d17741035b6 drivers/android/binder.c         Todd Kjos          2017-06-29  4593  		} break;
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4594  		case BINDER_WORK_TRANSACTION_COMPLETE: {
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4595  			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
56b468fc709b2b96 drivers/staging/android/binder.c Anmol Sarma        2012-10-30  4596  				"undelivered TRANSACTION_COMPLETE\n");
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4597  			kfree(w);
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4598  			binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4599  		} break;
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4600  		case BINDER_WORK_DEAD_BINDER_AND_CLEAR:
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4601  		case BINDER_WORK_CLEAR_DEATH_NOTIFICATION: {
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4602  			struct binder_ref_death *death;
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4603  
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4604  			death = container_of(w, struct binder_ref_death, work);
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4605  			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
da49889deb34d351 drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4606  				"undelivered death notification, %016llx\n",
da49889deb34d351 drivers/staging/android/binder.c Arve Hjønnevåg     2014-02-21  4607  				(u64)death->cookie);
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4608  			kfree(death);
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4609  			binder_stats_deleted(BINDER_STAT_DEATH);
675d66b0ed5fd170 drivers/staging/android/binder.c Arve Hjønnevåg     2012-10-16  4610  		} break;
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4611  		case BINDER_WORK_NODE:
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4612  			break;
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4613  		default:
56b468fc709b2b96 drivers/staging/android/binder.c Anmol Sarma        2012-10-30  4614  			pr_err("unexpected work type, %d, not freed\n",
f3277cbfba763cd2 drivers/android/binder.c         Todd Kjos          2020-10-09  4615  			       wtype);
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4616  			break;
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4617  		}
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4618  	}
355b0502f6efea0f drivers/staging/android/binder.c Greg Kroah-Hartman 2011-11-30  4619  

:::::: The code at line 4585 was first introduced by commit
:::::: 355b0502f6efea0ff9492753888772c96972d2a3 Revert "Staging: android: delete android drivers"

:::::: TO: Greg Kroah-Hartman <gregkh@suse.de>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EXtdzhMBAA==

--envbJBWh7q8WU6mo--
