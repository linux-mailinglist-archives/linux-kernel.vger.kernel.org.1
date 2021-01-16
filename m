Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274EE2F8F88
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 22:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhAPV40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 16:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbhAPV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 16:56:14 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B1C061574;
        Sat, 16 Jan 2021 13:55:34 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so25342932iob.11;
        Sat, 16 Jan 2021 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zI9m/88/zC4bXfzybZXMOWBpR1qzXzngD3/Zlbudf54=;
        b=X66Yz+ldWRglOqRx4lkYLATma5h6JQgFBBQfT3Zaszt8AVJB1OkyZv5ErmxEAVJl52
         zcEJWMS3tXeW/6BDBdCcip/QP8UwxKEAYNF8deUn8CIoso+XoGK+p3GF7KhLN+lYCEbo
         Olam/s7L+qfrIINk0nh8jI08OKAdpRB1o5Kngp01hb80cQM6vH+9nVLa24pVzrtzeE76
         nA5oHoF9jnqEvHDLD+1WptiJm6n4xuvmpg/tw+4Zd80nz4fGK4sXbPInE2jf93OIXZLA
         W4EYo9rNlE8BIlCBCkwOi+0jHuFITYk90Fn1ATa4AoSVMUJeFPcEYlKQlpvCb+X8ZJkT
         +zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zI9m/88/zC4bXfzybZXMOWBpR1qzXzngD3/Zlbudf54=;
        b=rZuVr0nU3c+1qvb2n+1oWNEcdYO2NKZdhXrR9uj9hG9v/CAa6jq0+9H/WrkXE5kasi
         Nc9VWBO2/rfOjCdDUhYEv77gxpBV4J7R3ix7lJdF9MHcOoVpA9X/9FKaXRY8hDNaA2nw
         oN1frJQmg9wI77JvwzVcSokk5SjA6RdyVlvz0qBCAuWNmg8Lgm+u1gwCOOiAcvtm+EHn
         p5XWfxsUFksmujORXM5aI0odJqp2m2kyruv9G3F0w3JtqM/IzqrA8llxn8Jh590rartS
         218b51NE5W/2nTi6PzHdi3sERicUOXDJz5Ousu5PhuMxHCiz7nUfJxSqWuNP8JKFMMj/
         rRWQ==
X-Gm-Message-State: AOAM530bzSk8BFrlHV/GEWil4IgoJ8uLJEUemNA19ZWQ6DlhcsPKy0GH
        1DnYYd8f2p5Sq7j+DzK5+PYssuwVuPEW7Q==
X-Google-Smtp-Source: ABdhPJzRmXjW2USpEGMGRV8ZM2koCDXodW496Y230kQR1Hiq9+OnTBVp30ZelZwGHfnWKaK6HpVEvw==
X-Received: by 2002:a92:845c:: with SMTP id l89mr16086055ild.114.1610834133448;
        Sat, 16 Jan 2021 13:55:33 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e50e:b7cb:7c2:91f9])
        by smtp.gmail.com with ESMTPSA id r9sm7544300ill.72.2021.01.16.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 13:55:32 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: vc5: Add support for optional load capacitance
Date:   Sat, 16 Jan 2021 15:54:51 -0600
Message-Id: <20210116215451.601498-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210116215451.601498-1-aford173@gmail.com>
References: <20210116215451.601498-1-aford173@gmail.com>
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

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 43db67337bc0..224118ca08fd 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -759,6 +759,72 @@ static int vc5_update_power(struct device_node *np_output,
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
+	/* The lowest target we can hit is 9430, so exit if it's less */
+	if (femtofarads < 9430)
+		return 0;
+
+	/*
+	 * The Programmer's guide shows XTAL[5:0] but in reality,
+	 * XTAL[0] and XTAL[1] are both LSB which makes the math
+	 * strange.  With clarfication from Renesas, setting the
+	 * values should be simpler by ignoring XTAL[0]
+	 */
+
+	mapped_value = DIV_ROUND_CLOSEST(femtofarads - 9430, 430);
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
+	int mapped_value;
+
+	if (!of_property_read_u32(node, "idt,xtal-load-femtofarads", &value)) {
+		mapped_value = vc5_map_cap_value(value);
+		if (mapped_value < 0)
+			return mapped_value;
+
+		/*
+		 * According to Renesas, bits [1:0] of VC5_XTAL_X1_LOAD_CAP
+		 * and VC5_XTAL_X2_LOAD_CAP should always be 01b.
+		 * Since the mapped_value is really the high 6 bits of 8,
+		 * shift the value 2 places and or in the 0x01;
+		 */
+
+		mapped_value = (mapped_value << 2) | 0x01;
+		regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, mapped_value);
+		regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, mapped_value);
+	}
+
+	return 0;
+}
+
 static int vc5_update_slew(struct device_node *np_output,
 			   struct vc5_out_data *clk_out)
 {
@@ -884,6 +950,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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

