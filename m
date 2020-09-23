Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E452752D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIWIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:05:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC199C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y17so726781plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fKP6FOpDeYpyYFjLH8r1ABkMFs7DJTksKtWssEBEscQ=;
        b=BBIhMtS0MCnPqHIv0CpcpUDZg0HS0Y4IDnD5lG8GSOiJ6G2is7QBkIq91z7nwDYfPo
         4ktk8OuaJxc00mnz1bQph0CxT87cyGRdEi1mfwcOuu1td5GCTxlZeHJPXeP68Vbsq4xw
         sKKZvWxY8RY3c4xLPK7aRHtWg3RUItwCYcvrPNJB+mKqXH7vSa+tE0cpIfhx21bag+ZF
         LquYGuGIaA7HUzHH4ru5qycFcgZ80KudDfdtyyYOBjpx8DuhFcm24XN3XAa+IdcC2alA
         2TQN6MJs7EwbkXCDVLPD80M/OKm67QLxyfmIlRfbeQSxaFZVvU2D4mXZ87ejRpzAsTFQ
         RY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fKP6FOpDeYpyYFjLH8r1ABkMFs7DJTksKtWssEBEscQ=;
        b=oIUHwfnx96e3oB4EAmpHYhEctZ7+sPAFPHK8Woi9xmohVc3HZVttk/FH9UN4wpnN+c
         vTiIAQgRjFPhWXZwrVLGdNUmESSqsVfYkV6x3Bg8+WIEL+8SGL0fEJFLfu47VvueR/Zm
         WhGSmsueAWNCOyxq2JtQqbelAd49/VHJasjziZHxwIwS2rZlmtF1hX1ouLLA3ii2aPOd
         eZONGjoGG/JkCsJAjP5R+RYI9Gu0jjbPV2v8z58ABFYpeFsz+HBKUdfiGP4UiipJ3r7L
         jJSOnq/yqoyAm84OkOVNXIGwM4Pfl4hfwx+3LS2RfYV9IzM71tch5e8lHLCTTZ8I9hzA
         GLGg==
X-Gm-Message-State: AOAM533JwKTRlFZPLDUllRxJn1seF9ymEjjYQaxLkSZPHV1qCPyE+FZ+
        Hxv62FuRYAxYnBNuM0Vn5Ps=
X-Google-Smtp-Source: ABdhPJyRKpPKTw30bfG4WCf53aT0fTyRGScwomwokSCSnCrt5psqCyFSjDzfO+JtV8sLWTRY8lOaXQ==
X-Received: by 2002:a17:902:c252:b029:d2:4345:5c7 with SMTP id 18-20020a170902c252b02900d2434505c7mr5857761plg.4.1600848354414;
        Wed, 23 Sep 2020 01:05:54 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:05:53 -0700 (PDT)
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
Subject: [PATCH 3/7] perf inject: Enter namespace when reading build-id
Date:   Wed, 23 Sep 2020 17:05:33 +0900
Message-Id: <20200923080537.155264-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

