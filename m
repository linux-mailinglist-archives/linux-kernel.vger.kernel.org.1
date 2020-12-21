Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403DA2DFA02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLUIh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLUIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:37:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D357C0611C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v1so5763178pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cQl+8W7T7tTQ1cOiJvQBRsmZmi9EppC/6vnqtfyVSUo=;
        b=CoQJxfdSlQKurIlH4UcSoiA0bl+E2TeAHgja/GCSohC2Y8Pp/5OTOb2fPizlZc78o4
         2U2CaJIyLiWURMjNj6xP+OV7ro3I9YtWF1uSo/8oqSm2LB+/FIVixeHdDWWyikkMzjUP
         hTYBcQC6bZxD2NAtaypG18U9Nvo4DlpEQuDsAuAyvcnLXGdULZe+51NVO1LtMW1qZvrv
         AaR5/+bqDZ8lsGEQLsu9c9eP/inCQ8T2q1jVFlSGv+oau2yWV43ZG0WvBFobby/+HDDK
         zIJRss9AQCDDSCs4ztNPsyhTKcyWwSoP7h2+QWjwFYlYitJPYAvxabaMdcmyXUUBg0Uu
         ushA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cQl+8W7T7tTQ1cOiJvQBRsmZmi9EppC/6vnqtfyVSUo=;
        b=KFwwbZZERnz0q5gOnRczCwhiKQ19sYvxXniFLeHWnf4d35ktWkNMfsbgf4tp6L2aBj
         tIT0Odd1sKSpNmZ3Rm6+BaXfAvay5+8CojTVi8KqPXoorOUSQ1nBtFyEtr2mGuSZX5lJ
         kLE5URNEhokWZgvSmUEcpVEUUmbpU9Z6tQKxKjdhNoQ/fuJe7Pvjrxs9U1U5cBd/A4yj
         rPoGuDOWfBwlqVl+r+86O3vyIyeQjAZC0ftWs9/+EM6SU2yzarDcdb3SVgvtFLbDL2cy
         VQ+TpQJGk7VtSUAkrTgdwu+nJEpzrGCNP8v9hwa/KKNU/khPdERq9LlnsVk9QNKQHNf5
         gtKw==
X-Gm-Message-State: AOAM533wBmkMiBgya1amtMODekeCDeRDJ1PT3izYI0tV2NieJdd5IDbe
        lpLwEEVpUhfCCEZuOqPs6ezF/A==
X-Google-Smtp-Source: ABdhPJzBx2ixz0DbLN07bvvSew+iXdyFTT5mNnybYL6qzxpsITIhlTqZJErQWoYJwH9yj998yoGvYg==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr16360060pjt.8.1608539834196;
        Mon, 21 Dec 2020 00:37:14 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id gb9sm1002019pjb.40.2020.12.21.00.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:13 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/7] perf arm-spe: Assign kernel time to synthesized event
Date:   Mon, 21 Dec 2020 16:35:55 +0800
Message-Id: <20201221083557.27642-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, it assigns the arch timer counter to the synthesized
samples Arm SPE trace, thus the samples don't contain the kernel time
but only contain the raw counter value.

To fix the issue, this patch converts the timer counter to kernel time
and assigns it to sample timestamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index bc512c3479f7..2b008b973387 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -232,7 +232,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	struct arm_spe_record *record = &speq->decoder->record;
 
 	if (!spe->timeless_decoding)
-		sample->time = speq->timestamp;
+		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
 
 	sample->ip = record->from_ip;
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
-- 
2.17.1

