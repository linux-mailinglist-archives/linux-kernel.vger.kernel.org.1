Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CC294602
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439659AbgJUA0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439616AbgJUA0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:26:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07576C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:26:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l18so387935pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdwZtavXZ+Nr+Yg8C050ouEBSFK5iEg6NJ5eRk4E26c=;
        b=kmy3R4cFRHdnUMj4lX6EkxXlxO0e/WsS2dOTP+YsXBp4s5SLB7pyhNr7BAsKuGtj0y
         McucWYt2EGQmWXKC3yN5mC/mzHbTiFWGEP568elzPOGQQyo/CK87uFlWI8WoIHGGQAOA
         uLnFKTglUUfNx4AYm5YD7Bai6ejm+eX2jVlgzdPmetVyZU7vy/0St1qLYtpWlGBFvi5+
         THMk0zWEgRrPuopaIIQeYo49wH2sfzSx6BuSSotoSmNgN9C5fwz0ytpL/3GLhmLEFYGi
         KRX/cfA2AxUYeLrgyV8zAQt/SaAzCH5OR6IkmoHQ3+Tdin+30pQzxj5nvjQexr1Kgw/y
         ceag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdwZtavXZ+Nr+Yg8C050ouEBSFK5iEg6NJ5eRk4E26c=;
        b=rMhnA7pc1KuCjVi6V8I+wkhzvTKg0UeYpFGVPnom02RKPTqfPjnKaEIFLW5BMcsCO0
         wfLzxG5dn1PYywINK6OR7DfKgG6hY9LnOzflDnOwbMmqBRrUOgfcJTKurKKc8wu+vZ63
         2d/Rx3CEY/BbqguqBYHVQ/G2qOP+db+kqDr3CR+QLMrvYl8aeqYVm8Um7TSJ2kXjRJEu
         afjLh+hzgJS1WVDr2v4FgL1gji8ywHdC+4ogMw0tKDcvv5Ksp0elaWHq9qbbIH/42P6n
         YphwLG/fvLzHoKU4soVA4vs+0I7KBO6XDsdicYXa5rgU7NxbdV7yPxdlP5BJZQkIGdQ3
         Nc9g==
X-Gm-Message-State: AOAM530Y0r/AkYb8gK5HSMOb/gm++f9cCbCyqY7DxGr1tgIa+7Y2aQwF
        QLj/a0iZn8XxQjSAcg+LpYyodg==
X-Google-Smtp-Source: ABdhPJxfOCetMUqH8m6a6JNYo2mthcQnxyVF52JXElZqp5BetNnsFu471+x3X0vDvrE3V7RVdTWWGA==
X-Received: by 2002:a63:c806:: with SMTP id z6mr736707pgg.430.1603239999512;
        Tue, 20 Oct 2020 17:26:39 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k13sm173222pfh.177.2020.10.20.17.26.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 17:26:39 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] perf lock: Don't free "lock_seq_stat" if read_count isn't zero
Date:   Wed, 21 Oct 2020 08:26:19 +0800
Message-Id: <20201021002619.28072-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201021002619.28072-1-leo.yan@linaro.org>
References: <20201021002619.28072-1-leo.yan@linaro.org>
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

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
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

