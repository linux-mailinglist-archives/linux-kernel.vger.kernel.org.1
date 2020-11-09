Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B9B2AC3A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgKISWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKISW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:27 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE279C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so390062wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HSXbLD6nqQi0zyF0AV9ugs6EBiM6o8rIQYPcXPYEB0=;
        b=FLj/b9i2Zy4p8huivBf9LP0kU7ppNFuEM3LX1lt9lGu787iQs513Vfmapi1LhRjrau
         BLdR1O6bGDu0xSXvJ1MqeuoOu6nQrfwmTDEx6wRcnQfQWwUZwMG9YDwT55gX6eWY2NWc
         mLCIMEWWhP6TVGA0R/D6vl5awrmI00Ln1ttaJMzTLuNE7bR3tRULSOgp4VWjUjUZmYTT
         a98XhH2Ga0H2kZ2hmn+1fKcPqkefoqt0Hukhr0VR9XGr/FnpSnPDLwu3dm07NiibN/0L
         Qc3ImYpeYWKYaRMTunXbDK9wH98FmruKYpu6V96IPuyldrcR/Ltg78qn88ci75am3Rvo
         vStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HSXbLD6nqQi0zyF0AV9ugs6EBiM6o8rIQYPcXPYEB0=;
        b=IAEDzjySlKhOq7/gHnnkJOdlxYxGvpgbxJVY7lKxx89WTtVvaHBHx8wr7deh7w8Bf+
         ZTn8IjVI0H5dO1O38l86QwxO8B6OcJiDH5SMNG6jdutM1K0doNZ/apK1r6NV3/h9Kn9q
         p6DX1huZmOEb9FyJTzftRo3i4BO8/K9KN/pt0ytZwt7cr0WxJt03uFAGcpZrzA2w9fvk
         OuRd7yc1vM5Y5anEz9nUKM0qYttyHi+CM+ZUovt/2XQOG3d88v2XVIJSug8Jrut9Dq0n
         fQli9dI8gcIVc3MyseEBcPcjHG99X3kmnvMFQsIikXyrveHCun53hRPxrkHtE31N5jHG
         /cUw==
X-Gm-Message-State: AOAM532XV5/J34leqn2FJhAgOKTWmqhCOw6ajCn6MojTdG1oy077kgdB
        jsstCEf1i0u+t9yd7JKVugBXSQ==
X-Google-Smtp-Source: ABdhPJyQ+mLrmjWtuwxQkAH6J9GltDMW0ka+19/wYcoOD4FYTq/zqrEMTKL5AhYYd0+sVSQTNTSX1A==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr491052wmb.80.1604946145584;
        Mon, 09 Nov 2020 10:22:25 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, Alexander Dahl <ada@thorsis.com>
Subject: [PATCH v3 05/23] mtd: Fix misspelled function parameter 'section'
Date:   Mon,  9 Nov 2020 18:21:48 +0000
Message-Id: <20201109182206.3037326-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/mtdcore.c:1592: warning: Function parameter or member 'section' not described in 'mtd_ooblayout_find_eccregion'
 drivers/mtd/mtdcore.c:1592: warning: Excess function parameter 'sectionp' description in 'mtd_ooblayout_find_eccregion'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e9e163ae9d863..31d1be4b22617 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1578,7 +1578,7 @@ static int mtd_ooblayout_find_region(struct mtd_info *mtd, int byte,
  *				  ECC byte
  * @mtd: mtd info structure
  * @eccbyte: the byte we are searching for
- * @sectionp: pointer where the section id will be stored
+ * @section: pointer where the section id will be stored
  * @oobregion: OOB region information
  *
  * Works like mtd_ooblayout_find_region() except it searches for a specific ECC
-- 
2.25.1

