Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA692C6105
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgK0Ijp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgK0Ijo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:39:44 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194BC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:39:43 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so5948459lfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJvzcy7h7t5+J43wnvVJczkQ0LgcB85G7JBKDrFHI7g=;
        b=w3q+qxNPouWPe6x/o6c77TaTt08SpFNzjr2oWYBx4LxGIT9P+ex8wViAzcDjj+VKqM
         IVqLZPZRsb+sjnl1VzOKQZRSz0ZBjnzrfZ+n2nxt1n26GC4z6TUuMM7qQIHL6ku5tVAn
         cotpvTklekXtAT6IDPGrgy6ghLxKmB74ZVtVMWosxEbWwGcNK5+DEqPYQc6l+K6kQVZj
         mN+OskOisIwFEv1lIcXozcFwbF3fHl3kE6Koq3oA/H1dkc85YK0DuIEyMtZdSts70ANU
         urhj1+bEBfj+PowcqItOY8hsFTiupNmcN+xT5SW7dReFP7Kxoiif3TV88ROvXrVpieob
         PcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VJvzcy7h7t5+J43wnvVJczkQ0LgcB85G7JBKDrFHI7g=;
        b=Nigzy9Q+ly1Iif9PMVSF34uEZypXpHbXRCKP5mC4QjY/KT5/8J7H95XJmU5VgNg8RA
         RuG9yNcH2M486Jr4vUhRIk1d3oFbS8giSJvygLtDis+KEMBgd15kalpvZZ/DP9JcNQv2
         n7sxveMkCWpy5f61YmgBCVDdyF+MiwA9yI4CBREnde1lBNjPt570tmu6r+VVUX70WqIs
         5XKVZUirVbh2IzLdyiLndTYjD/GythrXBojFxMciaXjuISBLLXNKpcnAURehYX0y/K0N
         wBetvJpbOgCV2bRmbQFR74qDqzk/qHFVtRNmAnxp5d8nmQOz/tZ0/a9Y5h6GHgQCRut2
         PPBg==
X-Gm-Message-State: AOAM5316kRig2lQZhQ6ywUBtoS34Jfv21UjvEFU0AVJn+Hitj18ctNYP
        pUGT4o3B2tbf3SIsvsjOKwLHOw==
X-Google-Smtp-Source: ABdhPJzEhJ3V5UZEyXJY1luOg1HNRaF3x+W7SsS0gUK9mT8lhBWFwSmdGHVA0B9K92mGdaQm478Ecg==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr2739630lfg.309.1606466381557;
        Fri, 27 Nov 2020 00:39:41 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id v1sm603194lfp.305.2020.11.27.00.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 00:39:41 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tsbogend@alpha.franken.de, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mips: lib: uncached: fix uninitialized variable 'sp'
Date:   Fri, 27 Nov 2020 09:39:38 +0100
Message-Id: <20201127083938.2666770-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mips tinyconfig with clang the following warning show up:

/tmp/arch/mips/lib/uncached.c:40:18: note: initialize the variable 'sp' to silence this warning
        register long sp __asm__("$sp");
                        ^
                         = 0

Rework to make an explicit inline move.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/lib/uncached.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index 09d5deea747f..21a4b94a0558 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -37,10 +37,11 @@
  */
 unsigned long run_uncached(void *func)
 {
-	register long sp __asm__("$sp");
 	register long ret __asm__("$2");
 	long lfunc = (long)func, ufunc;
 	long usp;
+	long sp;
+	asm ("move %0, $sp" : "=r" (sp));
 
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
-- 
2.29.2

