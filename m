Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF827DAD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgI2Vr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgI2VrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:47:22 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3024CC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w92so4074228qte.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M/tCJ87SKQnbyhBQptnFDCNgoy9D1scy1+3ph9ahS3g=;
        b=gdAEDDvLlL0msAdcbIE0elhCADhQmKL9S16dzNU1NewfqdOooSY9iFqACy8+PZ7gHu
         RjJqXHtJjRJu9BoQC0Z+qcoslnaCbYOM5YVwAUiEbJv8oMPbNKei4NbKX8/eYf1TjsBX
         LuD//MCUmK3U7ZJ2uod6D1w8OHvoyhKJylEziLAmUyzobSpYb93PY4CL1x+jJuLiN+Df
         TJvELp9Gtnh21l2Y6CWFhRqKGqHS7xc78jprEFcrRoojdnbVtKont9eEkY55sgaj+pEf
         r+rlpDV8ZtQQ3iUVmb9timiu1KOz8XTe/0fr94WEPlFW4uof3ENuM7MDtO9p1BgJUAsl
         mKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/tCJ87SKQnbyhBQptnFDCNgoy9D1scy1+3ph9ahS3g=;
        b=cc2yQvOGC+xlJqHyJMN3LvTqtrOGO2oTMIsmwJZ3a44klOoTCcZWuKM72BHqUBlxxv
         cM3VQl0q4ATGrDm5w5rWTOVVMqxvYY3x/1CxPSVT+NI0bwLSpvH+uw5QblhqIYZR58JX
         xqkO4XW9fwt/+O6AHcYqXiETo+iTkxMur2DS4xMq2sGE1vtMmgE9Qk6OH7VQyW82bL9/
         mnD2EdVuW2GuT4kbc3zGHPRosPF+FXBIsJqtz75FkknzZkLXrrHnrna4K7ctb1GltwGJ
         W3tfTa3zEuf4QtmFNWfyfvKfcuIkdbhriWJsbkqRUKWAKfHfcQfw9SYxIAK/FAKYikoW
         fuNA==
X-Gm-Message-State: AOAM531qYA9IiTxVsVVKAwQ7jI2jczU0+05+kFNUzvaPHwIkmTM9ROKH
        iGY2m+1GAHXt3TdlPcc9PuIZvb7WWevA7rS8p98=
X-Google-Smtp-Source: ABdhPJwIclf1YZILYpRHL9aLGjIyClVObMTVmWZ7pfwr9sU8b01qvKeenw3eQ8lUfzBJlACcTh5VbLCas1CqVTaKm1c=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58c7:: with SMTP id
 dh7mr6716936qvb.20.1601416041280; Tue, 29 Sep 2020 14:47:21 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:23 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 21/29] scripts/mod: disable LTO for empty.c
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

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.28.0.709.gb0816b6eb0-goog

