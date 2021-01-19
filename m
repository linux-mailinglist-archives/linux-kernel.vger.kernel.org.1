Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA26B2FC232
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbhASVXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbhASVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:22:14 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89875C061575;
        Tue, 19 Jan 2021 13:21:34 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q2so41026221iow.13;
        Tue, 19 Jan 2021 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lugoyWzUMgBNPKbfRWrzKBcF96tFzVzbKcvJz2SoEvE=;
        b=VN/NzfJRc7gUTIm7mQE8drysciOkARbiJTJPjlEORpTnbUo6ob4GD2dgWe8T3y8iB2
         VZqZQqxC0sMgT0hZ0Ns2AV7s+3dCJXMFyYml4Y7Nx9MScfFl8exsz8gubj1ETJpdHP/t
         GhjGAzMcR3IFK2SpVu2C73vC5xAwZOfRS5dPvTwFSTd0j6IsQ+h1Rnn1uF6apthYkwOw
         A2ENOTF18F6UYnB4Q1gPEsoKrzxLGQjjz4pl3csxEwn3deA56Sb5GqDP/tAgBB+CS33/
         MD/Z++f4sl8gShm4PzKXX7ZPpbmkTg3F6pQUuDJZur5QTADHoStuvLEvl4a5YlqO8O6J
         mR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lugoyWzUMgBNPKbfRWrzKBcF96tFzVzbKcvJz2SoEvE=;
        b=axQLOqEK8UxKWVf7x+RwDYpkhn34wFGb9CfT4jP6q2i+mfpDXsS/SMNLhUCIZcw++O
         UHuq/J54bQFb9DxG8QkSSk3tAsv8IZWWjThu7NLuILxzn1FkmKKqVaCkZVu+sLFmHGsp
         HYYn1n4oR+yfBDFRwvn91BHB6Y80rxEo0PwAahYvODxmtclvkYTMoykTYo1qhLX2uaRW
         8fV2NmOEECfpeevLWs6y9PSZ1BDDBKpMniebeF7BxCWdaGqQYlkTiIr+mbNLICF8iIf8
         Cl3/lyiCXyx9+m2v8BgUjjLesXVrhSGYM76+VeyxP5rt03Z5iejkwwr+oWWNudR+HBFt
         fJag==
X-Gm-Message-State: AOAM533Q/qce1q2qWgs52KWldmMIkeGnA03QgYUXKL5zHzYpbku8h7bO
        gDXm+26BFJ/yf09wdnyE65ewNUCPfla/dXWX
X-Google-Smtp-Source: ABdhPJyAmHX8k+g5802hwkSVrAwlqdNgR6HgZQj1kwrrf4OEHYzW7qOoK0yTsjBJSNMagadyzG9A9Q==
X-Received: by 2002:a92:77c9:: with SMTP id s192mr5088565ilc.75.1611091293569;
        Tue, 19 Jan 2021 13:21:33 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2386:3a11:421c:65a9])
        by smtp.gmail.com with ESMTPSA id z87sm61418ilk.40.2021.01.19.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:21:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] clk: vc5: Add support for optional load capacitance
Date:   Tue, 19 Jan 2021 15:21:09 -0600
Message-Id: <20210119212109.1064786-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119212109.1064786-1-aford173@gmail.com>
References: <20210119212109.1064786-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two registers which can set the load capacitance for
XTAL1 and XTAL2. These are optional registers when using an
external crystal.  Parse the device tree and set the
corresponding registers accordingly.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Make the math subtract 9000 since we have a DIV_ROUND_CLOSEST
     This also allows us to remove the check for 9430 since values
     between 9000 and 9430 will round up and down.
     Make write VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP
     a read-modify-write to not worry about the contents of
     bits[1:0].

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 43db67337bc0..c6b04c077224 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -759,6 +759,74 @@ static int vc5_update_power(struct device_node *np_output,
 	return 0;
 }
 
+static int vc5_map_cap_value(u32 femtofarads)
+{
+	int mapped_value;
+
+	/*
+	 * The datasheet explicitly states 9000 - 25000 with 0.5pF
+	 * steps, but the Programmer's guide shows the steps are 0.430pF.
+	 * After getting feedback from Renesas, the .5pF steps were the
+	 * goal, but 430nF was the actual values.
+	 * Because of this, the actual range goes to 22760 instead of 25000
+	 */
+	if (femtofarads < 9000 || femtofarads > 22760)
+		return -EINVAL;
+
+	/*
+	 * The Programmer's guide shows XTAL[5:0] but in reality,
+	 * XTAL[0] and XTAL[1] are both LSB which makes the math
+	 * strange.  With clarfication from Renesas, setting the
+	 * values should be simpler by ignoring XTAL[0]
+	 */
+
+	mapped_value = DIV_ROUND_CLOSEST(femtofarads - 9000, 430);
+
+	/*
+	 * Since the calculation ignores XTAL[0], there is one
+	 * special case where mapped_value = 32.  In reality, this means
+	 * the real mapped value should be 111111b.  In other clases,
+	 * the mapped_value needs to be shifted 1 to the left.
+	 */
+
+	if (mapped_value > 31)
+		mapped_value = 0x3f;
+	else
+		mapped_value <<= 1;
+
+	return mapped_value;
+}
+static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
+{
+	u32 value;
+	int mapped_value, cache;
+
+	if (!of_property_read_u32(node, "idt,xtal-load-femtofarads", &value)) {
+		mapped_value = vc5_map_cap_value(value);
+		if (mapped_value < 0)
+			return mapped_value;
+
+		/*
+		 * The mapped_value is really the high 6 bits of
+		 * VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP, so
+		 * shift the value 2 places.  Read each register, wipe out
+		 * the top 6 bits and, write the combined data back.
+		 */
+
+		mapped_value = (mapped_value << 2);
+
+		cache = regmap_read(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, &cache);
+		cache &= 0x03;
+		regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, mapped_value | cache);
+
+		cache = regmap_read(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, &cache);
+		cache &= 0x03;
+		regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, mapped_value | cache);
+	}
+
+	return 0;
+}
+
 static int vc5_update_slew(struct device_node *np_output,
 			   struct vc5_out_data *clk_out)
 {
@@ -884,6 +952,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return -EINVAL;
 	}
 
+	/* Configure Optional Loading Capacitance for external XTAL */
+	if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {
+		ret = vc5_update_cap_load(client->dev.of_node, vc5);
+		if (ret)
+			goto err_clk_register;
+	}
+
 	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
-- 
2.25.1

