Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126E62693EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgINRpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgINMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:05:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3134C061353
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so11335621pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTMUwLGNRNQB4ie8SSya+jnVAbwSw8hpqt0lrhaUPZU=;
        b=kuCmwrQrg7GJ9HX906/sSdZbuErryyJ0Dz8Oj+NGbspBGEYAznqdQWVNoTE8TLZLH0
         LuVLq2yO5Nk7H0eV+WdsjLsaNVOTQA3NNMYVFaUDJvMTik77DB/mWAsrYZyn96N/RvOL
         97A7M+Y5Iuf5kKiFE36DrcKO0zB8g/ThDLYh3DlkkzANowb1UvV9g4ZASIEDVcQ7+O4n
         3B2qz+E/JdDK+66qcmmo3+q/BWRCVwF7spBQwZW+sPdR0yHRx9cwrdc4AO3kHjr+MCZ4
         tKsrlEHOIi31ZJ2NuIRE/A8kTzIBs/PE2ct0OpmbJ9wAWbkII6g/0c6ShMt2WSge4JlB
         7pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTMUwLGNRNQB4ie8SSya+jnVAbwSw8hpqt0lrhaUPZU=;
        b=LfxgHeWZ3kfXfA+gb8s/69sEwmx4iOE8JvZJ8jVnGGXB2RK6Chb3CK8dnpBFNer0s3
         5K3Q+henVZIJYxmgv7LTPvyJEF3ylm9DvEo4PBjcFhbEZQstsRE49wM+t7iG/gR0Db+p
         4cBeA0rUBR8en41iegWSCdeUMDw/nReU5JwAM3ADpvs9rGOkhIxF1iqoc6tMF4qPWrso
         f8MNO2YPVMWMXh1itaqtR94fNzKZxyE+1l+LgjkQsyXvn6/opj94oaW+3xwaZHEAzsbC
         bzsYMFePlEbxDXHF5wWJJSgUIFR9S+ueYW61xC/jzG4N4dAWktuiAEX6HJp54DOEzwqF
         K3zg==
X-Gm-Message-State: AOAM532Wy++JnQVtRkv4ouIjmH/V58ZUso5+JVC0gL1vCtOfVG7y/c/z
        La22DnC2YVbOBKKdKLzy5Vwm8w==
X-Google-Smtp-Source: ABdhPJwMivTpJYi6MvYsaIi8RtkLmeWPRGs92dGue7CU8k3cf5rOcu1bj0SIUEFoRHy99vDQn47Vgg==
X-Received: by 2002:a17:902:ac83:b029:d1:920c:c022 with SMTP id h3-20020a170902ac83b02900d1920cc022mr14302606plr.38.1600084516188;
        Mon, 14 Sep 2020 04:55:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id v13sm9068714pjr.12.2020.09.14.04.55.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 3/6] perf tsc: Calculate timestamp with cap_user_time_short
Date:   Mon, 14 Sep 2020 19:53:08 +0800
Message-Id: <20200914115311.2201-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf mmap'ed buffer contains the flag 'cap_user_time_short' and two
extra fields 'time_cycles' and 'time_mask', perf tool needs to know
them for handling the counter wrapping case.

This patch is to reads out the relevant parameters from the head of the
first mmap'ed page and stores into the structure 'perf_tsc_conversion',
if the flag 'cap_user_time_short' has been set, it will firstly
calibrate cycle value for timestamp calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/tsc.c | 12 +++++++++---
 tools/perf/util/tsc.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 9e3f04ddddf8..c0ca40204649 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -28,6 +28,10 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 {
 	u64 quot, rem;
 
+	if (tc->cap_user_time_short)
+		cyc = tc->time_cycles +
+			((cyc - tc->time_cycles) & tc->time_mask);
+
 	quot = cyc >> tc->time_shift;
 	rem  = cyc & (((u64)1 << tc->time_shift) - 1);
 	return tc->time_zero + quot * tc->time_mult +
@@ -37,7 +41,6 @@ u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc)
 int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 			     struct perf_tsc_conversion *tc)
 {
-	bool cap_user_time_zero;
 	u32 seq;
 	int i = 0;
 
@@ -47,7 +50,10 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		tc->time_mult = pc->time_mult;
 		tc->time_shift = pc->time_shift;
 		tc->time_zero = pc->time_zero;
-		cap_user_time_zero = pc->cap_user_time_zero;
+		tc->time_cycles = pc->time_cycles;
+		tc->time_mask = pc->time_mask;
+		tc->cap_user_time_zero = pc->cap_user_time_zero;
+		tc->cap_user_time_short	= pc->cap_user_time_short;
 		rmb();
 		if (pc->lock == seq && !(seq & 1))
 			break;
@@ -57,7 +63,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 		}
 	}
 
-	if (!cap_user_time_zero)
+	if (!tc->cap_user_time_zero)
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 3c5a632ee57c..72a15419f3b3 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -8,6 +8,11 @@ struct perf_tsc_conversion {
 	u16 time_shift;
 	u32 time_mult;
 	u64 time_zero;
+	u64 time_cycles;
+	u64 time_mask;
+
+	bool cap_user_time_zero;
+	bool cap_user_time_short;
 };
 
 struct perf_event_mmap_page;
-- 
2.17.1

