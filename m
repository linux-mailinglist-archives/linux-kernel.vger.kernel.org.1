Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88FF269C78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgIODTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgIODTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:19:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198ECC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x123so1115755pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RXAoo+7t6uTbyjbJDM+DIt1+VWGOsCNXumcDVhweRBc=;
        b=Z39GAMjXTFIN0gI5C9uBz0aJ3e/tkQdXG/4bOXUtIBL+7V3lID+t/kkmqkZMUk0It2
         giKvapEPkSDn4Ut86XYfMXkouN5haMJbkCqLeNohtgdpgB2Zfgj6fYHqLQQ/DMh3qxNi
         yfQpD7TDkW72/dIW1FBQxqrAM7i/YLQ5I0DeLpW+6J2phwVgixTailR1Uq1vJIWgoVN2
         2x5wIZjkbYEaAxvvq2oqB8KuljXep+8iVfo5ySeUZik299XA6U2S11Q4HxjNuykZzROq
         q8UpX/o9+BCSBnlGcXeYgheDqZkC3c9HuSOxrW/dK6cP381DYcB2WtuaIchwcx00gbHY
         aghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RXAoo+7t6uTbyjbJDM+DIt1+VWGOsCNXumcDVhweRBc=;
        b=Hfq4DfKCTGSK8SorwsAEPAS+/MHnrbvOH6/DcDrzesBdItTYqGVdP4z+mgABhjcwye
         IzWXIhuqo/qzHlGAVZJwqwJkut2EYVWqgEvk0GAK6mXSRBpYoGZL2rf8Yk/nO87G6iT+
         OWf7dKbu44eKJz4E7Rg9CtrEc8rz6jyhSRlw3hIerd3vOX3wb0OUmAGVj7jYjpJNDnLc
         9ECngA8rhXktbW0HeyenLPfCXjtxhShSFbTgBRaw7FkxTo0ygpdsSLmHOYSXDWQcfjGx
         LjlBU6usmppY7WXWQQv8WKWIMzrn2xKgmdzcDC2OhmvjcC74VgIJxrUKDBQ4/7OX/F7d
         YUCw==
X-Gm-Message-State: AOAM533f4h5tgQOoeuxkdNVcUNbDMSnJtdkz4mDoZbmxRK4oP8u2IU5F
        Fv/+qLx4U8SGHJyK8FJspQY=
X-Google-Smtp-Source: ABdhPJy4NBlYat8Llm6qE3YX+Z/EZzhKJkweZIeLjpvLzAPg/pj8DCPIoALPa/cZ5StQjZSFCSfxuQ==
X-Received: by 2002:aa7:84c5:0:b029:13f:ed60:b20b with SMTP id x5-20020aa784c50000b029013fed60b20bmr6434958pfn.26.1600139938635;
        Mon, 14 Sep 2020 20:18:58 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:58 -0700 (PDT)
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
Subject: [PATCH 08/11] perf metric: Free metric when it failed to resolve
Date:   Tue, 15 Sep 2020 12:18:16 +0900
Message-Id: <20200915031819.386559-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metricgroup__add_metric() can find multiple match for a metric
group and it's possible to fail.  Also it can fail in the middle like
in resolve_metric() even for single metric.

In those cases, the intermediate list and ids will be leaked like:

  Direct leak of 3 byte(s) in 1 object(s) allocated from:
    #0 0x7f4c938f40b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
    #1 0x55f7e71c1bef in __add_metric util/metricgroup.c:683
    #2 0x55f7e71c31d0 in add_metric util/metricgroup.c:906
    #3 0x55f7e71c3844 in metricgroup__add_metric util/metricgroup.c:940
    #4 0x55f7e71c488d in metricgroup__add_metric_list util/metricgroup.c:993
    #5 0x55f7e71c488d in parse_groups util/metricgroup.c:1045
    #6 0x55f7e71c60a4 in metricgroup__parse_groups_test util/metricgroup.c:1087
    #7 0x55f7e71235ae in __compute_metric tests/parse-metric.c:164
    #8 0x55f7e7124650 in compute_metric tests/parse-metric.c:196
    #9 0x55f7e7124650 in test_recursion_fail tests/parse-metric.c:318
    #10 0x55f7e7124650 in test__parse_metric tests/parse-metric.c:356
    #11 0x55f7e70be09b in run_test tests/builtin-test.c:410
    #12 0x55f7e70be09b in test_and_print tests/builtin-test.c:440
    #13 0x55f7e70c101a in __cmd_test tests/builtin-test.c:661
    #14 0x55f7e70c101a in cmd_test tests/builtin-test.c:807
    #15 0x55f7e7126214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
    #16 0x55f7e6fc41a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
    #17 0x55f7e6fc41a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
    #18 0x55f7e6fc41a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
    #19 0x7f4c93492cc9 in __libc_start_main ../csu/libc-start.c:308

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 83de0b7d535de ("perf metric: Collect referenced metrics in struct metric_ref_node")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 53747df601fa..35bcaa8d11e9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -940,7 +940,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 
 		ret = add_metric(&list, pe, metric_no_group, &m, NULL, &ids);
 		if (ret)
-			return ret;
+			goto out;
 
 		/*
 		 * Process any possible referenced metrics
@@ -949,12 +949,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		ret = resolve_metric(metric_no_group,
 				     &list, map, &ids);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* End of pmu events. */
-	if (!has_match)
-		return -EINVAL;
+	if (!has_match) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	list_for_each_entry(m, &list, nd) {
 		if (events->len > 0)
@@ -969,9 +971,14 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
 		}
 	}
 
+out:
+	/*
+	 * add to metric_list so that they can be released
+	 * even if it's failed
+	 */
 	list_splice(&list, metric_list);
 	expr_ids__exit(&ids);
-	return 0;
+	return ret;
 }
 
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
-- 
2.28.0.618.gf4bc123cb7-goog

