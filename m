Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1192FD95A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbhATTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392109AbhATSuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:50:52 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95EC061798
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:51 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so9968689qtn.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=m6OwLILHrvtJ0mcAkErFeiRbxWWnYQiRbK1besy9tN5LjAdkoBV6XlBVPILT+zvLYS
         AdCKcD85a2CobiTu/5b4ig240n/g5sqvOlb+8h73Jp3KXA6jdl8vulXM2ebRLrEkVrHB
         v0UnS0xEsqc2jjZpoestC62hfu4rSj6BUI6mAi9VcDST3nWINy0CoKiwzWq6ytv1HhmM
         +xo5JUn3Q8auef4HYnzIYBanteThfLigipVgs9oeCb1MN9pObdiPswFBTUONuRiAE5Pc
         YfM7mGdmYRciHoqR9wYeczWwinuaSXmUZItKoFwA+Ba4M08Ho0kFAIay0jp+ReTRsLx+
         Psmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=M/mPfOofiPii6q/VwY4VVZORr3+8ePlnmkS0cyOgzACC2LOs4QUiXIrKZlTtoswoej
         FJGVUj8hJfx8f2e+5M5rfh7i5kixeJ5iHgjcZBhnTvdVV5dH9C3M4Pr9Zd6L4M1WJ56A
         nSg3DoYVOmcNXMguaH9ad4Xq/cqcvPR2mzaVgTHKPB+C8eEqOvbudJ/frD05Fo/byfi4
         kaGQ2/CTYZXC1EBVga8nxxyNi6XX3h1tPIXDC0RhHkWLHrI9ZahUgoWcO7W40ec7sTcB
         OVYkx9GytZ1nJeZ8HskI70Qpq0HELBggnm+aYqP6t0NbNRtzKyCYx8Ud344z+6JwRnbP
         zaKw==
X-Gm-Message-State: AOAM530D5+FCwa+sBpvHJoBnummgQccCHlQEOpxARUU1CxbyVM/muH86
        JTUQDFCSYumAazj7TeXF9LOdpw==
X-Google-Smtp-Source: ABdhPJwBQRVf9fK5zpVkbN5OtTOndxzPY2I3DAqDQD5hyvUNFU5gQt4Jcq8xPV0+QalCARaFCDyVSg==
X-Received: by 2002:ac8:721a:: with SMTP id a26mr10364146qtp.223.1611168530758;
        Wed, 20 Jan 2021 10:48:50 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w8sm1769903qts.50.2021.01.20.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:48:50 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Wed, 20 Jan 2021 13:48:42 -0500
Message-Id: <20210120184843.3217775-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120184843.3217775-1-thara.gopinath@linaro.org>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

src_table is unused and hence remove it from struct qce_cipher_reqctx

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/cipher.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index cffa9fc628ff..850f257d00f3 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -40,7 +40,6 @@ struct qce_cipher_reqctx {
 	struct scatterlist result_sg;
 	struct sg_table dst_tbl;
 	struct scatterlist *dst_sg;
-	struct sg_table src_tbl;
 	struct scatterlist *src_sg;
 	unsigned int cryptlen;
 	struct skcipher_request fallback_req;	// keep at the end
-- 
2.25.1

