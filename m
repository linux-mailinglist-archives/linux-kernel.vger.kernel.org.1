Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C37303274
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbhAYKZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 05:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbhAYKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:21:08 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986CC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:55:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so6963126lfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWWqCKxEe5JOZexnW4lpG/6Y5YZX1PGnjV7kCZ+jMOI=;
        b=lJpTkWGOuSkcSuTiplwRFmpSUe/ls//ZsRo8y/3awzDS4W2EphUupXRfKCj2HIQzbj
         b6gUDg4WV8HijFJZaY09wrSqxAqliAYf/jXvz9SHEcMRLUVgLs8cS27M7AgXYHgNBE1e
         hiDe0/7tJH7qoMWcdkaw3LgMlONjPCyrfoR2TYy4LM+xDBnxDu3G/8VsyQIjBpONIoHq
         VejgM/jYKcX4sxrwQnA54ohfAhDe2Okt5bA2ZzbMfcHZ3gPuLqrIzgOADZylHx29Wx+r
         z49Q7OxreraooZXkkbT84eSphTi8UTbPFOn5UG2NnOuG7qSJs8FgKNCPC3DtvNLiYFDD
         uexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oWWqCKxEe5JOZexnW4lpG/6Y5YZX1PGnjV7kCZ+jMOI=;
        b=PeMvXqceLjo7os1MCYO0iDJN9G0lhTtLZPltkbevfziaEPWpDweIz8sxollFhK4UAZ
         HjPyVSEwXxn0+jQcTbzaM5iiDHfgl6rY47gtSISmy/KvJxIEiVgT9kuYmGSu3TG+ruES
         883KZrdmc/gNf2itgLflgDMHnsrsk81kV2uOftbOnbe3kuSRiUnl293pmY7CXJMYTHYS
         Ot23ryIhMFO7MZ85HAVTmld2ZKryYwM0E6JMYpeRbVlV6XM2YBRGPDcMe9iI8MiloaGd
         Stafq7yh2t8Ozjqugq7WhsNvMdq8RfeUvQ0p1jmFDwCA3SywSSs404c3Ke7/XjRgLaEn
         carw==
X-Gm-Message-State: AOAM533yAwxw3ZYhAIxq8Z7/JkpLGhwwkC8+uJkdURSlR319qzfzBnEw
        Hkb2XzsiTf3R/13TgjRbfykFmMg2+ifVkg==
X-Google-Smtp-Source: ABdhPJyKGdG7+QrZxG9kETd6JFcnYe2qaU0hpEmEr9Ixzv7ECnOSsgV9nFZL0Z0znqmRwo7finZmOA==
X-Received: by 2002:a05:6512:2f3:: with SMTP id m19mr132155lfq.455.1611568517176;
        Mon, 25 Jan 2021 01:55:17 -0800 (PST)
Received: from jade.urgonet (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id y2sm1091328ljh.28.2021.01.25.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 01:55:16 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date:   Mon, 25 Jan 2021 10:54:45 +0100
Message-Id: <20210125095445.1524477-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing need_resched() before cond_resched() is not needed as an
equivalent test is done internally in cond_resched(). So drop the
need_resched() test.

Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/call.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 780d7c4fd756..7a77e375b503 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -149,8 +149,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 			 */
 			optee_cq_wait_for_completion(&optee->call_queue, &w);
 		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
-			if (need_resched())
-				cond_resched();
+			cond_resched();
 			param.a0 = res.a0;
 			param.a1 = res.a1;
 			param.a2 = res.a2;
-- 
2.25.1

