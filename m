Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D421CA70D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgEHJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEHJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:23:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C61C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:23:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so1018722wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrVGpdFxzonwgxJ+OKU7Fp1a8MGcZDkb0P4WL0sfouI=;
        b=pe6CetM0pazJqhwIXvLsz22uCnaevZ2LQkCF0nSHD9sGE7Usdx99WeHQS2v3GLg7mX
         bsAUYximeQMpADul/preJ+tn7oStPOpW4usljVDA+eCGsG6attH01ZecfLkKh/r3ro1S
         +xxNEVxC/29ZCaSpbhts7fwtdUCX00rqP2kn3H4hn9Jym2vW/6Ndqz0w5oUBycg/Jw3m
         jTYqmiErTTmKjVUisY4TmX8pFVzT0Byc6oYu2rv/95U9Cmoxt6nMtv/oJXs9YG8qanfL
         IXdS/3U8ns4Q9Xsu4KUjB7Xn6eWPncaUjEB2eh8iQh8kaPc9I7u9UhXzSMGS7mPAxomb
         ytGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrVGpdFxzonwgxJ+OKU7Fp1a8MGcZDkb0P4WL0sfouI=;
        b=SZ/JP4AYkaYF+Dcobl+eSRkVcF3zcoauPdz8TAsDZ7DwiiPGYxdKgX2MoRk9sIgiVd
         4cCsWl/BMfL684AQ1a8EyYxrpiPQNc/n5mkranv+YptaGCOVpXb80wSl18pKTpL4odh1
         Ap3f8p3ggKQmPOf5QarVZp2NOlMjKTSFOlgAXSFX5/0ejLHORZCISxZuYludQllgyTMm
         Wyphlmwa3rMoEBGz811Wqgb+aBn08KeHxfXfOwHPyMiW0RB9gHMquJ0l2m6hPv8QwBjj
         tyEwRMZakCsa9/kw2xEU+yJ3ocfYBxDQY1Teax8EqGWFK9Lznq3IEe21JtPv3f4zSivw
         Yvaw==
X-Gm-Message-State: AGi0PuYPxgTMsihlFtp2Uv41YchRAv8m5CFk+k+C/N1J+y62jPYDLHa2
        mckMZT3SZ8GszRSWo9DMClk=
X-Google-Smtp-Source: APiQypKSKJ/Sjb6y+TL/+F2bmwyDwghdslVwGIU1JplkrKV5rDVYkHkJJK8JMjchCzewhXY9n6+24A==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr1951460wru.115.1588929782947;
        Fri, 08 May 2020 02:23:02 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id a12sm1919760wro.68.2020.05.08.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 02:23:01 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86: Use INVPCID mnemonic in invpcid.h
Date:   Fri,  8 May 2020 11:22:47 +0200
Message-Id: <20200508092247.132147-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current minimum required version of binutils is 2.23,
which supports INVPCID instruction mnemonic.

Replace the byte-wise specification of INVPCID with
this proper mnemonic.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/invpcid.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
index 989cfa86de85..23749bbca0ad 100644
--- a/arch/x86/include/asm/invpcid.h
+++ b/arch/x86/include/asm/invpcid.h
@@ -12,12 +12,9 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
 	 * stale TLB entries and, especially if we're flushing global
 	 * mappings, we don't want the compiler to reorder any subsequent
 	 * memory accesses before the TLB flush.
-	 *
-	 * The hex opcode is invpcid (%ecx), %eax in 32-bit mode and
-	 * invpcid (%rcx), %rax in long mode.
 	 */
-	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
-		      : : "m" (desc), "a" (type), "c" (&desc) : "memory");
+	asm volatile ("invpcid %1, %0"
+		      : : "r" (type), "m" (desc) : "memory");
 }
 
 #define INVPCID_TYPE_INDIV_ADDR		0
-- 
2.25.4

