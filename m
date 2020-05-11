Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43C21CDDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgEKOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730471AbgEKOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:50:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j5so11348541wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa9Qr2jp38ntsePK9KQdtmYWS+E3Bq9MX0wlgR5JArY=;
        b=Ir9HanMKBE8JukedYbpWmHxSB9i/eZa7GV/x6f9Y8ZQohcVZunoV/TzBBMUy5lMyEv
         CIVT2YZ+NxIHFzItcr7SzHMNKRxUjoflLz4gVmpmqS+t8nJNbN6vqNCP6nKEKsvsdIcX
         ZoximNcZ6OMlyhRhMYgocWP/L77UGSTbwBYtGZQRgmK6ZxAZfwJxNGGKlZBa/SLKnOK+
         ScBi6wd08IrYgXUqjpV/BPH0JiVKKWiHIATMTFfERqe7h9exnLX54Q3OM42dcFAlVMvf
         ktOHAG1IsDctoC1lrhok3CAsTCvL+/34hncQD14y/sb8n8nGhP1ShT3MyHU2xZ/Oq9Mt
         qiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa9Qr2jp38ntsePK9KQdtmYWS+E3Bq9MX0wlgR5JArY=;
        b=HmTkKnnFu8r4tgE8jp2OBAxwDCJzCqVpcvnLFkaCZcItChOzvQYqOm6OIP/t93OEly
         uYVVnD7GvQubv+ThPlCWaQl1O+nLJYPDfylPuDo+/hBElFmpWbJ6OC8u4KX3Z+JW6TXA
         QO533sU9tgRXaneZ0WQnzFMfx+80ocXqgntrrXnrlMmLab83riqMHLG8NwNy8Ba1kDLD
         JSVdtrwLmM7V3Kj7kIyP9ZNqk2IFF6qS0tWQJ401Z5NRrUFo2pDlNd/0X1+iJuAp6fOi
         Z3C8x2SZIf2iC5klPNcSiO3GlRP8cCqWKMkD53ZgtPN8Udi9ZWtOGryVLA6QB5Ssks6m
         7IxA==
X-Gm-Message-State: AGi0PuZ4Eic5W+Usc596YaZzIO9ZHh1KtKbbxhoO1vatkux8Z5EiMQK1
        6jwDQRg3tX/r0Itlx63h1UEJpR6VAlo=
X-Google-Smtp-Source: APiQypKbQRHA90JHjofjxwmgNCrQuUV4skzkrcJnXRQQFDd3CcixchAdrG8phlvBmg279t1rxEmT/Q==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr19294796wrw.319.1589208656339;
        Mon, 11 May 2020 07:50:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 33sm18512983wrk.61.2020.05.11.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:50:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: imx-ocotp: Improve logic to save many code lines
Date:   Mon, 11 May 2020 15:50:40 +0100
Message-Id: <20200511145042.31223-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
References: <20200511145042.31223-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Several logic improvements to save many code lines:

 - no need to use goto;
 - no need to assign return value;
 - combine different conditions of return value into one line.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 50bea2aadc1b..7a1ebd6fd08b 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -196,7 +196,6 @@ static int imx_ocotp_read(void *context, unsigned int offset,
 		if (*(buf - 1) == IMX_OCOTP_READ_LOCKED_VAL)
 			imx_ocotp_clr_err_if_set(priv);
 	}
-	ret = 0;
 
 read_end:
 	clk_disable_unprepare(priv->clk);
@@ -435,17 +434,13 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	       priv->base + IMX_OCOTP_ADDR_CTRL_SET);
 	ret = imx_ocotp_wait_for_busy(priv,
 				      priv->params->ctrl.bm_rel_shadows);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(priv->dev, "timeout during shadow register reload\n");
-		goto write_end;
-	}
 
 write_end:
 	clk_disable_unprepare(priv->clk);
 	mutex_unlock(&ocotp_mutex);
-	if (ret < 0)
-		return ret;
-	return bytes;
+	return ret < 0 ? ret : bytes;
 }
 
 static struct nvmem_config imx_ocotp_nvmem_config = {
-- 
2.21.0

