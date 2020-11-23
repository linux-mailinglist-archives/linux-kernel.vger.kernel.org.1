Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C732C00AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 08:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgKWHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKWHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:38:28 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:38:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so15038969wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKnvipRdH5O5nwcZGT41u1DCEbXND0993nykFgKds7Y=;
        b=smrn5v9zKwc7LpQiiXvRkqe4V4Xyo+HcNnQfIYBjcjZxl8xKleGocb/Dw0+JucTxl0
         gxQvqP/MpdMJlRV26CVCy/SJ2AcVpTLt99cqNxGb634lBSI0yaa06VsU0RIpc1PNV9B2
         USJUf+z6LxdBBxOQEVYDTvkfQmRouuPJkvz5niDZI9/IAFuBvKhiyCJf7i3FlSXlHqMS
         +ekzryEGGiDuUjaltP2PZHoT6qlajd5DcBNhcsTILlV9wfjhUJiRbLYBZiXSSwqoYPPW
         /BnY6F2MeKVCVJlJEv7htF1Zbtqj9S23U2Z88XxTzAkbKxALjrAVhrxuVYEEwknCfApz
         5+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKnvipRdH5O5nwcZGT41u1DCEbXND0993nykFgKds7Y=;
        b=rG8XV83NiAIL7PHIRz7veVTV5rJiEB4JTSFN2sHLWX0z9vn7Nn+h9IoOUFYq9dRhpX
         NvH/6PiJ5utdoLCP6gZ4p8mnxzl1ulYfXANqDFYBCNMJknoi9XZkMVyGP1ZJhWjz0yCW
         Kf9AsxpJLlo8ZOpNlQUqHcgQlruH568UhSiKbt9t6C3P65eR9M4DEhJBGPArq1QExNac
         rwI+xANTwAs6VqKnyQYB6NLdfwyj9aMpT1hMNLHuO85YwbM4QfU959cnbqrThztcsOtF
         fcJL/IjKqebLNJwIHsHychBNXMgfwVxLmEXEc0eNPK4okqcdITGgWQgxCfFEz+ahIi8I
         8fAw==
X-Gm-Message-State: AOAM533MOMPkF9IzFWAn42D4H2Eu7Lg1kdH///DDm3MYIXB8qEtoNXf8
        MjwO/INBIXxyHt02fDlN0TE=
X-Google-Smtp-Source: ABdhPJwtvwR4tEbGdt64452+NtS6ThnxMs/sNtsxvROMuyckjORrFOrYWPoMYP+r428ViukTUJSJ7w==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr23507181wma.151.1606117106354;
        Sun, 22 Nov 2020 23:38:26 -0800 (PST)
Received: from localhost.localdomain (60-250-204-170.HINET-IP.hinet.net. [60.250.204.170])
        by smtp.googlemail.com with ESMTPSA id 17sm50927847wma.3.2020.11.22.23.38.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 23:38:25 -0800 (PST)
From:   Antony Yu <swpenim@gmail.com>
Cc:     swpenim@gmail.com, Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
Date:   Mon, 23 Nov 2020 15:36:32 +0800
Message-Id: <20201123073634.6854-1-swpenim@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__do_div64 clobbers the input register r0 in little endian system.
According to the inline assembly document, if an input operand is
modified, it should be tied to a output operand. This patch can
prevent compilers from reusing r0 register after asm statements.

Signed-off-by: Antony Yu <swpenim@gmail.com>
---
 arch/arm/include/asm/div64.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 898e9c78a7e7..809efc51e90f 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 	asm(	__asmeq("%0", __xh)
 		__asmeq("%1", "r2")
 		__asmeq("%2", "r0")
-		__asmeq("%3", "r4")
+		__asmeq("%3", "r0")
+		__asmeq("%4", "r4")
 		"bl	__do_div64"
-		: "=r" (__rem), "=r" (__res)
+		: "=r" (__rem), "=r" (__res), "=r" (__n)
 		: "r" (__n), "r" (__base)
 		: "ip", "lr", "cc");
 	*n = __res;
-- 
2.23.0

