Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07F269C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgIODSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgIODSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9EBC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so1197678pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1Wi1n1k1tvzjnZGeYsh38Zudyl6wqadvm40u/suu/c=;
        b=dIBsZUDYd/7184/XcKDI8HAYfGuTigLGhCMgBju8zBvUqjVCNV2z7MgxpEWZZ2jQRR
         4UwxWW47T1OOD0a7tcR5rshMP5dxKMokwKujihhpON88oSoLhfy0LWIieUpxgC4CDHJ2
         foO7k0KAdwtbZJmAE85g4GlyKoPU6wqzMnAXrP/cEN4LCj7GPw/NUhj2s/mEzHIpVVoj
         +/P9Xn2QvtdughH11d15PVXj0gYXloRfaU8fZZkniPV0NDnDUSRYq7P+q6DHZSxwNTf3
         6wFuN0hbOC5YGQwwSOOcA/cpV8Mgfahu3t9EWxQ01GAFD7MoHzcCpeKrguvuqlrwjcDw
         aSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=s1Wi1n1k1tvzjnZGeYsh38Zudyl6wqadvm40u/suu/c=;
        b=CfV1CUkNQNenpqVH5v1XakLKhqiREuQFfTcgm5jxt+3ta+zp7oQ8gyYFj0RTnm+ZyQ
         45qiihpWI3AHKPWiO68TfT1KfO34vOKNB/MZ62JfVw7OrxzBNEfSXmozcKQK7VxEEZL7
         jz8Ga+KFEaPyykPphxulNL8R+EvpR3WobJgmGKYb+Djy3K9gOq3eWcynwsYtDVd2CuOI
         c9i8Ol5EkHTHvbp5Nh20iYIvbPTZi2oCfbybk1x802DQ5CO+ZexsnV6Fa48NbApcnszw
         GCov6BlPNnB8eC245kHOpIDKVk3dWqN0SZakylX/k/cGILr3wqwB4xyTSJ+ISbHv1ewS
         12fA==
X-Gm-Message-State: AOAM531S6BBJjYX/O6NwUZl2WcaAm5ujWkV/X54nqSYfQjag/daK7LXU
        ZCErmi1+ub7Lag/9FeMrQgU=
X-Google-Smtp-Source: ABdhPJwuOjx4xuI0eB/i1N7Aq4vigYTdeRlPbsiTxb1oTEXcqBORzmUI2JVPB3ByQ05uCZIlimOANg==
X-Received: by 2002:a63:64c2:: with SMTP id y185mr13172867pgb.125.1600139911574;
        Mon, 14 Sep 2020 20:18:31 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:30 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 01/11] perf metric: Fix some memory leaks
Date:   Tue, 15 Sep 2020 12:18:09 +0900
Message-Id: <20200915031819.386559-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found some memory leaks while reading the metric code.  Some are
real and others only occur in the error path.  When it failed during
metric or event parsing, it should release all resources properly.

Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d03bac65a3c2..90d14c63babb 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -529,6 +529,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 						continue;
 					strlist__add(me->metrics, s);
 				}
+
+				if (!raw)
+					free(s);
 			}
 			free(omg);
 		}
@@ -1041,7 +1044,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	ret = metricgroup__add_metric_list(str, metric_no_group,
 					   &extra_events, &metric_list, map);
 	if (ret)
-		return ret;
+		goto out;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
 	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
@@ -1049,11 +1052,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
 	}
-	strbuf_release(&extra_events);
 	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
 					perf_evlist, metric_events);
 out:
 	metricgroup__free_metrics(&metric_list);
+	strbuf_release(&extra_events);
 	return ret;
 }
 
-- 
2.28.0.618.gf4bc123cb7-goog

