Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8827DAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgI2VsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgI2Vqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:46:43 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993BC0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:46:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b39so4098422qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l2+v7INMYKuznv8xFN02uATUaYPeLt4QVP2a2KYnEdY=;
        b=IBbDoPstUx6PvkrgRiZ41KzIphJCRrEzSeZx7R3BsJc/c2FU1xsagudvCmxJS0b8z2
         SjjbJNbVgzgrgsE4IMeYQoBOkgyNAJsokXmK8DUkwveVuIMwv2vc9kL6j11caQYcNzUq
         0vjsIxHqB8pCA2/K+LOJlqU0rm+b0gi9ZppmGex0Nq6vg3lFfAKr6863jjw2KdNrpjQl
         OE30bcUDioAlTaHnVtbs0RImv7YEk6Zl2qjv9SZgAykRMeNQidEDWQq/427XH29WRmMR
         YCgaWWx4UZCNDu0gcLoZMQgMMVDTjQx98O5L72qcpTB4n7pw1Wyy4oYvBIPd3DNE23kA
         MbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l2+v7INMYKuznv8xFN02uATUaYPeLt4QVP2a2KYnEdY=;
        b=bxiRscDtFcRlB3Ad4z3jRAL3ofzErfOj6rhvyUsdYQBPxQhfNWce2B493jP35E+1nA
         NS0AQKsZsJKJ21n+qBN/3xymBih0usfvW/yHZCUwLEquSBBbBd+rHKJWc3wNOJouccoe
         WKSG+COHK9e5bfTvEE7hsnX7yvMKrtzIGea7CWjGIOoFVcvNlGJdzAv4kryLuEYK70Sn
         XStXLWzNwt86dOZi/ek+8Vh7CPZ8m4oYUvAYMgOqJ1Qud0OzaY6VdYhr4FAdSZPDb0bA
         19au9944ypNJOYE30VN1YAonRQXUB7N1NF+L4Hqlshp+U7kAsCQUN5X5ocZeSSErh3KN
         isLQ==
X-Gm-Message-State: AOAM530S5b8hcaPAvW8iixE51jjmZErBknZ1+YWs0MZAYoum1xrEfO14
        YbcKvqCwUzGRtRPJSAxKjVgQQZ4gNhSaey6rAH8=
X-Google-Smtp-Source: ABdhPJy+h62MhF4FERE0IvCpSLKvcavDzP6aQkays6EhouTsZ6bz+Ey8zRCePHhbZ++PNw0vWZnJFjS/bZTiM4aTEAM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1767:: with SMTP id
 et7mr6378060qvb.43.1601416002753; Tue, 29 Sep 2020 14:46:42 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:07 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 05/29] objtool: Don't autodetect vmlinux.o
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

With LTO, we run objtool on vmlinux.o, but don't want noinstr
validation. This change requires --vmlinux to be passed to objtool
explicitly.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh       |  2 +-
 tools/objtool/builtin-check.c | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6e2d9e5ff48..372c3719f94c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -64,7 +64,7 @@ objtool_link()
 	local objtoolopt;
 
 	if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
-		objtoolopt="check"
+		objtoolopt="check --vmlinux"
 		if [ -z "${CONFIG_FRAME_POINTER}" ]; then
 			objtoolopt="${objtoolopt} --no-fp"
 		fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 71595cf4946d..eaa06eb18690 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,18 +41,10 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
-
 	argc = parse_options(argc, argv, check_options, check_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(check_usage, check_options);
 
-	objname = argv[0];
-
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
-	return check(objname, false);
+	return check(argv[0], false);
 }
-- 
2.28.0.709.gb0816b6eb0-goog

