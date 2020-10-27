Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177C529A589
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507671AbgJ0H3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:29:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36404 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507665AbgJ0H3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:29:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id r10so304576plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jTLK72RQ2qzFhUlC4dRmrJecIfAJ+TEyN9j0vePWpRA=;
        b=hUrFPqjKsjkkNDHhcqfRew1qpSff6k3Qd7lgWmTWYClPVfJgrhrZWSSoUbVcag88oK
         aVpdrarS1oHIsrWg0miYO8n+OD3B9HQ7vZOTTMZqtjgNo6GxIxw+pJp6njklaYNSAky5
         Dvai+YnsRPhxufWryM1iFiEcBJ5UekqdNaSgIz14t8FZ/ygFdx6XqHuQQB+dQ2Y8n2Le
         j58aSQk0F5vOXHcPDlYUiJ1VrmuN491FmjIXyASkHRfiwQ0wr+g8gpULyS5p4COeG3ZA
         nYdL0EBJbgTobU730KsIeR43J+FMNVeG6gqtZ+GS17+I+HfhRLdhsVZlXquoMTnqAPM7
         +5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jTLK72RQ2qzFhUlC4dRmrJecIfAJ+TEyN9j0vePWpRA=;
        b=uHzQuGdmdhltqiw6dI/oHvRjbTFNLOIMVrulybkvNB19owmeF7Wd1cr1OAIYp+yM7k
         LxpSDTxWr4NNzY8oZCSVa/dnbtt9p0lMLRsZTfGuS+FzeL84iSlvDTcnunFS8GpysCJN
         j3xrdlJ38dvh3SgKFL0dUAAhKdx8GDTiAZi23VpkepA1xfBbBXDHfnegoWDtaAekpWnq
         klJNoSNZePYDR59NlLBbIn2thQhk3E/NWjkICqXBAhcbiJ6GQg+xYf8JmZ2XLoHHXY4s
         fV3AwH5UPQzItvDQwnxQ07KJ7Ru92SrG7b51wB1sqzRnk8M0q9R88T6ML+zG8WruYor/
         s3/g==
X-Gm-Message-State: AOAM530ZL3G95GTV4IrQXarMGBRTFx/FWvN6hBNtn0yFsFmGC7ncNDgv
        hBzTaLqDwOAdYlsYkSGDeEU=
X-Google-Smtp-Source: ABdhPJxNoK0pLSr2j2RxqQjDqaTYNcSi1CzGTJrMo0qWNQ1fYf93WzjLX9euOOmGFEK2EVqoOD8aYw==
X-Received: by 2002:a17:90a:3fcb:: with SMTP id u11mr839330pjm.128.1603783743284;
        Tue, 27 Oct 2020 00:29:03 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id x26sm1043209pfn.178.2020.10.27.00.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 00:29:02 -0700 (PDT)
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
Subject: [PATCH v3 1/2] perf test: Use generic event for expand_libpfm_events()
Date:   Tue, 27 Oct 2020 16:28:54 +0900
Message-Id: <20201027072855.655449-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that the UNHALTED_CORE_CYCLES event is only available in the
Intel machines and it makes other vendors/archs fail on the test.  As
libpfm4 can parse the generic events like cycles, let's use them.

Fixes: 40b74c30ffb9 ("perf test: Add expand cgroup event test")
Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/expand-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index d5771e4d094f..4c59f3ae438f 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -145,7 +145,7 @@ static int expand_libpfm_events(void)
 	int ret;
 	struct evlist *evlist;
 	struct rblist metric_events;
-	const char event_str[] = "UNHALTED_CORE_CYCLES";
+	const char event_str[] = "CYCLES";
 	struct option opt = {
 		.value = &evlist,
 	};
-- 
2.29.0.rc2.309.g374f81d7ae-goog

