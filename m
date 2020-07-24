Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4061D22C2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgGXKHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 06:07:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXKHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:07:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 32FFDFAD88DD2DE5C59D;
        Fri, 24 Jul 2020 18:07:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 18:07:23 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <jolsa@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH -next] tools build: Check return value of fwrite_unlocked in jvmti_agent.c
Date:   Fri, 24 Jul 2020 18:07:06 +0800
Message-ID: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
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
 tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 88108598d6e9..a1fe6aa16b6d 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
 	struct jr_code_load rec;
 	size_t sym_len;
 	FILE *fp = agent;
-	int ret = -1;
+	int ret;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
 	rec.code_index = code_generation++;
 
 	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
-	fwrite_unlocked(sym, sym_len, 1, fp);
+	if (ret)
+		goto error;
+	ret = fwrite_unlocked(sym, sym_len, 1, fp);
+	if (ret)
+		goto error;
 
-	if (code)
-		fwrite_unlocked(code, size, 1, fp);
+	if (code) {
+		ret = fwrite_unlocked(code, size, 1, fp);
+		if (ret)
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
2.17.1

