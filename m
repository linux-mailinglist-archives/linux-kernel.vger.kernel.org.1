Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0F2A9F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgKFVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgKFVhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:21 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33FFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so2771573wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zU6AEe7QJ86BUUdNT9vgeNl78+UInfUWOmxhJubmBR0=;
        b=YuusY46lidvYZNZcyIlP029LugBzFM5/o75ceo7IvkH//GmrbJTHOAsMyoRKekOXtQ
         TMitq0JQgNzh3BTtq1WMw7iHMlVscy6Pm0oe+l3nNt7n3n58MDHtM1EgF5zfaxwvzpej
         TrplfRFEutXmar5oP3bwEM/W2dm2yvMrpuTx2ZmGIUVIQ1qysS9V7ChRifCaiMV2VLli
         Z6eIumohXtw/X03cudUHrEE4fE8PNkpyvpHPyHsyDCwlxgc1xtzbCYB6P2eQTjFfiaDI
         PkJJ9KI6WIdnWirDj9iQCXiQ8OV6wQLGf1xhikpyTW4Lge5bH3lIbJzAe3MfnGOBtvBX
         gCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zU6AEe7QJ86BUUdNT9vgeNl78+UInfUWOmxhJubmBR0=;
        b=pDAtOImdmyMB8An+WQ8PAaWT6qdvBpF04gH6M7+YxPTWMyBTwcPQ/hiwUaBXDWxBl5
         rAHTJKxb4JvaEI1CMCBHIX5t3vmZodikD3fA2kHGVxzzqB/AVkluTdeP4WSoEkeIqr7d
         TsODhwMdDmRyscc+4jXKE7Wu+/+g+GycYHQphY0swqLHab4WeCmRGrE28t68sGeBKt2v
         BBPb9rUruS/UNvQUwHwHfMGMk9QDEKWQ9cgEQ5qykBdrr+BwzFLxo0XUOjLA14uFQs05
         fEgqb+Dtk8Nlo5PnlGYTN0hkVArj9xE6TRbqGCf4R5iD8b6qZioUa4SPYkz7d64uEW58
         i/6g==
X-Gm-Message-State: AOAM532G+b+5EY7xKnF/x1emLN3ho9/Wz64vta4o795AjnJZp+gCPiHj
        cgKyiX5YYxrDP5bXCT1dCJGh7g==
X-Google-Smtp-Source: ABdhPJy0Ln9YOb1EajhIy7Mo7bt888ijqJbJAEpFYJf3GJYPpvuee8zVbgMhCF7sJ2CcQerM5hcZHQ==
X-Received: by 2002:adf:fd06:: with SMTP id e6mr4794908wrr.206.1604698639476;
        Fri, 06 Nov 2020 13:37:19 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 15/23] mtd: nand: raw: diskonchip: Marking unused variables as __always_unused
Date:   Fri,  6 Nov 2020 21:36:47 +0000
Message-Id: <20201106213655.1838861-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dummy' is never checked (as per the nomenclature) and the use of
'emtpymatch' is currently #if 0'ed out.  We could also #if 0 the
declaration, but #ifery is pretty ugly, so I like to keep it to a
minimum.

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/diskonchip.c: In function ‘DoC_Delay’:
 drivers/mtd/nand/raw/diskonchip.c:219:16: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
 drivers/mtd/nand/raw/diskonchip.c: In function ‘doc200x_calculate_ecc’:
 drivers/mtd/nand/raw/diskonchip.c:706:6: warning: variable ‘emptymatch’ set but not used [-Wunused-but-set-variable]

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dan Brown <dan_brown@ieee.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/diskonchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 94432a453e5ee..d5050e32cc421 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -216,7 +216,7 @@ static int doc_ecc_decode(struct rs_control *rs, uint8_t *data, uint8_t *ecc)
 
 static void DoC_Delay(struct doc_priv *doc, unsigned short cycles)
 {
-	volatile char dummy;
+	volatile char __always_unused dummy;
 	int i;
 
 	for (i = 0; i < cycles; i++) {
@@ -703,7 +703,7 @@ static int doc200x_calculate_ecc(struct nand_chip *this, const u_char *dat,
 	struct doc_priv *doc = nand_get_controller_data(this);
 	void __iomem *docptr = doc->virtadr;
 	int i;
-	int emptymatch = 1;
+	int __always_unused emptymatch = 1;
 
 	/* flush the pipeline */
 	if (DoC_is_2000(doc)) {
-- 
2.25.1

