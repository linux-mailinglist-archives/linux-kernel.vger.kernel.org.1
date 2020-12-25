Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023432E29E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 06:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgLYF2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 00:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgLYF2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 00:28:54 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D698C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:14 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n7so2679772pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxEw73aH8htDNc2tPH/epFrL2eOdsg6Hp+cPBazlzqE=;
        b=BhA2tHDLnHDPPgpjtgASdT3Z6FwgjaCYNFHye6ROWmX8IpKNd+66sfLwRoMSGUAR6Z
         D/mpTUIIsu4aC6DaBVTsWkP8/Vb7nBiKTcdz286Qs4w11XfFTQh+h8hgJBjyOgWW7pfs
         n6c8pFULCW0aBQWnUAK1KOFfBDlELmjr7bDovUpF2QmNk5LhJ82JC6KUC6ss7le7qzw0
         FMZwZMotPWVvRE6p+8FNoXSpYe6EpqQBWmFupZI4ypo1tMf1I3R6CuoxgnYGxjb+cTbM
         wWgxqFc4XhKpFcREb2KyWUGvBhTz1ue+L0/aUFIV/zSBQkMCbKn4A4rXDaGwrtY4IJVf
         k32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxEw73aH8htDNc2tPH/epFrL2eOdsg6Hp+cPBazlzqE=;
        b=Khl26A9HD0m61i1YAbmDFTu4oWXmA+OFeyfFKpl2eqGTDByYpvCFszSIypik7BvzLz
         EI1ICrZFu2Ade9z2V2ar50J/5q7gl4VPxAXWHfJqvkkyIb+wR41776drB1n447asmAZF
         P+Z4Hsm0cQiacACMxlzj1E5hX2gnByZWuMDKHJcRfKCIuBz3VuqcxnFkYZ7LU6EKTmaI
         MCMRimi83kTIG/OsojLixtZ21Dxk8oqHU/MqUTMCD2UTCZbxh8tysZqnSfa0NXZdKRLW
         NpEgx/XQnWfibrC53+oBVP0DOsEbHOBOzZL6EydURcuw4eqHjGNXAcWl/DlhPdeax4kb
         mGXQ==
X-Gm-Message-State: AOAM532f5OgrNoNCw+yc6IwYz4IAZbnYm4T3mDCXYCYEm2aMrmK8A7up
        lN/eaHbbHuTRz6IKl6MIZwSdNQ==
X-Google-Smtp-Source: ABdhPJzFrfFhDXrOAD8lhm8vjoUNQDaoWG/S0zkZlpElQjhLJdBlklM7vJDWIGGuCqZfZ0bc+fvz/w==
X-Received: by 2002:a63:da4e:: with SMTP id l14mr13737064pgj.248.1608874093876;
        Thu, 24 Dec 2020 21:28:13 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id l11sm29184800pgt.79.2020.12.24.21.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 21:28:13 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        He Zhe <zhe.he@windriver.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/3] perf arm64: Add argument support for SDT
Date:   Fri, 25 Dec 2020 13:27:51 +0800
Message-Id: <20201225052751.24513-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201225052751.24513-1-leo.yan@linaro.org>
References: <20201225052751.24513-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the two OP formats are used for SDT marker argument in Arm64 ELF,
one format is general register xNUM (e.g. x1, x2, etc), another is for
using stack pointer to access local variables (e.g. [sp], [sp, 8]).

This patch adds support SDT marker argument for Arm64, it parses OP and
converts to uprobe compatible format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/arch/arm64/util/perf_regs.c | 94 ++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 54efa12fdbea..2518cde18b34 100644
--- a/tools/perf/arch/arm64/util/perf_regs.c
+++ b/tools/perf/arch/arm64/util/perf_regs.c
@@ -1,4 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <regex.h>
+#include <string.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+
+#include "../../../util/debug.h"
+#include "../../../util/event.h"
 #include "../../../util/perf_regs.h"
 
 const struct sample_reg sample_reg_masks[] = {
@@ -37,3 +45,89 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(pc, PERF_REG_ARM64_PC),
 	SMPL_REG_END
 };
+
+/* %xNUM */
+#define SDT_OP_REGEX1  "^(x[1-2]?[0-9]|3[0-1])$"
+
+/* [sp], [sp, NUM] */
+#define SDT_OP_REGEX2  "^\\[sp(, )?([0-9]+)?\\]$"
+
+static regex_t sdt_op_regex1, sdt_op_regex2;
+
+static int sdt_init_op_regex(void)
+{
+	static int initialized;
+	int ret = 0;
+
+	if (initialized)
+		return 0;
+
+	ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
+	if (ret)
+		goto error;
+
+	ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
+	if (ret)
+		goto free_regex1;
+
+	initialized = 1;
+	return 0;
+
+free_regex1:
+	regfree(&sdt_op_regex1);
+error:
+	pr_debug4("Regex compilation error.\n");
+	return ret;
+}
+
+/*
+ * SDT marker arguments on Arm64 uses %xREG or [sp, NUM], currently
+ * support these two formats.
+ */
+int arch_sdt_arg_parse_op(char *old_op, char **new_op)
+{
+	int ret, new_len;
+	regmatch_t rm[5];
+
+	ret = sdt_init_op_regex();
+	if (ret < 0)
+		return ret;
+
+	if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
+		/* Extract xNUM */
+		new_len = 2;	/* % NULL */
+		new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		scnprintf(*new_op, new_len, "%%%.*s",
+			(int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
+	} else if (!regexec(&sdt_op_regex2, old_op, 5, rm, 0)) {
+		/* [sp], [sp, NUM] or [sp,NUM] */
+		new_len = 7;	/* + ( % s p ) NULL */
+
+		/* If the arugment is [sp], need to fill offset '0' */
+		if (rm[2].rm_so == -1)
+			new_len += 1;
+		else
+			new_len += (int)(rm[2].rm_eo - rm[2].rm_so);
+
+		*new_op = zalloc(new_len);
+		if (!*new_op)
+			return -ENOMEM;
+
+		if (rm[2].rm_so == -1)
+			scnprintf(*new_op, new_len, "+0(%%sp)");
+		else
+			scnprintf(*new_op, new_len, "+%.*s(%%sp)",
+				  (int)(rm[2].rm_eo - rm[2].rm_so),
+				  old_op + rm[2].rm_so);
+	} else {
+		pr_debug4("Skipping unsupported SDT argument: %s\n", old_op);
+		return SDT_ARG_SKIP;
+	}
+
+	return SDT_ARG_VALID;
+}
-- 
2.17.1

