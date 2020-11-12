Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB0D2AFC72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgKLBhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgKLAO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:14:57 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD5C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:14:57 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e3so1636125pgu.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Zc4FtrffhJ40dHokDMmzk3M0beSaAvptI8ZzV5EZfTw=;
        b=edtKqlHvgZlW+FjvLnkQmKTA3zEOpxEYi6Tkz6gJqeYD7PyLxNtTWTDhJX6t05Idju
         BY0G0dn6KAvUFi7MXCQSbXF+NT6OJKSzba6ksDTZP5Ej1pKLgLhVzCrOOxzzfKXsvqVi
         BPUC4qgWhKzJ+7vVqDfkJFVmhUwqlxFHGVRmi/7MDMHin5hjoLxHtd6gOoUT3LgYLCNd
         XZ6TkAYnV+ZxT8qtktz23J28XW8y5WnfFna7QE/Gi2eCph2iMIiHHr6twGEAptqFsC97
         lWTjDHDJsz329WpP2ygEtU1E7DebwDFMaHOWM0U5aicvZPfYbE8JELoDrjn4dqQhurqp
         mzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Zc4FtrffhJ40dHokDMmzk3M0beSaAvptI8ZzV5EZfTw=;
        b=sjlfc/pq9+0x+JX/Pw38TJ11eXFG0giNcEvVTDplGModRoQUVy8gg8r/eO/66gfW3x
         tZAyz17JTRCRtwtdSz3IkcqO1cjl5+ch1iczwHsrv3GRjZzWDrssIqcuja/x7stSBF6w
         EwyY71fSGcSEtBy0edSll3xFyrsWat1vtV9a2LYwiK0Dnp1cZmLrSall2V6jpOly1dT6
         c95iMfii4nkFRhylwUPr7UiT88pazqrqVXBdvqtcxHHvtsg2qAToCCchpe1B1hQMkXYx
         QTIkb5Yduq6b7ewnDfrTElJHJBp6SWeafnyx7VS/UoM6ISPNwjobCDyDibub19EKplV+
         IAXg==
X-Gm-Message-State: AOAM5312DkxNNnPbri0O3gIVdn/YYWCAE/AaWLX1gGp1fsF05g7bAgJn
        uIsh1KXonQvpmufG0jlBCuonpOKxrcgxBUeIWlo=
X-Google-Smtp-Source: ABdhPJznT1kj3LnCLLY8r9Vwp5fimyEq6m0h5lY5KmuN1jkZqcR5zYfTDMzE0HwLGzNzG8VkxWRJmf9yFVrhRc7N3Cs=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:aa7:8055:0:b029:15f:cbe9:1aad with
 SMTP id y21-20020aa780550000b029015fcbe91aadmr25173195pfm.71.1605140096514;
 Wed, 11 Nov 2020 16:14:56 -0800 (PST)
Date:   Thu, 12 Nov 2020 00:14:22 +0000
Message-Id: <20201112001422.340449-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] arm64: Fix off-by-one vdso trampoline return value
From:   Will McVicker <willmcvicker@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-team@android.com,
        Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on your host nm version, the generated header
`include/generated/vdso32-offsets.h` may have the bottom bit set for the
thumb vdso offset addresses (as observed when using llvm-nm). This
results in an additional +1 for thumb vdso trampoline return values
since compat_setup_return() already includes `vdso_trampoline + thumb`.
As a result, I see a SIGBUS error when running the LTP test
syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
vdso_offset in the VDSO_SYMBOL macro.

Test: LTP test syscalls.rt_sigaction01
Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 arch/arm64/include/asm/vdso.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index f99dcb94b438..a7384379e8e1 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -23,7 +23,7 @@
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
-	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
+	(void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
 })
 
 #endif /* !__ASSEMBLY__ */
-- 
2.29.2.299.gdc1121823c-goog

