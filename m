Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9F268D53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgINOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgINOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:19:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341EDC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s65so10600164pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LzI4NVIZYMYJhFikPO81AHCmMRsACZLPQgfgpIaJP5Q=;
        b=Cl9StQfMBs+QDVIvjUFqxAfyNodAOEevNax0bqBPkbSIqVxwTCENulZxqgwM6SkbIP
         tjFxsEw0Q3T+sXJprFPi8pn/+01ZQujKD3ldqNcC1zmekTDe7TahBmTbx8zxkiEfbAMm
         wU5F01oRV7M8nDgdBlmI3GpcDjfEStx0FPRfHm0ukfxUmiNyHTXJFGjm7NrvOvHcbW3H
         GEs15o8VxTUOkDGA8AMvx10C205urKo7dQVIRzTp+8dMYT7N70MovInAbCohIYEIhiMB
         AGFugs7D+eP7xAF06PhLbQiMoQvkHLwFQfjpubqihmjLOFK7xHeNQTW5nMhyZwpse1xR
         h9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LzI4NVIZYMYJhFikPO81AHCmMRsACZLPQgfgpIaJP5Q=;
        b=hPvJID59hniZm3BDT3234VkfAzL6mU3NC0IQm1sMZLwRzDhvr4RySFCTk9sESDNP5X
         hEQh+e9wAZt1fsu4KuCkJIaZIgob4ACbE6wNTyfcEJ7bZWA3na+DYYXaP45e4VlC1GjB
         VVf5dpO1AoPF2GAZqMltCPm2zQXc74uG6yNR0JDyAlYsX6PqSc5trq+wDaABmQYhyceJ
         f0Y/RjsMZFMBXkOYVSr0AnzzmqKPtNucgng4M4Q3Se4DXGHZ/U003mIO7h2/TAmyJ0P6
         04x537ZxtmCn1QmIglscLECttHMIYq+p3lxo9T0DHRiJJNf0+PMSJKcEbyVu4zqIpCdW
         vx2A==
X-Gm-Message-State: AOAM532VrPIIeLlFFZUQFQenEAVBAjSgCZdFm/mOnobvxdldkMfQu2Bp
        cW6OsRD4v3U7MHIE5x+kJOs=
X-Google-Smtp-Source: ABdhPJxi+sU18BZToj0Rl9jN8dA8C5/fwD2hsm1BlYcp4hSGFLO3Ei9asyiYXt85iIl+ppc8OGgB7A==
X-Received: by 2002:a62:38ce:0:b029:138:838f:dd53 with SMTP id f197-20020a6238ce0000b0290138838fdd53mr12762209pfa.2.1600093148779;
        Mon, 14 Sep 2020 07:19:08 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id c3sm9209440pfn.23.2020.09.14.07.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:08 -0700 (PDT)
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
Subject: [PATCH 2/3] perf inject: Enter namespace when reading build-id
Date:   Mon, 14 Sep 2020 23:18:58 +0900
Message-Id: <20200914141859.332459-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914141859.332459-1-namhyung@kernel.org>
References: <20200914141859.332459-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be in a proper mnt namespace when accessing the file.

I think this had no problem since the build-id was actually read from
map__load() -> dso__load() already.  But I'd like to change it in the
following commit.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 59576877c67f..a2804d906d2a 100644
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
2.28.0.618.gf4bc123cb7-goog

