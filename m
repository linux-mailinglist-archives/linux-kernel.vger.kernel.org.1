Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0612A2A16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgKBLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgKBLye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA793C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i16so8834901wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGKp9BcrRvWbGFJ8nJFrwV99IT3tH0nAgbqx1me4UIc=;
        b=Ps+goPOuM+t0f/WlfFZJVo78ITTY00f5bitMKqOsoWammNIcgHwveDbWPtJrWxn3CA
         /C1xHAxMEnQNkGB0blsWANw8bvBY1hzTMg1o0li6opngvZP7JgNhbBcCJo7ZPPM9K/SR
         AL1uFPtXD7bNCl2f6vSoA79GiV8d+OiAlL1MIg3wA51gWFV9zJsO6ZlJOnOyVJwf6fzr
         k7oYoPxGyQs7Xyd5iT9XHCbPspf/uJ40ir9lKEve74yHqx/HTc6rfSa/VB0Nf4VE4kDk
         6F8QQmKRT3tWThuOYOxlfh2PxNDagAQHy9n7SUUMbvcrRllTOLSGnV6Z58/L+FXQcufc
         R1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGKp9BcrRvWbGFJ8nJFrwV99IT3tH0nAgbqx1me4UIc=;
        b=KWh7CQphBFDFXn+tlb9HhrhoQQeLN3FNgN52EV/EMdUk4KWqeR1zeCzM54jRB5VTch
         3llhly6simXl1P3CEdeTOfAqpD2ygtK7gez4VO+jeXV+ZgePpAN7SyumvJds79CMuHWa
         skFQBLHfi13/1K9++b6wtuX2AVK1s8/EudIMclrI8z7wGl32tG4mBxvl2eQxKhtVAZBL
         etNpYPH79YB1UkFV+L+mURopVrQ1EWRgZrcoBEkne+BoN1tkrKLsGEIit6TvDOxfAMgF
         Q56qligivqWXN1hlB+iysrXlf3S40wLUNIrBPram2+9dSg6Zm5RPwHqZN6ybmTQmq65d
         JXhA==
X-Gm-Message-State: AOAM53309sMLF3NOA20m7ONeEv/S7NS+duhmJe1M+POSj/Bf4XPVZ2GJ
        Zp2VhgetfopTTdpqgIjBkELXKg==
X-Google-Smtp-Source: ABdhPJx8dr9zZZzDtiWfkhNT+ZvBeH8jDPzmE9Oh4H52mODH7lx/pWbnvgHt1iT5t9BMiZpIL92TvA==
X-Received: by 2002:adf:f286:: with SMTP id k6mr19922306wro.34.1604318072455;
        Mon, 02 Nov 2020 03:54:32 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        Kalev Lember <kalev@smartlink.ee>,
        David Woodhouse <dwmw2@infradead.org>,
        Fabrice Bellard <fabrice.bellard@netgem.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 15/23] mtd: nand: raw: diskonchip: Marking unused variables as __always_unused
Date:   Mon,  2 Nov 2020 11:53:58 +0000
Message-Id: <20201102115406.1074327-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
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
Cc: Kalev Lember <kalev@smartlink.ee>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Fabrice Bellard <fabrice.bellard@netgem.com>
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

