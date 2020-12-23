Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C922E190D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgLWGkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLWGki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:40:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC5C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so4222835plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 22:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=467lFgAtQsgtCwBZ9cW2L8IHsN+b1oJWtlD6IzgSFFI=;
        b=d446zeA4uH4Y0+x1O/BSppDYUxhtb4x78BQy3xs5EDDCtPXSh52bztqT5GIQZkXVHD
         xuVbJckUmaSYlS/CyspydhE6GI43ARrWGBXGmnZf8FA68nvi/vPlwJ1DqkVk/rdyWlQ6
         nKiyCNdzR+KMe7yLAtOHF6ZtLCxWW+AAkWK9ZiutTajOwvKtrao6T/2pM12psw7WzSm+
         Xquy8qyKaoVf1rlWuCG3sit+gTYJTRZQxBhDIxbuu9yCThsETHBSdFnjtME5JwcDREx7
         7WWqij9dekWvUFsiidbDV9toS/0lsl1vExeXDw/Eo/E5tz4q8nfVbd2wM36kD4Kuy7Ro
         300Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=467lFgAtQsgtCwBZ9cW2L8IHsN+b1oJWtlD6IzgSFFI=;
        b=cYHmlQSv5ShamGAxXPoQtw3Jq6KXAiKO/10I34+El27gQw4PF1a6bD26KICks/hyKO
         kszFKn+gAMClTnYRNw3FMSWTgDJPx5+RK5+zSv+oDg3Pv+Wpt2X7NRX2uHnJZYqzogXq
         ICSwRZf0KbvwSxboWjWiIIuYGLZhM4XJbbeJ+D+tuIsp5mBmgDvObyqMwljIbGZPHrwP
         +IDgMrjt8KcH5TxFjKZOycOm+XgKydmVvxZzmlJTpNnNqy1MncdiJ0dG1sSVy5XNJvcY
         f9k/LtojL9JA5nGMXj/eTTGnuLEQj9e5GnGQMRpIqCzYuPcu5FCulAjbdyIejbSHn4Oq
         fC5Q==
X-Gm-Message-State: AOAM532ozMbl8KOywX761PO+V7uMqSx3V7w2q49rM//y747pO0gjqsTS
        tsL0Y007rXymVkqtcRmVfwRNmQ==
X-Google-Smtp-Source: ABdhPJwzDH6uuTjVup7Xb65qTxOPldy6fSUD2MrRS5KkW93S9TDqr9xamcozg8/9O3NB277Gs3DboQ==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr24721470pjq.21.1608705597984;
        Tue, 22 Dec 2020 22:39:57 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id x12sm22519430pgf.13.2020.12.22.22.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Dec 2020 22:39:57 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf arm64: Add argument support for SDT
Date:   Wed, 23 Dec 2020 14:39:05 +0800
Message-Id: <20201223063905.25784-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223063905.25784-1-leo.yan@linaro.org>
References: <20201223063905.25784-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the two OP formats are used for SDT marker argument in Arm64 ELF,
one format is genreal register xNUM (e.g. x1, x2, etc), another is for
using stack pointer to access local variables (e.g. [sp], [sp, 8]).

This patch adds support SDT marker argument for Arm64, it parses OP and
converts to uprobe compatible format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/perf_regs.c | 94 ++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/perf/arch/arm64/util/perf_regs.c b/tools/perf/arch/arm64/util/perf_regs.c
index 54efa12fdbea..6b4b18283041 100644
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
+/* [sp], [sp, NUM] or [sp,NUM] */
+#define SDT_OP_REGEX2  "^\\[sp(, *)?([0-9]+)?\\]$"
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

