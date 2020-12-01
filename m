Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869522CAEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbgLAVjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390151AbgLAVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:39:48 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCDEC09426A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:37:50 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s29so2477811qkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e77AaMfAoOs/rzHffqgIcODt2AF3tTsGcr7ctg09Fiw=;
        b=PhIES9mZeaV2CcOOl8w4l+2ikBXS+wckgodD2kCIALpUfGhJq/JokBFVnpLyEDHks9
         s8KS77HbtwZgIGJAF1Tgq1CMBOT+U0TGPDCswFllP9/Wb/lsfsDB5gnxFlvnlGfpeufY
         Hy8In8h71u/8sWWwnYUrcWgb/UQdJioTucpyV/6eOUpCpsAT76h4F1u2jVLu4RS0k6r7
         PUe2D5YpmZV4+lsiyaOpuXMkzEX6Xy4dTdjoE4jUNMaeybvIa8H1LPOZHv/Qe2/UnLMt
         PTMAailmADrwZlpd1jeXUYN/0RA5Dv57F0Y3YPHXVxD2ACvJtXUB7QfmCy0vCpyChfJ+
         bQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e77AaMfAoOs/rzHffqgIcODt2AF3tTsGcr7ctg09Fiw=;
        b=kcB4SAPdm6In3U0/eRICT2B+Ua367+8YXTZ1hq85t61khUlR0C+TLfP3jX7TAQVBEd
         GBMFpO0b4/KkplmIbTSGMyvCthZbpSbOsvtu3hgojLbGj3phJF7mr6B5TPl/ArQNRfhu
         703uS4MyRJtmz6rkQQPug2g/plzKocWi0WHqTsA1Ioh3nK14mcHcYoB+AtXxjUmuIzGF
         Y/6v+IwQlqoydA/BW2HF5LBFwioxziQ7uGdbjSviHsDIGtQsqiR0Bs/lwZvyHmeV11pI
         9emFXeotVh8GS3BCnelq/XH5Ndo/zBNxi+aw018nkoOppY1C4xgkelWHYsiqLRYj2MTP
         wZ2g==
X-Gm-Message-State: AOAM532Ymk0sfa20pnngD8iJDEugCaFEHi+EscNwp2Pycl7krM98g1zh
        PjS90gqeKHnRXx8g3OmlCSq+haBJIU9zaq+/PCc=
X-Google-Smtp-Source: ABdhPJweI4qeGM+e2zDq2SHC9xWM5C+tGpvQFN+igQT76ck/RAf7jjMcn/GQMDX+kf4UQlLCPrmaZJR673f61g+6O7E=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:a9d0:: with SMTP id
 c16mr5348289qvb.5.1606858669593; Tue, 01 Dec 2020 13:37:49 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:37:07 -0800
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
Message-Id: <20201201213707.541432-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v8 16/16] arm64: allow LTO to be selected
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

Allow CONFIG_LTO_CLANG to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c7f07978f5b6..9d29c48ecd4f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.29.2.576.ga3fc446d84-goog

