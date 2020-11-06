Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E744E2A9F33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgKFVhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgKFVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:31 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:30 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so2634411wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ynyF2LluxBEO2JLmlcMvxixiCa/MBQSn7HUEDQ95Ad8=;
        b=sJW30ndVh1qGXkUaw3pZaZEjF2ef9gfmBHcrLUN8CKyAoBZToeJQQGOgveJ9pOnH9G
         iLnj25fAUb5CHE4pzNXFTP4bhMNeVU9zyQDF1cWEHGd11k8kQJFQMEHxT3Dl1zjar9i1
         fLeGKBfoVm5SSIuvPhaI1FnA013nnfZJ8yjEL9YynAZGNTKmaaPzx1Z8entolXVdwDXF
         CpfAG963D1ALbbrNpXiYanN/0p8rW8kbDmkOIfYRs2zp7QT0lXC2BhMYgEqAXpdrHyfE
         U/pK0fH1kVdmS6ynQhtxJ6E8bO3EBpBdOD+PU9rYMIdej1Dw7doRpC+V18xrgEa4Q7rq
         2Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ynyF2LluxBEO2JLmlcMvxixiCa/MBQSn7HUEDQ95Ad8=;
        b=We/WFKkBIz89tsfD1AO07vgrCJeueT5KGwUTY8v4YNCJRmzcfZKmdk4Po1/1jEerDI
         K5gEw2fPt25ODzDeQiW3uMHlDhla93pvk3l7dcz52RsHVEQfpVxfBEf5pbhlIFboyOee
         IOIqSLvHQHDActRwlappaxMnAEBcLPQiLbCqDBLJSTOss562c1bhJQdgOgxqMjrVEx/3
         BRrJ+7SoxbZU8qGzBjVW+ITVLnBbSAoRqfIFEKAN2r8k6vN4jeNbfzosg6fNRQ7X0jhI
         advXviy4dHRHBbqx/qED1tNZbatEYPgkwo0hTLS6W2efP+j/MeJd+Xbi/gghbDtcRSaC
         m6iA==
X-Gm-Message-State: AOAM53196S2WcGV/AdxgAcdNlNoISDtAem8PkcRN8SUIHaSIZXMeNsWE
        n/1o9nPFfh0B5B1Cz0A+2m4kFw==
X-Google-Smtp-Source: ABdhPJxG+LiIYfVShEQWJVAJMZtLl+cVPcfShbpulxjLFaLqCc0rq0BMZWwZRXF2wVzCbzIu7Bfcjg==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr1574214wma.14.1604698649574;
        Fri, 06 Nov 2020 13:37:29 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:28 -0800 (PST)
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
Subject: [PATCH v2 23/23] mtd: devices: powernv_flash: Add function names to headers and fix 'dev'
Date:   Fri,  6 Nov 2020 21:36:55 +0000
Message-Id: <20201106213655.1838861-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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

