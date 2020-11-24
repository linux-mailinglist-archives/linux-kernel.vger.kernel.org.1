Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD562C22F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgKXKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbgKXKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:30:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:30:47 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so1952691wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8PmD3Bf9tk3KCdD713D1O58pSiofS1lz5BZy6HUEh8=;
        b=tyM6WlKWLLtXlYIvbUb8ziiZ48yujVBSTGjSJxf5F/OYmEjulDxcQ/TIWeqR9Jpv6L
         DBLMLhaiWjSCMLfzpeBtEcjRWzET6hqUmtpr4MEa3OHOgKPPBCBzDZul3d6nUG/iBLWm
         D6BDvx/1ycsy5qDP5jaLIdZcSc6Gw7BEjtUdQ6Nli+1uYEO7VjIQO2WLO7Tw8a9wXKLh
         tpSxHhB3mEG57Br7frk4MzhZefl4BLroB9R4wharWllOq9b5pgMjk8nSlcXNh1yC5WVZ
         7Ng6TBLDAhSxRMptSiIS3KlCF6yL/1q/aYfprTEtsRFwarSKQbPMFUBQW1BmxkOyUGV6
         eAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8PmD3Bf9tk3KCdD713D1O58pSiofS1lz5BZy6HUEh8=;
        b=TQ/kinm3cpDzzmhnB9BydeKi5wm/qxnOlVu4uiD8AGfi1JuwlGHT0z+9WZuL4C9D5U
         +Je3hL99hY3TmVeqgy9FOvgYaQf61zqiIYqL9IvIc/LdPTEdfnJERHeb9Z9WDUxeMwtE
         As5PETkHY1l9Nqk4fwQkMTNS52TleQd4rTNwWmkxR0kfrXdrFbHtaz1EvAd1SJ1Zx/xG
         AYUZ6tQaYEenMD7WbGAW4NHoSI9YXXvQ5aYaHh+jyxI1N62Bt3IBXt+tsvgoFA26zyb7
         E/iPtFv2aw/vVN23D8kJ3zImO3Qet42Mz8Q/eVwg2f4hu5BsNDqKGb8+c+KJk7RjVGmi
         E3Mg==
X-Gm-Message-State: AOAM531OFxZjbFWQe9Yw07bXgn3SlVSGawy4SDR7Xn6bKoZLMU4sN6i1
        /pka1eh7L8oCADWjRUSOspRcd3kipzn4tOnD
X-Google-Smtp-Source: ABdhPJwvSa5tko1akY0OLwMOYx7qNFZYXCHn2G9RzQJbE/d6r2eqFtQTtA2/JJVOF+1pJtmx68XjSw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr3673260wmj.162.1606213846283;
        Tue, 24 Nov 2020 02:30:46 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id n9sm4471864wmd.4.2020.11.24.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:30:45 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Malat <oss@malat.biz>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 3/3] perf session: Avoid infinite loop if an event is truncated
Date:   Tue, 24 Nov 2020 11:29:19 +0100
Message-Id: <20201124102919.15312-3-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124102919.15312-1-oss@malat.biz>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an event was truncated at the end of a perf.data file larger than
MAP_SIZE, the event reading code ended up in an infinite loop. Break
this loop by making sure the mapping window is always shifting
towards the end of the file.

Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 tools/perf/util/session.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5f7bc5ad620f..79b2e93c1639 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
@@ -2182,6 +2183,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		}
 
 		page_offset = page_size * (head / page_size);
+		if (!page_offset) {
+			pr_err("%#" PRIx64 ": truncated event\n",
+					file_offset + head);
+			err = -EINVAL;
+			goto out;
+		}
 		file_offset += page_offset;
 		head -= page_offset;
 		goto remap;
-- 
2.20.1

