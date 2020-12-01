Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10A2CAEC4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgLAVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgLAVi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:38:58 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE54C08E863
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:37:25 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v18so2265565qta.22
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ioq5snZDZDriQbZnteUYOvtfB50kdQ3NzmE0Bt/uZj4=;
        b=cTOyof8D27Eb15ctHFkguMw8fQJTDxevhAv86xzy/JyHIKohwC9kcPozSDGX4ZvhjH
         hv1rR4G53Z3ln+Cmqb9RjUK77Rma8WI1knxtAcMzXLo7jpqZX03s3IjAuAKcPGe698IA
         tqCRwqNReUE6+2DHbVXsqGEAH3DKihfcNiemIM2g7zH4vjz4yRgdtjEGOxPucEoKGI7o
         TP0NKml15Zj0kVGxkNppCMBBYfw5RCgEPqWu/IFdSOVZwRHRqv5Cob9LcnhewWjKXfLJ
         uxIRAby/D2ArEQUd3zLg1F9Be0crsc+S/9EwAcR/g6vVudxNV4zhBdGhHukse6etLm6r
         ljAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ioq5snZDZDriQbZnteUYOvtfB50kdQ3NzmE0Bt/uZj4=;
        b=IAiy0S6nwh+c7827H887JZMqt5JQmRKpa4UBwJ9YOBGxntlXZgA3seGeR/Z+NH21dd
         FIYWfrQEhbtMoYQvu9879gpcTKODfu5Slk+Syu2xe+0gP4PmI5BEjQoAmqZnWOsEEoUC
         a1tel3LYiG4mGpcYOpQFjyRkoJ4SSeI6unpKn588kIh+hLOjHNcdsaRjwV2GQpzXWUWN
         pBj1H6lU/2ZRXIliDtLQRc427bKCcQHxB7qvkDV8Yk7dVR8JxS4oAG35Qhwo3uaYhy4q
         Ii5Fdlj4NgY+FgukeNX7emgOAB/BdEdvDdu3nTNk9R3696tj3zCt5xasfD71sb050v8G
         zPvQ==
X-Gm-Message-State: AOAM5326WqavL6jGVB9ZeKoFJ8vTjLNaiM6JDbYUVLtx9shleBtBOFBz
        okwMzTKSG4vPX5vAsXkrpkeEkqZeRdWrYH/6Bg0=
X-Google-Smtp-Source: ABdhPJys1KC5O8D1Yq/SB6UjKKBqwmwFlcdQVBXthpLtwbdm6607CxLE6p9eN4XkDXwUu6B0iPn5A0SVU7zu7mNfSPU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4051:: with SMTP id
 r17mr5301753qvp.39.1606858644813; Tue, 01 Dec 2020 13:37:24 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:36:57 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 06/16] kbuild: lto: remove duplicate dependencies from .mod files
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
index eae2f5386a03..f80ada58271d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -281,7 +281,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.29.2.576.ga3fc446d84-goog

