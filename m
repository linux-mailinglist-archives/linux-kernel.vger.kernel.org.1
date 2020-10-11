Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC728A74B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 14:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgJKMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 08:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbgJKMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 08:10:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E25C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 05:10:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so11333620pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bjCClCxGzWPbX46LvzEEkxmiEn4tAueHmmW2QidcQvg=;
        b=LIL9J3dhGlUN+Okgj/fN1D5+eA5lgGiSXC1hRNZZRKCdaRFaoNk1yPZCUNJk0EMbEm
         b0TnfMwCPxNxwmvs7faJsXW488favsgqCBllOURPZtIZlZupHgM5w+OBHn8M7aWrH+HO
         U1wdkN+wMAlZtuzFpUAx2W0IU1g5NOvEhsO72MwA/9WoDYCCCIsYz/O5ptRIhxhp4I7T
         RKneEtxch9PI2UaWEpoqu1ri1STpRPJ826j7TVZjkLYpEHDHz+y58IN/iXttSXAOP+oy
         8+KnzfGTlgkoUpsjcDVY8wns9htpLGdkLgaYWXGeXkVsjc4FD1myQ6IQXo3e8jgHHTgc
         Q7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bjCClCxGzWPbX46LvzEEkxmiEn4tAueHmmW2QidcQvg=;
        b=qDguS3po329g3qlleELGdw2neGuQVgGgdSmZ3Mll2W2IKfMDGXBum032nsvHHvb2e5
         ZDInk/+5P3dBkHJTcklOXxZ6WV2FohB2mut3/BQDBYjNnn1jwohsuasgIuHIP4Sm7225
         G9ckw5KezB7DsFgNudaHkdleS0iqXGD8bn+UqUHTakrQHEkJXAWcqWfDofGk6EjAEArC
         KKEae8g+/0XV9HtNWiWDOMB6RYq5UKe5Bpb/FRqLoXWf6v/SNZu51dGpjRG+oY61qkKo
         53ZXTLXABD//VXnGs/iBVvWpPijDOO1mQMGgQJbkriWqMDIHrJ92IWx3qoxDldFdPpiY
         mmug==
X-Gm-Message-State: AOAM533TBh3oMZLbIQnXB5S65fUweLt9ImPE8UP9QVGEiTwuYBMQRXe7
        PhizHQ8JEJLvU+6LkX91TqT5ZQ==
X-Google-Smtp-Source: ABdhPJzG9kQg717Sjx3VqbbTqZgRg0FxyZZ7OoYiGqOng6+mORE0YL24vfKLdSLqSahW/7559duFXg==
X-Received: by 2002:a17:90a:6fe5:: with SMTP id e92mr14477556pjk.98.1602418242991;
        Sun, 11 Oct 2020 05:10:42 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e1sm15318819pjv.2.2020.10.11.05.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 05:10:42 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf c2c: Update usage for showing memory events
Date:   Sun, 11 Oct 2020 20:10:22 +0800
Message-Id: <20201011121022.22409-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b027cc6fdf1b ("perf c2c: Fix 'perf c2c record -e list' to
show the default events used"), "perf c2c" tool can show the memory
events properly, it's no reason to still suggest user to use the
command "perf mem record -e list" for showing events.

This patch updates the usage for showing memory events with command
"perf c2c record -e list".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5938b100eaf4..57bb6cce43e3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2916,7 +2916,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	bool event_set = false;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &event_set, "event",
-		     "event selector. Use 'perf mem record -e list' to list available events",
+		     "event selector. Use 'perf c2c record -e list' to list available events",
 		     parse_record_events),
 	OPT_BOOLEAN('u', "all-user", &all_user, "collect only user level data"),
 	OPT_BOOLEAN('k', "all-kernel", &all_kernel, "collect only kernel level data"),
-- 
2.17.1

