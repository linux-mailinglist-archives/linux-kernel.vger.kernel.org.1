Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2F2AC3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgKISXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbgKISWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:53 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:52 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so411843wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=JG0FKV/X2yDwIdPtEatbJ1X6LQYXklus6P8onB6/u0tn7V68yNLntZy1sSn4Wzs2k1
         4/An9IgzQ3F0k5B0fP2oVaO+arqq4X3MOnfd+4DmKaMczl3kWck7y6cNF0eOWi9gShVs
         hNt5ALd0WDJ0Sop62dYKiCz928hWnMqJ3ax5z+6v1IGCNFpNhv4Dqo6n+2jz7cXBDRDV
         0aldMnpz8A4X527dr3varaz5iZ0nWv+z0942SIUPEh2J7cISPwYb7bOiiBA/AaVr2A0z
         IL+U5UKCTR+ySA6BmYJgkUdJ4I2BFaK8X6vX9VTY5lPVWkZdHFyXJecQHkQNjVyf8ppP
         +OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2abslax4xTZx4NcG965UPlBWLqxdXR2VSBh/TqhIys=;
        b=i4uytkg7cl2HoXwtraLv710LVmQKY0jaKhZLFZt4aVwj5vtZArX7FUrsyEo3VehNvM
         GSQCCfCKxCITFz8FuEKGx9Z9ybWfNOwZ8sg6k0zxVSpl2fdww7qmnL1OhBZO3wssF+Sk
         J1kvCqysEpZTLRVvmjgUGhZe7EXaHlV/QuvkYMkoPkGSXu4kFxH+jbd1eQnWLIMZIi1n
         DsZjnb9BdsES58jHpWLLpzMKAOw78cNlT96/FAtl7QqTG+7bHOvNFuQmMYDEBvMiX3BC
         +ZuThwWwGRJY8rpzYLg79qzbGrPhUpCP87E1l5SgrYZ7Of107AjIAbMkSpLcrqsT48SZ
         RByw==
X-Gm-Message-State: AOAM532E/9VdJPud9NFAc/VNpWfXtyPwt4KSIQoWC/HZtMC5nZGXJPSF
        BD0q23/VIZWTTYpSkvIBU1CFcw==
X-Google-Smtp-Source: ABdhPJyzi7fMuTPBZNRbNWcG3+uL3rszDHNeNnPzZvInmK8lsw4JADfODH3gkvoM5Do2k4q7dS28uw==
X-Received: by 2002:a1c:67d5:: with SMTP id b204mr495254wmc.92.1604946171618;
        Mon, 09 Nov 2020 10:22:51 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Choudary Kalluri <punnaia@xilinx.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 21/23] mtd: rawnand: arasan: Document 'anfc_op's 'buf' member
Date:   Mon,  9 Nov 2020 18:22:04 +0000
Message-Id: <20201109182206.3037326-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/arasan-nand-controller.c:133: warning: Function parameter or member 'buf' not described in 'anfc_op'

Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Choudary Kalluri <punnaia@xilinx.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index fbb4ea751be8e..549aac00228eb 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -118,6 +118,7 @@
  * @rdy_timeout_ms: Timeout for waits on Ready/Busy pin
  * @len: Data transfer length
  * @read: Data transfer direction from the controller point of view
+ * @buf: Data buffer
  */
 struct anfc_op {
 	u32 pkt_reg;
-- 
2.25.1

