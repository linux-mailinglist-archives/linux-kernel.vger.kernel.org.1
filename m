Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEDC2AE692
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgKKCv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKCv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:51:29 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:51:29 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m15so501187qvx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bulE7KzGYIStw+Zl8IeHnyGg4JJF3dfqfcXDUty9Kvs=;
        b=VkSMAoESM2PhniILgFtn37m9VIfatRNQSCdzJJ7WKqWjcjuLqG+VkWdjeRnBOQAUxr
         iVzykI1wXrTOnm4o7q5YWeJoUSpglvysYTgymBopV+FD4Lf6e+ufyX3bbbO91xY0v6CW
         99+Xw+FGgJ5xLJPPQLNt/7uH6xyBaRM5auYU9hlT06+PzsdueIWyI6jRXjW1ZeYBos6F
         MGtNhwg5O3vBxvlxr7KAAHwfkshRwqetAbAn+sOAMK/J9zuNqBbIkcZHv5E54V9R+T7K
         ICluv5640GCIoH1CwWCrLk0N8FSdi+xIUUGulzdMYCBTr5ovWewHPccsbRf+l82wZ0og
         2iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bulE7KzGYIStw+Zl8IeHnyGg4JJF3dfqfcXDUty9Kvs=;
        b=QyZGODWo7SMoOrhwGVFSI9AFmM07+W4EJ6//xum9T3+b7/bSE7VwAXV3EFtuaO6VBI
         vtr/cjkLQPUQWroK5325Hj/bw/PFfCCE/6Y40NWD2nf2kipYFOG8mihm+tQppJlmuwCx
         PB6X1HFqt3cY/FKNlAPaVciBCagjZaj43AiKkuwZSKT/zhVYY+TVotlAfoPMnekoAMb+
         Rkv6VOH0yxKcgPUJxlRMCcHdW/KaOfLVYMcJKU9rKzpmYMXjtwOttLl8ywO9T3+C/aEO
         zau879bq75tg5W5wHlU27haikyMcn6bRev6dCUA21+QE5XN4MvNdV1dPM8016JFT51q4
         SszA==
X-Gm-Message-State: AOAM533oExicpf+43ZHXvkibKzW5pVaKoWFtPDcl2GfSjY8mFZmEQT2G
        SOOWU1so6KM+AvQgqy5te5CF3M7LscdEoYRkizI=
X-Google-Smtp-Source: ABdhPJzUT8nzcrrTw4qSR2kkL02EQ16pfhi4e8UiOPyCvensjx9bjx0r1OPZIKUuw/o5/hclvf4GmZwS8mR12oMLQNE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4105:: with SMTP id
 i5mr22618577qvp.47.1605063088245; Tue, 10 Nov 2020 18:51:28 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:51:20 -0800
Message-Id: <20201111025120.1694158-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH] ARM: unwind: remove old check for GCC <= 4.2
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since
commit 0bddd227f3dc ("Documentation: update for gcc 4.9 requirement")
the minimum supported version of GCC is gcc-4.9. It's now safe to remove
this code.

Link: https://github.com/ClangBuiltLinux/linux/issues/427
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/kernel/unwind.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index f35eb584a18a..59fdf257bf8b 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -18,9 +18,6 @@
 #warning Your compiler does not have EABI support.
 #warning    ARM unwind is known to compile only with EABI compilers.
 #warning    Change compiler or disable ARM_UNWIND option.
-#elif (__GNUC__ == 4 && __GNUC_MINOR__ <= 2) && !defined(__clang__)
-#warning Your compiler is too buggy; it is known to not compile ARM unwind support.
-#warning    Change compiler or disable ARM_UNWIND option.
 #endif
 #endif /* __CHECKER__ */
 
-- 
2.29.2.222.g5d2a92d10f8-goog

