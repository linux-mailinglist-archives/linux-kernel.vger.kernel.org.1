Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD71B8FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDZMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 08:32:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbgDZMcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:32:00 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DAC4EB289B124920F9A9;
        Sun, 26 Apr 2020 20:31:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sun, 26 Apr 2020 20:31:46 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] perf report: fix warning Comparison of 0/1 to bool variable
Date:   Sun, 26 Apr 2020 20:38:03 +0800
Message-ID: <1587904683-3510-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

tools/perf/builtin-report.c:1403:2-34: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 26d8fc2..02c09fd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1400,7 +1400,7 @@ int cmd_report(int argc, const char **argv)
 	}
 	if (branch_call_mode) {
 		callchain_param.key = CCKEY_ADDRESS;
-		callchain_param.branch_callstack = 1;
+		callchain_param.branch_callstack = true;
 		symbol_conf.use_callchain = true;
 		callchain_register_param(&callchain_param);
 		if (sort_order == NULL)
-- 
2.6.2

