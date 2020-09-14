Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F502697DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgINVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgINVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:42:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724F3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:42:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so1153628wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv3jV7gXm2zqMYubAXDmuMLaJFvcfVa1TTcvWO4iJog=;
        b=DXcW4c+sYUy6WIxjwulWXeTf6DVn8qTz+NUCU9jkOH+38ihpU6hLLfNGZ9wf89DZ41
         +Rx4f9Rn9LF1fhSZi9a4Rqw3onUVbcqq1+9erxd0F+b7Dvye1+IooWgGK6Y9yd1Z10nS
         c1VNJ8ff43OnFXL7TxvC2Po+vQ6gkpAsJr1mZFokBNqkV5Kz1chjJuV0iaFeZjrwsrfY
         ZPG5zorp0IRMpIlghv4UBYEnrCUEWEEoo7CDpE9W1y59eoFsaTrYvAofbHtyUkQ7nrU7
         +qxi150zKvHIe2hNATtt1HDtV992UK5cCZjQyWaHuZu4EFJdvtyw7xXo7STiHnrnvP99
         qhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv3jV7gXm2zqMYubAXDmuMLaJFvcfVa1TTcvWO4iJog=;
        b=s750Xv5eI2Zws0HsTqHzCHsaQ7sh0zbGrcS7bs1nc0neiS04fEk1q6C5UHedbFqbmA
         M0SLcQDaZzWbw7z49tAX4BsDOQ2C2q7NO0eO5jaK4IlNANmR1Xh3tr4/6q6ABZIklYi3
         W4i8MXo0XdKM7AW7RY9b+MtBh/qpVbHn/zu+rBMmNe5pWqtiO+/WV2sskdvhAhCrexsH
         esx87kOyUc75TZw1Y7FlOlXB7jysb/0bry6QscW3JlfCBjYOyEluA2axOHQ1/Tmzwmp9
         WalCj/1zIuwYPYlTi9cfzWMe6zp1OeoUhUUMSBvrVlHh3pvKJfr7WS7d7jHGGNlTmwCy
         qQ5w==
X-Gm-Message-State: AOAM532BcMlYHLk5e1QoRoQCKnlKMCzw2D+hR1L3kW+V67C8hUnOO3Cs
        PUNnx9mM2owjB1ghy8sfDHA=
X-Google-Smtp-Source: ABdhPJyLeG/7qJcqtKMm981UPoUoJxPqLs/sFip5XZeftkOhvXxRtZAVgnv5+L8j6dsyb0uiVZxm/g==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr18650597wrp.187.1600119771142;
        Mon, 14 Sep 2020 14:42:51 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id h16sm23913899wre.87.2020.09.14.14.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:42:50 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: atmel: Check return values for nand_read_data_op
Date:   Mon, 14 Sep 2020 22:42:44 +0100
Message-Id: <20200914214245.14626-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In atmel_nand_pmecc_read_pg(), nand_read_data_op() is called twice
without the return values being checked for errors. Add these checks.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 309ce410d792..e6ceec8f50dc 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -948,11 +948,17 @@ static int atmel_nand_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
 	if (ret)
 		return ret;
 
-	nand_read_data_op(chip, buf, mtd->writesize, false, false);
-	nand_read_data_op(chip, chip->oob_poi, mtd->oobsize, false, false);
+	ret = nand_read_data_op(chip, buf, mtd->writesize, false, false);
+	if (ret)
+		goto out_disable;
+
+	ret = nand_read_data_op(chip, chip->oob_poi, mtd->oobsize, false, false);
+	if (ret)
+		goto out_disable;
 
 	ret = atmel_nand_pmecc_correct_data(chip, buf, raw);
 
+out_disable:
 	atmel_nand_pmecc_disable(chip, raw);
 
 	return ret;
-- 
2.28.0

