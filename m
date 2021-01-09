Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598D2EFE55
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAIHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 02:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbhAIHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 02:46:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B7BC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 23:45:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so6890888plk.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF8wwaa/cVvmvlFINdzkMrYN3OctWp3ZZ74ZzUuB7Y4=;
        b=cqxRtixQocDt6H20SQxC4dCcWtSK6WR1GGxn2YQYZgpP8eN95C1neXZ2KjYHJgnu2a
         G649R6nxcsv3CeC4TsZVnEvjKuTNKruZ8lf6tTGJv+bQfU8WNmn2b2Q6CCKd3LbjVY2w
         t5/wKguOApM1ZgX2Ab15JgBtF7TyfGwfQXY1w6GlvP9zMOaPcZPjgZxZHC6YtsM29L0c
         iu7YhERUeE426puzBcZIdYdCzl5aP0YwKZaO5JubKZ9Osu2UhK1xO67p1qy31ftZKZyz
         TUScImZSB1JP0cu1Fn+FMw9ZGNq9M4k1pZHF8mBbGYu3Qlahrp0YLeS6KhGw7ITL452h
         82bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF8wwaa/cVvmvlFINdzkMrYN3OctWp3ZZ74ZzUuB7Y4=;
        b=YlXJ2rv7Y4dFf96IXKu7yvHeq6KLN5NLGpLkDBBYzbOZP/hGcWX8f8xmWwJ9GK4WDq
         ZOoxwtwNwTZj5M1SuxlpRM+XTumr6MSdOg8ol98NmBDy2FWrNFEbMHDUhfLXgb2zbNdP
         sMAylvXjI8tmrz9emK5h937d2g25134cwREim6AzhKEUiD34VuBUMn9I6zb1DzKurpe8
         4TwFuoWsvykTF3HX3JT4zrN0Z0W+EPiKG8ZHWX2STf9QxqH/CK7zJk/3Hq22YcjMs8FK
         oxIq0u/MkvZBoXP8zCOmL3/XcEOq2/FRJfVhS526BEoshvx9kOfR3Ovhw8Z93+XMiNFZ
         IP5A==
X-Gm-Message-State: AOAM5307KHwdF9owfpEVbQphQjwCphfgogW7Pubf9DcUh3fEA4f9q3qr
        FKWaeZf9dVTznPmPsLqVD+za7Q==
X-Google-Smtp-Source: ABdhPJxgYDHASWS5ekABCpRPD0n++0E+SuyZ8clpRqHh2VNtV+fe44eSrdVzOb7bQHO5EUYKol4BkA==
X-Received: by 2002:a17:90a:7844:: with SMTP id y4mr7738077pjl.68.1610178313429;
        Fri, 08 Jan 2021 23:45:13 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id p21sm11056872pfn.15.2021.01.08.23.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 23:45:12 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 6/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Date:   Sat,  9 Jan 2021 15:44:34 +0800
Message-Id: <20210109074435.626855-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210109074435.626855-1-leo.yan@linaro.org>
References: <20210109074435.626855-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds helper function cs_etm__get_pid_fmt(), by passing
parameter "traceID", it returns the corresponding PID format.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 18 ++++++++++++++++++
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8c125134a756..6705d39c8cee 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -157,6 +157,24 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 	return 0;
 }
 
+int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
+{
+	struct int_node *inode;
+	u64 *metadata;
+
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return -EINVAL;
+
+	metadata = inode->priv;
+	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
+		*pid_fmt = metadata[CS_ETM_PID_FMT];
+	else
+		*pid_fmt = metadata[CS_ETMV4_PID_FMT];
+
+	return 0;
+}
+
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id)
 {
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 8cbbea6100a1..98801040175f 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -175,6 +175,7 @@ struct cs_etm_packet_queue {
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
-- 
2.25.1

