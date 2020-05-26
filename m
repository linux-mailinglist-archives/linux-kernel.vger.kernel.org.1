Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA21AFC01
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDSQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 12:31:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:33454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgDSQbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:31:06 -0400
IronPort-SDR: URu+Zj8Zw//h0nulDAtxzqs3xOjybNQWZPjC3Y3ndpmUGhqAga0eA/TuPIFUXpGqHrLbuHd48Z
 0iHZHbAt1Bpw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 09:31:05 -0700
IronPort-SDR: cDj466ESEicSNpCnZq11rUfjvRzpbm1kby5Rco7dNvhFBe4Jmb+r8Al/0O7/Bz++7AnnDCDTcv
 gT/z4frZkL4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,403,1580803200"; 
   d="scan'208";a="300079018"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2020 09:31:03 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] sched: Clean up newidle_balance() and pick_next_task()
Date:   Mon, 20 Apr 2020 00:31:30 +0800
Message-Id: <cover.1587309963.git.yu.c.chen@intel.com>
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
  sched: Extract the code to put previous task in pick_next_task()

 kernel/sched/core.c  | 39 +++++++++++++++++++++++----------------
 kernel/sched/fair.c  |  4 +++-
 kernel/sched/sched.h |  4 ----
 3 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.20.1

