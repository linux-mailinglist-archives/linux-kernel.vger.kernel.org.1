Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2362AC3A7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbgKISWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgKISWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:22:43 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB97C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:22:43 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id j7so2558317wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zU6AEe7QJ86BUUdNT9vgeNl78+UInfUWOmxhJubmBR0=;
        b=eespszn+YzerPW89j0B6QI6zk+RxJ1PHs9P1SEM5hZerhh3ZzcZTRQ7GHYMYUf+Dga
         ++A4cusms1L/Pe1u5fJ/lrRe8YuhE0YY4giowbFwEgp7orkXRh/ShfipGTynSUZfJG6n
         39I7QLU/e3j/1irF9M3iDMWnl/RkEj1RCEy3SK0goOba5IQrXJWY6/lDuy2s6qVpbGcD
         4JTixvz6bWmsoKNFGRlTSQOfZPXUMjf7969pxHbsAuzxn1/emvmh3hcYmCMpR9/GwKmE
         /1L09ZZE7s99hP1qDvCXoyVha6cwY597da0n090H+kuJ4XNbD/lqED4riT3Nev2R1ZIB
         zvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zU6AEe7QJ86BUUdNT9vgeNl78+UInfUWOmxhJubmBR0=;
        b=s/Jt0mPKJY57ICms6Cmz03yGiLWlI56lVV/tm06Mvm35ENhrOqBPd7A3pLi/y29Z/R
         /wz77YH0g9T7Kk8TKP9AHTTiclDBCa6/wikfzvtGrAG0YdC7Sx9UDRvJDX1dkjRsTzjQ
         yBYzqwNaGH/6gd8n1uMt6Fekv+z/ePA1uacG+4WtgGSdz8Hvv9Qwe8iJ8oIihfnQzkHV
         yOTG4+vBd4ZkjffDakcmmnkAr6Gn9M6SzJSqLUjaWZH+v2DfLGXlj64kb5ZpfOdurdTT
         QoQyMEYZiLjrpxSCkZixf9WkilMoslVLYSe/PptuYxChlMKn6aZIdXHOE3l3VMbeCWdw
         DkbQ==
X-Gm-Message-State: AOAM53130B+j/n0zQjDMP/hOKWv8ukLjD8iAAWpmEUh8e4n+Hph7DJBm
        aR2OG7s5zPGK+8q2mMVyAhhQbw==
X-Google-Smtp-Source: ABdhPJwh4ngGh6y8Wlc6J5atpBxTT52cWGhiUWgeYB5bTlJSHS3m0gEHxir0U09GRfBwvJAcMdrCRA==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr20167333wrr.64.1604946161879;
        Mon, 09 Nov 2020 10:22:41 -0800 (PST)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id g186sm735365wma.1.2020.11.09.10.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:22:41 -0800 (PST)
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
Subject: [PATCH v3 15/23] mtd: rawnand: diskonchip: Marking unused variables as __always_unused
Date:   Mon,  9 Nov 2020 18:21:58 +0000
Message-Id: <20201109182206.3037326-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109182206.3037326-1-lee.jones@linaro.org>
References: <20201109182206.3037326-1-lee.jones@linaro.org>
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

