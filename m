Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798752D8D5B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406979AbgLMNmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406911AbgLMNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:40:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4222C0617B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d26so533881wrb.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbUcWwmkA9H9YpcVE1GVGOEgOuV0HZe1q4eWGHmdNsE=;
        b=iHI/sNz1gp8cM/UulK/nrn+fMJm0gW4FrGrgGVU+hRuYfCKy786t+KVZF4nv1adOI3
         6/c51vX2X8FlzIVsskcuzV66NSG6yRw7loz5fQhdN2BDmb8uE7tyDs0MvQQAPhgoNIuG
         iWTT4vzbR1A7ehzQyUl1Phz2WCOOgCYvDCKQQEBQVtPjAnOd5mORq/PE4HpnacwUwuCd
         Tp/ZkFlBB757mZLMjIolC11ws6aCenrMOurenf4a243G0kBAWcbzyaSyhK37A86SnWi1
         33B8c4qg6sE9VxKGEbuTFOn0cML9KUMUm3J7M8skKm2VdSbaFZv9EB/vsCY2ZGxL3mgY
         FvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbUcWwmkA9H9YpcVE1GVGOEgOuV0HZe1q4eWGHmdNsE=;
        b=tLjGFE7PMEpsPf6SyazGrqaBVWGlYlJoaAKZoMrg749EuBsFqVGpUgEehRfTc9mRtQ
         QQp8IM8UmG9Q4t8RMMlh/t4gut6vquEX3+lbM66th1p0eKzOHb7FvwJUlJGczuHGDHCS
         f2g6iUHWmiBKJ4rO4cje06eKVDLRf+H8J5lSxqc0g9xql2jvdoM4c9VAUnV4SDdJMCcE
         or1nNVAjPVMlRxQjlfvxEd9iWNwxikB9t2Yrd0WHIl/vnscOxFAHrx18YVLwHye8J3jB
         KN0k3OBA0B0L/1GjPt6eVpbSvijL04xbsFe9D1gzHxW+IFbfLlM813Gw833hI3GDnoSx
         OVYw==
X-Gm-Message-State: AOAM532+BQIghIEy1roDH/GkwqwCN0qi2cqk/YKwbdK5B8FuAiDA8sLs
        4fyVgO0DnXwH3Qm4jcMzxrdOTQ==
X-Google-Smtp-Source: ABdhPJy6/Wpg1M+sZjjuL4em1DWaHSn+xD74cN6YQYjB6D4/4y8nx81SNGwFeicLDUYnKoX68KUxSA==
X-Received: by 2002:adf:f70c:: with SMTP id r12mr24028297wrp.234.1607866750731;
        Sun, 13 Dec 2020 05:39:10 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:09 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 08/11] perf c2c: Refactor node header
Date:   Sun, 13 Dec 2020 13:38:47 +0000
Message-Id: <20201213133850.10070-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node header array contains 3 items, each item is used for one of
the 3 flavors for node accessing info.  To extend sorting on all load
references and not always stick to HITMs, the second header string
"Node{cpus %hitms %stores}" should be adjusted (e.g. it's changed as
"Node{cpus %loads %stores}").

For this reason, this patch changes the node header array to three
flat variables and uses switch-case in function setup_nodes_header(),
thus it is easier for altering the header string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 50018bfb1089..846ee58d6cfb 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1806,12 +1806,6 @@ static struct c2c_dimension dim_dso = {
 	.se		= &sort_dso,
 };
 
-static struct c2c_header header_node[3] = {
-	HEADER_LOW("Node"),
-	HEADER_LOW("Node{cpus %hitms %stores}"),
-	HEADER_LOW("Node{cpu list}"),
-};
-
 static struct c2c_dimension dim_node = {
 	.name		= "node",
 	.cmp		= empty_cmp,
@@ -2293,9 +2287,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
+static struct c2c_header header_node_0 = HEADER_LOW("Node");
+static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
+
 static void setup_nodes_header(void)
 {
-	dim_node.header = header_node[c2c.node_info];
+	switch (c2c.node_info) {
+	case 0:
+		dim_node.header = header_node_0;
+		break;
+	case 1:
+		dim_node.header = header_node_1;
+		break;
+	case 2:
+		dim_node.header = header_node_2;
+		break;
+	default:
+		break;
+	}
+
+	return;
 }
 
 static int setup_nodes(struct perf_session *session)
-- 
2.17.1

