Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63CE27A226
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgI0R4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:56:45 -0400
Received: from m12-12.163.com ([220.181.12.12]:48604 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgI0R4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:56:45 -0400
X-Greylist: delayed 5956 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 13:56:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=gwLq6
        F0IGV2h9FguJGAL8rqUYLvvKr2EmAfRFumx4M4=; b=mMJVqSiZxS1p5QE2If58u
        NqKwK+39jW9zg1f1U5JtaUzneO8wLg59GfvTvyV4SmvCh5/5iT/6NV0g7jVJBnqd
        VKhCHHZqUOe8lkx1fJQjaom2dP/e+fZIuuQQVEWrvsjwZndwyMvabfXe5eRW5WtF
        fsYX09kRYAXRwvHVUEdo18=
Received: from localhost (unknown [101.86.214.224])
        by smtp8 (Coremail) with SMTP id DMCowACHJd4Qx3BfygQRPQ--.48802S2;
        Mon, 28 Sep 2020 01:08:32 +0800 (CST)
Date:   Mon, 28 Sep 2020 01:08:32 +0800
From:   Hui Su <sh_def@163.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86: fix the comment of perf_sched_init()
Message-ID: <20200927170832.GA6243@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowACHJd4Qx3BfygQRPQ--.48802S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1UArWfZr43CF43KFyDKFg_yoWxtrc_W3
        W7W3yqqr4rt3sxt34jkF45XF13Za9Fga1ftr10qF1Ut34Dta45Cr1kKry7A348ArsxZFWx
        GrZagr1Yvw42kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn90ePUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIBCsX10TBh3e0wAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the comment of perf_sched_init():
interator --> iterator

Signed-off-by: Hui Su <sh_def@163.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1cbf57dc2ac8..74d430b31d78 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -719,7 +719,7 @@ struct perf_sched {
 };
 
 /*
- * Initialize interator that runs through all events and counters.
+ * Initialize iterator that runs through all events and counters.
  */
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
 			    int num, int wmin, int wmax, int gpmax)
-- 
2.25.1


