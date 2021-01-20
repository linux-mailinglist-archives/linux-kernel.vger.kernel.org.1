Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD62FD955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392096AbhATTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392108AbhATSuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:50:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D9FC061796
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o18so7354129qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ckoNO1YJt5QKI0zTcMaiAvFZHq1fWNUxmCXeDkmSik=;
        b=sPpCMyU5a/KbiaJEZnuL75dHd3hNUe5y2Qm6K2Tygsn0dLPHKWCEcibvsA75MTKTpP
         s8hUQV1RREpcP+iJBh4k2an/TDE6qPYsHXDCH0Lqh74plPbvzyS30bHiIc2iOmTjdySx
         ZWS4BaBYfaUd3X6oN/ljIJSCwsQ0LaG+JpQdn72u3RspT1sdON+Nw8Ooq/bu9Hx7ucZ5
         skjek77aXLjVyShV0pGYb+8CAf50A/aBn+my1BD0OqjNZM1/STccUR6yQTzfHfp+kSjd
         smA5Z/s1tvK8hafVPNppx08HXa4YUz1SoBnm/5gAF6nNEL0ORirFKAc4F7CAjPH/k1xo
         e20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ckoNO1YJt5QKI0zTcMaiAvFZHq1fWNUxmCXeDkmSik=;
        b=BarZ927bevARG7Sp3n8UMJHa5Kl+n6nJDBLTy+FuwscSliTvxTJ4/95aTYyaaNdFjT
         dJXaNJrvHrxEHCrR+9MlT1rNi5a+PMj/fw0IKBJdfdBBuNs557ckLYYK+oDcJECZMoS+
         vqV89EadlIoEg6CGxJ91zIHsPvN4rv+Xul4wAcUuW1Ss+wPvc2seWzLVoWraXDL7p39b
         0fWiCaqHe2pSWEUHgcYNSW6kE0PMrBNFPqTjPe1NUPDD6qXqcav1WRXixXcIvYIdnRCW
         9o9c4QW9Yp2qT1F9CBdePqaF3yZpGMnOGKDMIrWLb8zkOu7oIjhtiWn6XdV0vijnESOg
         +hqQ==
X-Gm-Message-State: AOAM533oRhJQ7RxTI7MbIrRv9Cr9ZZIQR+tB2DjJdIBHrqPEykus8b2K
        SVXptk7qUDea+ZtvJciP/3DsMS9BvwoGpA==
X-Google-Smtp-Source: ABdhPJxUwOEs2lcO5h+zfhLY+6rFbR/C19jbgImjc6kM5gI//Eqx33qYWRewdzyvcPdlg/yxiOtKSg==
X-Received: by 2002:ac8:5852:: with SMTP id h18mr10039542qth.357.1611168529688;
        Wed, 20 Jan 2021 10:48:49 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w8sm1769903qts.50.2021.01.20.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:48:48 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] drivers: crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Wed, 20 Jan 2021 13:48:41 -0500
Message-Id: <20210120184843.3217775-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120184843.3217775-1-thara.gopinath@linaro.org>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
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
index a73db2a5637f..f7bc701a4aa2 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -295,15 +295,15 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
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

