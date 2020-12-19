Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C02DECEA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgLSDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgLSDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:31:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1631BC0611CB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g24so2873411qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrTDV1JC3FHqRkPuc+wq4o33QEiL82RGRHhUmIGgN6s=;
        b=FV0bA/glG6mM2oq/0OIUCIVCj6ovoytZ5Qj/7e+wkIWZ2ELS8XCIiKnF6W4r6i7jRT
         CFWxHpAaKVstazgf50GOecmqvoxJ2c/3Af0zFXqfBCUnWWXQ3csgizyva8ZTedaBRUyp
         SlbsXze46vnkooO1wMFJVXrx/DLreGecZ7HHnYRpDtxesRsJPbyQiaUGm95dmA1Sa3dj
         UwcPkuerUDLJjuvenqZZs+gD6LhbxVI9wf19i/Lu9hfL5LGveHHuUCxxb05T7GkrQavn
         jjMUfR3lwsQfMjOjnOV+SrD3sgnnXrTlpuBtEZawPuKmA0uTzkWQNSg7GdlQ1D/LA+6q
         iT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrTDV1JC3FHqRkPuc+wq4o33QEiL82RGRHhUmIGgN6s=;
        b=FUjDRWTzAiLUw8fbKDrHxPk1aOYSuURpVVLxA79cCy9vrFivT3KcQnTzOqTcl3JG6G
         i24CtoKSuNlPoXhMiGzviNNDVl1VZuYaaGzYjTtYdk+ZUWeRo3jSWgEXHdBX3lXr6/ht
         Hc95EpY8DQFEgYW+8Kq1LhMFHwmi42Dk0yepNn7MmUW8Nx7sqkeYi6zGsluUx0jwQwMb
         v6ZL96fVI/NxuxZ2po36yT8/rrcobINu+jW9fDuWzqcOsvc7E9zgowsrV3PDpN15NnAX
         pNS+kQDKoTyIXbGgnHR/gGCkMDLa2orW5iJVJ71OSc+SJL2qjDaVLvk6tm8S5/9iIocr
         GtxA==
X-Gm-Message-State: AOAM5321bPfNRFf/yvyd/fL5bFL1bdFRSE5/8zSAgQyiEIaUwwE+SvJl
        HORVnYg4xCeXVk+9wXym4VbS+A==
X-Google-Smtp-Source: ABdhPJyLn6gTjUXMIfEImNEoRb2yDuEHvY0BV+clvgYgkiG4hWdWLhGB0lP4Ja9P51BVOBuZ1T5/sg==
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr7248502qta.215.1608348633318;
        Fri, 18 Dec 2020 19:30:33 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id y16sm4376045qki.132.2020.12.18.19.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 19:30:32 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drivers: crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Fri, 18 Dec 2020 22:30:25 -0500
Message-Id: <20201219033027.3066042-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219033027.3066042-1-thara.gopinath@linaro.org>
References: <20201219033027.3066042-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the register REG_ENCR_XTS_DU_SIZE to cryptlen for AES XTS
transformation. Anything else causes the engine to return back
wrong results.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 5006e74c40cd..7ae0b779563f 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -294,15 +294,15 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 {
 	u32 xtskey[QCE_MAX_CIPHER_KEY_SIZE / sizeof(u32)] = {0};
 	unsigned int xtsklen = enckeylen / (2 * sizeof(u32));
-	unsigned int xtsdusize;
 
 	qce_cpu_to_be32p_array((__be32 *)xtskey, enckey + enckeylen / 2,
 			       enckeylen / 2);
 	qce_write_array(qce, REG_ENCR_XTS_KEY0, xtskey, xtsklen);
 
-	/* xts du size 512B */
-	xtsdusize = min_t(u32, QCE_SECTOR_SIZE, cryptlen);
-	qce_write(qce, REG_ENCR_XTS_DU_SIZE, xtsdusize);
+	/* Set data unit size to cryptlen. Anything else causes
+	 * crypto engine to return back incorrect results.
+	 */
+	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
 }
 
 static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
-- 
2.25.1

