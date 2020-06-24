Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D0207D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406565AbgFXUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406546AbgFXUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:33:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF15C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e82so3496439ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AKMu7RfRr5zvA7HsB83o+xQyox7udGa4dX0knD98vpQ=;
        b=hwKULFJxGC6lzKBnQLuceB0YfBkygKMN1Y7kZQBIXHCsEuVKl7k53XBbhlEet2kuY6
         c5h57Jm4RTz3npco+GM34bS8OimyDEzCAs5RtXK9amKrkhc3iWeXVSSos5q0no8zlKoC
         g7pLlix/dBDvLN2ZPktXFsba5h3mffSKhoE5+GmDS8Vr6JOxA4ewukdjiiGEPv8wdNVT
         NFihuGuX3xW6/cOtws4+jn8A9DLBsarXxdSvLrg+AB01n3pWOgDMboQG92CgRsUahvu2
         9lqJTUHzdlliTFgZhjxMp/9FS3YVs31mDAc+87qMDsCYIvXwnXEZPUfskY1g7XwXJnjL
         oU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AKMu7RfRr5zvA7HsB83o+xQyox7udGa4dX0knD98vpQ=;
        b=E1aR8Ax9rkai6wjcMi2GjG+rYdfXKfuB8hiv++gwG7FPiLj/4eGmnmrd6q9oWYqHXt
         t2k4+U5a3Rd4uUMyJ8BkZwFCjSzM6ZyngS8vKmdoHrRE296CKKNmweNY7unH4kHqeQ0k
         u8cL0r0JiD9mvKTORMfSk83G6P76MXehgCUbaLNqufHTf2yHRy1qyHHgrrLMWfwGOddD
         RkVO13SgjfS6xbHhMpwea12eW/u8Qml9r76+Wer5DKjtXHrOiZiD2CJTPlNfB83xJUNH
         YT8GADLLGgpM2K6ykK8kp8BkhVud1GQuwS1CEXcpWZlSfDbR5MmMHaQllU2dNU32iz/C
         QzaA==
X-Gm-Message-State: AOAM5325cIh9GaYSxwYTnObzT5TjOnu0PJ5RnQoysPxcZLMUeQR+8hAI
        MRjYHTB7QM7JrIcNtBAuCtSsEw6uP5ENSnkdues=
X-Google-Smtp-Source: ABdhPJwsJ60waNyWplHPwTwdw+lH2n4awv5MY2TpgjYhyfFuYQs+mtvKBzjvblN4Mn7p7o+48GiQMs2cNGX9hzUSV7k=
X-Received: by 2002:a25:dcb:: with SMTP id 194mr50401188ybn.226.1593030801479;
 Wed, 24 Jun 2020 13:33:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:51 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 13/22] scripts/mod: disable LTO for empty.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 296b6a3878b2..b6e3b40c6eeb 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs	:= modpost mk_elfconfig
 always-y	:= $(hostprogs) empty.o
-- 
2.27.0.212.ge8ba1cc988-goog

