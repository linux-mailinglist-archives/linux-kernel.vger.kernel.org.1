Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC09223E29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGQOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgGQOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:37:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429DFC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so6757866pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu+rs2+2gElCUdDzPBQL6sWFbu1uYUhKK5LQZgejHd4=;
        b=G1hceBPwvaKjLw0Pz1VWyQfYuSAj3S6gxYAuMFBnFyaK/fQPgIaGZSGoVFkCZew70m
         ze2Z3xLPLmgxND5yOmf85tI9pGH/TgwkAebNfYWNLc3IkWr+LZ9TpZqVdGdgyH+uNHw+
         J1Eh3BGz32G19EECpZQbWIEas6/V25xLJz7ZTnUbosMjIqH/AsgzTIbMhAYQW4m8gawH
         lgAb4dbKuhVMYmhdStvWrnVmbbsbktez/cExgpQnMuliiM115gMbQcBN6kTInPS5Q1UI
         zhPKOHnWqtb7q2ezdJoYbP0LgzU/lyTQYuUzQZXkyldINOt0tlwh6QPauklhscvR3koY
         xxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu+rs2+2gElCUdDzPBQL6sWFbu1uYUhKK5LQZgejHd4=;
        b=cVXYJCIdQvkBw9Ohr9CD3S9oHwXHbk6J2BUwWk/rgz2E0QO9ADcgqnMGYd5673Z8Vl
         nBkG7B/YcCZi6Pkm7ZYTU7FHOrw80yShhJTWDJBJBTXHzMYW4OZE8HKAulwWHs73AmKV
         Esa6urqppPQ8k2TiX1jYaKjA9XVDJpyLvPckwB3ogGG7oki9P+72jV/WAnmNCYTfUx6v
         VRnCHi5SCWa5WgZLYjjEjJc24iqAf35TWqJoaeZRCYkUYgKDbxz0R60Eu2t5GpeAIrEl
         Oki1yEZp5XEqFrrN4Qa5MYspPvp1o62d2QIgJoWoO/QWC3mxNz+4rbm6NOkd4oj0ozdd
         TIRA==
X-Gm-Message-State: AOAM530lZ6QaJ5OWK/JoQdCsfgBeFMLjfgz8imABNk4rWKTLzZNTl+ks
        7LJRw27S+gwaa9jTmO86wuY=
X-Google-Smtp-Source: ABdhPJyACb8fWnQ3XHXwrxdhBgxXQhTgtgH/s2lAAE7C1CB7sxcrAJ/L2U5wSQjeMJw6gm5jgUxL+Q==
X-Received: by 2002:a62:192:: with SMTP id 140mr7970491pfb.53.1594996631866;
        Fri, 17 Jul 2020 07:37:11 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:37:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 03/17] perf ftrace: factor out function write_tracing_file_int()
Date:   Fri, 17 Jul 2020 22:36:14 +0800
Message-Id: <20200717143628.47721-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse this function later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3c0e60fdfe0f..9abf97c29cb6 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -168,6 +168,17 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int write_tracing_file_int(const char *name, int value)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	if (write_tracing_file(name, buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -298,8 +309,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -308,9 +317,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
-
-	if (write_tracing_file("max_graph_depth", buf) < 0)
+	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
 		return -1;
 
 	return 0;
-- 
2.25.1

