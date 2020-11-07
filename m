Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D176B2AA3EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKGIpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:45:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942EC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 00:45:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l23so4556933ybl.23
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 00:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fzwLmUg9BrArXqj3uzgLmgiDgNrjU7jE+CGMP35Ad9Y=;
        b=LVnfVfNrkWDdooqiFIJAOpK8o9u7d6ZTKpiF2DWUqzpoGHVQQkAc8Wq3XV0ZPhscZr
         rqXez6K1SZij6m/YdVB4I1aWPBeAEU0rRoi9gJcJd6MZM2SeQj0x3vydXKqV/vrACSSh
         Bkb0V+eXIkZCNaU+9bAO98paU2HqBOTOd+L0QH6MyqkkoFVynrZuRnKgpfdcHNXSXf51
         eJkKgwRoxqK3naTTeoBxl0UXZ+pym6af+Y1PPxKIXkPXVWwoy/SJcsZnEzhIV/eFc3E9
         9ibFksl5G/r5z5GnDY37w4tlrk94Fx8O35LXAToiWH0Ifm9GrlhwjWO5ce6LrqT1j+3D
         XgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fzwLmUg9BrArXqj3uzgLmgiDgNrjU7jE+CGMP35Ad9Y=;
        b=fzAl9RQH6pJbCXs3uyh6QesGP2MrASr5FK+8U68VX3hWHRiDXDdG/nucUvFVK3sQzC
         qGuJmbccUbwVhn7CWNGpMOPCKpepj1v+WEUhZ3M6+4u8RP0Y6g3+zez3xPBn0gR5POt+
         Cdz0vBA7cdYsqZbC7Ur22lNM+WbiiV9WSSklEFUuE9PstzMh++uRUA42YVf/Ye2evYDg
         6Gfvc/z/H1OSElfncP2G0LHpnFRpXs+o+XlJiXkgnDPXSsmic+SoxeV5Bos5zNx6+2FV
         cj6BbutTpehdRf9Ynx/o93jmKn91eTiZJckcIUqNwbW0il9hIomtip3fdMCfl5nXRWxs
         /TTQ==
X-Gm-Message-State: AOAM531KuQU7IOWRyhH6NRYXOZSCp63JBjE/0aHg7pQmuYCuAoIMVsQO
        kfQUHKLk4RiVpIZwcK0/v3B9kQ0TrC1qgilbvXQ=
X-Google-Smtp-Source: ABdhPJwvbyxfTGI1QWDDyyYWDUNMhhhxA5QxQAsjXG8jJn7MS4MCSMqlGRNhxrVjhHM+oz45UvOWbFaNt/esUQqAoyU=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:420b:: with SMTP id
 p11mr8784954yba.100.1604738733025; Sat, 07 Nov 2020 00:45:33 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:45:24 -0800
In-Reply-To: <20201107070744.1133811-1-ndesaulniers@google.com>
Message-Id: <20201107084525.3417278-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201107070744.1133811-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2] Revert "kbuild: Do not enable -Wimplicit-fallthrough for
 clang for now"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e2079e93f562c7f7a030eb7642017ee5eabaaa10.

This has been fixed up over time thanks to the addition of "fallthrough"
pseudo-keyword in
commit 294f69e662d1 ("compiler_attributes.h: Add 'fallthrough' pseudo
keyword for switch/case use")

Link: https://github.com/ClangBuiltLinux/linux/issues/236
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
* We actually want a revert, not a partial revert. v1 removed
  -Wimplicit-fallthrough outright, which we don't want. We still need
  cc-option for GCC < 7.

 Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f353886dbf44..3edce16daede 100644
--- a/Makefile
+++ b/Makefile
@@ -777,11 +777,6 @@ else
 # These warnings generated too much noise in a regular build.
 # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
 KBUILD_CFLAGS += -Wno-unused-but-set-variable
-
-# Warn about unmarked fall-throughs in switch statement.
-# Disabled for clang while comment to attribute conversion happens and
-# https://github.com/ClangBuiltLinux/linux/issues/636 is discussed.
-KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough,)
 endif
 
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
@@ -905,6 +900,9 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += -Wdeclaration-after-statement
 
+# Warn about unmarked fall-throughs in switch statement.
+KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough,)
+
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS += -Wvla
 
-- 
2.29.2.222.g5d2a92d10f8-goog

