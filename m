Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F5528ED05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgJOGV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOGVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:21:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:21:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id 97so1122313plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UJEGV5xwox/0wW0o0swixifI6DFM0YrOg3bmPbi+30A=;
        b=lVDggNAvqxpDm7yOO50yAMlKNIhkwQ4o2yfbniiEfQgGPpCiM5JUyIIidUctoSDs+2
         N7ekybj9qi0s1NJtSJM3NPjIxJxU0/46xXYEtdqrcvvUxpYrQlBl3f9Fr7fqxSWnSNhh
         ceMbKLhwAQEO4n5lpO5toT3fD6R10ZMi1Xz/p+9Vrndl828FiEqUEq8D3zdtAFMnuixX
         0mUJZxMu37PfOSDVISnTGSNolO9TDaJCVgzpG+XUJqXHKlfIW7lbMvj/jV6qOcPva9YA
         8reUENMg0ZHwidkjmGxGBkyfHBEL28kVkuIif4Pw939yTyzRTDaTE4nM74denBiDp/PY
         OR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UJEGV5xwox/0wW0o0swixifI6DFM0YrOg3bmPbi+30A=;
        b=Ai3oZiP92fKYCpVNXV0sen5n+hGsB6z4/fN/9nmGT0g4tkcJ5GuhIH6EoxRMd4cuhn
         EhiAeXJp6XfsdDl1U3Snir6y6IUFyDhZLODju8My2xTjNPW6ceJ/JniGxcl6tgQaRf3L
         LeVhCgZuJHBpF+FC3Fdxjyr3lza6p9iMp6V5TvxMOaHeKz3suEVdJUvWGb7sYBuIxoTo
         qOSfxvyjrO+5I4Hxu98lK7bAB01xRpfBk3UjnxBNAoZdIrSs6NJOC+SvXyWdarGVqrxd
         6FcPUh25tGzaxkqRfvm0FHYLsvYhGe4mNymjkflq4nc3Fn10Ji2zmiQOzdClTBQ/WB4k
         +BCQ==
X-Gm-Message-State: AOAM530xNRNP8FLiUKqAplkiAoNz7jQAVREdj18ihRu0qtR1w79yiJWt
        7v1rHGrEarZT4s3ahVHZu+9jUzHGW/+b
X-Google-Smtp-Source: ABdhPJxMLT3WcNiiXVHBBL4JrCMVpMH8DPRDU/MtAQ0KOk/outo3LIQpYTqEzUu26D2i870li4/XtihJ0bdB
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2a5:b029:152:5652:7191 with SMTP
 id q5-20020a056a0002a5b029015256527191mr2676561pfs.7.1602742913479; Wed, 14
 Oct 2020 23:21:53 -0700 (PDT)
Date:   Wed, 14 Oct 2020 23:21:47 -0700
Message-Id: <20201015062148.1437894-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 1/2] x86/insn: Fix some potential undefined behavior.
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

If insn_init is given a NULL kaddr and 0 buflen then validate_next will
perform arithmetic on NULL, add a guard to avoid this.

Don't perform unaligned loads in __get_next and __peek_nbyte_next as
these are forms of undefined behavior.

These problems were identified using the undefined behavior sanitizer
(ubsan) with the tools version of the code and perf test. Part of this
patch was previously posted here:
https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 arch/x86/lib/insn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..57236940de46 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -17,13 +17,13 @@
 
 /* Verify next sizeof(t) bytes can be on the same instruction */
 #define validate_next(t, insn, n)	\
-	((insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
+	((insn)->end_kaddr != 0 && (insn)->next_byte + sizeof(t) + n <= (insn)->end_kaddr)
 
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

