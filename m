Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7B22C6703
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgK0Nj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgK0Nj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:39:56 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A2C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:39:56 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so5745105ejy.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTzYDGlssiWZrUEFT2+YAeEh5ntk2vBgSh5UR1iN5dM=;
        b=ULNlQGsr3qUNzH/jaEfgFSgEyxt6P0XKTUnq1MIA+5i44yiv0m/KnfBsBRFM19+Y+D
         RSScUObp4c25El6RzmLPoNg/JsufYS7LHJMAI8Oo+kbZBY1+ZE7komJ9u7CEfhmwBL2H
         HWZ6/nn2XkCunJ8v5w4GQxlK92VT28h5Wbc4n58j+Fc5AhffjZAgrVJ29bgICVLg5aoS
         aVC+WsED7UiDvLULIuqF4Duy778G+j1sR5X5VXB5v5owMwFLc0JYwo6JYhLowRBbuv0I
         1780ULPOWodEfzXGZ1Pcy+rGSmYWLS8nhoLMTcoev+/wBAKySLxh4w8sVla71UFvlQ0U
         vSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTzYDGlssiWZrUEFT2+YAeEh5ntk2vBgSh5UR1iN5dM=;
        b=fZNEFyIZX+YqVpxV7B6fUHbSaxAgbJQhk+CtoOx+ygYEVGmnXnh8kxeuOVJF7+OAHT
         civOT0ITcVhW+dzKayg60so88Nm2NL8f1T6zHmtMW90DPWcNPq5BGTZWDVafnmPS7hdP
         OWj5ZGTwaUethvYHa7UYDZZw0Bf3bZsPmuY1v1zZafWLBCXDoYbgjPKGZDVo9eE+r4x6
         ggl6DzMzBrYIJULE1Gojc3hT+ikn97i2MlZU8V97Eyi3l2+3Wl+skEDZ4+U/jSJTQKyy
         J4Bn5oNS3Wffr6+ZsE+BP9bNn3okhcvoqr4+SeR8WmQFrBGRhNA+KtkWx79OP/YuDMeT
         2dEg==
X-Gm-Message-State: AOAM5304sqm+aQS/yi1h6H+56RR/6UVlgwU5tRrQT7r9Lh/AHpPHuHff
        Mop4bN5Lcm+RDEZpSdVu7Mpvbw==
X-Google-Smtp-Source: ABdhPJwfONJAi7YtCaCsi4iSGdldwFF46ZMraq6EoZJOiOLRQAkr6rj/+YjLyi/d50CKVVgwe/dX6w==
X-Received: by 2002:a17:906:7a18:: with SMTP id d24mr5856719ejo.324.1606484394871;
        Fri, 27 Nov 2020 05:39:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:a6a1:9dbe:c8e3:3524])
        by smtp.gmail.com with ESMTPSA id z16sm4840092ejx.119.2020.11.27.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:39:54 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     loic.poulain@linaro.org, robert.foss@linaro.org,
        bjorn.andersson@linaro.org, wsa@kernel.org, todor.too@gmail.com,
        vkoul@kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] i2c: qcom: Fix IRQ error misassignement
Date:   Fri, 27 Nov 2020 14:39:37 +0100
Message-Id: <20201127133937.93208-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During cci_isr() errors read from register fields belonging to
i2c master1 are currently assigned to the status field belonging to
i2c master0. This patch corrects this error, and always assigns
master1 errors to the status field of master1.

Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")

Reported-by: Loic Poulain <loic.poulain@linaro.org>
Suggested-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index f13735beca58..1c259b5188de 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -194,9 +194,9 @@ static irqreturn_t cci_isr(int irq, void *dev)
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_ERROR)) {
 		if (val & CCI_IRQ_STATUS_0_I2C_M1_Q0_NACK_ERR ||
 			val & CCI_IRQ_STATUS_0_I2C_M1_Q1_NACK_ERR)
-			cci->master[0].status = -ENXIO;
+			cci->master[1].status = -ENXIO;
 		else
-			cci->master[0].status = -EIO;
+			cci->master[1].status = -EIO;
 
 		writel(CCI_HALT_REQ_I2C_M1_Q0Q1, cci->base + CCI_HALT_REQ);
 		ret = IRQ_HANDLED;
-- 
2.27.0

