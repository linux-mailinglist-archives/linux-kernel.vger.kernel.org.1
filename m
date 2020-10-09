Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0D288E12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbgJIQOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbgJIQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:14:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34999C0613B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:14:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p187so9500800ybg.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4HzvBRrh7y77qbzNEjVJ7UvC0hGlxJRwsbNcMQwghFk=;
        b=ZNNTphyuqijkRLPow6CC/aXgGKsYBRFzq/yKSKcyxkgD/lkmYvVzPyhTAXclZndZdh
         L3lGMAoJTnYIv0JKMzOqbYFxS0Z/IXLeipSXzl8ZMqk57oa/VznHrTFfgXFW0/IfZcD5
         RqYTIdP+HiFz81jIb/NfQ1D9Haxc/uPLhTJVMZahC+e46ULJHAo2s4sjJ9UcS9BRTN/f
         US6FT8LeKQoMEj/HEtVefzXtpmZ2ndjtN2ZYgQYJ/yL6MsN+9+7BEiRxGDQkpU/Prblz
         jXweMCv47z7uMWgqx10kSVje4u+fTnnhzw09XocxwMtFtHquTcS5T3ofegl5oYhmmSKN
         kLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4HzvBRrh7y77qbzNEjVJ7UvC0hGlxJRwsbNcMQwghFk=;
        b=ks0VESClT7QPUgR276GJC5jevqPoSo5HCjmz2h+k6nGFkrP9peg5bCsaSkRT2ugrX5
         m14gpyUt8b3JnC2QskWk+RsTG/uIw0xJ72sA37SMcknYXCZRBTu0JhdCTa7ORkw7bVKN
         BHEGhJflmibKmxHW124F13yu0WS2CTc2NowM5zMr2DwWx/Ir4Ii7kFL14kM8SnA5fWH/
         k6ShGHq2c4QXHTa5o4dkWbRGt64W6/iEC0q5p92i2eHKr29n3OW0MgTjCq0DWvl3SRii
         P6hRXngyt1p+ljuYaevO8dCjri0l2duw6kUpBcjKsY4OuCWzGj7QWCIqgUtD5L2eMQ0U
         Xxcg==
X-Gm-Message-State: AOAM530gJWiDPywMnrqcY1boS2IC/ebPZLU+BSmt2+OkT7Q/qjPR0CTT
        mCz/3O0whZTBIdvtulAcQ33p6lC3xs7/Qk9A7eA=
X-Google-Smtp-Source: ABdhPJw9ZF97isedllPPEidWjLehS6Y9RG+YGmBbMiJNYvcjDkRjrFEYfvutxmTQNPM4Efl/aY3oqUISefUn5+QvCQY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:af90:: with SMTP id
 g16mr17666057ybh.259.1602260045402; Fri, 09 Oct 2020 09:14:05 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:21 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 12/29] kbuild: lto: limit inlining
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 6d31a78d79ce..3fe2dca17261 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=default
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.28.0.1011.ga647a8990f-goog

