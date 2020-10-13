Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F174128C64B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgJMAed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgJMAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:33:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B48C0613BA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k3so19107431ybk.16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hXDRuVDCt6QcdhcOoOZPfzkgSyHjAxTz3vM4hOZGaOg=;
        b=Q8OgoYWJ38A1DTeEf63Hk3c3hYYH4ZF0z/4PTOL57lC91oiRnkf9gd9B9qku6Q1r6u
         wJpqEn6EAi4UteX1DyN2q/JvaTTtpy84jR6VL0m2JhAl1RoRGIYWTX9l1lTaDfwxSMKw
         LefJJwRakxdtpPQ08/FQAf92Wa1ozzQh8P2RP2YZPMgSGdz7KcYbVYFd9TUmBqArokGv
         +ldWe6u3YKRcL8TPbph9eLO/Rzlrbtj3yh/gdxcr/CPwfeRwl+euqw8SSVnfC+RC6cR4
         StF7LmGsoqGTDk0I/EG14+cMInf9+wTZSixivfF3ZGh1ldNUWQxtZk/Jwl6sRHt0BJIe
         TMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hXDRuVDCt6QcdhcOoOZPfzkgSyHjAxTz3vM4hOZGaOg=;
        b=YHg20Tv5w04dfzIl0wNEOBnusgRcYP3xc0/XGmzztLd+CN5IR6XFPytgVNJ7Es0Yia
         pU6yo8AWlpig+tXWUB7J8mOke+ibRr6vwNkNbqR9osGFIbZkvbo4CUhuBnyNROV5KIGZ
         1+++G8MS3aYmLYcBapsezO/qm8hk8sYbXjwcZEbUJsAyKzZPyauqq4x/vLxSGPsq6pq4
         wb7XzRqY46pJKMgCWQV+tY7LKWDSDvQzsAW0YpsgKtlphGaJdybzP1siIc66bohwMS0E
         qrLlfkVOpT0BWmoidwAYjtVei5/06c2PQSsEoHvKsJp1me8ffFPeLwpSg1PiT9itfjD2
         IdRw==
X-Gm-Message-State: AOAM533VFG+LJDAaKYCREi3Eqo5ovVuR7HCvE2RHX1nVqPGYRuLm5Ggf
        UbZwIv8wfdnJx27hHE6sTcH6MBKEKcyBbeMOkPg=
X-Google-Smtp-Source: ABdhPJwbnvZ4QCf51zdpzXBwYixY461mQNfzv2AaPBdgQJxvN6CQhpCGMZEflp7FPw1Aa3EKTn0uJBFEhoLOmniOABo=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:842:: with SMTP id
 63mr33820736ybi.311.1602549177444; Mon, 12 Oct 2020 17:32:57 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:32:01 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-24-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 23/25] x86, vdso: disable LTO only for vDSO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

Disable LTO for the vDSO. Note that while we could use Clang's LTO
for the 64-bit vDSO, it won't add noticeable benefit for the small
amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ecc27018ae13..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -90,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.1011.ga647a8990f-goog

