Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45942C630B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgK0KZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgK0KZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:19 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93FEC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:18 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id z5so518319wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0efWPHptGDOCPLwQ0ASym8qAND+GCtsojOlG99y4xBw=;
        b=lVdaEYYxYPGdAI1bLdrb68hXukBC6PEvtHSGmt+7hYhpSg1QYPOQ4gmUOkA9LDVRC0
         GEEK3ocdZNbouz/ziRZIiy8FgJydVUTs9sVGPW04QBHrUXnK0Mg7xZrR5A0J96/0mYTf
         i0XfGbLXkXAMd48a1hIi6fQhKg/C4zEKmUwLfwAcJEXLUINKa1JlNpqXM4RdOemthWTF
         UOef7PE05uNjzM9L0HlQ2V54d2VdGCo+CVM4hquEa0A4i4jL0hcjZo/OGFQCtanO5/UT
         2WAS3774lv8QVO9cRUbiRYLJamTXKn4480/20YPRe/AWPHs4ePoVT79M7LsXSJW1uS8M
         NqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0efWPHptGDOCPLwQ0ASym8qAND+GCtsojOlG99y4xBw=;
        b=G4cRI2ym+/Y9BKQuuwvHvnXWrwPWbxZczh58yDpFLQXEA9y8y8pyWXmBqUfTN6uxiF
         48avTLiS5sgodUppn3gL6Sj52M9ciOCmSa/xxwUWPX1NJZkyE3mk/b4VYTnAf6nO+eQs
         gubAZqgYzDwv5p3dRx6m7aLJNwVU77a3ctq+XvS5IPpA3bYIyNpp2PtdLWdeBjPKRELU
         Mb3So538JlzsmFv8hh4TTE1WIh6e/lIh9+KRWbbHi847JxIsl+un3RehwIc48x56oVL+
         0LAojcJHKb4fKYXhwkik4T8KZ821DZ90Z9V7KSd8vRKn95z4VO2fdL44bacuiTlhjczz
         fazg==
X-Gm-Message-State: AOAM5319MqhIqdOtfuisfVyAWsfwvCEmO/UEE7QUB/DwYRAgkNJHPUU7
        ktW/nmQ1YmL5kQuyKrtSfP5fe8lfiGs4HxXH
X-Google-Smtp-Source: ABdhPJwLR1LbrHiWVnqilqH3D956Phon2yQ94r4I40IxAyJli5PmDdanOF7Nts+2dB/r12VgXDRDSA==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr8202006wmt.73.1606472717596;
        Fri, 27 Nov 2020 02:25:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] slimbus: qcom-ngd-ctrl: remove redundant out of memory messages
Date:   Fri, 27 Nov 2020 10:24:51 +0000
Message-Id: <20201127102451.17114-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Failure of dma_alloc_coherent will already throw a error message,
so addition message is really redundant here. Remove it!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 82dad7490588..c054e83ab636 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -689,7 +689,6 @@ static int qcom_slim_ngd_init_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	ctrl->rx_base = dma_alloc_coherent(dev, size, &ctrl->rx_phys_base,
 					   GFP_KERNEL);
 	if (!ctrl->rx_base) {
-		dev_err(dev, "dma_alloc_coherent failed\n");
 		ret = -ENOMEM;
 		goto rel_rx;
 	}
@@ -728,7 +727,6 @@ static int qcom_slim_ngd_init_tx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	ctrl->tx_base = dma_alloc_coherent(dev, size, &ctrl->tx_phys_base,
 					   GFP_KERNEL);
 	if (!ctrl->tx_base) {
-		dev_err(dev, "dma_alloc_coherent failed\n");
 		ret = -EINVAL;
 		goto rel_tx;
 	}
-- 
2.21.0

