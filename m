Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9AE277151
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgIXMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgIXMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1633710pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+tAeuuP039EYMlDCRNEZ1nn6oxx3USGkFSyzS2Ctg0=;
        b=H4d2NNnpTHT0a7gIfjO/llaaCLA0Pp0yEMDY9S0hOHIbG47tVVpfclFShZj0h+Dnjo
         rjren2KllUWNu4/wQnJVc22hSQ/xPJLkGM/G/gSE1wtwv5ptpPguB4LN0KTd90v+OhZi
         jXXebqyVgbbLEqRz+ekOv0EQxbz3gWq4DZDOS81Gguue/GinQ/VwMMkQ6I3ohDigtiiT
         HWM3zpOF05X2AYr/wk3dmLjyPgn0uswmNRUm5yuAOPq/YVVpWdgiTtBhNyDjb4IL6K/u
         tSWubsXM3GWCJF1d6V49CcQriWEQb/gRV9IHzeluQ1Vc+yOCX2UZbk95YQnINELyLcLt
         CVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y+tAeuuP039EYMlDCRNEZ1nn6oxx3USGkFSyzS2Ctg0=;
        b=k4VnIoEDSi9VkaDfvFWPM5e3gAOUv+JhGWrGLxCxDYA+g1jtSzS3Lye5SZmiDRkZhz
         1TCqZfHYvPm2BgwKJhmQaungUxqW/tPWMXclyQIM5C/JJ+u8WZMKUUVDG3JVQ0ZV6o2x
         LQn8ZM9FNt9mOP0JXTBDw5EnD09UgbfLx8P5eUaPbsWhVb3stFPiLJKwuMDWywxO54/F
         +Cfi6CXOq0CMCpYfRmZiG9hVJlq2QftZG3DbVWwdyqrlvGUX2dir3v6AZaYYpnOJY+Hl
         YsfVdM/lzFuJhaFub1YzHSlu29kCfHWshqXAEmPpXzx6KOa+q8TDqjvfAS0TkMMyc3r0
         3UOQ==
X-Gm-Message-State: AOAM531xcUXGDSgjXAcZ8on9lOV9sFm8QCJTjWSMRgZN5/3SHDtef1oi
        1jl9PkhIfnxaAD6q2cBCvJM=
X-Google-Smtp-Source: ABdhPJzJzPwjVv+Iod8u8uvZS337sL5um6ytCSVYpp6qCFecCIu9kBWdl3Uzf5+ilT2HEpSiuE+uzA==
X-Received: by 2002:a17:902:8545:b029:d1:f2e3:8dd4 with SMTP id d5-20020a1709028545b02900d1f2e38dd4mr4442016plo.65.1600951521693;
        Thu, 24 Sep 2020 05:45:21 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 194sm2690310pfy.44.2020.09.24.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:20 -0700 (PDT)
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
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 4/5] perf tools: Allow creation of cgroup without open
Date:   Thu, 24 Sep 2020 21:44:54 +0900
Message-Id: <20200924124455.336326-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924124455.336326-1-namhyung@kernel.org>
References: <20200924124455.336326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation for a test case of expanding events for multiple
cgroups.  Instead of using real system cgroup, the test will use fake
cgroups so it needs a way to have them without a open file descriptor.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c |  2 +-
 tools/perf/util/cgroup.c  | 19 ++++++++++++-------
 tools/perf/util/cgroup.h  |  2 +-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2751699a8969..b01af171d94f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2235,7 +2235,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 
 		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events) < 0)
+					  &stat_config.metric_events, true) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 6e64c908fa71..b81324a13a2b 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -51,7 +51,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
 	return NULL;
 }
 
-static struct cgroup *cgroup__new(const char *name)
+static struct cgroup *cgroup__new(const char *name, bool do_open)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
@@ -61,9 +61,14 @@ static struct cgroup *cgroup__new(const char *name)
 		cgroup->name = strdup(name);
 		if (!cgroup->name)
 			goto out_err;
-		cgroup->fd = open_cgroup(name);
-		if (cgroup->fd == -1)
-			goto out_free_name;
+
+		if (do_open) {
+			cgroup->fd = open_cgroup(name);
+			if (cgroup->fd == -1)
+				goto out_free_name;
+		} else {
+			cgroup->fd = -1;
+		}
 	}
 
 	return cgroup;
@@ -79,7 +84,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
-	return cgroup ?: cgroup__new(name);
+	return cgroup ?: cgroup__new(name, true);
 }
 
 static int add_cgroup(struct evlist *evlist, const char *str)
@@ -197,7 +202,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 }
 
 int evlist__expand_cgroup(struct evlist *evlist, const char *str,
-			  struct rblist *metric_events)
+			  struct rblist *metric_events, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
@@ -240,7 +245,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			if (!name)
 				goto out_err;
 
-			cgrp = cgroup__new(name);
+			cgrp = cgroup__new(name, open_cgroup);
 			free(name);
 			if (cgrp == NULL)
 				goto out_err;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index eea6df8ee373..162906f3412a 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -26,7 +26,7 @@ struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
-			  struct rblist *metric_events);
+			  struct rblist *metric_events, bool open_cgroup);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
-- 
2.28.0.681.g6f77f65b4e-goog

