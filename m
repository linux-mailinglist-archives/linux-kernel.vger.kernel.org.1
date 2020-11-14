Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84A2B29CF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKNAXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:23:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:23:12 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q5so7374900pgt.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lQaUE3nPpIqiOwCX3suyvobXtPT9vrQJ7f04qI+2MK0=;
        b=LoBrY/fiWqzOWdf0vXAUFecSPZ3MGXq5ZhZ9KwKzv3qyRjAaxKK14VhSgU2tPY4hO1
         WXwSGl9Rnxjh0JBW7cj6YzJNauBwzwiV82kmHBVUAds07xswPQfbbJc9AHIW7ACoKNxa
         LtilPTYEMYrHwTLX/V/4YU1+bguAf0MAfBoD2Wbwom8BhWQTy8+KhAZjgTRkDcAuqbb1
         AiqV4V0O5jGBhCnn0bscraIKIEH3xALovPlgyVcRTR/wfhk21RGt4DaVrP16LczxKg+S
         DSPKrzaHRNw+/4JJM2FZWfIB3fdz32foTxZ3agkTTKWc+PANpeBEkONs7xLhInsXAaJ5
         hY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQaUE3nPpIqiOwCX3suyvobXtPT9vrQJ7f04qI+2MK0=;
        b=sadE+EOzbK7uIH1slV6W8IcpHhIzjhGligc2NWVbSUCyHCyzmipjQNotTvP41O9xgl
         PHafQZLM1462A81AfJn3e0OlbMKlUvfRPMZoEt85PMyAVwq7MhSJtz3Y2ejg3SW1Cp6Z
         n3BWrC9Q46JI4fetGevnncgu9pm8QYkWJ+Cv+6eY1ZTcyBl8ha9GvJJBf+FzKTTad+1e
         twYf8S+xHIhRA9JbcNIcqWwVnZiUwzqcIxUMiEXR/z1KMzr4UNh0BWlZqd9CoaY+mgzZ
         qlLppCuhHg2QB4gOM2nX+B1g8AzJnBRNZazDYl5PBjzDlSHuO55isDblrkcwfCEpE/Ll
         FJlw==
X-Gm-Message-State: AOAM532paaxuSBvHVCidzQHudMKTKyq8hqFfdj6La7mVNej6xedFPSnC
        XRjIQQVzVwBN4x4Vpi9cee6fCACzmc6O8zikfeo=
X-Google-Smtp-Source: ABdhPJzLgrtcK7Rs8r12VJo9Q+Cct3LlZ2XI8cwQQM59cjDxA2i80PXAdTgOP/xmadNZKGvZTccq46f/V2wMEMf5y9o=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:d549:: with SMTP id
 v9mr3877629pgi.242.1605313391793; Fri, 13 Nov 2020 16:23:11 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:23:06 -0800
In-Reply-To: <20201114002306.4166604-1-samitolvanen@google.com>
Message-Id: <20201114002306.4166604-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201114002306.4166604-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 2/2] x86/e820: fix the function type for e820__mapped_all
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

e820__mapped_all is passed as a callback to is_mmconf_reserved, which
expects a function of type:

typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned int type);

This trips indirect call checking with Clang's Control-Flow Integrity
(CFI). Change the last argument from enum e820_type to unsigned to fix
the type mismatch.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/e820/api.h | 2 +-
 arch/x86/kernel/e820.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..a122ca2784b2 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -12,7 +12,7 @@ extern unsigned long pci_mem_start;
 
 extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
-extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
+extern bool e820__mapped_all(u64 start, u64 end, unsigned int type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 22aad412f965..24b82ff53513 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -145,7 +145,7 @@ static struct e820_entry *__e820__mapped_all(u64 start, u64 end,
 /*
  * This function checks if the entire range <start,end> is mapped with type.
  */
-bool __init e820__mapped_all(u64 start, u64 end, enum e820_type type)
+bool __init e820__mapped_all(u64 start, u64 end, unsigned int type)
 {
 	return __e820__mapped_all(start, end, type);
 }
-- 
2.29.2.299.gdc1121823c-goog

