Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467AA2F268A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbhALDHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbhALDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:07:09 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:51 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d14so718197qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ckoNO1YJt5QKI0zTcMaiAvFZHq1fWNUxmCXeDkmSik=;
        b=RvUHC9efiBoahnjz2FjLCD+IuvX86QT5zWbdiCacODGMTQGYVBOLw51LGdvI6/Ce1H
         PwrDw6JDzPF6Mz27YuLEbStFEnBESjXagprqey7vNXtq8UzW74p+ocfBN9MMH9ipSk67
         7S4aYdodeQzhiQLmnCpqaaXcXXvKhvs4FtgD6bsnZUby3k1ssGR/H7eR0P0vklIby8Rd
         kQ/tL9IdYXWIuBNximdCNNerKwj1C6QyShlSuwi7ktMOOEelrdtSmdiP3SLRz+UpKVCB
         eZvf9fgLjC/LfI9nEsMFp18YReehWclMoL36KdUCy8JmQ4lP9bbSQPzWaEiXvORERn5y
         lEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ckoNO1YJt5QKI0zTcMaiAvFZHq1fWNUxmCXeDkmSik=;
        b=gowbGSFcP8Cid1nQCQImBV6IsNJSFqp7gIn187x5hbHW59j3Otg27RJQ7DlMJsx2n+
         rGH14cL5jiPZo1qLZlylReVd9exgWFE0nQTmPmZKzRU6E+zCy9Hv0kV83pJ0CYcmXKK9
         PkcBf0B8IxRCNIlp83xzOhXuGZkvQ5aAImfbiIDkWI59kzrpZf+HbvNwBbbWUqJ2SMnk
         TKK4LOLcq6USlMoLL0h530y6x/jI+bENCcXpKcUgNmsPc9Y3murlVddLDCOR+3Z6ryoe
         wiO5BGff7NSpxicO6QmEk4Nbpb4VfAJ6Yb7/VyNyrpU2dwU7vjjf8WRjxr0417eAGJbW
         Jf4g==
X-Gm-Message-State: AOAM532Ppkpm9V2IjGpoeg+dd5P5d53uDyE3j00WopOlQte8uTfT4bbr
        rvq1kJdpPIcjQT+83Vb/5x6Gbg==
X-Google-Smtp-Source: ABdhPJxzxKhiEsftSsOs8LwuKbvVHCRrhfAI0/KLdehVkiC7h8bh/zTIoHs7SsrmsTAvW5JAorkCzA==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr2405243qkg.479.1610420751003;
        Mon, 11 Jan 2021 19:05:51 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c7sm814235qkm.99.2021.01.11.19.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:05:50 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drivers: crypto: qce: common: Set data unit size to message length for AES XTS transformation
Date:   Mon, 11 Jan 2021 22:05:43 -0500
Message-Id: <20210112030545.669480-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112030545.669480-1-thara.gopinath@linaro.org>
References: <20210112030545.669480-1-thara.gopinath@linaro.org>
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

