Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFE2AC3B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgKISWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbgKISWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:20 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA313C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:19 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so5399149wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=MLmdlcfBaJHqzeKtW05Qu2AgvRk3QbkPgKqYxdcQn/1A/jiffq7BuMemkFyCQCjI4n
         dh15uXBZl3q6EMSToflbkjhECcXRr8rkVjJZCSfow88lt6hKWFTXApRMRg3rsHcees2I
         A/TM7IsyzUHeTYlz0v/XqmYnRCuIJhjhqvR9GZewB3NVY6MQovF2y6f+SZb+vIYUKb4z
         xNsscJVEDrpBbfj15bdAK0oJD5y8YmPjZLCL6flOu/kzJlOHY3VebswJbKxKdV6yfgEX
         rnct8wFTkeNme6OuqwlX41/U+ZNk4vbTPxg7dDLUtrTJQFvsbN63J7+slDFP9UoSGxkN
         25vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k1rgmOCefV5rf9QkuupaTuT0YgnMPjbaR9fAX+QknE=;
        b=qA83ehdGKzcY063tKwQNVClG6rsE1p/BXFLM37fUYmJTAnHtwyvR3w/MmLYsuYlcUX
         N6QDrjZPQpRVawjp4AC1VfzD7zCCmCYoDBvUL/Pb7qr/8Cnwura/eoyw77f4FhUFSQrp
         Kabh7dsJFHI+qaTChAcjOPuovgLNCxuF24qleCGRPonzMSjntZvgHQPFuvsib0ziJTC9
         pK3dmSZGa5y0NGzgJmomFTZtIG5hCN1qE8wu2Szf/UczQD0LdpPwWR53cjaUvT6UsUlY
         RWw7NJli6XZi6tq9gzoarCt+dA59BSr2dWLAjMIVpmqA6UOsH7Ey8R7h5WiubrYi8+4x
         halw==
X-Gm-Message-State: AOAM531xta4ebV9GFvkKFCk6XYYZbNXAx1u94w4F/yFSlnAgee5YkYaw
        lGyGwsyFwqx9VuE+02rM8y3eBA==
X-Google-Smtp-Source: ABdhPJy+Jhlqvl0oYRlSi+FKgD+3S1rNcl9yehdbWZvPZWzmw4dopz2nHcAkmSAcjCJFmZXKUAewPw==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr7528845wrt.66.1604946138536;
        Mon, 09 Nov 2020 10:22:18 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Gleixner <gleixner@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 01/23] mtd: mtdpart: Fix misdocumented function parameter 'mtd'
Date:   Mon,  9 Nov 2020 18:21:44 +0000
Message-Id: <20201109182206.3037326-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/mtdpart.c:300: warning: Function parameter or member 'mtd' not described in '__mtd_del_partition'
 drivers/mtd/mtdpart.c:300: warning: Excess function parameter 'priv' description in '__mtd_del_partition'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Thomas Gleixner <gleixner@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index c3575b686f796..12ca4f19cb14a 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -292,7 +292,7 @@ EXPORT_SYMBOL_GPL(mtd_add_partition);
 /**
  * __mtd_del_partition - delete MTD partition
  *
- * @priv: MTD structure to be deleted
+ * @mtd: MTD structure to be deleted
  *
  * This function must be called with the partitions mutex locked.
  */
-- 
2.25.1

