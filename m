Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26542EC281
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbhAFRkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbhAFRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:40:01 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CEC06134C;
        Wed,  6 Jan 2021 09:39:21 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id n9so4003753ili.0;
        Wed, 06 Jan 2021 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EekwCiDptoxEoXvmyyK8hndNw/3aHN9snXxLo/3Gy9g=;
        b=fLOIfh9aBZspzg6BrSydswXwW8B/wkIN+Bt2rcHRj6g9oRWKoRHr/0ECB1NufL1Gk1
         ZrmjuhPLwFjfeS8+JHGLWE7vn0Gj8FA/8VJ9rFYwWOHLZHOiKNMNMLq53E0XuOEfY7X1
         Y01CqVbl4ea6eWkFei7A0N7GcmWMblacGBjijQkNLgJxUXluEaCREWMumn1b3j2ljZvf
         qbOYNnV9KbGa3xQPsmJCKarESk5iWakcGJ5Joa0t8nuS4tKEYKN+0m9aIWCAzMXPwqLl
         28TrjlM3nAG2NAiBqU5DrCktZKJ9mQ1bnDHZfUxDAFW9hum52ZmpKa4M6HE9AvJscF07
         9F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EekwCiDptoxEoXvmyyK8hndNw/3aHN9snXxLo/3Gy9g=;
        b=BNbnes6sgzedxe1HfXgpmKi1aORw9wVMdpD0kPcMiTMkbVB0NwQb1PXe/yQy44mzN7
         1kyjPQj58if2+VHS8gwBmpI1NOl0ay1dqLc+hXsyiRksWLdpUBv+2F04GJ0Dq1Bm7qiT
         6VqHpV0w5vFp8xoTQcSPTfPk6ssSDhjcAfidt07y7orzXGMxSoSfSEs1wXswSpN8SLfq
         ruLwWdKu0floT0Pw5WvrNWaFI7YR6HLynxEITQHcYW9EXnvCzkmvAz5J5xfiM8pTfzwW
         qTsiIMsm6FW3HIB0ZBYvkjVCuVK9z/OEGSQh/pH0LB814Pq6cRXJIGjIp7mhF1FN+TsT
         lwHw==
X-Gm-Message-State: AOAM533+mmYfsOuxw6X4erI5dc2WwoNXhMqMgYKMzEFabShh0YOZgYGq
        jzqAiWK3CxaEb/ZyplKy1H4ZYr2c2Yt2EQ==
X-Google-Smtp-Source: ABdhPJwmlQ48CXKbwgYz7ywrC1vziQZCByLAXtrDFSB0MBp49YFGWfIlD2yDO/QfNWgly9uj5dl9Tg==
X-Received: by 2002:a92:d2ce:: with SMTP id w14mr5655421ilg.182.1609954760230;
        Wed, 06 Jan 2021 09:39:20 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:71d3:d2c6:eb48:76be])
        by smtp.gmail.com with ESMTPSA id y5sm2461132ilh.24.2021.01.06.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 09:39:19 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/2] clk: vc5: Add support for optional load capacitance
Date:   Wed,  6 Jan 2021 11:39:00 -0600
Message-Id: <20210106173900.388758-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106173900.388758-1-aford173@gmail.com>
References: <20210106173900.388758-1-aford173@gmail.com>
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
 drivers/clk/clk-versaclock5.c | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 43db67337bc0..445abc3731fb 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -759,6 +759,63 @@ static int vc5_update_power(struct device_node *np_output,
 	return 0;
 }
 
+static int vc5_map_cap_value(u32 femtofarads)
+{
+	int mapped_value;
+
+	/* The datasheet explicitly states 9000 - 25000 */
+	if ((femtofarads < 9000) || (femtofarads > 25000))
+		return -EINVAL;
+
+	/* The lowest target we can hit is 9430, so exit if it's less */
+	if (femtofarads < 9430)
+		return 0;
+
+	/*
+	 * According to VersaClock 6E Programming Guide, there are 6
+	 * bits which translate to 64 entries in XTAL registers 12 and
+	 * 13. Because bits 0 and 1 increase the capacitance the
+	 * same, some of the values can be repeated.  Plugging this
+	 * into a spreadsheet and generating a trendline, the output
+	 * equation becomes x = (y-9098.29) / 216.44, where 'y' is
+	 * the desired capacitance in femtofarads, and x is the value
+	 * of XTAL[5:0].
+	 * To help with rounding, do fixed point math
+	 */
+	femtofarads *= 100;
+	mapped_value = (femtofarads - 909829) / 21644;
+
+	/*
+	 * The datasheet states, the maximum capacitance is 25000,
+	 * but the programmer guide shows a max value is 22832,
+	 * so values higher values could overflow, so cap it.
+	 */
+	mapped_value = max(mapped_value/100, 0x3f);
+
+	return mapped_value;
+}
+static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
+{
+	u32 value, mapped_value;
+
+	if (!of_property_read_u32(node, "idt,xtal1-load-femtofarads", &value)) {
+		mapped_value = vc5_map_cap_value(value);
+		if (mapped_value < 0)
+			return mapped_value;
+
+		regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, (mapped_value << 2));
+	}
+
+	if (!of_property_read_u32(node, "idt,xtal2-load-femtofarads", &value)) {
+		mapped_value = vc5_map_cap_value(value);
+		if (mapped_value < 0)
+			return mapped_value;
+		regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, (mapped_value << 2));
+	}
+
+	return 0;
+}
+
 static int vc5_update_slew(struct device_node *np_output,
 			   struct vc5_out_data *clk_out)
 {
@@ -884,6 +941,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
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

