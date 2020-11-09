Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A212AC3AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgKISXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbgKISW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:58 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:56 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so9795318wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ynyF2LluxBEO2JLmlcMvxixiCa/MBQSn7HUEDQ95Ad8=;
        b=CJgWPOdfZfDFX6jowwB55bCXH/oVH+oRW/NOmFaMU7wqCfffw9BI6AX0cZLLRnoQ83
         f1Q3pJnStHDKmia5wsQ1jG/5yLT5iyXJHSbfVxF2652p73ZossGiaeADkwfMVV3VPzKl
         y3WUZ3gkpVEtts++2sjN4KN/Ate1Zx1Llx1URhWTAmp8q9vb5It/GiVpx1x00v8thRr+
         Jg0NrctCAawSlL0MlhXVbqG4J9tngKUVGjMD35l1hjxw7aj066anrVGw76eLOV6PPGpJ
         +3NJvWcQwSa1y2r2ZhJVX092wzbs8xv/E5ZSMs+rZSbQxaMrOoi1cDjRQZHpsP5bhVsw
         Wctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynyF2LluxBEO2JLmlcMvxixiCa/MBQSn7HUEDQ95Ad8=;
        b=uXfrPtgfHWQ94uSUEQ4Jb737dUm3HzzosDdyzltkv1TarFl70hZKTqFTUVP1/cAtVa
         unGkoIykLiEYqBOgaUIu803f0adHufNBYw5xNSbWWSQ7IicCE4Fd1VEjcjzHwOXYfC2d
         e/Yun8ZjoipqVWMVf2SMZOw37AIXD6tfm5zaPtrH5ihzNwk/nuPIrSpvtoasbUZlm0xr
         EHo53oikgsXizgbSO51wHhERRYtFJs9IJO8gPzpvgBz71STwzkRQkUhr83QTb7sF5/uv
         xR/7JBMz3T8GTz3iH9BAajJIvkZa1c/V4NIDFRFrkmx7LM6CFWzGKIJScyy+1SQ1dlX5
         zWXw==
X-Gm-Message-State: AOAM531Oxlso2+DBu3jlXQ9ZsBZQ2fdNjiZm6wO6WP4MzAH0RfiNGj7P
        TPd12Hy512EbfLaMs3wNnNebig==
X-Google-Smtp-Source: ABdhPJzYJ6GXTplhTN/922OmWLnE6Yxzwd1FCSkYbQl6bOCvGF6TFsl11Dt619RBL63ntiSfCz1t1g==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr2948571wrp.339.1604946175640;
        Mon, 09 Nov 2020 10:22:55 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 23/23] mtd: devices: powernv_flash: Add function names to headers and fix 'dev'
Date:   Mon,  9 Nov 2020 18:22:06 +0000
Message-Id: <20201109182206.3037326-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
 drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-mtd@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/powernv_flash.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 0b757d9ba2f6b..6950a87648151 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -126,6 +126,7 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
 }
 
 /**
+ * powernv_flash_read
  * @mtd: the device
  * @from: the offset to read from
  * @len: the number of bytes to read
@@ -142,6 +143,7 @@ static int powernv_flash_read(struct mtd_info *mtd, loff_t from, size_t len,
 }
 
 /**
+ * powernv_flash_write
  * @mtd: the device
  * @to: the offset to write to
  * @len: the number of bytes to write
@@ -158,6 +160,7 @@ static int powernv_flash_write(struct mtd_info *mtd, loff_t to, size_t len,
 }
 
 /**
+ * powernv_flash_erase
  * @mtd: the device
  * @erase: the erase info
  * Returns 0 if erase successful or -ERRNO if an error occurred
@@ -176,7 +179,7 @@ static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
 
 /**
  * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
- * structure @pdev: The platform device
+ * @dev: The device structure
  * @mtd: The structure to fill
  */
 static int powernv_flash_set_driver_info(struct device *dev,
-- 
2.25.1

