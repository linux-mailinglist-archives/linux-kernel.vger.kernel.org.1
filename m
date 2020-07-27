Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59B22FE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG0Xz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgG0Xz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:55:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A336521744;
        Mon, 27 Jul 2020 23:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894126;
        bh=Xembc9dQ8yhlgzOVMOC2fFG1tNs/RdV/1tNnSRkgMtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDBV3X7yDRkwB/WvcqzUHljBjiz/lmYYobbY3bGZxNHcMCEXaS+OsXRjpimZYcm8v
         OXjlJeTsW8gyrZXBUngSaFRZozmITIgTsQUKE4n+pAb+ePM474uRvJa81g9MdyLrMF
         natG8kkzgBq7kzUl6eFfG9VYLxUfnNor5WpSIHm0=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, bigeasy@linutronix.de, frederic@kernel.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH smp v2 3/3] smp: Make symbol 'csd_bug_count' static
Date:   Mon, 27 Jul 2020 16:55:24 -0700
Message-Id: <20200727235524.828-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200727235343.GA30963@paulmck-ThinkPad-P72>
References: <20200727235343.GA30963@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

kernel/smp.c:107:10: warning:
 symbol 'csd_bug_count' was not declared. Should it be static?

Because variable is not used outside of smp.c, this commit marks it
static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 3830f93..33036d9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -106,7 +106,7 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
 
 #define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
-atomic_t csd_bug_count = ATOMIC_INIT(0);
+static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void csd_lock_record(call_single_data_t *csd)
-- 
2.9.5

