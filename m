Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E18227DA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgI2VrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgI2VrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:47:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AFEC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g1so4055026qtc.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SD1yF5YD1LCllhQ+wHxnWDGScJRWPVuGZBuH/1UV7E0=;
        b=J0iZkzh/GjzAvSvvMSQSffvTtscp77TuS/rOOUU4WJ9pgFewxPSYIc3SuYF5TYZa3f
         nnJs5NE+Z7HnfV7im6jer/93vPDjH2tAsMsDCCOkNJH1RmXE5K6MIkNKUWtTL0TsRGwX
         qAdqdJq3CyXfTerbts+lbY6m8AMjwxizFh09pkc2952byTSLnpnpLEsH+VeTxDQPhQlK
         KJc/bEwAWARFDxCjnLIpypY36iZV6YBpeoMe0S3Fhkxk2EnpJ3bKxAnnRVKOCtJywZ8S
         cn4idbWnDoWjvaMpJXjclpVdG1XxH/TZB3j/SaC5oSMROSGKYvddyUIYzmMFA/b7OTLC
         QNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SD1yF5YD1LCllhQ+wHxnWDGScJRWPVuGZBuH/1UV7E0=;
        b=ZaFIxMKjRLQPZcrth/L9RHglEyhbmsmP+tGrxtXXhQ3uadr0hSy41w8mj2KEp0jcrV
         8dI89Oymw/GfodjU5P7CnwyDCxGvNhEF8l8+aPbvv5XwJEl4mr2MbETJZJPgirVVDIfB
         ApqdVL4nu/SP/+cFYwFefG4HKUzNdemIgjGTws+cwPJMbov+Gg9ApBAB8OkottFBdey/
         hkgyf0H6B+3yyR4pwoul1Eq3svmxr1sQ9HjHpSAZbV6soy3AB9aVW6YPmZC0HayK9vmE
         z5Jp7qRZxlzb5DWoqfkoigvqV06tl46bMn7tIAAxDiybNUsjmbYjH7vbrK5KwLuJnGmU
         rRMg==
X-Gm-Message-State: AOAM5328D7Fae7iOVbvObOuQLQWIjIgUBd+bH8H2BUDgyU159ftp+73E
        CSeNb6aj/tutbm+qP1HvHCVJQqjlDID7kn+ntsY=
X-Google-Smtp-Source: ABdhPJy7ECnfWEGwUFe6hxmbM3YxQNxU/8qssaAcXSiWxNNwaQyUUyZL5rJnjOfK3ZrxDFzMzY/3wIlsYUo/Me039B4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:55ce:: with SMTP id
 bt14mr6729584qvb.2.1601416029039; Tue, 29 Sep 2020 14:47:09 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:18 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 16/29] kbuild: lto: remove duplicate dependencies from .mod files
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

With LTO, llvm-nm prints out symbols for each archive member
separately, which results in a lot of duplicate dependencies in the
.mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
consists of several compilation units, the output can exceed the
default xargs command size limit and split the dependency list to
multiple lines, which results in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and
easier to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ab0ddf4884fd..96d6c9e18901 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -266,7 +266,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.28.0.709.gb0816b6eb0-goog

