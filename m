Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872962A9F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKFVh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgKFVhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:13 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4620CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:13 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so1961804wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/I+nJpznOBt9dN4XJqBf8TuNQJ12DhAWcPprYkWhwFk=;
        b=JycVzerFxCDO0acY4F3sQuqh9v6MOHcwEibDy7V7bw5+6K9Wh4QNB4dhfoop8pVaYu
         baFmTxcXKO585C6cRr2pKnDcsUZ1liJ9d+YTlDUopHb0a0C5LhiiI9OZ8be4QUpil7j5
         Bh5WEZUeTbxTBz+rZUxaGbLSlqmzkddW+BQc3BsX2tiDQlYHi8aDrEGQGe83NacLI2J/
         +NT/AdhYSgdNHBJQ3rmBRGMYgPWHXnqgojurUK5yE16FjBigO70asoYdnR+LK9s1hvsp
         bYUtZ7ULWnyeS2YhGQq89w75H5ULaYbeGhcLyXQM85AS0LQUe7bWJ9VXeZwbmsHRQuIo
         3ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/I+nJpznOBt9dN4XJqBf8TuNQJ12DhAWcPprYkWhwFk=;
        b=TR4rmpvuwAGX8j5ozw82D2fX68m+W+F2ZGz9ecoBnWoyw1ulW8El9/h5AKdUzWb7jL
         ruJybMqSx9pO8bDQ4C+5RN5dJGOOmAilX5+Y/lslfL7HdPk1tHBF2vHDmag2xgmhOVFt
         iDPuKeDqEWB2dN2v0wNrcNc0Zp2eeJ+RWj3NOzNAOJbd2MN1KK6qEoO3t+KhKQaDHcGT
         Ld+7hiQZxBE8ZRa9WWksEQ3L26XmCd7fA8+Zm7bzKk2pQl9Zl4bkLG8PFCqggOBPOOuR
         gaiJWBhIZoWlJdyErHYfYcJ2akb/yA4yyVzxq95N1kQZf8mAl2IEiLxajBHBH8eAeRxm
         tuiA==
X-Gm-Message-State: AOAM531adoRo8+NFW0ZuRdLwXU6YsUm0XmMFBIbGUVsLDyEgrEqFfcdO
        N9pZ+twY8oTc6nCzn11gGSy64Q==
X-Google-Smtp-Source: ABdhPJxnvbtFoBk4hDhio/jn09EFDKRsg5XQldgSdLNbKekR087/2H/FfLmWXSNvpLb4TVDBHBTwSQ==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr4424905wrv.299.1604698632054;
        Fri, 06 Nov 2020 13:37:12 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 09/23] mtd: nand: spi: toshiba: Demote non-conformant kernel-doc header
Date:   Fri,  6 Nov 2020 21:36:41 +0000
Message-Id: <20201106213655.1838861-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member 'write_cache_variants' not described in 'SPINAND_OP_VARIANTS'
 drivers/mtd/nand/spi/toshiba.c:36: warning: Function parameter or member '0' not described in 'SPINAND_OP_VARIANTS'

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/toshiba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 21fde28756742..7380b1ebaccd5 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -28,7 +28,7 @@ static SPINAND_OP_VARIANTS(update_cache_x4_variants,
 		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
 		SPINAND_PROG_LOAD(false, 0, NULL, 0));
 
-/**
+/*
  * Backward compatibility for 1st generation Serial NAND devices
  * which don't support Quad Program Load operation.
  */
-- 
2.25.1

