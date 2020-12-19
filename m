Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACD02DECF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLSDcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgLSDbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:31:51 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27367C0611CD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:35 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a4so1645144qvd.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=K77tGdpSQ+xMM14yYMq1WYAAXE96zJ8N41hgJgBFYB3OEpifFIWHJuYoP/PJyhtstG
         H4aeCDacaVtKytY/VskSNfQEjIij2QkgzN2ym3MHhIE3xK6FOk2/wJTB5r490i7jTjOW
         3KxOsLG/fA2f1oizKJiKhYnqyCmnTWkZ2ya/TNv2rLl6a83I1j8Zuu4s/U+VoIy0ZjJr
         IFFk5/ogPUTi63Pqs7Wpkbot9i5z71+XNuAGxVzff9D5gN2zGzw4YOAiEEZyczIl3I85
         YuZFH5WxHP2hB3BnmoNyiLJPYWLhIDdftVqZsOG5RZxGKj83OuvAE/W7DAdnZNXt4Iit
         tJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=QiyPB+6E8KHGzwVsdvauggIR+x8CPgbWIJchkm1AOt0rytRoETEKVE/9eASKVrTlAQ
         kPQbV/kGLBYc2dOmKrHYOIKvtTvj9n0AZ5BHVhZvIRvQxT8/75WmKWDfLDSGMHV3mX1e
         W9PmSGYl/n/avKQI67G8duqH+wx+dJMj0/FwK0iNnA81hCfkbnmdCFoRMPmN9WV0WAm6
         /TokRjQD4efERcLVAsSnjWAyK8EMz4qDotvMSzxi+sgRB89oqMnsaiCiuGDQfE7TTMHl
         00Vbj2kh3jXg5E0lMO2rhyQovx58yR4ryA4fjDWjlxoe6a5VqlgR6XhbVFw8DJRVoopB
         xP+g==
X-Gm-Message-State: AOAM5332f5ic7Ws4sSW3QnKVLYyNzGU1MUDV21TE+88Do6LiLsZDLnF6
        IQApXZzr2d5J6RewuF33J4WDXw==
X-Google-Smtp-Source: ABdhPJyup2brldzwfzliD+vFKuM/4Tbezy87g9fD3vRaKbDzEuyx3TVEO+Ivr7JYD4BjHf/NqxHrsg==
X-Received: by 2002:a0c:b48c:: with SMTP id c12mr7632370qve.9.1608348634463;
        Fri, 18 Dec 2020 19:30:34 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id y16sm4376045qki.132.2020.12.18.19.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 19:30:33 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Fri, 18 Dec 2020 22:30:26 -0500
Message-Id: <20201219033027.3066042-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219033027.3066042-1-thara.gopinath@linaro.org>
References: <20201219033027.3066042-1-thara.gopinath@linaro.org>
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

