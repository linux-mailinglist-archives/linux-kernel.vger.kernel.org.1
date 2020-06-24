Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415F22076C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbgFXPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 11:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404140AbgFXPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE44C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so2852973wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6bqmwyzyHG2RdGTyEeF3lokJJurQOvKiY/PaolAzM0=;
        b=UDb/Vse+j4PLUklMPE1jOG89dEqQuO2i7OzePR1xZB+Siiw5RD0TNhZ61xg09kUs89
         /j6gfY5MnzUfpvNACK/AyPui2vyY89OSGCOHsoIVLaqSqPW9LpLNZAFOlC1J8E0fmIdp
         an9XJ9DImy6JVYbEUnIPVyxSCmwdNyhEkapxPgOahBtkigo0F522HmM5oAB7yoM0WR1U
         D32plII+0qv9D9duq0tohxdfVCI6gjoYS/9hQYTQQmTvnHOBVyeSxKVGEiIKxXoGzl5B
         Ax/pJQOymt1mxWUlguQssE0BX/ehCYDcRuTAyJiWxEyRVtjn0QJTfb+Hq32A+W97Jhov
         Ch/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6bqmwyzyHG2RdGTyEeF3lokJJurQOvKiY/PaolAzM0=;
        b=VMccaGcWKel4cE4kTKEcWuQpcELNUTXZExBC2qZ/ZHGE4M+AjSCf7CkQCJV2P/77hj
         7fAWErgVdrFacwWby/vPeDEnkwFmTSpIJ+wmUknh6eLyFyL5X/A1OGVK8HAZJyjz8D9d
         iR62nEJt+aGhP6eWUdWJDkWbGqaKMm80MsaeDjwB9hnbe7lKz6UcWhQ+9pIEs/7GNXKJ
         PB2511K3nPitqYffruDhoS+ZseU4PsqXfsrIj3626ergtvmk5vKJ+ojOdH2Q+cH1hWLR
         Wku6pZKxWdfs0ckBNVejy0iRkpg2wGVzQHhiAvuNNSNssyCOsyp9dXU/DC/FGxXhehQk
         /V7A==
X-Gm-Message-State: AOAM530nWDVQ4rEB4hAgh44i+mzEsic0ncvlG5XsKBdDnBnnnafMliQJ
        EKG1eVViUPltPunu0hF7Io8p+g==
X-Google-Smtp-Source: ABdhPJwfNOYCqcizNAWS6wfigwc8Rf4j01V19FGJhjfXQf2U6h6zjrh7PY3vYsNnGql2y9vxSlE+Gg==
X-Received: by 2002:a1c:3881:: with SMTP id f123mr29878381wma.178.1593011235038;
        Wed, 24 Jun 2020 08:07:15 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>,
        Eric Miao <eric.miao@marvell.com>
Subject: [PATCH 03/10] mfd: tps6586x: Fix cast to restricted __le32 warning
Date:   Wed, 24 Jun 2020 16:06:57 +0100
Message-Id: <20200624150704.2729736-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silences Sparse warning(s):

 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32
 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32
 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32
 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32
 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32
 drivers/mfd/tps6586x.c:323:16: warning: cast to restricted __le32

Cc: <stable@vger.kernel.org>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tps6586x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c8aadd39324e3..c36597797ddd8 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -309,18 +309,19 @@ static const struct irq_domain_ops tps6586x_domain_ops = {
 static irqreturn_t tps6586x_irq(int irq, void *data)
 {
 	struct tps6586x *tps6586x = data;
-	u32 acks;
+	uint32_t acks;
+	__le32 val;
 	int ret = 0;
 
 	ret = tps6586x_reads(tps6586x->dev, TPS6586X_INT_ACK1,
-			     sizeof(acks), (uint8_t *)&acks);
+			     sizeof(acks), (uint8_t *)&val);
 
 	if (ret < 0) {
 		dev_err(tps6586x->dev, "failed to read interrupt status\n");
 		return IRQ_NONE;
 	}
 
-	acks = le32_to_cpu(acks);
+	acks = le32_to_cpu(val);
 
 	while (acks) {
 		int i = __ffs(acks);
-- 
2.25.1

