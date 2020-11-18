Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D52B8769
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgKRWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgKRWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:08:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FAC061A48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a126so4521942ybb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zNEbBbUjVUwNrqsw9c+UpkNEFF7VA0EYfHLp5cIzntw=;
        b=n0bp9cJvxDsjt7xTCOt5iMFW1d/2tTomLx5U5GAiKgRUC31U0PGdIlVksp+a0VVrdY
         g5/MehVGAk5dAFkfZ/0D3/kc0qKP/5ghMg0SX2rzCLQrn7ZzkYIMJRTQA4tAkeENX90q
         zMfWfxpHMr797C3+ufNsF8n5E2EarI0M+SxfmyYFrfheXFRY/USHp0McDL2ojl4Lgr9c
         ZSVHHwyxFBuJf6EQIB49Tm2/Idyx3u+mRdPPOBh4ppAaY5/pZ300gTIMAOc0hbNqctmz
         NshfWwPYJRHHUsUv7bRZJJIdOYMWpv3CBbpJoRLYa/A5uDpHU91hRb4ca8tn+CBC/z2v
         7wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zNEbBbUjVUwNrqsw9c+UpkNEFF7VA0EYfHLp5cIzntw=;
        b=c/WWo6fPP7BbexZgeihyN9ZkPKdDo6JkLXiBjCobX/qv42g/s9xYe8C2k7cqhUS2Rc
         B91CfV0ortDAZ3sP8KCSKo2fIf+oWtb7t1MuwzYnPZEE0YnICHUow8fNzAbMIP/BkJF2
         Groo5I8UpRcCTgOceVCo7/FkWkX7GOF3ObjoCFRLlhuPfTIFlzGSGILj+pjPrXHHUKop
         hjzarL/uWSnOsfjjXokR6dMRx9hhaopHftcTeMroKdBTK+/SYiSelCc6cwi0YC2JaE6c
         9YBEYSnes4N6p6uwRPEU3BeLOCTgGlftFfViDz+8b+KXkvLy0RI6MSBzSMRuxcFDs3nZ
         Td4A==
X-Gm-Message-State: AOAM530T8dzjj7kNxyBBBxNgWqcN7BlFCHmnKBboYgeo/SIcwb/HROfp
        7CM3pGMjxlv620tobfdwvBWN93UnHGSiHqhl7wc=
X-Google-Smtp-Source: ABdhPJwWbtiTp58G6aNpNqEPufDWDe2zDs+IKNE1XLpICWlrRQN8YWmIrp5YpIBo0gnH6aOzErytNSLLgd+pskDj6ew=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:aa04:: with SMTP id
 s4mr8172287ybi.285.1605737293084; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:31 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 17/17] arm64: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c7f07978f5b6..56bd83a764f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.29.2.299.gdc1121823c-goog

