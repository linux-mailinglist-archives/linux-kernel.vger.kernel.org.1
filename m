Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AD2AC3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgKISW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbgKISWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so9795026wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=Om0Q1XGn7g9LWqjDEE9rirPV/Bis1yJ4FPfeQFg7UtCOpxgiMsN42PJccIEVLNKGGq
         /OiOIi8mf8V0d6u6wacVBmr6rk5g2qrht3gNJoD3MKVqFB79F9/fKsbJpYSxTdNFWJGQ
         kUDobLHsoXc4F6Gr0MpobjEm+k7omT0DKA6FtHyCdi9pLItiaxItxxfGPmgVdfT4ULp0
         Tl8lfSWJgNOuzIRHdHfOhGqgCv2INPWqC5lifk+NOd2frkusO07YzAPscjRQRJlFkgDf
         bh3UgedxvyGASFljyBptJpwga1D+ARVKK7e7CwmNRO7pzKvCWPziYhG6vY06LABzAlz9
         n7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4FI0nTKy9xJSbbEI5xWFSlWi+PCjFwRWpkkSRoALdw=;
        b=roZ+EDF3Kcdr+C5WnYQeQqBIxVxWbD1JqlviOz9i+wAWLPABb5ZBPT0HGdXP7+rOHh
         jt06SbYZcXu+RoK6Ipq4R5nnaQLEYTGFektXyIDx7E/O5Cv1XY3J73qfLY/crv+v5+/d
         hwcRRiWVGE8OxRc12L7m+I1AwMLagcImMfbxKnomOXH5O07Fg3IUjeZmLkk1f7pAaKpI
         1c1qPh10Scrj9o36+2g5x8cy39iQxbfD642mgoUCB9Amv8FlKqQwMdRMkfZrRPD9pIwB
         9AqbZMQZFXR1Eveeeqdcqzd2XuMa1WajLxhihXjo0xkH/MdM90UTE2xbRBoif7ZJ5I1d
         hdog==
X-Gm-Message-State: AOAM530sd5vaTCW/6VbjqqN6Ws8v7TI0xtlamh/3a73U/SvGTNg+SoHU
        XXrqLj9KVVzXi9X8yCBpcbj0EQ==
X-Google-Smtp-Source: ABdhPJz43p+ov8G0fPIsIRmkRV4I/T93UNCy8svThTZ5Q9U/WL4EIbSOh4qqb1aE0xx7AU2OUIjlwA==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr5624510wrn.39.1604946169621;
        Mon, 09 Nov 2020 10:22:49 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris BREZILLON <b.brezillon.dev@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Dmitriy B <rzk333@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v3 20/23] mtd: rawnand: sunxi: Document 'sunxi_nfc's 'caps' member
Date:   Mon,  9 Nov 2020 18:22:03 +0000
Message-Id: <20201109182206.3037326-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/sunxi_nand.c:250: warning: Function parameter or member 'caps' not described in 'sunxi_nfc'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Boris BREZILLON <b.brezillon.dev@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>
Cc: Dmitriy B <rzk333@gmail.com>
Cc: Sergey Lapin <slapin@ossfans.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 1ec672bbd459d..923a9e236fcf6 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -236,6 +236,7 @@ struct sunxi_nfc_caps {
  *	   controller
  * @complete: a completion object used to wait for NAND controller events
  * @dmac: the DMA channel attached to the NAND controller
+ * @caps: NAND Controller capabilities
  */
 struct sunxi_nfc {
 	struct nand_controller controller;
-- 
2.25.1

