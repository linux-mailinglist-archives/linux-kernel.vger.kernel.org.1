Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7A2AC3A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgKISWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgKISWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:37 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:36 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so397485wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=pISmdvdSsAGV1QIK8I4/nXbvzV4BpyRg4zyUJt09AIUwDnQOACl7kVRWIlyZmqQFmu
         h8mZCjA7ExEBqY7UPobPGH36uZeALUfjlSpsODuSdTwFYMaHv5sYNEOJTALE1KEutu+C
         RgDy4EZwHHKM+WM3pVjJOo4C9KfPKSll+pNQfBMJy2sz3DSOjb8zpvjYBt2ntpWUWyVL
         aP28CxDBuNZ2Z4vI1+SivZCt0x7e5sXUTDaoGqw+OlhpZygKYwKxsQjw2348oRFE0DWy
         KO2TPj52VpVqlNk5H8ho0v0+f1qb2m/Leb1RXjg+uMmaNMiF9wqWvSzbQIq+phKexoxY
         ty8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWKR6uPZUpsHw9fLiQN+tCUhIOQtuUG869jNO4i86ZY=;
        b=Bh2viHej1NLdeFfYXNMX2RLaViWd6/20+NV7Odi7I8jUqzok+t4nHR4KTmW632RO9F
         cV9WAhw7yFBUEwqc8UbP3KbbaChRu/ZNXLe0r6/WFrEH4Yy1lY709QjLBgnvlQd0PYap
         wkbk55YlPS/MRQxp4wqZ/cFFLPjUwDON2u8k9Sd/3jke1lzI4UvEzhzy8SnrMkkRuvHb
         OuKJmMSsOlfAuKiG2Vl9ryYdmJhUONdRrnYni6oTygjt8G55gl32EHur+oiqGdlInhyZ
         XZAnDVEAjHzZjeTDrq/f+R0eO/Uulz/ZnxiYOm8YlVkefu6sj2SdI7YbnqQGDohFoQ+S
         aIVw==
X-Gm-Message-State: AOAM531amYuZG7op+TjPtA5StP1WxaNWa4asB+Z0tHXqKNyRCald0tjb
        qmxqEZcT2DBnZJiyG1wAhSLKXQ==
X-Google-Smtp-Source: ABdhPJzVFDmrznnhXXVDaVtytN/m1ApIQJ9IObX0ZNMZx+35FLITCYT7SzrOgTW0NRH8EaemRS2Omg==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr433586wmb.181.1604946155646;
        Mon, 09 Nov 2020 10:22:35 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 11/23] mtd: ubi: eba: Fix a couple of misdocumentation issues
Date:   Mon,  9 Nov 2020 18:21:54 +0000
Message-Id: <20201109182206.3037326-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/ubi/eba.c:1304: warning: Function parameter or member 'vidb' not described in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1304: warning: Excess function parameter 'vid_hdr' description in 'ubi_eba_copy_leb'
 drivers/mtd/ubi/eba.c:1483: warning: Function parameter or member 'ai' not described in 'print_rsvd_warning'

Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/ubi/eba.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 0edecfdbd01f3..892494c8cb7c7 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1290,7 +1290,7 @@ static int is_error_sane(int err)
  * @ubi: UBI device description object
  * @from: physical eraseblock number from where to copy
  * @to: physical eraseblock number where to copy
- * @vid_hdr: VID header of the @from physical eraseblock
+ * @vidb: data structure from where the VID header is derived
  *
  * This function copies logical eraseblock from physical eraseblock @from to
  * physical eraseblock @to. The @vid_hdr buffer may be changed by this
@@ -1463,6 +1463,7 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 /**
  * print_rsvd_warning - warn about not having enough reserved PEBs.
  * @ubi: UBI device description object
+ * @ai: UBI attach info object
  *
  * This is a helper function for 'ubi_eba_init()' which is called when UBI
  * cannot reserve enough PEBs for bad block handling. This function makes a
-- 
2.25.1

