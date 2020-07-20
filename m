Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8478C225BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 11:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGTJoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 05:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGTJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:44:55 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7F23208E4;
        Mon, 20 Jul 2020 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595238295;
        bh=xG+MHTa8zHjZxmdpibpH8xzfEtpzgDpm4owhk97WPow=;
        h=From:To:Cc:Subject:Date:From;
        b=hsCU0a/aR4MuecLBLtFBKgrdrAbtbR+oeUtG6hk5xU2fymFpLEtEGig0REJi2zURF
         f/39pebyjEEOLA6J0rQXb5KKWHuynSRlm1xNC9zLbrm6cm0Z6UUiXXErWCHlS/6hsr
         EVaOuxZXDDmjnKkioy/EyrSnH6APHB8H7C4J3uDg=
Received: by wens.tw (Postfix, from userid 1000)
        id 5F5EA5FC12; Mon, 20 Jul 2020 17:44:50 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] reuglator: gpio: Honor regulator-boot-on property
Date:   Mon, 20 Jul 2020 17:44:49 +0800
Message-Id: <20200720094449.32282-1-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When requesting the enable GPIO, the driver tries to do so with the
correct output level matching the current state. This is done by
checking the boot_on constraint, which is derived from the
regulator-boot-on property in the device tree. This is especially
important if the regulator is a critical one, such as a supply for
the boot CPU.

Honor the regulator-boot-on property by checking the boot_on
constraint setting. This is the same as what is done in the fixed
regulator driver.

Also drop support for the undocumented enable-at-boot property. This
property was not documented in the original commit introducing DT
support, nor is it now, and there are no in-tree device trees that use
this property.

Fixes: 006694d099e8 ("regulator: gpio-regulator: Allow use of GPIO controlled regulators though DT")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/gpio-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 110ee6fe76c4..5646b7a26288 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -148,7 +148,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-at-boot"))
+	if (config->init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
-- 
2.27.0

