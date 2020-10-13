Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330B828C606
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgJMAc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgJMAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:32:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BADC0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b41so10529960qtk.21
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kVJaNW7eSaj0HFfwrYDw0RQeIfteodxyLLwn3XkvFZA=;
        b=qUa1vHHcZgq+GOQlX2iLACARLoC/9h8vfuF9kwmVqVXA6Ay82zVe3uxoPk7oE9G3a5
         qspmhivovZKsl7zTe/TB3hhhY10WADRHi+k8hnkVHAdhubXLpnUEkMhxCS4DpvzY4fG5
         PHSzJ/adCJ3UEYsP53P7E1DazaOwM3ZH1sxI6dX+vcxypIOCYcQNAdiKAN+VBaDFVnEm
         8IPYRyR+hoO/wI0KaLDF4HCza/Ja8k6r7MrNh/bpFr8Hc/LwI0gzp5Wcj5mZmwtbzUgg
         SiAlpC4qMNr7O/bt2XOuW/rZtWiM/XRlM4/puqQkxdt2vQoQuYb0S+oJ1E4MnJy4FDei
         mUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kVJaNW7eSaj0HFfwrYDw0RQeIfteodxyLLwn3XkvFZA=;
        b=UgT/M2ZaBmeVOYRUo35V90WLty9uMC5Z1rEo5qNbtiDsXbBl7sHtJKZK9T4KcUmluY
         KPJnq7rruqpzJPiPRu2y5SS4yLp7Kj9OKAinJWu2mK80Fm22V3SM122MZt/04tNlr0oa
         tB4FvM/7C7Y3CHH7eKjpQPaUkJnSSimTSM1lyItxXIw/suYJ7T+29aKIvQuZvxUWnZQr
         pUK3OY9emRMKpDchOdAkgF18t4QQgcY4WxIrmDTZXItwUAxocAs4tAqWc2Pry6RZi1PU
         Z1oWONVBIAWAHv95CNKoya7UAR+LXEMFgWsF97pwiy0xhWgylAUzgli0HllOl3nB7ARs
         7F2Q==
X-Gm-Message-State: AOAM533GMAqJYFkxDM9y+Nmm6YDzMLikL1+RFdE+Smd5+NXXtMcKc2+B
        FTWxhdCG0XQDHSq50GNfoI1Xa7NQjthvGBswu7E=
X-Google-Smtp-Source: ABdhPJxxVxVLXATH28VAjZYJvCMjRNOfP6FG+zwrqzoHwd+tVOzS3ssjn2tzJdDq4rR6gIG7Z06UGW92/5YWikencXY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5843:: with SMTP id
 de3mr28374099qvb.12.1602549131356; Mon, 12 Oct 2020 17:32:11 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:41 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 03/25] objtool: Don't autodetect vmlinux.o
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
 scripts/link-vmlinux.sh       | 2 +-
 tools/objtool/builtin-check.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

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
index e92e76f69176..facfc10bc5dc 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -41,7 +41,7 @@ const struct option check_options[] = {
 
 int cmd_check(int argc, const char **argv)
 {
-	const char *objname, *s;
+	const char *objname;
 	struct objtool_file *file;
 	int ret;
 
@@ -52,10 +52,6 @@ int cmd_check(int argc, const char **argv)
 
 	objname = argv[0];
 
-	s = strstr(objname, "vmlinux.o");
-	if (s && !s[9])
-		vmlinux = true;
-
 	file = objtool_open_read(objname);
 	if (!file)
 		return 1;
-- 
2.28.0.1011.ga647a8990f-goog

