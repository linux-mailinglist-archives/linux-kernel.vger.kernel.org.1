Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAC2A49AD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 16:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgKCP3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgKCP3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:29:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294CC061A49
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:29:34 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b3so13090992wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05S3ru4tW4mcaDRoeFk8QLKhxybxsfGcFNjhW6F8wDA=;
        b=mUHzgMDhCaONSYhvmw/ALRA7QndQYhUnZgTu7ZoaTFh5kihM3G/YdksvozD0IgEffI
         pkycfuihbdujTsBIL5+VnxXSwLlDtyR9KW9IE8011+Gz/K0CGkTgsLoTj5OJwGeufpQK
         sJ5F5ouNBch0vfaJcEjAGYFUC1L/b7DEHtGLSCKtVfhzVnTnG12d8pLPOp3fYtBjcTaI
         hAnquaFCoxWyZ7cWArrkiChK3XacR3l2bcrfUn1J5rokQhVfW8aCmLYwS6fZNeTLOZLx
         cLW5WTrrJxIVyg8kqBeOJVjYH9wz2Gt0OSb4rzGbC2teSbTZosg+WsN/Xvu76fExJZch
         EVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05S3ru4tW4mcaDRoeFk8QLKhxybxsfGcFNjhW6F8wDA=;
        b=B550Cl+DYrlQlik9CIM9pEOm3mOKs71qvPccfLymURLhB4uSLBYudi9iPuwM1C6LuH
         7hiIn4jkklVCJTiw1GdqZky50pnf82Tz/zkBiFEo5czw83Sv5DOmq1zPgO3P7a7ONq84
         KyVB01X1dIfQmMSBcqEuIW5EJurAnaOqggS+aa6eT+vRYu3VagpLHFdpm/MCHiT2l69J
         JUPEmZYrgAk596OgK8EEzCgSz2dOaHtwhnhUXrwZ0WHODMnnLBO3xWuVol7M3PxLALoB
         40l39VdGDv26Dw26O39wAyUSBSFnllS1TkWSu2qRPsDdkQ6MI5yEKdi83b0/xd51MdTE
         +Duw==
X-Gm-Message-State: AOAM533hmbvaeNT8KNuWEM+3wHEp00poC7LYB49ATbZxwNO22FxilJux
        A7QRwcv7CdtilSPQhQl1v/gNWUmwGTt2PGGc
X-Google-Smtp-Source: ABdhPJzDNOQApkc32dJ66+dO6QtsCwF2WE0kOXaJCzV+lWdTifAu4mloBHleqsSF6TcNi+erSSQq7w==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr26793520wrt.221.1604417372710;
        Tue, 03 Nov 2020 07:29:32 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id j127sm3491779wma.31.2020.11.03.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:29:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 17/25] soc: qcom: smsm: Fix some kernel-doc formatting and naming problems
Date:   Tue,  3 Nov 2020 15:28:30 +0000
Message-Id: <20201103152838.1290217-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103152838.1290217-1-lee.jones@linaro.org>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/soc/qcom/smsm.c:140: warning: Function parameter or member 'mask' not described in 'smsm_update_bits'
 drivers/soc/qcom/smsm.c:140: warning: Excess function parameter 'offset' description in 'smsm_update_bits'
 drivers/soc/qcom/smsm.c:257: warning: bad line:
 drivers/soc/qcom/smsm.c:260: warning: bad line:

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/smsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index 70c3c90b997c9..1d3d5e3ec2b07 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -130,7 +130,7 @@ struct smsm_host {
 /**
  * smsm_update_bits() - change bit in outgoing entry and inform subscribers
  * @data:	smsm context pointer
- * @offset:	bit in the entry
+ * @mask:	value mask
  * @value:	new value
  *
  * Used to set and clear the bits in the outgoing/local entry and inform
@@ -254,10 +254,8 @@ static void smsm_mask_irq(struct irq_data *irqd)
  * smsm_unmask_irq() - subscribe to cascades of IRQs of a certain status bit
  * @irqd:	IRQ handle to be unmasked
  *
-
  * This subscribes the local CPU to interrupts upon changes to the defined
  * status bit. The bit is also marked for cascading.
-
  */
 static void smsm_unmask_irq(struct irq_data *irqd)
 {
-- 
2.25.1

