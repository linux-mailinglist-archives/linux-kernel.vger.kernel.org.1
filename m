Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658E02C8E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgK3TkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbgK3TkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAFCC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c137so17283015ybf.21
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/CpViICP2Szh7uDfZ361U32LEVMsvMr0WgLoxDL9EOU=;
        b=WaQ0nLe4l5R1+ZJ+jKc0q+gH2uNKGH7jZ/WUXON4xrUEL1LnQ8/YJNvc6QEbJlZvie
         PyVbnU/rziUjTmusczx+4wQShTqKL7hZ2fVY38ePtCq2awcAUAceXb6b1myBqfHTjF+M
         s2efrxlGINdwTJGLYqB9dt5F14b9uUDnVythVDs3rONqP8ALD5pyj5CpGd4l/l4CLeHx
         In0GsUtGgTi3St9ViyCfaBIMAwwhYF/pAUhCRmnZznNuXYeztIrHuSjDFvGLYJBg9v9Y
         4T4tKdy16zNWoO76leVqTo84KyLk6cuvEA4W88EDKim2AH8IRUG/k5XJriAIXKaJf70h
         h+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/CpViICP2Szh7uDfZ361U32LEVMsvMr0WgLoxDL9EOU=;
        b=R2dUQMW/Hsok5yR+YJu+EKIAAIXTMJvrePn3BAjasK5ayeS3ewK3R058phSMum96D/
         n7F/sZR2ao/x5VFjGv0cBhaqGSROEKom/ChNT94SCd0wl3pnyHgutJyPT4EEpDImoiXR
         wcDCkzZJk7CPzhNZ8pENtVj8H2KjpbHn287kF2mZK+tDh7ULUwv0IHQQHfaPD5/ohV/E
         rhwSJqC5AeMaes21PzKnPqRlzf0uvBSGw8gH+zXXqtMHll2/0YAiZA0ducAqDgD3Xpxm
         Gzpj3zoErzQyw3kx1oVtTLaM/YZFJvaPkO99ls5WraHSxa7L+j2Ymv8MO8AD+KaPgpcl
         FgEg==
X-Gm-Message-State: AOAM533AJcudSVG9TXEQF+VPKfDQanVuACf/06gGSR1H+suBNiACnp7D
        pDxUZu8C1X7J88WKS2MX7C2TlcNzpAQyF3NykmQ=
X-Google-Smtp-Source: ABdhPJz2hhvnmoRCgKkg0UhNf2Kdu/uVBtu4oW/KGg3ws9CcyTxKbcIbnR46JAGwbxlxp5Imkq8AU4k1cYtAvf635lQ=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:428b:: with SMTP id
 p133mr38276555yba.261.1606765143451; Mon, 30 Nov 2020 11:39:03 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:39:00 -0800
Message-Id: <20201130193900.456726-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3] x86/pci: fix the function type for check_reserved_t
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e820__mapped_all is passed as a callback to is_mmconf_reserved,
which expects a function of type:

typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);

However, e820__mapped_all accepts enum e820_type as the last
argument and this type mismatch trips indirect call checking with
Clang's Control-Flow Integrity (CFI).

As is_mmconf_reserved only passes enum e820_type values for the
type argument, change the typedef and the unused type argument in
is_acpi_reserved to enum e820_type to fix the type mismatch.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 6fa42e9c4e6f..234998f196d4 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -425,7 +425,7 @@ static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static bool is_acpi_reserved(u64 start, u64 end, enum e820_type not_used)
 {
 	struct resource mcfg_res;
 
@@ -442,7 +442,7 @@ static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 	return mcfg_res.flags;
 }
 
-typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
+typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				     struct pci_mmcfg_region *cfg,

base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
-- 
2.29.2.454.gaff20da3a2-goog

