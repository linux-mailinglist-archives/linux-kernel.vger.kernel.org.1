Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811DE2AC3A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgKISW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbgKISWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4995C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:47 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so394523wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=TaApzXVB+tjWY3O4ygHBddamqEspK3W5/FCL3tALWaidy20HXcEGe/exoLio7ssBf5
         DQP2B1k+qr2JChEFw/ixG2OK3MnjcZS6+23BWHVJ18cyf44vwHJJMs8AT6MkfHtOmNP7
         QO43bdNHlqmp0/cBHz+D5TtlWJQtRbRXnq/1uYHXebIMkgqEroEoUukkKz90r90P25BF
         OdOBfI/PVdWsfHd4wcjwi1H85tRiGY1pQoMF8z8G2fG9lAOoWbppPZJj+tS1/ihgYdXr
         jgZBbqNIXljmWAios30Ay7Z8g5Zn/J7hviWe8OT97sawUBMywVISBq+umUkvHHwzCOVh
         A9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=n5IW7VRT+uP2J8ufRac1nBvEvguS33LGRBhlkyKx1B1+K6vB7ibzs03fxa8BWYWnF/
         hatffWswgSnQCW2+0rVcUb+NJ27Mcate8LlXfXh/y8ZMdYeQCbezgaGAidLfJdidqQCJ
         Mk5QdCAcEgU2GXPAJUXm2yKWJIAFuTdRyfq9JO61RCETFLzEtv8F2DbAaf+skKxTl/JN
         2b3kGKHRGQjx7t3skrvtn/c6dbzxXXf6AHL8rM2zmSPlfRKHWvuSC64PVA+Xk4bweZtV
         PxadK8VV2N73/L2zdlYCHFlgv82IsMEdlfQG6XznG/3xES4iuGCFb7kBwGPA6knW2Wu9
         5NsQ==
X-Gm-Message-State: AOAM531vZsjPEIWqFMfONgCkDb5sOhD3RZ487Uf9kDacMkn2AkVDKiDV
        iXfz4TScHrQLO6hRvHArqoS33A==
X-Google-Smtp-Source: ABdhPJxSRRGwBeX/TCcBX23yoBR7/m9pAcOOBQ3TTFvjG732s1aPClv25Re189MM3cNFPQrfHpWL5w==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr497070wmc.118.1604946166577;
        Mon, 09 Nov 2020 10:22:46 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 18/23] mtd: rawnand: omap_elm: Finish half populated function header, demote empty ones
Date:   Mon,  9 Nov 2020 18:22:01 +0000
Message-Id: <20201109182206.3037326-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_steps' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_step_size' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:102: warning: Function parameter or member 'ecc_syndrome_size' not described in 'elm_config'
 drivers/mtd/nand/raw/omap_elm.c:440: warning: Function parameter or member 'info' not described in 'elm_context_save'
 drivers/mtd/nand/raw/omap_elm.c:488: warning: Function parameter or member 'info' not described in 'elm_context_restore'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/omap_elm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 4b799521a427a..550695a4c1ab0 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -96,6 +96,9 @@ static u32 elm_read_reg(struct elm_info *info, int offset)
  * elm_config - Configure ELM module
  * @dev:	ELM device
  * @bch_type:	Type of BCH ecc
+ * @ecc_steps:	ECC steps to assign to config
+ * @ecc_step_size:	ECC step size to assign to config
+ * @ecc_syndrome_size:	ECC syndrome size to assign to config
  */
 int elm_config(struct device *dev, enum bch_ecc bch_type,
 	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)
@@ -432,7 +435,7 @@ static int elm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-/**
+/*
  * elm_context_save
  * saves ELM configurations to preserve them across Hardware powered-down
  */
@@ -480,7 +483,7 @@ static int elm_context_save(struct elm_info *info)
 	return 0;
 }
 
-/**
+/*
  * elm_context_restore
  * writes configurations saved duing power-down back into ELM registers
  */
-- 
2.25.1

