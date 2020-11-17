Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFD2B6C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKQRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730253AbgKQRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:49:07 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBADEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:07 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so1463975pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=268k75iGgPwajGOaY5d0Of03PhQtD6bYvRMlc9HmW4g=;
        b=jfOa4AiS/tPxjopccSsFwVuEPAIEFOQvgNIDZfxXpCqZM2rBRAbMSPUGrRZCUxk9RM
         M1lSMnYTKmkr2XwSjmUTy27z01sP+vWfmEPHgxDNEejk9lIudy+tadMlhWcbHgGXGsAR
         m9Hv77MP41Mel1ZJKkB6HvxyP0sB62RPYQoM944E6Eo6+T24PBAzzub48v8+buJCMMRL
         vwM2SOKLaPLTVb64Py+CQN2TERL4pdJLcKZ9w49oof+AXLuSDSzabeXmjYwy5mLyGPi9
         ZyZVBHp4DECrukNla6p+KiGhOD3Jum1NWBvyRl7F4SiAeuW+7CxLg0w5K2zA2Rn7Xhls
         0ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=268k75iGgPwajGOaY5d0Of03PhQtD6bYvRMlc9HmW4g=;
        b=Q7MKlb/sTTgxlNE+DC1bilVnTmzORUySiImuwuhCd8qqFqZXFtlQ3ptRzRTOI4NNTO
         TrQtbf+rixMs3L80/qwxl+eznZTzLGifUUJaKXR7i5ES52KIsHz7GtrMohjFnAerI4x+
         a1x3zoXKAFY5I+1DtZB2llT3Q3QhEWrYANNhNXISzseciaFkuzVxpS29a3RiAl3bqUuV
         KSLqhqn8ZvMLtc9yNd6Zw1vhuIYEp/yNpSp5p1lN7uf2R8GfeiuZ1TNHZeGg+b74SOTe
         gAT4LI+t0Kk/xUvfZcJgHv7wHhwG85bbh9eZzi7Aab9aAGzGEBo9+cC6DrYIA09MWA3Z
         SaUA==
X-Gm-Message-State: AOAM533RsbhZqjgceMzL6UyDgeYdP7xW632v2HgMvKIebFGPxslE6l0Y
        m3MVxxCebv5dGvJHanIFyn/M
X-Google-Smtp-Source: ABdhPJxY8KGN1ZSec/mXAFeuvkUuavubQH+z6KaVaM8f1siege4JnI9ulfj0qykscLac6PxVdm8hQg==
X-Received: by 2002:a62:e40c:0:b029:18b:ad5:18a8 with SMTP id r12-20020a62e40c0000b029018b0ad518a8mr707392pfh.16.1605635347218;
        Tue, 17 Nov 2020 09:49:07 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 192sm22222810pfz.200.2020.11.17.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:49:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/4] mtd: rawnand: qcom: Add support for Qcom SMEM parser
Date:   Tue, 17 Nov 2020 23:18:44 +0530
Message-Id: <20201117174845.28684-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
References: <20201117174845.28684-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using Qualcomm SMEM based flash partition parser in
Qualcomm NAND controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 777fb0de0680..1b031aeac18b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2797,6 +2797,8 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	return 0;
 }
 
+static const char * const probes[] = { "qcomsmem", NULL };
+
 static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 					    struct qcom_nand_host *host,
 					    struct device_node *dn)
@@ -2860,7 +2862,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		}
 	}
 
-	ret = mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
 
-- 
2.17.1

