Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373A9269C71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIODT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIODSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so1117395pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbtjWTXnEFgw1CFjaSYOnSUcpiR5DAuu8CXMr3NDp1k=;
        b=iXTFW/3QbQslDq3H7Rn/cDYlg6hjvZdwZcl6/H2Yw5Dxa8W9L599AMSsw2UzQ4B3mj
         KGAdgyQ02KhyifUklrRhMZGCTDvLXzmjB5DYoNqZ+ommePEZRjcKX5ZQiKuHq46fTRcP
         iJE/v1LU4yjXswSnJ87JbhLusHXj8H6zs+1gtyxn9kbgclV/YecJWhqGRzlZS2xkL3QQ
         nXPEDRiMV7MvDw1lqWLnh9qcTPeIZoWJNeOgvCZ2m0tp7u9e6SN+NJXDtZsFpkrk+3or
         tNkBrUrAze7nUcnxf1aM3X0/gLQRnsniyhR9qzdJi+TTQKnU1Sd8kwnWa82uwWwafe4T
         so7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WbtjWTXnEFgw1CFjaSYOnSUcpiR5DAuu8CXMr3NDp1k=;
        b=MD9pNFrVpoSdTiVkpOfsUkeayMn1Cb9UpQxNa957nD6eGNdbJveBIGkOSPms3xPKZl
         EJJU9mO98dfxYxSQB4PB4xc8Udp1/aWHVBdVU5nXVn4YwAv0myGEagTvPyXI1jYcksUe
         pLxdsyu4F9cmaMs45CREFQRIiP1X0suLmtGGwb4c4kqsDJeoo4rxTc/Q+HJHLRcAng8k
         /CR27IFdV+leRyeigSKZaPEMG9KxDC5mN58MSIjViByuivF50ruH3IXirovbWo7rARlv
         vekrXZ6Hz30bt/J3g4viCH2vwqssPp6oh0Ok00+29+AC5OIojqo2hM5mayQ09PzcmWql
         nWOw==
X-Gm-Message-State: AOAM532SGdcupNa+2CfALJxF7ERwoq7XgJcKAaXTJkw3RGKQ7iPQhAvG
        pp9lSjr1pUTaXaKuNm3io/Q=
X-Google-Smtp-Source: ABdhPJx/1xWEkx//dzA4csT17f/PbvWFM+a53wrj25T9/0LOs7oehoN9+kf5TH7QtKFrT4wixod+og==
X-Received: by 2002:a05:6a00:2b1:: with SMTP id q17mr15880698pfs.74.1600139931492;
        Mon, 14 Sep 2020 20:18:51 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:50 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 06/11] perf test: Fix memory leaks in parse-metric test
Date:   Tue, 15 Sep 2020 12:18:14 +0900
Message-Id: <20200915031819.386559-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It didn't release resources when there's an error so the
test_recursion_fail() will leak some memory.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 0a507af9c681a ("perf tests: Add parse metric test for ipc metric")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/parse-metric.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 23db8acc492d..cd7331aac3bd 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -153,8 +153,10 @@ static int __compute_metric(const char *name, struct value *vals,
 		return -ENOMEM;
 
 	cpus = perf_cpu_map__new("0");
-	if (!cpus)
+	if (!cpus) {
+		evlist__delete(evlist);
 		return -ENOMEM;
+	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
@@ -163,10 +165,11 @@ static int __compute_metric(const char *name, struct value *vals,
 					     false, false,
 					     &metric_events);
 	if (err)
-		return err;
+		goto out;
 
-	if (perf_evlist__alloc_stats(evlist, false))
-		return -1;
+	err = perf_evlist__alloc_stats(evlist, false);
+	if (err)
+		goto out;
 
 	/* Load the runtime stats with given numbers for events. */
 	runtime_stat__init(&st);
@@ -178,13 +181,14 @@ static int __compute_metric(const char *name, struct value *vals,
 	if (name2 && ratio2)
 		*ratio2 = compute_single(&metric_events, evlist, &st, name2);
 
+out:
 	/* ... clenup. */
 	metricgroup__rblist_exit(&metric_events);
 	runtime_stat__exit(&st);
 	perf_evlist__free_stats(evlist);
 	perf_cpu_map__put(cpus);
 	evlist__delete(evlist);
-	return 0;
+	return err;
 }
 
 static int compute_metric(const char *name, struct value *vals, double *ratio)
-- 
2.28.0.618.gf4bc123cb7-goog

