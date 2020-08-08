Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC923F5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Aug 2020 04:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHHCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:32:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384A5C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:32:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 77so3513541qkm.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFfOcAY9NHCKx2jHcAWpPvvKXB45RHZv9/iNsEBwXwU=;
        b=uidF/MhzswI6tsWGvi/OA1Y/BOkyk2T1h2+Lf1Jh3mN1OEajHhlMfNmqR0gWF/GJ14
         oMDHK2fhKhtgIDtSAE8JLXSrYlF8fB+ty4L+okV/ZA/D4/OmBZT61SI/KVbru83KPz87
         NAprfpQciTY6Vek1zSjgHtHBa61MN2lyeXMEzjyfKOSUv9yRcd3mRFglOxMpzjax0Jut
         r2kaYPjOyZiuFbXNOBT9Inio8HGS1lvzBpKZBjP9Ws/DACSIh8qdkFn4Hs/Ym10+kdbR
         hsfzf5kT8Ku8SNfeWcLcOmaqNln0T3+jrDrh4vkOdwCiuTUDAY9e4pGJ3Sn8V2FttutI
         W9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFfOcAY9NHCKx2jHcAWpPvvKXB45RHZv9/iNsEBwXwU=;
        b=EPDp1+vECW1zU4PLUFB8YTtpxTDE0a+a6uRLUZLKCQ2t+o8CMFPkLskyhxqTTctkaO
         gqI4VN7Qlh0LS/VHEJzsUc4E50ekoccd6/ateRhkyAix5AK5oj0J2WEv/lRccAnYZFzs
         XBeMtlCCJYVvPkJMhJnygRkgn2YmavUAdWUH7oT6PSugfjm9Jfmr3UWwDESNYEZzKyV7
         5GV5Ed1pExuKdB+93Oq2+CGl3WEEaxaEzQw+Ot3JfTEKGF5/LTZQ6z/yMCw7ihShKrC4
         4HZy3rpdzyGjQLJCUnmlEa++tangmbi9f9Za+MsUkXWKdDhPuqZGQDTrV0rIa5CHuFxO
         UyfA==
X-Gm-Message-State: AOAM531YpmadyQka3ekox6PYNKwARUcbuONeDTKLllloEcdgkukhiA86
        AwiXGylphGq3OR6K4tMi1FM=
X-Google-Smtp-Source: ABdhPJwCcwG0OLUyAvdYwqCWaeuYbRuFbVANUJKoky/qGDOXisEon24sSXybTVoK32B0fiTBVzfU6w==
X-Received: by 2002:a37:9e48:: with SMTP id h69mr16829548qke.249.1596853933512;
        Fri, 07 Aug 2020 19:32:13 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:32:12 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 03/18] perf ftrace: factor out function write_tracing_file_int()
Date:   Sat,  8 Aug 2020 10:31:26 +0800
Message-Id: <20200808023141.14227-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 1ebf71ecc1a8..4b3fcee5725a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -169,6 +169,17 @@ static int read_tracing_file_to_stdout(const char *name)
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
 
@@ -299,8 +310,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -309,9 +318,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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

