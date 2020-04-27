Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6677C1BA996
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgD0QA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgD0QAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:00:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4889C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8so20797489ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MhrpwHs0AsLMtVzb820LtwCNl0W7a7WFfLC0oPkvUmQ=;
        b=DHL29TiSaxcDKg26ae3snSvd9KBniehMx3v50e59HOzn23b9luEep1Uut6Rh1bgH//
         KO956X4m67E0WpTwHcyuZx/xco9K1MfUnOei1/NJ7DvhzpuBWAQQoieFIzyDvLo6Xj/U
         LSa76QE4JoiA3ockCGPZD1FfXXH04NOXGtZ1PxX9YzsvIand259bV5kmRZPWkfPadlSz
         XWC+qkJlG8khvQVMgO8moC3HdAi7FoVaXCNT/Dr0tnUqnPV0HoVJ/fMpxxfRfRmbMoG3
         yBAUhuFYHDK2Ll4Rry67J9w3Df6Y/7mnJGUxW1bj4MawAaAPsThGV9/Mf4P8wQ1n4vgO
         xZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MhrpwHs0AsLMtVzb820LtwCNl0W7a7WFfLC0oPkvUmQ=;
        b=IAWSWCK27wrJlT/ZWQ64uDzh8rHq2wxHiUEDLN9JP6vK9PkZQUTj4xKsAULp12BBIU
         ocdwWmUp1hDF1ZVvQUZxAKhb8trOqIgnCfXBMcT9yIboxCOl7vanzwKGjnk6ZDUZPEnI
         uNtiyn+PAr8q7XKJ78YhKAFYbip8UYMeWiYuO2xiY7c/NT2OC8aMPLorOqlNyZ4b9b5A
         drcQFNOW85A7uvMwvnVuWdkrnnsfDhimISbJMgm2NQNp7tdjS6smsI/R3eHSB8kHrax1
         +gjyUBu3S4V9YGoe70mAvUcmAVPhhtuGTRXM8qz4uVh73bLsq6rZrep1N22jvUm2w6Vl
         JyUA==
X-Gm-Message-State: AGi0PuYWxNmjGDiZeRAWUgR62QybKK5EDcep75xVWL82tzj6BF3jhaUg
        /opqiDvkjVDxi820zt6t0R57UUF9I/F++GsV+RI=
X-Google-Smtp-Source: APiQypIKYYCqrjrGDUY1B1bGA9o4qwmVhzAAlAiSD0oA2v0bEfRWWMuFhQtbWcozWJZsq/jS263B3BZnI77ktov0l6U=
X-Received: by 2002:a5b:44b:: with SMTP id s11mr21987518ybp.399.1588003254867;
 Mon, 27 Apr 2020 09:00:54 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:00:15 -0700
In-Reply-To: <20200427160018.243569-1-samitolvanen@google.com>
Message-Id: <20200427160018.243569-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200427160018.243569-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v13 09/12] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable SCS for code that runs at a different exception level by
adding __noscs to __hyp_text.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index fe57f60f06a8..875b106c5d98 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -13,7 +13,7 @@
 #include <asm/kvm_mmu.h>
 #include <asm/sysreg.h>
 
-#define __hyp_text __section(.hyp.text) notrace
+#define __hyp_text __section(.hyp.text) notrace __noscs
 
 #define read_sysreg_elx(r,nvh,vh)					\
 	({								\
-- 
2.26.2.303.gf8c07b1a785-goog

