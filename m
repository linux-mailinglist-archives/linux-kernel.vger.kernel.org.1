Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA72752DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIWIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgIWIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:06:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF3C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c3so6429645plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iHcwpgtyZUZb8p9qxIRg3qOzfcQEwEXu/Fx2PhxwG0=;
        b=uJDIHb04Qe29vhufDpT1yc3BLAGX1gAFXLkWMDOtu6XB7K+uZpgVtcb6+MUtclGlm1
         tILUhT6g7dSl64/dS3FwP6Q2/tdSD1SeK8Afcd8c/95QVjPhaiC8VKRnZIUu3tHI487m
         jvRCJfYxy5D23uTQFUjkc/GT1BCszDRWBG7AiqyhwMe/aWQ0BcfNuiZLAhfJ4R5GeSu+
         3clkb6jYRWxng9QlYisoA4t2isBWjy4Ui58iaj7/pq+kQiduHltGOp8YHNiRStXce6Vg
         sVWKLFKoRHM8CRBOoQYOHTtVaeZQTjNlkeBtOGtaTshQkrVm9IVAERKAM31qaLMUVvwY
         lZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3iHcwpgtyZUZb8p9qxIRg3qOzfcQEwEXu/Fx2PhxwG0=;
        b=Zq5d+hrnHLGB7rqSBWdLUOg1ay5axSvklCiz4QDcKHqgAzphBX6ONxgaDgXcg37//E
         Nz/wQd7LYopTa+SAV9L3zfx5Ki3Ra7eLU5VvWQ6LN6wEJ4ulXhrwgGgS3QhrbqGx85L4
         JeC3NvPL4823uRrUPhNJxyRCUl9zdE5A5v51G2UNDQsgjqAL4Um4moPl5ED391gR1032
         5wjqX39+ja2G+3if/Nfr06jqvbBXtBkL4Bo9NNYstTD/M5imxY9aAmY+oTfTTvhT79mT
         nz49pJaJzWQ7W6SLUhY+J3CNl7HHIU4ZM79kRpKg9o//meaoQraGdzPr8ib4mwiU6vpe
         t7GA==
X-Gm-Message-State: AOAM5317A9KRA+IFktFPT/MCjCDbwYWiGNVP8PiGr7jyn8aKXWwkb1lz
        XdQ8PU5yAOlykplgQ6aUieg=
X-Google-Smtp-Source: ABdhPJzlHYQC8BxVmRgZRK3EdwP3d53PAwyahQsXrpMxx2WHDiyHBv22/YMiLjjsOK+p72tuoVeZnw==
X-Received: by 2002:a17:902:784d:b029:d1:e7cf:83e6 with SMTP id e13-20020a170902784db02900d1e7cf83e6mr8122661pln.63.1600848369549;
        Wed, 23 Sep 2020 01:06:09 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:06:08 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 7/7] perf inject: Remove stale build-id processing
Date:   Wed, 23 Sep 2020 17:05:37 +0900
Message-Id: <20200923080537.155264-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we don't need to call build_id__mark_dso_hit() in the
perf_event__repipe_sample() as it's not used by -b option.  In case of
the -b option is used, it uses perf_event__inject_buildid() instead.
This can remove unnecessary overhead of finding thread/map for each
sample event.

Also I suspect HEADER_BUILD_ID feature bit setting since we already
generated/injected BUILD_ID event into the output stream.  So this
header information seems redundant.  I'm not 100% sure about the
auxtrace usage, but it looks like not related to this directly.

And we now have --buildid-all so users can get the same behavior if
they want.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 500428aaa576..0191d72be7c4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -277,8 +277,6 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 		return f(tool, event, sample, evsel, machine);
 	}
 
-	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
-
 	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
 
@@ -767,16 +765,6 @@ static int __cmd_inject(struct perf_inject *inject)
 		return ret;
 
 	if (!data_out->is_pipe) {
-		if (inject->build_ids)
-			perf_header__set_feat(&session->header,
-					      HEADER_BUILD_ID);
-		/*
-		 * Keep all buildids when there is unprocessed AUX data because
-		 * it is not known which ones the AUX trace hits.
-		 */
-		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
-		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
-			dsos__hit_all(session);
 		/*
 		 * The AUX areas have been removed and replaced with
 		 * synthesized hardware events, so clear the feature flag and
-- 
2.28.0.681.g6f77f65b4e-goog

