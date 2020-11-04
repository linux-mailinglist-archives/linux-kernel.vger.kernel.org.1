Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0A2A60CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgKDJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgKDJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:43:00 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94670C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 01:43:00 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 1so10045527ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZTEvRl34/ltG27zu0i38hIQPnfchyj04AqsxWgKGqo=;
        b=mteQwTSrrLAF55P0uCUdUPSgG4mJ8q/gbQ7Ce+xgshakURElmVD/KzME0Plvo9F6MR
         Sd8e0GdWeacRcHjmq4FKBOIW/g6ntqO1mv9uDq0sJwz2IuGemG/mLF+COydE+QcBvgnc
         ZwalPjZFH3QOsOq6B6bvCSh0Q9pTa65QxHBMsB7Cmi8kj6LaSM0Z9HF8Hve0o6TnJ5md
         naSBOCK4KqlQu0Wvi6NaReE96MA+NBi0qoQ8wB+7EjMEqW30yqRC8svJKP9ndTKz1Yxb
         PvvlPaHl46asJe5O7vQhvbJaq/TgXuOgAYPT+5BnBXJeOgi0zCDme60UD5eImNmTAo+f
         AOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZTEvRl34/ltG27zu0i38hIQPnfchyj04AqsxWgKGqo=;
        b=dFNdJhB3Xn73YWyIju56FShncrYIZiTAJxL3kcFVOmmx7n69AFA7A9MMDjeMcRTbBZ
         HKttykpPdclPSklBfdPZAfry7QqNW+xUwAn3na7FwD9xjSwxAOe8NDyyT6FarkNqFLe0
         rHi9qZmDa09rpDeASiAVtq+PsQP9k7JOrfbQ98oahK5AU2aikDLrs2DItH72cpJG+q9v
         7QjwBxWpv5mr4BJKVXdIpL0MesGlHPxCkQ+LGMZHLVQneKWtnEygddR95CHKVwfgBqYD
         FDGw21O4kA10IJXISippdxZ+WLGSj84I4EGKkxZBbYTM2zb7h9vj7+YHHr0ANsnP5hDo
         qLAQ==
X-Gm-Message-State: AOAM530CFK2Ba69UkcLQtCvBG+KVfncorBNY8xsajFMq0Nr07ZlySxCI
        LcSLv9boTTKQQi18myVfe3bmxw==
X-Google-Smtp-Source: ABdhPJw5JN5TrdNWWI06PIUcmTLwFWzhpVkB0uiZJdER28unFX9dgu+PSs143NdEy3S/lTwYIp4+jA==
X-Received: by 2002:a17:902:8347:b029:d5:de7a:db11 with SMTP id z7-20020a1709028347b02900d5de7adb11mr27790701pln.2.1604482980142;
        Wed, 04 Nov 2020 01:43:00 -0800 (PST)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j13sm1884835pfd.97.2020.11.04.01.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Nov 2020 01:42:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/2] perf lock: Don't free "lock_seq_stat" if read_count isn't zero
Date:   Wed,  4 Nov 2020 17:42:29 +0800
Message-Id: <20201104094229.17509-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104094229.17509-1-leo.yan@linaro.org>
References: <20201104094229.17509-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When execute command "perf lock report", it hits failure and outputs log
as follows:

  perf: builtin-lock.c:623: report_lock_release_event: Assertion `!(seq->read_count < 0)' failed.
  Aborted

This is an imbalance issue.  The locking sequence structure
"lock_seq_stat" contains the reader counter and it is used to check if
the locking sequence is balance or not between acquiring and releasing.

If the tool wrongly frees "lock_seq_stat" when "read_count" isn't zero,
the "read_count" will be reset to zero when allocate a new structure at
the next time; thus it causes the wrong counting for reader and finally
results in imbalance issue.

To fix this issue, if detects "read_count" is not zero (means still
have read user in the locking sequence), goto the "end" tag to skip
freeing structure "lock_seq_stat".

Fixes: e4cef1f65061 ("perf lock: Fix state machine to recognize lock sequence")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

v3: Corrected "Fixes" tag to reflect the first patch causing the issue
    (Jiri)

 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 5cecc1ad78e1..a2f1e53f37a7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -621,7 +621,7 @@ static int report_lock_release_event(struct evsel *evsel,
 	case SEQ_STATE_READ_ACQUIRED:
 		seq->read_count--;
 		BUG_ON(seq->read_count < 0);
-		if (!seq->read_count) {
+		if (seq->read_count) {
 			ls->nr_release++;
 			goto end;
 		}
-- 
2.17.1

