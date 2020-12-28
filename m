Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3152E33E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgL1D1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL1D1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:27:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C33C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 19:26:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t22so5629329pfl.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 19:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlaH8b4GBHX+66xFw40oTmpQ0Y4qvDTeVKqb0JTujuc=;
        b=PibVVNAlCanQukF8fCsUfBBxyp2KYIWxPZjtCu96jNCbxxG5hDN6AP20YVn0cvjYLo
         vsp7X1u9eGed4fcZzCd+JY6HjVcjPLES5kroFyNcps4qJ7/ADC0PGyc9vezJE5Yie/oA
         qhu84AHtpFHwtpq3wPpdH4lVEF8Bvh++dLEftzSN+yZMrV6Ksck87ZI+TC/+W75veALw
         tBFFTyAbg+sTDe5ey1tuT1c7u0mfwcRr0X4dcCUBniAWPDj4ItwzNpbi1N4gxu7v2kaE
         9Riz320XYjqjb7NQ8lwvFAG6Y5MS4fQwtZqKvIv945Q177YHwIK3EjgWPls3C/8ryoOX
         dORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlaH8b4GBHX+66xFw40oTmpQ0Y4qvDTeVKqb0JTujuc=;
        b=oZx8aCBkw58XKUkU4b+oBw7ZxD9Kww/kF1sR2vaXXD+C2kyUZLTPn0HeosLCzzn/9l
         GANQ79nAWp5YyAa0KwuDO1Wb5IeK0rdG1ZC+3kopBwHdoq1lQ/3LKv3u06/OdqVYJTXh
         NeZ/1jZkar5vv0DkyWjtbq9Xjdo9n/F+UIfQoJOtjsyyNBVkHdYLLB87c7ZHL8YenBM7
         uNR38gH3aPSzNASh/2NRV2aaUrFB0CH9ZJlccuw74BmZpToaS29EHPrfWPoeFpmxQYnE
         sW1391Ugzuk1q4PmCEj3H9gxsPMQxmtJnUYx+Aai96sioxeUwmZLg7QVz3WTwZrLrKb3
         UtIA==
X-Gm-Message-State: AOAM532IqivIy9HiOdIy35hfgnHxo3vCm74Q1ncxYPrAj3GIk1PO8InV
        FdY0sec1rPsOu3wdCTiXJus0mQTewUg=
X-Google-Smtp-Source: ABdhPJyH0/cpLTBIwQwLkkzQRlTx1t91n3RBmeOpQaCs/OLWUfgVTkdfQimyM4Bwqvht1CvBtTSF9A==
X-Received: by 2002:aa7:96c9:0:b029:1a3:c274:f717 with SMTP id h9-20020aa796c90000b02901a3c274f717mr38882754pfq.38.1609126009438;
        Sun, 27 Dec 2020 19:26:49 -0800 (PST)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id x23sm40841340pge.47.2020.12.27.19.26.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 19:26:48 -0800 (PST)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id CA2521A0240
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 19:26:47 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Include thunk_$(BITS).o only if CONFIG_PREEMPTION=y
Date:   Sun, 27 Dec 2020 19:26:46 -0800
Message-Id: <20201228032646.341547-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer GNU assembler may not generate a symbol table for the empty
object file.  Since objtool doesn't like empty object files without
symbol table and thunk_$(BITS).o doesn't have a symbol table when
CONFIG_PREEMPTION isn't enabled, include thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/entry/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95dbc911..83c98dae74a6 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -21,12 +21,13 @@ CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
 
-obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
-- 
2.29.2

