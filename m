Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AA28ED06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgJOGWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOGV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:21:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A229C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:21:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m62so1915055ybb.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C80j7Nw7LdZVv12jD8G4UBrzvB65iIyHmBDpLMfgVHg=;
        b=bvdjG2rQGHmMvr1DZqKC/RqeSBgJsM4YcQtisq+e/149HyeCkdRsgTBmRiQPOZ+flU
         4rjxozmYVmI7FP1hKEqiP6QF3KnC7rANwP1A6MjfnqRTAFGenQFYz01XoNsgDrNsfRu3
         TRBuESkoTOJmXSkrMFe+TUF9ouG3aJg171p2zGcs2UdK5t0n1TvoG/SsyTIEMadHQ7Va
         6f0rVbjBAD6jVINB0JHwIlXzlCSPZa3MUdi5THBqMINYQFp6bnOXXrYD8MHHItuMFGea
         zDvfjxgLXNKUxdcosI8ebxaGQcUhYm+dBWcu2mTE5zbWTmKuOZH9l2ir6RjyyRATGwvt
         8ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C80j7Nw7LdZVv12jD8G4UBrzvB65iIyHmBDpLMfgVHg=;
        b=Q8wdUqVcOnLiYVbPLM6MmnxpbHHaNEFULkKULPW9Syq8dKzYayG7cIMlGpoQHXPj43
         GsEq6g3k7ciIfgWMdfF0Y6bri7Bzn4qCLkaHt4ro1Gu2ykfyz0OBNOvosyBwLzQpAXby
         0IlktB+eKFV21cn8WPW35u5AIoAEdQxK54NQqSyv2jplNXxasRSsxShaTa05E1zxNhzZ
         ra0ShZWez8QNvllrEqFP18IZUIlsbwL+IYGv3uuRQt4uqEWcItw1JpmGtTeDnITXK0pG
         ct04BEsjiUHsTp0yC+a/P9zToACpE+6v47zivByWpxy9FpgFeTw7oX9mdudWLJ804XSz
         m/EQ==
X-Gm-Message-State: AOAM530lA/iQ7q3b4+s/VvYj8B5mtt090lWlgc2T4XiR2clEPihGvI+T
        eWBHBLCfP/KeRD53ANEzV5fU3Jj8rZO9
X-Google-Smtp-Source: ABdhPJwRtI+sk5qFLEqcVagNij/+WCcI3F/UAqcAHx7xojDczOt86a6MCvQjP0wuKlFheas9VlRBvYhy4Ddr
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:b316:: with SMTP id
 l22mr3282909ybj.395.1602742915638; Wed, 14 Oct 2020 23:21:55 -0700 (PDT)
Date:   Wed, 14 Oct 2020 23:21:48 -0700
In-Reply-To: <20201015062148.1437894-1-irogers@google.com>
Message-Id: <20201015062148.1437894-2-irogers@google.com>
Mime-Version: 1.0
References: <20201015062148.1437894-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH 2/2] tools/x86: Fix some potential undefined behavior
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
(ubsan) with  perf test. Part of this patch was previously posted here:
https://lore.kernel.org/lkml/20190724184512.162887-4-nums@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/arch/x86/lib/insn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..e8874a8cac2c 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
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

