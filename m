Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4499B27D721
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgI2Tn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Tn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:43:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BFEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:43:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o11so4307765pjj.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=L+ZQTMyUzbfAF4MuXzem6ruOy1jTior618txOZRQrDw=;
        b=JemOKWyuOxhCUEgCq4LBeWvD9B32/OB1HfIHGAAvckrTpq5LIvBiCbRxwut5xE9GQC
         I/JldAYejW65SqHWDgvHvxerNRwDBLsXyMM+Dt+L5JuB5GCPpRUXw+RCKyk3Ksx5pqLW
         AhNOAiW8tmlj1kXInhu2megrBHMi+RnlZqpSjpPjNDtHh2oN0df0yIr4VH4A9Xh+tyCU
         1EiH/TjvUzM8GS7CRv9lSwl6qBz97BcGLKw//F+BsHJ5E93w2ancnfTwPc1cifM8wNYY
         MTMfoOi4ezt13lJAe/mSWgyD3p5bnAIf8juKQ0G4eW+/X0JoVhbzTIjxukpW2XDQvv9r
         O4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=L+ZQTMyUzbfAF4MuXzem6ruOy1jTior618txOZRQrDw=;
        b=J7l6kN7oe/LuPPxSxcsRXEpYJbps/NjBzHyF9Yy2ZEjnsrx2I9sqQxDT7p9peUlM4+
         yNCcDLLlejxzXduZ998L2ihXZstW9WXNF0YLRl8hOHW+A1qyfNaN3XkWogjUpgquUkHb
         4D8Zek7JpxgkH0RcK45AbBP/utb2/eDHuXTfMjiAkdXqqrcmWBlcHUYX3RzfWAWZgyHe
         WwMCUAFl6I6diXvdQ0LYxNvRskfJnuzEX3KqTcCXjjS3bElEAuIj1WkKmy1CZWMrtJrw
         dgZqJuQVMU15KHHoFKKCjO7bRM3k9MkjkS+sutmCTGZN+/5o3iH7PFRkiojZw9QnEa+/
         kMfA==
X-Gm-Message-State: AOAM531S/NTntvhMNbUmFn/BZU3p0+KnwyrecWKsZehUq4B56wtn04uA
        AYu8h2p1yXv+VElr0iqqmTalfscJAIyKq3NmFJg=
X-Google-Smtp-Source: ABdhPJz+UMD9185MqbkmGncxHLJ1Duw6GZjw3eYdwaS9kGJ0XQZJB5AmmUFPQqITN9rot3EA3+wKUg5wqkY7TZbMxVk=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a62:2c09:0:b029:142:2501:34f8 with
 SMTP id s9-20020a622c090000b0290142250134f8mr5448080pfs.81.1601408603686;
 Tue, 29 Sep 2020 12:43:23 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:43:18 -0700
Message-Id: <20200929194318.548707-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] compiler.h: avoid escaped section names
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stringification operator, `#`, in the preprocessor escapes strings.
For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
they treat section names that contain \".

The portable solution is to not use a string literal with the
preprocessor stringification operator.

In this case, since __section unconditionally uses the stringification
operator, we actually want the more verbose
__attribute__((__section__())).

Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 92ef163a7479..ac45f6d40d39 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__section("___kentry" "+" #sym )			\
+	__attribute__((__section__("___kentry+" #sym)))		\
 	= (unsigned long)&sym;
 #endif
 
-- 
2.28.0.709.gb0816b6eb0-goog

