Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23C2F268F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbhALDHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbhALDHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:07:15 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7CFC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:52 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id z11so750874qkj.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=FHZHVAvQFH71NDVBauCoz+B55dhLcRsdkajoKvOLnZoyTJq+4I8K9Og8Lk1vZ7rWnC
         DiAOSAnQTdcbeqKTyewqxEjHVDsHsfV9lmTTDtDNmxWm6gSgVHnEf2dEFxMM9lVfjq8F
         c9OTxAEXZTI5VpUbHn9dmEy5km2cowmprq03G6Bt2CxoySAKyTc7v1Oj67n8zIayR0Hy
         VfTyjF63WAR8kcnGg3nf2tPJJfW+awfpEhgVbgV0ggs7IJ78usyrl/lCS3yDrRnIEcSW
         Z++bgygu65OpIU2QEo9w7kjmeYf0DodFQ9F8mSIereqv1n43Yy+zpYvpTK/tfGqoDmVU
         f/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJE2aPOEkLIKEj61l27Ctrd7+4+SFwAw4jzWQDD0G1c=;
        b=JOZTdzIZZNvGq6ONEqW8RXbMrlQWcs+XLjFJWCR0Wj0aNBb2cLkR1o//4ey/UXzGrF
         pIv9B9G5eOQGNO4874Bc6Wkjd75yP3kBUI2SW3TRWdiYMPPa6dW3pjKKXpHpp3TkaWkO
         qs+NYjz/SzRT2o2YK2334/0KyH2YehtzkTLN6IQNbnNQx1VGayt4fey8zOduBDEnwppR
         YVFluFLVHczi70OEfv+cqJ+iRKLHoIBgsJ3RE0zKgI8iQkExd2ow58NOppYsF3GBEgPj
         cicICO9iaCRJyrIGph9LbcdfeDFtF2y20tQif6oFjUQTmLURny+nQJ2DfkrkOmsNtI3y
         EwGA==
X-Gm-Message-State: AOAM531Ew4Hm22WIkiBpkbc+Bq3VSV4lzP7LgZYnVOjpjqybhguh8W8k
        6nLJ7qV5OhhKQgEZmeueJAjUag==
X-Google-Smtp-Source: ABdhPJxf3e4a0so5Iln3VXaLFeknfpUjHW8w/n+/U729zUA1wQmb98eBT4jX3dIEOaUJmv2zK+oM9w==
X-Received: by 2002:a37:5b85:: with SMTP id p127mr2514915qkb.180.1610420752138;
        Mon, 11 Jan 2021 19:05:52 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c7sm814235qkm.99.2021.01.11.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:05:51 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] drivers: crypto: qce: Remover src_tbl from qce_cipher_reqctx
Date:   Mon, 11 Jan 2021 22:05:44 -0500
Message-Id: <20210112030545.669480-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112030545.669480-1-thara.gopinath@linaro.org>
References: <20210112030545.669480-1-thara.gopinath@linaro.org>
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

