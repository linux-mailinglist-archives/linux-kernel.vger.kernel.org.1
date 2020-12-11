Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA4E2D73EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgLKK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390692AbgLKKZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:25:37 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2234C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:24:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id l11so12663052lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBQx9xO5u4u8XZlcf1cIHxx3BPtxa/Dl6Ow9KmNUplg=;
        b=byCsg5/DRR2oVGR5EtRAAIVieBYmVgCOoM8iJ8p0Xx1izAgoLC44AHtuUArms1oJdI
         wGRDU+StYpSlEgLC24C28dPMxINpXkIHM/fqJ9ZDx5vM0fk6xO9Z68K2oNBN//7SyZ+0
         M+2mjjvpTHcRRwZfS3HNZzhp+WZs19H97tu6zd3mOL2o397fCOM08Iak6gizN+s7BQEf
         YgVahUw2R6TP3IIXQnem4jhNLxSiRSJHbew8U/9gb6TiOhevyU6utl1gc8YOFdg7aKgC
         c5wbfOtoMLZsM67HFg4VB919KnKPU1NAIooegJZpuzuVFlNe1Df57Q8gDbzIj2QKGxjz
         BXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBQx9xO5u4u8XZlcf1cIHxx3BPtxa/Dl6Ow9KmNUplg=;
        b=JdPTueVUC1J2SzhZx6EVEJYScXWseJeGuLgfxm4/9G/f3zKqAlD3rTzf4MLkmkyOGM
         xaFLG90X5AQCr1T2Cl+HI56s3KiWNOHYOrf/Y2yMrJgdl+bLLuur+Zc4CwlapH/7hwT/
         OJsBzB88xeenJ6Q9j1IWBIEzpaU1le9M/r44vn8+9S+RPeiGdkjPYc9bFMmb1OhIPDd8
         XuilBOfikMB5wU2ViYZuN07FLi0k2NG/vyHYJkRZRzMX/5yn/cbjV3aYv/feP71p2toK
         DegBEXj7PBDdZiEGZQwIC86sceNSjgvpxh29jKhRZkbixVQWc4yxN/vAEZ7yB5KbtK9B
         179Q==
X-Gm-Message-State: AOAM532Xrvj7HEk5G8uSIVLcYOcldcvlHTcbPcUam19O0ReDUpaQ4IJg
        /OSxQp6H+jYV5VS04Yfx8Xfskw==
X-Google-Smtp-Source: ABdhPJxKo/aDKyPAHBZ/SABdawDsZbvwiCVst9dJY5+hC6OBbOkAXC7OOX+Z0neGmL3AriKiTZG7xg==
X-Received: by 2002:a19:48e:: with SMTP id 136mr1997511lfe.357.1607682295088;
        Fri, 11 Dec 2020 02:24:55 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id j1sm826622lfg.225.2020.12.11.02.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 02:24:54 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tsbogend@alpha.franken.de, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] mips: lib: uncached: fix non-standard usage of variable 'sp'
Date:   Fri, 11 Dec 2020 11:24:37 +0100
Message-Id: <20201211102437.3929348-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mips tinyconfig with clang the following warning show up:

arch/mips/lib/uncached.c:45:6: warning: variable 'sp' is uninitialized when used here [-Wuninitialized]
        if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
            ^~
arch/mips/lib/uncached.c:40:18: note: initialize the variable 'sp' to silence this warning
        register long sp __asm__("$sp");
                        ^
                         = 0
1 warning generated.

Rework to make an explicit inline move, instead of the non-standard use
of specifying registers for local variables. This is what's written
from the gcc-10 manual [1] about specifying registers for local
variables:

"6.47.5.2 Specifying Registers for Local Variables
.................................................
[...]

"The only supported use for this feature is to specify registers for
input and output operands when calling Extended 'asm' (*note Extended
Asm::).  [...]".

[1] https://docs.w3cub.com/gcc~10/local-register-variables
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/lib/uncached.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
index 09d5deea747f..f80a67c092b6 100644
--- a/arch/mips/lib/uncached.c
+++ b/arch/mips/lib/uncached.c
@@ -37,10 +37,12 @@
  */
 unsigned long run_uncached(void *func)
 {
-	register long sp __asm__("$sp");
 	register long ret __asm__("$2");
 	long lfunc = (long)func, ufunc;
 	long usp;
+	long sp;
+
+	__asm__("move %0, $sp" : "=r" (sp));
 
 	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
 		usp = CKSEG1ADDR(sp);
-- 
2.29.2

