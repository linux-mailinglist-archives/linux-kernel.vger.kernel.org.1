Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEED12BB05C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgKTQWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgKTQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:17 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539CD223BE;
        Fri, 20 Nov 2020 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889337;
        bh=SRwrYk85QtRvs535MX/n3ZEfTivmPucGYB46L0yPbD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keXezjqo0BRLJmWpA8wvZH5EnTvz0q6wloYSNL5n+jtkmiV0SOG1tYjHNJN9QjFGg
         N+6SmAz0LvR0MTbcakWkcyTzJM+Wkh4nYKRze3jtq4FAkZ61aXeNQ1EceTwgkubg3A
         3/724gtnh8IUt3INnbUQ3RwfrkrNRkETdDSXncgY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 15/16] mfd: axp20x: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:21:32 +0100
Message-Id: <20201120162133.472938-15-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match either via ACPI or OF.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  drivers/mfd/axp20x-i2c.c:60:34: warning: ‘axp20x_i2c_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/axp20x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index 068e9c083f13..2cfde81f5fbf 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -57,6 +57,7 @@ static int axp20x_i2c_remove(struct i2c_client *i2c)
 	return axp20x_device_remove(axp20x);
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
 	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
@@ -68,6 +69,7 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
+#endif
 
 static const struct i2c_device_id axp20x_i2c_id[] = {
 	{ "axp152", 0 },
-- 
2.25.1

