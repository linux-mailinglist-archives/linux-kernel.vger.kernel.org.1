Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138DF254B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgH0QtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 12:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgH0QtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:49:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCB2C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d11so8519296ejt.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5mt7pQURye9ecR53f+JvCJ0uiGgMxCegvnwnLRHzLo=;
        b=EakLQnPFKi98TUfE+RqWCoPr3r9CgBHj/DV4tdU3T4twCuQndAB4O6iUrgVlxPMdG7
         Gq+nZwxk2bEnY3RiAyb/670KKTFQ0Af+huh57E6sdJBMdVTpwYembXC1o5Qgva629mQD
         4tlkzj2lXMfrkUNxIVfc7JZ+viH55An4qkeoveT7/DFtgwZTWY7gox8VZKgFqoYB7uT2
         BHUAM0GHQGixfKeI3oxt5HuQNAKWsXIjL2gEI3mvJP8SEqt1FDhkT11PgEP5a4MoTUNv
         PzEL2SMLy5LsZOIN27+GoJY6okVQmW1Yo8uudbRtDxQ3O7CYHSHd4bga6oys58LM0wuC
         RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5mt7pQURye9ecR53f+JvCJ0uiGgMxCegvnwnLRHzLo=;
        b=swXSVkkCvWVT6l58KBbYm+h733mL17rIZ0vVNMz/pxXHcFfarrgh+JQHM5V3Ew90JL
         5CdhGN/E/6mscN1n/kQPyoABcOsfsddEEVaZBkgSIt2T+DOtn3z4YCMZLs8g28oKxnp/
         lBrVFomr8dY83enDthpKsXKRJ/ruVY4P68JLLRdYpB4+VVJMyvxSGd8TEb62BxpvJNQW
         GuDAy4in74iuJVkrn6n2WTKSkvorpr0Sk4RGK4R7uRp9bhIcV6syWhfKQhZ9eoE9iNSI
         q5ClUSk+cjGzfTKah3zeidfJ2CvuXqm+U5AAj33dYYUa6PcMZBqva0Ytgj7FDs7ir0sa
         pusQ==
X-Gm-Message-State: AOAM533ha1XaoPlEl6JXBppdDExq0+gzjb2MBbTdqEOPCfAajGCpKMrj
        PuCqyd9u+5F7EdQ2PelhNnU=
X-Google-Smtp-Source: ABdhPJw0ClNIO9jd/shZgALigC7aDMkBNZ2ND8Oqiy6UAgf7eU77ImYjD2vtFD8Xqrm4zCfIUaKk7g==
X-Received: by 2002:a17:907:271a:: with SMTP id w26mr18415996ejk.402.1598546953816;
        Thu, 27 Aug 2020 09:49:13 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id lx15sm2285182ejb.66.2020.08.27.09.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:49:13 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: Use XORL r32,r32 in __get_user_asm
Date:   Thu, 27 Aug 2020 18:49:05 +0200
Message-Id: <20200827164905.88235-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use XORL r32,r32 for all operand sizes. x86_64 zero extends 32bit
operations, so for 64bit operands, XORL r32,r32 is functionally
equal to XORL r64,r64, but avoids a REX prefix byte when legacy
registers are used.

32bit operation also avoids 0x66 size prefix for 16bit operands
and REX prefix when %sil, %dil and %bpl 8bit registers are used.

As a bonus, 32bit XORL breaks register dependency chains, avoiding
potential partial register stalls with 8 and 16bit operands.

The patch lowers the size of .fixup section by 20 bytes.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ecefaffd15d4..2bffba2a1b23 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -343,7 +343,7 @@ do {									\
 		     "2:\n"						\
 		     ".section .fixup,\"ax\"\n"				\
 		     "3:	mov %[efault],%[errout]\n"		\
-		     "	xor"itype" %[output],%[output]\n"		\
+		     "	xorl %k[output],%k[output]\n"			\
 		     "	jmp 2b\n"					\
 		     ".previous\n"					\
 		     _ASM_EXTABLE_UA(1b, 3b)				\
-- 
2.26.2

