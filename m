Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6E28F677
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbgJOQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbgJOQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:12:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD8C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:12:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so2420809qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=BdZDlc0VgpP2Ln7XZ/SJzkYEHvK/fd43ssyrqdMV8Lc=;
        b=mW6Dp+96INwoUu0vyVN9WtCsrfLyXMNru/NIX528PPsBLkjCGONPtRuIrkY5rqMuVi
         YPTIJms4p4xd2n5X3ZS5xAp47zvrv3sy+3ZsibOCcsBB1h2Nb9oLzrsQeKfNgXlD7EK9
         XY7JBoE8kayWVwhbj7USCWhMw+b7kGKs51Z8ehZitV9gc/9YpR5eD8ktfIdqqhzm7+8i
         3808CYJKywtpSXLuQ2nFgvoDHwE4UIE7At6lUy0Y2CCmGPGXNL9+mV6E7gTdeip2I6dU
         PHSx7IKdL6gmMh5JbICbWvf4vMbCfppO+r8pReIRMMcsNV8WtPjWi/OqYFVNWQpAWjnx
         w3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=BdZDlc0VgpP2Ln7XZ/SJzkYEHvK/fd43ssyrqdMV8Lc=;
        b=fz4Fw0hl5DjV9T6RF2M4mg9FQ9DK6vXPUZW9g9Y8p1rfJv51kuscZEgrSezJzNKSEO
         f5e/cZkYm3OBr7KKzwi0M8EVQK3FNeKuuXe9PVlZ+E0KibVEF0xbwOIbdNABmSXZHrVp
         EOsvDZXxIDh62ttgGptDCK4C7JVdZd2RpG1PUMAsWoz62wy7WQ59jcqqlEbuHEZHcRSG
         y/fIfYIDstbNdkRtrySTlSeIfSLxo7Kf9nAxRLtyqBBOKjOVQpaFYxJz+pxLqjFcu9rr
         qKeWbSTy8qpCQ4tJG1Fh5qU0ceNbfWxMJ9OHVfhzkk4+EZQNFFahBuuPvAqjyKsdi46M
         SkVQ==
X-Gm-Message-State: AOAM533I8HvpFq1CjPJeCGRGo4TarcjEGY3clW9pbBZPJ7jQch4zRl4O
        LRyOe5QAIcZ4QSZXVREPhfWvW2E8t5pE
X-Google-Smtp-Source: ABdhPJwL44cUfBhiz/kpQd9sl4Ph/ufdHDFZTNTTRmCidI/pDuveQJl7QSqPqnYe7uEEO9s8IFOcMEeihI4I
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:a345:: with SMTP id
 u63mr5556078qvu.17.1602778340129; Thu, 15 Oct 2020 09:12:20 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:12:16 -0700
Message-Id: <20201015161216.1563600-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined behavior.
From:   Ian Rogers <irogers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

Don't perform unaligned loads in __get_next and __peek_nbyte_next as
these are forms of undefined behavior.

These problems were identified using the undefined behavior sanitizer
(ubsan) with the tools version of the code and perf test. Part of this
patch was previously posted here:
https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

v2. removes the validate_next check and merges the 2 changes into one as
requested by Masami Hiramatsu <mhiramat@kernel.org>

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 arch/x86/lib/insn.c       | 4 ++--
 tools/arch/x86/lib/insn.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..be88ab250146 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -20,10 +20,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); r; })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..92358c71a59e 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -20,10 +20,10 @@
 	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
 #define __get_next(t, insn)	\
-	({ t r = *(t*)insn->next_byte; insn->next_byte += sizeof(t); r; })
+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte += sizeof(t); r; })
 
 #define __peek_nbyte_next(t, insn, n)	\
-	({ t r = *(t*)((insn)->next_byte + n); r; })
+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
 
 #define get_next(t, insn)	\
 	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
-- 
2.28.0.1011.ga647a8990f-goog

