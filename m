Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B219E1F8C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFOBgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 21:36:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728032AbgFOBgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:36:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E68481E5B08BA2A3E80F;
        Mon, 15 Jun 2020 09:36:40 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 15 Jun 2020 09:36:32 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <Markus.Elfring@web.de>, <cj.chengjian@huawei.com>,
        <chenwandun@huawei.com>
Subject: [PATCH next v3 1/2] perf tools: fix potential memleak in perf events parser
Date:   Mon, 15 Jun 2020 09:36:13 +0800
Message-ID: <20200615013614.8646-2-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615013614.8646-1-chenwandun@huawei.com>
References: <20200615013614.8646-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

Fix memory leak of in function parse_events_term__sym_hw()
and parse_events_term__clone() when string duplication failed.

Fixes: b6645a723595 ("perf parse: Ensure config and str in terms are unique")
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 tools/perf/util/parse-events.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3decbb203846..6f4dc8a92817 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2957,8 +2957,12 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 	sym = &event_symbols_hw[idx];
 
 	str = strdup(sym->symbol);
-	if (!str)
+	if (!str) {
+		if (!config)
+			free(temp.config);
 		return -ENOMEM;
+	}
+
 	return new_term(term, &temp, str, 0);
 }
 
@@ -2983,8 +2987,12 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		if (term->config)
+			free(temp.config);
 		return -ENOMEM;
+	}
+
 	return new_term(new, &temp, str, 0);
 }
 
-- 
2.17.1

