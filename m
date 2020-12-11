Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385B2D7ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392323AbgLKStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406220AbgLKSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:48:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D6C061A4D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x12so5819663plr.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=E+U0sSuZCC6dC6kicRnG1UaOFnx0iJfVyKRNQUtLjfW4hBBe8OQHaAuEWS9h6JwKDx
         nx6Zu83awRxikbvdB79vty/SByEvJivxVql9gf2LMdRTfeqEVv6ipQ1QsF9J7PWYP4ci
         xFn+wn1LX/1iDg9jO4eVqOOQ4FreP1QjK0OhIyps0vVvKsrGxhaOt0uJ7F7usCg/jpLp
         gwWhvDGGPcYg2A/8emqAajS7l0RY+zs0C+//CZq5Gur4DDUAlFbFqzlQpajQdqS8M9Zx
         v1gv/9kwRgkR9BQVqOJaPgZ90khLPqENshOnYY+glZxACDE1KVCQlvqrVGtAtOTfVdje
         HG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aPTc8wYkBIIZS9XLhaJqPHrVGew/rHRzWtLqs6SwnEk=;
        b=uT6mwGdsOT0TNT3pR7VUmJymzOrqkGRHWqgWkXJelXhB3XTggCEDhyRl2YfPpUPSRb
         itVlG2MDcXdiPrZAY48LAR7/j4tVgetZ8CP1brDR3Ipf1hsFHlF2/a+IJF8FT6CXWmrT
         gvNzh6VjwmL5mrUN4pLmu8m7yevOzpTuQEjq5FQ6iA1amUsyQ+RE3cOsfMh0VJtyIMhu
         /dkI0t2UTfN1F1S+QKTbV/uXepAKX4IfXY9H4NxbquwvBWQuRgzSLSI9fxXzqiCSrKls
         rE9qVn8IGz5PJpIIgKiVBnSlawaUSDrPS9f02tH3btW4a1S6T7SafyAWWR5ER9MXRbPM
         /Q0g==
X-Gm-Message-State: AOAM533EzEnQuZWHTllOKlFvDp4QZjyJoqlkb0IhM47delnkg1YmGjUB
        q1ADJ3uFQZevoun4uuGhfSr9FJ6PL8TR7px1Y98=
X-Google-Smtp-Source: ABdhPJxd+bMesTAWKmvtUqjomdCAHsA1n3+h09FJfVuePnPbd9mL5SpzLXlx8lDAG4fdUSPHIEIQBY9z8nx1PVd0SrU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:a24:: with SMTP id
 o33mr10805536pjo.191.1607712421542; Fri, 11 Dec 2020 10:47:01 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:30 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 13/16] drivers/misc/lkdtm: disable LTO for rodata.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.29.2.576.ga3fc446d84-goog

