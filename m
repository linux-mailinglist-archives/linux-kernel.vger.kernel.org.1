Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB32137AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGCJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 05:29:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgGCJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:29:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 180C814964524D981A9D;
        Fri,  3 Jul 2020 17:29:09 +0800 (CST)
Received: from huawei.com (10.175.113.25) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Jul 2020
 17:29:02 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <zhengzengkai@huawei.com>
Subject: [PATCH -next] perf util: Fix memory leak in __parse_regs()
Date:   Fri, 3 Jul 2020 17:33:44 +0800
Message-ID: <20200703093344.189450-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when using perf record option '-I' or '--user-regs='
along with argument '?' to list available register names,
memory of variable 'os' allocated by strdup() needs to be released
before __parse_regs() returns, otherwise memory leak will occur.

Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 tools/perf/util/parse-regs-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index e687497b3aac..a4a100425b3a 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -54,7 +54,7 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 #endif
 				fputc('\n', stderr);
 				/* just printing available regs */
-				return -1;
+				goto error;
 			}
 #ifdef HAVE_PERF_REGS_SUPPORT
 			for (r = sample_reg_masks; r->name; r++) {
-- 
2.20.1

