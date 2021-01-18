Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB52F9C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388903AbhARJdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 04:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388670AbhARJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:22:48 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EBAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:08 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u29so8023930wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IZxX31YwQJxY4qKXB8kaGSAyfVufijU5UZLnTc03xew=;
        b=PVEk3tnsQj1svfSEAwlXh1Vfsz4IAVEr1K6SIFCqfP3mDrILXQkPhAtk+ikkFUbhfK
         2C1v3Xj/VmNnq2TOiiSOvVd2X9eN0eIeS1Vz2QZDvOoMzEm5h64GOoJAjp+qQzIoDysI
         NbQJIza1JcqqQziB282h52top1Nu9tBZUR4/8y2xEbE3zuBaiN7DT5CibGByDOJuh6mu
         6K/JbsuW6Utttrk3lB4BtI9F6dW6UKyXA0hT/pOQFySx2c8YaBjn6CfCXWcqdsSNA/nU
         9+QxvfAuMjYFpphvWTP7r4JyrU7OJ/6nTXlTmsuulAxTgSTwLlcs3owYQqALICDNr7OC
         N9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IZxX31YwQJxY4qKXB8kaGSAyfVufijU5UZLnTc03xew=;
        b=m2GxsvJxKrXpPxX6o8G4DtguiRmFC8r8sbjaCSowqwZVKORnyK9ZPGm5sn4pX6uZ/X
         aJ/vyl9Bk3pMtlWjCEDQFLYjGRzJ6zLbO8FhM7KtkL5NOeN0QM2WLggEV00njCEMThEf
         h++NhE6eiZ+9kIHci4u1kSxnI0y3hf3Q+EXgGW7s8JgaflsH42CTwSez05qAR/f4DrBL
         MRzYNnBsjgwMJJVpgJZ/I6lgl82N8PAJGd9xfDPn0nAHwRXuUxtMVKWsymljKiEs11Yo
         YZGJJ7J+R1/iHq3z9UPSzIUzyWPXxofYS2Rd4JS3jCRxhR5IrzzxdoOGbUrKuJItu3XF
         ygOw==
X-Gm-Message-State: AOAM531MEBuV+gsZtzWYnai3joZ4RDQwBbFpFI0Ed0D0bRbzB16k+DlS
        xuoCvaQYCi+l6SRsQBsR/sseeMKC2g==
X-Google-Smtp-Source: ABdhPJyxTNm231M+X8FUTU+onEgKbTGm5BnbsTbZSQSA4gnoCzI1krEf2EoD1cSB8OT9Wriz/HQ/HifYQg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:adf:f60b:: with SMTP id t11mr25193199wrp.401.1610961726705;
 Mon, 18 Jan 2021 01:22:06 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:21:57 +0100
In-Reply-To: <20210118092159.145934-1-elver@google.com>
Message-Id: <20210118092159.145934-2-elver@google.com>
Mime-Version: 1.0
References: <20210118092159.145934-1-elver@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH mm 2/4] kfence, x86: add missing copyright and description header
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing copyright and description header to KFENCE source file.

Signed-off-by: Marco Elver <elver@google.com>
---
If appropriate, to be squashed into:

	x86, kfence: enable KFENCE for x86
---
 arch/x86/include/asm/kfence.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
index 2f3f877a7a5c..97bbb4a9083a 100644
--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * x86 KFENCE support.
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
 
 #ifndef _ASM_X86_KFENCE_H
 #define _ASM_X86_KFENCE_H
-- 
2.30.0.284.gd98b1dd5eaa7-goog

