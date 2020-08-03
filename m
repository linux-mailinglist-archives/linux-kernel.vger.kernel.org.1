Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6668D239D24
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 02:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHCA5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 20:57:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgHCA5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:57:09 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11092ABB9F2F3570F786;
        Mon,  3 Aug 2020 08:57:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 08:56:58 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <acme@kernel.org>, <irogers@google.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
Date:   Mon, 3 Aug 2020 08:56:29 +0800
Message-ID: <20200803005629.40651-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function jvmti_write_code called by compiled_method_load_cb may return
error in using fwrite_unlocked, this failure should be captured and
warned.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/perf/jvmti/jvmti_agent.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 88108598d6e9..dfb6cb8564cb 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
 	struct jr_code_load rec;
 	size_t sym_len;
 	FILE *fp = agent;
-	int ret = -1;
+	int sret;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -400,17 +400,24 @@ jvmti_write_code(void *agent, char const *sym,
 	 */
 	rec.code_index = code_generation++;
 
-	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
-	fwrite_unlocked(sym, sym_len, 1, fp);
+	sret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
+	if (sret != 1)
+		goto error;
+	sret = fwrite_unlocked(sym, sym_len, 1, fp);
+	if (sret != 1)
+		goto error;
 
-	if (code)
-		fwrite_unlocked(code, size, 1, fp);
+	if (code) {
+		sret = fwrite_unlocked(code, size, 1, fp);
+		if (sret != 1)
+			goto error;
+	}
 
 	funlockfile(fp);
-
-	ret = 0;
-
-	return ret;
+	return 0;
+error:
+	funlockfile(fp);
+	return -1;
 }
 
 int
-- 
2.25.1

