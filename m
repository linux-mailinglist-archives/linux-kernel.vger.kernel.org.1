Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF22F5CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbhANIuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbhANIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:50:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C266C061794
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:50:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ce17so562079pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjWizhyu8VZ0DSSvcqVJazdL/52t/573vXwoR+ssZ28=;
        b=ld7VKN3g5PPE7gXB3i6relGVgV++/oi+YlgNNZiisOPRSem8VLy/bZ9Sbgy6vh1zPA
         wwc4brGsfgj2Cx4RaUp8oxzIEmqYsZ0cGaAE0qfSsZXBI//Qrjnd7xSqSRZ7mtDqfb30
         +ROHUGVgb9IibgTuPontr2aUEpTXl3zuODBrbTCj/yZXIEAajuc9u2m1GSc2tGTGkDJK
         iSLApfFSwCOYBwHfWVZL1v71ID8l8kTjpWducC7b0qU0I+vaVwqwrr25xgAXbIVgizo9
         nPYYxCZgAm6KLOm30YMw4dTMmQnSVAMD/6Xw5iORr/vik7TEHxcp2/0wgxddvbtFmoKP
         8Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PjWizhyu8VZ0DSSvcqVJazdL/52t/573vXwoR+ssZ28=;
        b=rg5ALZ2aRzsPJeUqCrC/MkBjkLgmvE3pcCeqK2Ir5hjX3I747ZjLK3pNKMPrmm6win
         nHSPHSGIV8I+wS7roFFNe27WH4htWh4ByTkxPDTvsDKxFpGOlrEcgGDOMlViEFSxvqhc
         l0Y5oE42gLl0pGHAROPss8XlntcTFXrMTX23mFs60oYUzdSKNZMSpuEYAWs7/aC7H9QF
         ppJdAKwo6ytXPJEl/1OxvJE72B6Y0v2b/Wsvv6z0LjOIHGsuOMLDKkxkZhgIBPX19NoD
         oVreDqrfR90gz8FuT0A2QCN7tGx1kKq9tJa2I+rDgVfM6TNgW1LxOh3vusfLYEWdhc3/
         e8rA==
X-Gm-Message-State: AOAM532lOOIs2IgESYkBSKS33n2E6b46gipLxlkfh7PA20PuczL7hFaK
        upm8gJTGw0zK9ZhqfmXJ9/U=
X-Google-Smtp-Source: ABdhPJzBwVwqoWYyw0xzVl+k1K+7vNU+w1WiSHexSgjUPn5uJ9XTYa65wNGJRXcaCMtyBXQlWejkqA==
X-Received: by 2002:a17:90a:f0c5:: with SMTP id fa5mr4074299pjb.174.1610614213892;
        Thu, 14 Jan 2021 00:50:13 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id gz5sm4992131pjb.15.2021.01.14.00.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:50:13 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf tools: Add 'cgroup-switches' software event
Date:   Thu, 14 Jan 2021 17:50:04 +0900
Message-Id: <20210114085004.26606-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210114085004.26606-1-namhyung@kernel.org>
References: <20210114085004.26606-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It counts how often cgroups are changed actually during the context
switches.

  # perf stat -a -e context-switches,cgroup-switches -a sleep 1

   Performance counter stats for 'system wide':

              11,267      context-switches
              10,950      cgroup-switches

         1.015634369 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 1 +
 tools/perf/util/parse-events.c        | 4 ++++
 tools/perf/util/parse-events.l        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b95d3c485d27..16559703c49c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3b273580fb84..f6a5a099e143 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 		.symbol = "bpf-output",
 		.alias  = "",
 	},
+	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
+		.symbol = "cgroup-switches",
+		.alias  = "",
+	},
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097317f4..88f203bb6fab 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -347,6 +347,7 @@ emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 	/*
 	 * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

