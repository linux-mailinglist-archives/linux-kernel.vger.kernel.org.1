Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E452C226C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgKXKAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbgKXKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:00:08 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so8708984wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5Qh18Xc6zjNeLbPQ4HFWqP/SYz2kcEjQmnK6oh7uk8=;
        b=P0IzXh98GNUDZhhFHZLztFXbagF40y1+BUJSBMnTs0fVmKVGfKS7oiWDpfJGdC7myT
         xcv3bs0vT5KO9h3lIzf4XNhkXUFxfeunR1rhhZCeOXAjZMiAlWxRi+LT+oFc9RMmZugN
         ldgDos2P7kUcaL06BpfavUOL7FOYGn7j4gT5iQFUKOq8SO+wiCvYqZY4ttuu+VCqj7it
         WG03XtwVJe0sBkb8Gz/+Kemrx7453VODFu1lQlsh0aUeZFYrzVqxEZlJcclQvAdJG9Jm
         RWHfKT05wDg2UAclBouOa2yZcinbHHvH+pgL3Xab1/jS63i9w9bpl5pIEMeaYuo6/st1
         Pdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5Qh18Xc6zjNeLbPQ4HFWqP/SYz2kcEjQmnK6oh7uk8=;
        b=UlszkKVd92se9I7BAGA1Z0nxB241PDaw+T7WaoworiLkWYvZ+X9U476jQwNeGlKe5r
         1+B7d4ob9ZCX+WgOT5oNuX7eEPOtB37zKedI7lm/AtOxCJpWVYSku8bv+ptBamvrbD+/
         YZrBW/GhLOpkI2Wa/CiVtGZFZN/jsi7JnljqES5dcVb7Z5fS6SH1sZW3deR7Teqrw2Bl
         WkFDt6B2ssDE+2bArWPBwBHaa8ykEdu0aVJl5oE8XWlNZCUtlG/yCzlgwqv0hcOQYzJm
         mR6msQLJalFO5GcaO55CDbihWYYAiC7EHeden7WTgL6GGHXhE+8FAvzSEUWseBps+K5h
         D8iQ==
X-Gm-Message-State: AOAM531+SSns7dyhkwO8zDA3PaiYNKiOwS4r8KVZAeDYoXRcwNiUbXjc
        3aMWuXy7LSChrNIGDt9ZM1733gMxdO0WgUHK
X-Google-Smtp-Source: ABdhPJyVTOuOky+hBCBloay0R7dtjKRQ0/bnAMHvP4I14OXyyaLI44sMrPePud80PtsnnXeZwpV/HA==
X-Received: by 2002:adf:9043:: with SMTP id h61mr4397897wrh.237.1606212005532;
        Tue, 24 Nov 2020 02:00:05 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id g186sm5565168wma.1.2020.11.24.02.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:00:04 -0800 (PST)
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
        "Paul A. Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 3/3] perf session: Avoid infinite loop if an event is truncated
Date:   Tue, 24 Nov 2020 10:59:21 +0100
Message-Id: <20201124095923.3683-3-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124095923.3683-1-oss@malat.biz>
References: <20201124095923.3683-1-oss@malat.biz>
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
 tools/perf/util/session.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e57b0d09d196..b73b85d99628 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2168,6 +2168,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 		}
 
 		page_offset = page_size * (head / page_size);
+		if (!page_offset) {
+			pr_err("%#" PRIx64 " [%#x]: truncated event\n",
+					file_offset + head);
+			err = -EINVAL;
+			goto out;
+		}
 		file_offset += page_offset;
 		head -= page_offset;
 		goto remap;
-- 
2.20.1

