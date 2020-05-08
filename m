Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D21CA8D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgEHK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 06:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgEHK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:58:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF455C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 03:58:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so1342516wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/h+XC3vAKi4FluKMboMarUmedZlHjNKOcQxPCTi1T4=;
        b=WGZ001MDFDdQdasGMkfpNfvfiteinvJbjaTJPJi2NO0b/NCtB2SH+g7UnBebMFEX+a
         40ozCOz6X1NCHgRWFfnc4zPJwdWPCU84O8GyECisTry3HPR3WMcx8zhzsJaYZ/M7B9cI
         wn4GSuFESMInLqUcLVqkWzJuQDdVWPxcqf5ckEZhINmy4Gl4CfWYNRezliBEylSaXW0O
         auDuIJUPJ+ndovcgatqTb5lNJkJuiHxsXPXFlU5ORV9pexLNAy3uFXvJ6qFedLM86c2b
         xCRlevFVXpAj/6jJX2Xzyn0goq/MtJPzM+NWUKSFJGfWjGbjPRolZK+SeYvjrGEg9lE3
         dqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/h+XC3vAKi4FluKMboMarUmedZlHjNKOcQxPCTi1T4=;
        b=TIz7QfgLGjnPFeEdK1rwCwQiEjwf0z5peOjEsRGU8zpl5npjhVaFGq/FgsIs9NuzKb
         HPocRpKVHpg3sZe4bvl4qv2/z5lVYUbuahMy0cGjydnSUnKigGjQHfGnAiVTDukm3+cZ
         OvmlN009xQANtsfQXpsmIxTf6Rl+4/Ry7RvREmyzczgTCD6v+3Rsi6FY8Yt0VTcp4yPF
         KfyhOW+JVWMPAZUvKWqMJtmZSuUaoZBGkkB9b2yY8/TPDGgufdCBWQFtPjUi6VDAj3z4
         dT4nlTylkFnNrd//q8Vx4eCU00S0vDlC8Z9oSzbn5wPXZKuR/4b+y5FRm4DYhO+b+vcG
         LHdg==
X-Gm-Message-State: AGi0PuY8MYlT7S9Y2Z8ke7n9qPmlQ89J/ILsaI7V3VOLuLUbkmBGnCHK
        xXE0imu0wSkAkP1kyiIDXOc=
X-Google-Smtp-Source: APiQypK8RgOS7Gp842IOMiOpBSKXCehYVTUrb4UqGubnhfSJspN3qcjkFmaKOVbzpL+R+E8J5qfLow==
X-Received: by 2002:adf:b246:: with SMTP id y6mr2341075wra.205.1588935505377;
        Fri, 08 May 2020 03:58:25 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id k4sm8504020wmf.41.2020.05.08.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 03:58:24 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86: Use RDRAND and RDSEED mnemonics in archrandom.h
Date:   Fri,  8 May 2020 12:58:17 +0200
Message-Id: <20200508105817.207887-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current minimum required version of binutils is 2.23,
which supports RDRAND and RDSEED instruction mnemonics.

Replace the byte-wise specification of RDRAND and
RDSEED with these proper mnemonics.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/archrandom.h | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 7a4bb1bd4bdb..ebc248e49549 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -15,16 +15,6 @@
 
 #define RDRAND_RETRY_LOOPS	10
 
-#define RDRAND_INT	".byte 0x0f,0xc7,0xf0"
-#define RDSEED_INT	".byte 0x0f,0xc7,0xf8"
-#ifdef CONFIG_X86_64
-# define RDRAND_LONG	".byte 0x48,0x0f,0xc7,0xf0"
-# define RDSEED_LONG	".byte 0x48,0x0f,0xc7,0xf8"
-#else
-# define RDRAND_LONG	RDRAND_INT
-# define RDSEED_LONG	RDSEED_INT
-#endif
-
 /* Unconditional execution of RDRAND and RDSEED */
 
 static inline bool __must_check rdrand_long(unsigned long *v)
@@ -32,9 +22,9 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
-		asm volatile(RDRAND_LONG
+		asm volatile("rdrand %[out]"
 			     CC_SET(c)
-			     : CC_OUT(c) (ok), "=a" (*v));
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -46,9 +36,9 @@ static inline bool __must_check rdrand_int(unsigned int *v)
 	bool ok;
 	unsigned int retry = RDRAND_RETRY_LOOPS;
 	do {
-		asm volatile(RDRAND_INT
+		asm volatile("rdrand %[out]"
 			     CC_SET(c)
-			     : CC_OUT(c) (ok), "=a" (*v));
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -58,18 +48,18 @@ static inline bool __must_check rdrand_int(unsigned int *v)
 static inline bool __must_check rdseed_long(unsigned long *v)
 {
 	bool ok;
-	asm volatile(RDSEED_LONG
+	asm volatile("rdseed %[out]"
 		     CC_SET(c)
-		     : CC_OUT(c) (ok), "=a" (*v));
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
 	return ok;
 }
 
 static inline bool __must_check rdseed_int(unsigned int *v)
 {
 	bool ok;
-	asm volatile(RDSEED_INT
+	asm volatile("rdseed %[out]"
 		     CC_SET(c)
-		     : CC_OUT(c) (ok), "=a" (*v));
+		     : CC_OUT(c) (ok), [out] "=r" (*v));
 	return ok;
 }
 
-- 
2.25.4

