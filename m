Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332C12A2A14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgKBLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgKBLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:37 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B4C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:37 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k18so9213003wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=bxEoYhnoXdbhVx3LfdVJMLEWx3cLOp3NjMInQHLPIjLoF47lqXOvfj+QiE6wvRY5G+
         asWwji1UeXYUvhs0Pgir9GeNfo+oV/PsOAjY0NHhgJ7KOIAuMGVBmOtIHLKWpfHXlW8c
         fNWs054/fbJxwFxwI7hTsMD5m3Rbv4tYbcVk2BFe7iOWJM0GWO4YFteB3SOfPU8yP4jX
         PKLpMA+hShVRMY6kK2MyKcxOLUp1k0cHvCZzCvY9A0LcH4bgJkXqNmHa8T3lMdhZv1R0
         qDrdKumdDE5NsPYxl5OrRj+wuqJCL+lIk9csVfX3TlMnMDh4t5B4qP+Qa4ZSM2Q5qW8W
         1W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc+oP6vugsB/NFox5ee2E+FED0ZhjBIzS6GFVD2ExkM=;
        b=CNqSdlo1iMJRAsLeHgDMDPvCTjW9sR09joIlaB2XEZfhWB7Lx3bYG42KQdqeUi8SNO
         a+bGOgEIbOy/A0qkCkGkkFLsYzfIJMQ9Ly9IRrspxoW34+seyJcjiFbZJIqz3b7Cg2oX
         iDElG/LAhJL41xE5euluc678Os8ZFNvbqDKiUqnGZqbjjQOpg1PpdwDP6Qii7gncCDU/
         vtuKNaELM8TuOWZO+4vIqpZWDqc1C/h0A88Kz/foaBmxeU1ZNwzPLEtUNrqOwmg/SPr/
         jLhtPy1hv1KwqsB4i/JMNK/dsOkM14vth46/IekxTgDY97rkWYPqD3jt7ELD+kQ7lAHE
         8hHg==
X-Gm-Message-State: AOAM530o6a8XponRorCECWOuDh8SAwrVzq8TYY4UXG51RRg6SP6tFU2x
        wwiLUKuUhVTb1GRMpx1t+9cTRQ==
X-Google-Smtp-Source: ABdhPJxatNBxfZS7tSdF9u2DkhAP+wkqDutYNve8P7+3Eb/BXQMSvYjDydq8lRDjjsEbAWqF4/ioBQ==
X-Received: by 2002:a1c:205:: with SMTP id 5mr11364455wmc.7.1604318076024;
        Mon, 02 Nov 2020 03:54:36 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 18/23] mtd: nand: raw: omap_elm: Finish half populated function header, demote empty ones
Date:   Mon,  2 Nov 2020 11:54:01 +0000
Message-Id: <20201102115406.1074327-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
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

