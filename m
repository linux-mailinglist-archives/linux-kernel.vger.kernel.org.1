Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D894C1B2451
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgDUKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 06:50:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:12785 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUKuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:50:00 -0400
IronPort-SDR: rXYLHfoZ9m0r0WXb+yCRQASGRuGOubbfK7rvLH3/KRmuLiQMjkV/5ea10ubLrw7MPCsNoQLiNp
 5msFJ4MMjohQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 03:49:59 -0700
IronPort-SDR: bIZwYTysqpJ2YziHJ4mCUKfCOuUQQ6JRXs+0+eS3ychRYrpQqvBRt467vNlybSUYb/myyguePQ
 fLr6fZLsYmpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="456058639"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2020 03:49:56 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][v3] sched: Clean up newidle_balance() and pick_next_task()
Date:   Tue, 21 Apr 2020 18:48:47 +0800
Message-Id: <cover.1587464698.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Peter suggested, here are two minor code clean up in the scheduler:
1. turn newidle_balance() into a static function.
2. code extraction in pick_next_task() for future re-use.

Chen Yu (2):
  sched: Make newidle_balance() static again
  sched: Extract the task putting code from pick_next_task()

 kernel/sched/core.c  | 39 +++++++++++++++++++++++----------------
 kernel/sched/fair.c  |  6 ++++--
 kernel/sched/sched.h |  4 ----
 3 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.17.1

