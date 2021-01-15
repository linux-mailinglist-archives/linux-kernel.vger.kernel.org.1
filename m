Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD82F7C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbhAONKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732595AbhAONKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:10:09 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5419EC061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:09:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y22so10270885ljn.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nj25LfTkFrAAE+qx8en0KB7gSAPCw/LDljzLCu37kJw=;
        b=RbBIDKsG5AyXSoGKHLolqmP9CsgzbCWO7vIeUc586k5RKCpmBkSNZvo+UIZ+HX7Xmh
         9814SPTXCc7VQ4hvKBI9H+F46fmpyTOy9r1/A1Ja9DHKRRU7jqj8gG3RARLIGSeSCI6S
         AKH/pa1h635Me4UmzBSKO1y4Zvq53UnfOjlqalouLYWy4mhD+vmZ3K+3hdoauVpKMCJJ
         ROWvhachqr9PexOH3QFs8xyi4zQTufu5RPiMPkOn5CbzmIqiKLwhElSPAl7YKxleeBMM
         iAhg510vTb4oZ6Uys/oYjHA5Oc0CFDjm7Qg0Mb5BI3TyQ+wCCiu6jo8222X6AVwAOaOW
         KL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nj25LfTkFrAAE+qx8en0KB7gSAPCw/LDljzLCu37kJw=;
        b=p0jwrKIhqiRVLh2sJoYyjbuFfSu61nIrhyec7Qw0CjoDrEwKHrb5AJ5i044F3pRW4B
         DdPnzETyUlZb/+AOWMHheEy0g+CS148YgcNZUy3LXC5rG9qRdYxsX+FdC41DyLFOFmLK
         awi1ifFg7wDVQKTmhkDsHKd9y+rv6bmQcO3xulioBlZQR+XrwEE+JfUJ8ZG0bRd6t5mJ
         Fpyi/fHbiaN21ydGP2cNS+6bDXPqWYARGMssGr3w+rHOpVyxhZ3r6eTddoD3LTPOgrMN
         j/Crpgj4KNtw3xcmqZ7REflyw/AqhHZP7oaXzgd7ERXo81q9gceotM5+ED5e0GlWtAgu
         JhfA==
X-Gm-Message-State: AOAM5331cDUIvMFtAKIYlcuz9vqy19BigoGza/6VfX6MTk2DYLzNd6Cd
        RhMICuxF2gVfkCBJSxWHJEp9Bg==
X-Google-Smtp-Source: ABdhPJxE4FoBVVcwDdbqlZxkblEHd8H+07xbt0GaHOcm6sDnZyB04yStjO0Fe3b0p3WTf0VBHFoyJA==
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr5339872ljj.464.1610716166861;
        Fri, 15 Jan 2021 05:09:26 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id i11sm894372lfl.297.2021.01.15.05.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:09:26 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] mips: lib: uncached: fix non-standard usage of variable 'sp'
Date:   Fri, 15 Jan 2021 14:09:06 +0100
Message-Id: <20210115130906.1084281-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115130906.1084281-1-anders.roxell@linaro.org>
References: <20210115130906.1084281-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5b058973d3205578aa6c9a71392e072a11ca44ef upstream.

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

Cc: <stable@vger.kernel.org> # v5.4+
[1] https://docs.w3cub.com/gcc~10/local-register-variables
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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

