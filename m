Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6023427DB05
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgI2Vs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgI2Vrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:47:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79DC0613A5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:33 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 16so3667097qky.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HR6xYTbNbcDM2Zx8OyOOjD6y5MQ06zsj0pUhq+j+6f0=;
        b=mjtEviXmAKLxRM/LKJDKCHLIap39YYCJi8bXUSknQxexGmScOixPfgLk2saryOKVhr
         MDXdwtc03Qsk8BhzaMB6wWLfJxFsJFr3vbeje5KUt1CCBDcvypxfH4Fd/DWdOskLuiWX
         NuoS4Bfi9pPbelk7+Wps01W1gREOYAgy0hs0foMuoNPzPZHoq/3Nbj/lsE5jTNdKMozj
         B1pDJbVp/H5WbOFBXWVr5QnvhRybtlvviWImhHwfWGzZfBrzqfvE+v/WN27Qnhw99flS
         d+zHsrVrZeZ906dvjvCq1dGlmBlNMTipr0bhZn+88+kegFwV/4iyBn9hGct0i3bRdod1
         YlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HR6xYTbNbcDM2Zx8OyOOjD6y5MQ06zsj0pUhq+j+6f0=;
        b=lVbzzVA9bln9x1A6lVHIpTxdVO840NUNxXFhx8H3nA5Uztkwfv0kpin8lEWQcKu5VT
         NiELcfYabs90Df77qkIYjlLVKK9UvDhEFdzrlTMjhg7tIHD/JechnevTJ62ml88IBJUp
         dYrjZamUtliH6H9MsdhoMlJVqlOCU5UGm06UTxqHpwVgOZ1dGMPtlf8t5JWMfnSthCtM
         2gO+7zIj9QP3yQ8If/A816l8oQs3EeCNFWRmv6Hc1ZKWhcm5avfJNkv8qPHObXOICPu7
         ddP6/S3rzYC+UtCZIzh0UxazKR8DXlyIy5t751EcYaM78oKr1onLjwxqaoj2KHn1f8vz
         AcAA==
X-Gm-Message-State: AOAM5330fO91vs3FKiefQsYtuT4w5rVVyd2PD12ia9vANWvM40+9YrGc
        vC0c9GAWS0P/ug+DTet66fNq7KrRJwQ7SLGTE0k=
X-Google-Smtp-Source: ABdhPJzU2WBEA+8eGCg04PobSkCT+PMZ1E++tYvTMvMYCJ02D4tu/Rlfu13A0+WZqSX+Koxe9SboRRHBjqEXIi3STU4=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d682:: with SMTP id
 k2mr6249286qvi.27.1601416052963; Tue, 29 Sep 2020 14:47:32 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:28 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-27-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 26/29] arm64: allow LTO_CLANG and THINLTO to be selected
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

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ad522b021f35..7016d193864f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.28.0.709.gb0816b6eb0-goog

