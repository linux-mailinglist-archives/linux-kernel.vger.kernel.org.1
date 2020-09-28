Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7427A914
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgI1HxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1HxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:53:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so211098pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGoeijhyKEiC07ZRJh2x4UzyDfOC8TrQvW4SG32LltM=;
        b=UEUNSPydXUj+pWDRl1G8llMcp1jniaimb3eaa8GBmS2W00msVA3kpopXg3LGwIega+
         bfrGWgCFF5cHe5f1Bt9nDAc+Tiqqo6URWILrOCxymem3fH+SX8XcPH72OBJEZnXXJqt0
         C7iuQyuiSPmlygzuZ0T3mRwn3Wsn1f+RiVdw45KkdRZBRTghj0gS8jfPg0m1h7000VFu
         BDyWyDZTS0FmfKNfiOZmZEdA2ZBE+X0hnS1S4qv08HaQyHGSH1iqji7MQHLmM5FLhrj5
         Hfqhjptm2T35KDtAnd78dIj0Gnunn0OIzCIEL6K3OQx+8SKenWJcOfFsDGxsKk14+iCM
         cZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dGoeijhyKEiC07ZRJh2x4UzyDfOC8TrQvW4SG32LltM=;
        b=eBlMISYr311GzbvyTkBrMoCYgoQ7/JBAeMc2B1H5Jii7amhiyyVDJSvLIHfw7AsVkE
         D9NIANKdZUQUK/Sfi2OSAFepbhIl9qM6bcNr4kCxespWtBrQoffg81hPPvJE3VkF9ApY
         rMh+Pl4SquoQ3777BKP+7eCuQ/m8kFrIgAz+nAtuMa0Fw34uQQ/7IS3njDN+CVVEnFSN
         /ryUME9+uI1jSASfnOVH1LpiZp4zL9bQLbUwSW6FgwtMIi3bgH2PkjSaO4NPD9TY6nn/
         VVyPy0kTltWCkmY45DBcTsGCX4YqHAC5tmrIRvpt1PRpT4rFhVfYUxBPycpVH7rlWhuK
         Fr+g==
X-Gm-Message-State: AOAM533qIQ6CmT4ztpEWkAFkMIJQOhljhrQgpGU3PPaCmgLYnF3eDpO8
        95URRNnTDm2hZjQZuAQ9cKo=
X-Google-Smtp-Source: ABdhPJzpnZ3K9nifF3C9s7o6FK03OiPHl5pdIIpzIdzgLGiXhciB5pdda5/wwGUNYBa1Bb0SKgbLEQ==
X-Received: by 2002:a05:6a00:15c8:b029:142:2501:35ca with SMTP id o8-20020a056a0015c8b0290142250135camr419984pfu.42.1601279590918;
        Mon, 28 Sep 2020 00:53:10 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:53:10 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/6] perf inject: Enter namespace when reading build-id
Date:   Mon, 28 Sep 2020 16:52:43 +0900
Message-Id: <20200928075246.853729-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200928075246.853729-1-namhyung@kernel.org>
References: <20200928075246.853729-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be in a proper mnt namespace when accessing the file.

I think this had no problem since the build-id was actually read from
map__load() -> dso__load() already.  But I'd like to change it in the
following commit.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2c5e23d73a8a..670157db2502 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -23,6 +23,7 @@
 #include "util/symbol.h"
 #include "util/synthetic-events.h"
 #include "util/thread.h"
+#include "util/namespaces.h"
 #include <linux/err.h>
 
 #include <subcmd/parse-options.h>
@@ -419,16 +420,19 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
 
 static int dso__read_build_id(struct dso *dso)
 {
+	struct nscookie nsc;
+
 	if (dso->has_build_id)
 		return 0;
 
+	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	if (filename__read_build_id(dso->long_name, dso->build_id,
 				    sizeof(dso->build_id)) > 0) {
 		dso->has_build_id = true;
-		return 0;
 	}
+	nsinfo__mountns_exit(&nsc);
 
-	return -1;
+	return dso->has_build_id ? 0 : -1;
 }
 
 static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
-- 
2.28.0.681.g6f77f65b4e-goog

