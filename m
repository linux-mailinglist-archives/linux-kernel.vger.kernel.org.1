Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC02626F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 07:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIIF7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 01:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIF67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:58:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B2C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:58:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so799023pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrdGrjWlbHWJKsCtghUkQJr2+1VPk/m63JYhuF4kMYQ=;
        b=iLP8ZhKlmq9plG9uZA+V2rOQg688pagPWiMRLHuscoDVZMX+Irh0eftJEETOV7QPOT
         DPQqeUv69dycIK8bbysSNhtD+ymkugnE6aSXa8gjvrVtGkKgTlFe6WUR/Do810GbTxj8
         0IuZ75t4Gph3QcxykR8ao2nUUI0pxTNUlBHeArJfygUcjuV1ohVB1ye0T4RfcyAWdVly
         ZgMpAJT751HvsnXJYAJOqvZFySogRiqCx+eORPRKJHHVFFHjJj7uyyLkHFy2tKSrQhTU
         DPWCrmMfKK9kTzYSNjDTem5rWJ0aESkY9l1Zz4T5JXLvCLBrzEyBDylFg2CnVveRjvMv
         AIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lrdGrjWlbHWJKsCtghUkQJr2+1VPk/m63JYhuF4kMYQ=;
        b=Aujp+bF6DLewYzqV/PYVQeJ+/mkr3Ohm5HWkjdPyUIl7MFsKwe0rODBrmf4zzgULgz
         qEiPbWpLtXjHsfbuY1WkApUE9jKcpJVaJQGLKTrRKw1cPv/Sg8btnico2de7DVyYVVzc
         q/YqFCpLOOeMhj+BUl702pS/QpGIczGSH/kJkjW1UPW2mhf4TkjcmZAtsKBWuchH4xuE
         t3077uH8uowQwzCYo4yEorEyVRxMS+M3NDbnMCVVYQerT/nKX6mW4NMB32ht3i9voHju
         qQa/yy9Sp2KHuP6KIywi8Eko3WidM9fqEq4blTNag9qRyy2sR2teL8N1u/7b6NRfJCMP
         CxPQ==
X-Gm-Message-State: AOAM530Va4uqTvjzhOx8etCbLG4vlMZqWAuZC1VUoKv2uUaaf5JJNfFz
        LOC5BZ34JaeEDCxb99iQEZQ=
X-Google-Smtp-Source: ABdhPJw7cfecMxa5HeDxO6jigGBtOPiRb5C8/vWijRSc8ZVHl6vo6vQ42fp6muPqN+/h/vSbWNuRig==
X-Received: by 2002:a17:90a:5283:: with SMTP id w3mr2220260pjh.201.1599631138751;
        Tue, 08 Sep 2020 22:58:58 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q3sm1267158pfb.201.2020.09.08.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:58:58 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/3] perf list: Do not print 'Metric Groups:' unnecessarily
Date:   Wed,  9 Sep 2020 14:58:48 +0900
Message-Id: <20200909055849.469612-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200909055849.469612-1-namhyung@kernel.org>
References: <20200909055849.469612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was printed unconditionally even if nothing is printed.
Check if the output list empty when filter is given.

Before:
  $ ./perf list duration

  List of pre-defined events (to be used in -e):

    duration_time                                      [Tool event]

  Metric Groups:

After:
  $ ./perf list duration

  List of pre-defined events (to be used in -e):

    duration_time                                      [Tool event]

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8831b964288f..38464d7d2d63 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -535,10 +535,12 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		}
 	}
 
-	if (metricgroups && !raw)
-		printf("\nMetric Groups:\n\n");
-	else if (metrics && !raw)
-		printf("\nMetrics:\n\n");
+	if (!filter || !rblist__empty(&groups)) {
+		if (metricgroups && !raw)
+			printf("\nMetric Groups:\n\n");
+		else if (metrics && !raw)
+			printf("\nMetrics:\n\n");
+	}
 
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
-- 
2.28.0.526.ge36021eeef-goog

