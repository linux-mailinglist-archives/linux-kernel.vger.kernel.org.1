Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54026D35E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIQGC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:02:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3D4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:02:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s65so739676pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY0P4ISqX/BlkwFip5IXHUhpzZ/gtHjw0QSgLOOkdBw=;
        b=BvsoqQBmBcAvhkEGbASP+qKvgtQzfObk+SJvduzj0cuM2662E6qhhgqBHRZ8ZOJy54
         MfsGETgsHElVMK9MR9iYQ51rfblSe8knGJ/8LcAQYVJmZQhOiuwYoVThjYho/PCw9RAT
         dM1OnECo6pxn1HUtM0lK2YR6CrTOfAfGv1sDihFBmOhv4sBb9bESLWDQeQm6LmLg8cu2
         iFbmkR/O49KJ6xXA1iPWKpXwh/wY6oKY/g5/mu5Tb2YOnJbhtbMgIFGj23K/sPSjRRoP
         rCO8ALaEGQhZBnaq3Xflgsyewv7/+8TOSf3pTk2qPGnohLnhbuEX/TTQa+8WWjS+cuiC
         znHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LY0P4ISqX/BlkwFip5IXHUhpzZ/gtHjw0QSgLOOkdBw=;
        b=toXeTkQRI5Y6bmcF7kC5T+Wd1vUFR60x9H3UWlejbPlkiabrTb5dCII2gvdjkfWwhn
         tytsXcW2Mm66tqHmeDAIlW9ATKTGzKmNWZLD/OlpPtGwxgtuHGxzCFULSCxF9LpglVl3
         /cgbsPxBknZcO2xBL4VyXiTL4fg6QHxh1KvlUbBtezo3CbMPFl/tPIa0rnkbkLfsUNe8
         coOkSHP2tNqvKfAosHWevQ4UH/zyN6E+IWmsyWI+6SMDxcKGxtLd1JfTG7K5hAo5zVDt
         JHfRJ/++LugFelq/7TChHn8TVbx/hVbSi/Rr4Zy4cJtKYml+dsNLFPjxkGYtUNWkocrF
         1Sug==
X-Gm-Message-State: AOAM531Rz7i1tGcwjH7GWz3JTy+liKMHP0wyi9Sd2DuJUjTpS0NTY/ox
        SWUIJxbd7hamGE7ik2cHE4s=
X-Google-Smtp-Source: ABdhPJx8/b/cdweSwDtE20zdohe90HRAbOZDr8LG/qSHdCB3n48yYSmmBHd3KoN7nBQYH1JqHgRArg==
X-Received: by 2002:a62:3447:0:b029:142:2501:35f0 with SMTP id b68-20020a6234470000b0290142250135f0mr9421551pfa.80.1600322545043;
        Wed, 16 Sep 2020 23:02:25 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id o19sm14602960pfp.64.2020.09.16.23.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:02:24 -0700 (PDT)
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
Subject: [PATCH v2 1/2] perf parse-event: Release cpu_map if evsel alloc failed
Date:   Thu, 17 Sep 2020 15:02:18 +0900
Message-Id: <20200917060219.1287863-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 667cbca1547a..176a51698a64 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,8 +360,10 @@ __add_event(struct list_head *list, int *idx,
 		event_attr_init(attr);
 
 	evsel = evsel__new_idx(attr, *idx);
-	if (!evsel)
+	if (!evsel) {
+		perf_cpu_map__put(cpus);
 		return NULL;
+	}
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
-- 
2.28.0.618.gf4bc123cb7-goog

