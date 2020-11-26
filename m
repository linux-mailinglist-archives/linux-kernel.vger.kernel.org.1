Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5EE2C5C63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 20:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgKZS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgKZS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:57:19 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB895C0613D4;
        Thu, 26 Nov 2020 10:57:18 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f9so2092689ejw.4;
        Thu, 26 Nov 2020 10:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hxouV8TOd4XlVrwIhmMmebV4SGHsuIQGOklsA6qAvCc=;
        b=P1BA5OZB9H1UMsnEh5lZFDw1h9hn3R4fCP4UNcUKF8r+gVmXGhbKOLQnJdVa0TtOdM
         g4mp07JHOyZEPhO6FYts5hhu+ohkDJKbRSezLrfpwCKgrcHyrcwDdfk+KtF/E4eXQCCz
         eag0ShohciEhvzuQJ03Ko1WGjHlDaMDb8BQ9iTxJEAPszwIUroWhJPLpvYIBcqDl+6WY
         P+5tdGaKllTdPlbUN4IVzoEc9Qdro0WaethqaEKystBBkfvKRYjryxt7JoP+8EKb6jkq
         4J4iqojkiia8u53TMjoi5qmX9vMcvxCMeIGXKKCFWWxBcsztN1XYd5Xo2cPE/rVltx1L
         CRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hxouV8TOd4XlVrwIhmMmebV4SGHsuIQGOklsA6qAvCc=;
        b=TkX4VtuRoj6z3rLieJzQp+Sg+nAnFrR+Q+2ncMHBpOsx3+3fzN4ui9GAQJ2JOIJwTt
         GQ9wfgGNyLILngL7I/xlzv/TJG4tKhNy2TNdvsd/cv4JMd7Onw5+wZrGE9oMM3wFBc6r
         XfFvNUncjezLZWO6iDT6rSsXo2s+2iavXwHIoc0Tgv6jkfYyzJxmQPPUMBYxIx3I+Z/d
         NMMDnmXqTIBS0Pnl65GZ62VBCfjnZeWo+LbAUa4AU+VjNLThnVg5Yu4CjwRY2yO4JnHZ
         PHOGgXs9Za+O309q549kOss+MwZufO/psOey2l777hMcYX0sQPpPcpOMMbTXLhicKX5V
         LT4g==
X-Gm-Message-State: AOAM533bUt57triW1x9B4VzbgKie5tQbgZjbhg2bDxTB6Y5fMbXrzuTw
        UKeSkIguiRCOBQxuquY1BWQ=
X-Google-Smtp-Source: ABdhPJySyqwz/r9Kf4d4rxdX4Z3k4Zsrt3FePPH8A2z70ISRpvgRiIK5q333LgaToGDUmeRQ4qyEEg==
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr3891042ejp.395.1606417037519;
        Thu, 26 Nov 2020 10:57:17 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d3f:bc00:d891:6628:cbb1:a6e5])
        by smtp.gmail.com with ESMTPSA id k2sm3529855ejp.6.2020.11.26.10.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 10:57:16 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/usercopy: adjust __user annotation on __copy_user_intel()
Date:   Thu, 26 Nov 2020 19:56:52 +0100
Message-Id: <20201126185652.1875-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit beba3a20bf90 ("x86: switch to RAW_COPY_USER"),
__copy_user_ll() is used for copying in both directions, i.e., from user
memory space to kernel memory space and vice versa.

The underlying __copy_user_intel() is hence also used for copying in both
directions. The __user annotation on the arguments suggests a
specification, only copying to user memory space, that simply does not hold
anymore.

So, reflect this use of __copy_user_intel() by dropping the __user
annotation, as the __user annotations have already been removed at higher
level from the pointers in the raw_copy_from_user() and raw_copy_to_user()
before passing those pointers on to the low-level __copy_user_ll().

__copy_user_intel() is only used in __copy_user_ll(); so checking soundness
of the __user annotations around __copy_user_ll() is all that is needed.

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201126

Thomas, Ingo, Boris, please pick this minor non-urgent clean-up patch.

 arch/x86/lib/usercopy_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 7d290777246d..4976283a01f0 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -94,7 +94,7 @@ EXPORT_SYMBOL(__clear_user);
 
 #ifdef CONFIG_X86_INTEL_USERCOPY
 static unsigned long
-__copy_user_intel(void __user *to, const void *from, unsigned long size)
+__copy_user_intel(void *to, const void *from, unsigned long size)
 {
 	int d0, d1;
 	__asm__ __volatile__(
@@ -291,7 +291,7 @@ static unsigned long __copy_user_intel_nocache(void *to,
  * Leave these declared but undefined.  They should not be any references to
  * them
  */
-unsigned long __copy_user_intel(void __user *to, const void *from,
+unsigned long __copy_user_intel(void *to, const void *from,
 					unsigned long size);
 #endif /* CONFIG_X86_INTEL_USERCOPY */
 
-- 
2.17.1

