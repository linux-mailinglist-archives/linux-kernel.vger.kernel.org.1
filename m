Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E42DFA03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgLUIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLUIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:38:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D547C0611CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t6so5260608plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b41ba1W2ldSG8KVAp1Q9RnWVHFezJ/i7w5LipFnjCC4=;
        b=tp7l5aUBba2mqatBtxBI1D8MVFq38CUJzZvJY8uMXHtt/XBBulxtQv3L4y3LZNXJIK
         E6XgRoDZNyEv6VAptUYRtfwYFsF7lW6n6DeH+7W0cTPdhkmxKkRCmED4PW4TodEhK3ZU
         d42Ycj+EP4rwtHWMuxe304024Be28cvX++GFOYq74mc2ubeaH8zWR1AmpYF1y765IEDh
         ql9wgR6N1jBQ45zdHDbyJAH3AwAMdjTv6W28dtR2v4kz39SzlGHdg5MA/cTIHIv9IB0R
         biZtL0WRhmNgkRRQ80HSgP+fNlZJ1c9aLFSrboOnU3+3x54JV/azJiaMEI/pTHbBy413
         Kllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b41ba1W2ldSG8KVAp1Q9RnWVHFezJ/i7w5LipFnjCC4=;
        b=AL6iJ0geusC2dkvvWJtjKfNA/wqfyQIAgvS6lnw+iWhONJFQ5jmaQiA9NEEgpfw5dF
         uqKtrjxHbzGuuFGiteoM0l0vF0263sHeANdIsZLqdECmfgaM+9WYr151czBy92OYpOhd
         JtJRBk9V8bAd8biLRXpr+62RLxEMH8TVF0z057HSYiSLgmObKY+KqRRilzKF58JVDsC2
         MU2ZWsbBAs2ZGqX71op5XMYHxLsZOu9Nu9m323wYm5gW3uWBOxLKjHEggd0AlC5gAl6S
         DruD1k8HnFIuV/r7Cs/+xwVLaGEL6SFr9PXYa6U7M/HnuVp5Mf+UYwUSrBCdfOYYjORm
         vBbA==
X-Gm-Message-State: AOAM530QmyAI1Ne3Sj8o3zQHD8Lfaeh03MMof6F+dxo1xvHgYPkbL5a5
        dR7Vkf37mFsB6vgR2Pi/Ylq42A==
X-Google-Smtp-Source: ABdhPJz8K2lFPB+LYaUhTkF5BikoiG6xN8o+YhFsl4UMIY1BmsWUswZUh39KzXuHgV/+j8AwWf6AKA==
X-Received: by 2002:a17:902:8685:b029:dc:299c:a2c7 with SMTP id g5-20020a1709028685b02900dc299ca2c7mr15559270plo.33.1608539837724;
        Mon, 21 Dec 2020 00:37:17 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id x15sm15980340pfa.80.2020.12.21.00.37.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Dec 2020 00:37:17 -0800 (PST)
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
Subject: [PATCH v1 6/7] perf arm-spe: Bail out if the trace is later than perf event
Date:   Mon, 21 Dec 2020 16:35:56 +0800
Message-Id: <20201221083557.27642-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221083557.27642-1-leo.yan@linaro.org>
References: <20201221083557.27642-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that record in Arm SPE trace is later than perf event and
vice versa.  This asks to correlate the perf events and Arm SPE
synthesized events to be processed in the manner of correct timing.

To achieve the time ordering, this patch reverses the flow, it firstly
calls arm_spe_sample() and then calls arm_spe_decode().  By comparing
the timestamp value and detect the perf event is coming earlier than Arm
SPE trace data, it bails out from the decoding loop, the last record is
pushed into auxtrace stack and is deferred to generate sample.  To track
the timestamp, everytime it updates timestamp for the latest record.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2b008b973387..6bf2e4ff5342 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -353,12 +353,36 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record;
 	int ret;
 
 	if (!spe->kernel_start)
 		spe->kernel_start = machine__kernel_start(spe->machine);
 
 	while (1) {
+		/*
+		 * The usual logic is firstly to decode the packets, and then
+		 * based the record to synthesize sample; but here the flow is
+		 * reversed: it calls arm_spe_sample() for synthesizing samples
+		 * prior to arm_spe_decode().
+		 *
+		 * Two reasons for this code logic:
+		 * 1. Firstly, when setup queue in arm_spe__setup_queue(), it
+		 * has decoded trace data and generated a record, but the record
+		 * is left to generate sample until run to here, so it's correct
+		 * to synthesize sample for the left record.
+		 * 2. After decoding trace data, it needs to compare the record
+		 * timestamp with the coming perf event, if the record timestamp
+		 * is later than the perf event, it needs bail out and pushs the
+		 * record into auxtrace heap, thus the record can be deferred to
+		 * synthesize sample until run to here at the next time; so this
+		 * can correlate samples between Arm SPE trace data and other
+		 * perf events with correct time ordering.
+		 */
+		ret = arm_spe_sample(speq);
+		if (ret)
+			return ret;
+
 		ret = arm_spe_decode(speq->decoder);
 		if (!ret) {
 			pr_debug("No data or all data has been processed.\n");
@@ -372,10 +396,17 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 		if (ret < 0)
 			continue;
 
-		ret = arm_spe_sample(speq);
-		if (ret)
-			return ret;
+		record = &speq->decoder->record;
 
+		/* Update timestamp for the last record */
+		if (record->timestamp > speq->timestamp)
+			speq->timestamp = record->timestamp;
+
+		/*
+		 * If the timestamp of the queue is later than timestamp of the
+		 * coming perf event, bail out so can allow the perf event to
+		 * be processed ahead.
+		 */
 		if (!spe->timeless_decoding && speq->timestamp >= *timestamp) {
 			*timestamp = speq->timestamp;
 			return 0;
-- 
2.17.1

