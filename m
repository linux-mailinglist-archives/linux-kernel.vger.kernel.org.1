Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976C127D9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgI2VTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgI2VTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:19:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306BC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:19:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y7so4513400pjt.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=zLJyFMf9XZVQIy9gnwTsATrEt+DgUwH6ys2B+6ApuhI=;
        b=Y7594vIbHkXBhApmTedw2NwyrpJX9f2YfI72IgOYLGX/daGmvomA28H71cor7NZwm8
         rhkEBz7K2u6j3w5klPkBAnppYc0cuCn4RnyLCDfttpT4iDWk/n94iCjGAyKlW2n5HKFv
         VZD80GgYBFs4kqSlF/45g2NKdo+yFdg4pHUfz8VxC89N+fm2M6pDetzbdZyiv3grIhWa
         ap5hgRUbvDzc79SpSnPaJ5WA1QmEAg097fIckc35Qc5saTiIWtXSiIAsSZhdZQWhyJIQ
         3X5tYfFzxQR0xYWMH+W0II9PkT9SbovJ5UMOG1DwLs1ZAzODwQFn/4CsCnMvoeXYBi6y
         tEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=zLJyFMf9XZVQIy9gnwTsATrEt+DgUwH6ys2B+6ApuhI=;
        b=k19E0Th3/7xl2f7q21ZMyybx4+CjsOlekX5dT5ya/iPMpLa8e6+g8D+pfGpDsnPzSI
         outqNJU8+qDCPnruDQlhdn8C6CdSpCuhlDDz6wQ2YqMPqlmYcsug01INrt0X2qYBh8GB
         5BTwZZVq9zB/UyPA17Se5hcAiCrcGVwm7s7+G3Jnl1djkEDEB1zlkCpXssF4mXvz4G/n
         EMlNvSrkCZGGI9weOFR1FGk8rT3MQOtoj9gP/NxHx3h2KNiRyFCyFzVTYbdXgMtmDD29
         DOq31IMjKs/8jJbVA6mZYoDsW7w8s2Vn42X6vOwZ6OBrnl3v8kVUuwI7JNDYMb5+ldEV
         MiMA==
X-Gm-Message-State: AOAM532+F07P53sxUlNhEfUz3OLYVeXfV0z/nx2iS7qjmUZi6YCGNW8c
        kloxQoq1Z0bH5tF1na6W76qqUp0l9DbPB+QgMsw=
X-Google-Smtp-Source: ABdhPJxMiJ29B6/aBRGEVbZqKnFd8BQ8IkyftiV8NGjJZ/F47cWFXbYu/vlnLs/c9iNH8M+N1zQ5Jkxd0qSzOpcar/4=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:aa7:9592:0:b029:13e:d13d:a054 with
 SMTP id z18-20020aa795920000b029013ed13da054mr5822227pfj.26.1601414382399;
 Tue, 29 Sep 2020 14:19:42 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:19:35 -0700
Message-Id: <20200929211936.580805-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] docs: programming-languages: refresh blurb on clang support
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel with Clang doesn't rely on third party patches, and
has not for a few years now.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Documentation/process/programming-language.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
index e5f5f065dc24..63af142d64ec 100644
--- a/Documentation/process/programming-language.rst
+++ b/Documentation/process/programming-language.rst
@@ -6,14 +6,15 @@ Programming Language
 The kernel is written in the C programming language [c-language]_.
 More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
 under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
-(including some C99 features).
+(including some C99 features). ``clang`` [clang]_ is also supported, see docs
+docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
 This dialect contains many extensions to the language [gnu-extensions]_,
 and many of them are used within the kernel as a matter of course.
 
-There is some support for compiling the kernel with ``clang`` [clang]_
-and ``icc`` [icc]_ for several of the architectures, although at the time
-of writing it is not completed, requiring third-party patches.
+There is some support for compiling the kernel with ``icc`` [icc]_ for several
+of the architectures, although at the time of writing it is not completed,
+requiring third-party patches.
 
 Attributes
 ----------
-- 
2.28.0.709.gb0816b6eb0-goog

