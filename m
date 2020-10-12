Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04F28AEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgJLHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgJLHCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFDC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so112544pfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnqrTrAcT/VOtU/CToYJH1aMkdkbU54lkaVpUGUxWv8=;
        b=SbndNsBSOWsCe2aa6ngCeSV+PsZP4lCEX6H7UvmMebcEwvKduO1tpXnrOsYBJpJfaK
         2tqH0x/HdEueKn+WcN5gCiLrowduEdM/B6quaiMbXDNPOsKg5eV+EiVd3dwE99mitLK7
         JJ4wZrv1QvLoVDQiExjpzSR4Luiwph/HdPunEwODRQQBxpr+THAtUAli7YU7t6gSaaBT
         rfyQLuzNSTadhSYsrnFyAmqpIeZa3FtUhwxvXWKjRVgSkx6kmri68y5CZ5nKqkzOaZwz
         t1pJqvaq+PSGwFp541JNM+07NUUND7K+h0EToaupitbhDydQ0J8+lE3HJrPWo4+7/Phm
         P3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZnqrTrAcT/VOtU/CToYJH1aMkdkbU54lkaVpUGUxWv8=;
        b=XVuNwHppNi5UfUFBWjGFy1z4sRm48BFAqLy4yyhmX5rHH4HVnTbHtbVJQanIboLi2/
         4Cin9GEZUOJ8QHTHy19P5Y5L/lORU+hZ1mjqAwEwV5uO3XzDamrEe/iznUOpzLASwMba
         asjT0skXJDd3lCRwZzaazB3eC67q4OzezfgQ/1YuqYVx5MycOHZIatt2JUFh0z9bee3A
         DYqI2uJunoUSfpO1xAfpdLTdK/K3S4TeZ8vlk/uA2Dg4TwBPkQix3e2/t9xNscjElkoy
         g6+xAAO4yqTkU6Fp9tLMw/grlzeCvIedsRYKpBJgvgNwHJGUw67VG6pl+kN57qxW2mer
         TV5Q==
X-Gm-Message-State: AOAM5313Y2NBqCJEwrLXcit4V5NaP8QWI32cYmWSt+KyqazBzg9h7bVe
        feORAgy+sH24fKFjCUR4kaQ=
X-Google-Smtp-Source: ABdhPJyoPg0Y0hJGcB11OdgrYnCrhIBbGpDr9Xm1rxBNZHuLk4CQJtzv4LMFKBH0ssC8/tWgyhx9Hg==
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr18176893pjd.7.1602486150065;
        Mon, 12 Oct 2020 00:02:30 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:29 -0700 (PDT)
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
Date:   Mon, 12 Oct 2020 16:02:11 +0900
Message-Id: <20201012070214.2074921-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
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
2.28.0.1011.ga647a8990f-goog

