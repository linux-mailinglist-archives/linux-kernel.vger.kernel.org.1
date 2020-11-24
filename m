Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28872C22F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgKXK3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbgKXK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:29:49 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D038C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:29:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so21712071wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxhchTB+Jm8r6cC7CBclbcy8JtqFZgJF6LPdvmhp+mQ=;
        b=YSfDTdFxP5rqLj71/gciy2MkB5vL96xaSS0c2oYwx+ITe2+1O3kM+i3bXFZm2QeEAw
         SXqNmbQ/p0IdzaVL2nSiyA0nqCqfFE+b7fFVJeIBoU61Fqo87CDURWQqjJgCQZsAncHl
         3nM2DSWfOk4qZ8vMLkipmC9WPsSMJXphCbvyzZU5FN/EN7HtFuPZaYdiK79fLY7S+pTX
         Cg0h9giNnjDFXEMgw9yKjwb3fFtZqxCowGGiSRYGox06EEJ0rHCnncvU6hwXsRjll84x
         FGmYHA3I20PqW/UlzaunhChCejcuefOhnIqtuf1NDkNfl9sZPw8IeWCKjG5Zzj+RpOSV
         L03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxhchTB+Jm8r6cC7CBclbcy8JtqFZgJF6LPdvmhp+mQ=;
        b=Jeesaz8I7aW5VBVR8F0UIUi67eGt+iq1Fo69QzenZp+AGpp4pVI6b6FFljd1Zx7Ysf
         egFtEL/q4CnxYw3wWS3jHHzo0gaAW0MNQQd7g/lkcfFWydrkm5XjRi5Eo01GXTaYPj7P
         EOGx8nfZqZYHLzaMYVuzcGzlXQj7vy+ZMiyVMIDXGfvuXSvDp0BNAUs6pTFQrrh7Uis5
         ZDEuIC3TjgjWjXng/d/2qMk8eL6qapUVau2X5CPz31cfTmfeesw3PNoXUTVVuMX4nZzk
         5ZhT7vQEf9lSMaookBM7ZhacwBG6gKICsRBr89v1e5EiyLF0X3QFLtZ+WQ72kfrY9OuG
         zfug==
X-Gm-Message-State: AOAM533Ul2T6haQmQ9wxie9DbykG/jiAEMxrKVx/AOawncysaHTuXjgZ
        KOrJsE0GbqkNu/v0qjbdxs7mMGrnpFU1EOSX
X-Google-Smtp-Source: ABdhPJzz5gk7QJbF8dDiyA2q2OVaLtNLnrH4WEFap3l1CPmcA0riGeK9tW5A+CTZ9UyM0mGXswWKRw==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr4346722wre.383.1606213788034;
        Tue, 24 Nov 2020 02:29:48 -0800 (PST)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id n9sm4471864wmd.4.2020.11.24.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:29:47 -0800 (PST)
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
Subject: [PATCH v2 1/3] Revert "perf session: Fix decompression of PERF_RECORD_COMPRESSED records"
Date:   Tue, 24 Nov 2020 11:29:15 +0100
Message-Id: <20201124102919.15312-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124095923.3683-1-oss@malat.biz>
References: <20201124095923.3683-1-oss@malat.biz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both mmapped and compressed events can be split by the buffer boundary,
it doesn't make sense to handle them differently.

Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 tools/perf/util/session.c | 44 +++++++++++++++------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 098080287c68..0d7a59c1aeb6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2038,8 +2038,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 }
 
 static union perf_event *
-prefetch_event(char *buf, u64 head, size_t mmap_size,
-	       bool needs_swap, union perf_event *error)
+fetch_mmaped_event(struct perf_session *session,
+		   u64 head, size_t mmap_size, char *buf)
 {
 	union perf_event *event;
 
@@ -2051,32 +2051,20 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
 		return NULL;
 
 	event = (union perf_event *)(buf + head);
-	if (needs_swap)
-		perf_event_header__bswap(&event->header);
-
-	if (head + event->header.size <= mmap_size)
-		return event;
 
-	/* We're not fetching the event so swap back again */
-	if (needs_swap)
+	if (session->header.needs_swap)
 		perf_event_header__bswap(&event->header);
 
-	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
-		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
-
-	return error;
-}
-
-static union perf_event *
-fetch_mmaped_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
-{
-	return prefetch_event(buf, head, mmap_size, needs_swap, ERR_PTR(-EINVAL));
-}
+	if (head + event->header.size > mmap_size) {
+		/* We're not fetching the event so swap back again */
+		if (session->header.needs_swap)
+			perf_event_header__bswap(&event->header);
+		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
+			 __func__, head, event->header.size, mmap_size);
+		return ERR_PTR(-EINVAL);
+	}
 
-static union perf_event *
-fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
-{
-	return prefetch_event(buf, head, mmap_size, needs_swap, NULL);
+	return event;
 }
 
 static int __perf_session__process_decomp_events(struct perf_session *session)
@@ -2089,8 +2077,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		return 0;
 
 	while (decomp->head < decomp->size && !session_done()) {
-		union perf_event *event = fetch_decomp_event(decomp->head, decomp->size, decomp->data,
-							     session->header.needs_swap);
+		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
+
+		if (IS_ERR(event))
+			return PTR_ERR(event);
 
 		if (!event)
 			break;
@@ -2190,7 +2180,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	}
 
 more:
-	event = fetch_mmaped_event(head, mmap_size, buf, session->header.needs_swap);
+	event = fetch_mmaped_event(session, head, mmap_size, buf);
 	if (IS_ERR(event))
 		return PTR_ERR(event);
 
-- 
2.20.1

