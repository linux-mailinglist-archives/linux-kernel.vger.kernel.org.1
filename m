Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E9274ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgIWCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:00:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA032C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so6021793pld.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEYyqzb4frgCBgCfJyrfAkTQQa1bA1an35lUdMvUiGY=;
        b=gU0Bz1MHqdxiA4PLnlex0h1BWY1wqvPwkYQ/RxUQXiFQZvEYBHQrAaqaLK3Jta/1QV
         Xh6zXRKmcGnBtypveHatFW2rApK3SkenuQzcAyW/P4v/mEnJuWlzbaz9h3vgp52zOcR3
         LS9E/3qlDeS9PlQxKFCXubtYZYnpnUyarW4BXc4QYGjKRTd39cmIIj+xML+xZgv/yf1r
         iupcpVsxqJsk1BV1PGqJjX8e6E1DFI0Kpcye8Gnb3DwvyMYIbuKD1dNv70tvirA4rLiZ
         RzvJhgrL7tJZzv7mKziTtaMLdtpG3QBy5uFcHwiCl8+ZItzkBhHevboGTWuhGd4bq1Be
         mLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gEYyqzb4frgCBgCfJyrfAkTQQa1bA1an35lUdMvUiGY=;
        b=AV+V6+cI+vxSMaahUAeskn29Mf42Qu0uAvKB6l5AHO/9/WeMGpN77xV/0hDRAgjWyq
         OWAxA+rFXSeGjsC2BzmruQZ0veRTrhsOYI/a1x52YgJNMYWQ/i5nPVAxG1Tfyw4tHYbA
         E1+LoBJ4GRNhfYrzuwd5mEA+3JETESZoIMGE9p9VaJiRJN8yIcCpkTQGl8Q57EKGtfYh
         VofqhDi+aZOWO4rcWcy/P+horZLdGJqIRS+qCvilWWzTn2neCE2ghC+bBsLnvaAjdb7e
         cLcyeHE/L5z0mLAQUrG29motz9PKAY3GMlt1+3HzSPnZ0tozTYIzNiVMNxlRT33qfCWk
         dcPg==
X-Gm-Message-State: AOAM530d5anpgmuJ7aeH+HYLEae1vkuGWZSqYensyL0XrFrZyP9BTxAX
        3qxqQ4r7ZUSs41MrGqJTspk=
X-Google-Smtp-Source: ABdhPJxC6OtzKQ8jBDqSs2jxmAuFB6uj1Xr0Mh/S50gsT6oM0w3gmY6X0DPUf2kXVXgUP3huQhwu0w==
X-Received: by 2002:a17:90a:81:: with SMTP id a1mr6044043pja.136.1600826407253;
        Tue, 22 Sep 2020 19:00:07 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v13sm3367741pjr.12.2020.09.22.19.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 19:00:06 -0700 (PDT)
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
Date:   Wed, 23 Sep 2020 10:59:44 +0900
Message-Id: <20200923015945.47535-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923015945.47535-1-namhyung@kernel.org>
References: <20200923015945.47535-1-namhyung@kernel.org>
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
index 66a33d97192d..d9d5de6f3108 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2256,7 +2256,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 
 		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events) < 0)
+					  &stat_config.metric_events, true) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index dcd18ef268a1..d82f4cad762c 100644
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
@@ -235,7 +240,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
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

