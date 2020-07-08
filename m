Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB3218050
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgGHHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 03:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgGHHHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:07:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B32206DF;
        Wed,  8 Jul 2020 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594192049;
        bh=lZrmalpD7ItTgQTfiaDyl7dVCPGQ4oHIakyDehMdJxk=;
        h=From:To:Cc:Subject:Date:From;
        b=hxEoNTv+ulPBeK14F0fbAmoMkmGpukeSqjZsfaT9W5+YHbmvHAXw3+hw6TWpiYZC4
         ZODsv9+1Av2Fpn5ubOhlUdqMFihJK++igjAHPaR8Ru3ES/q2BjDuDRvgkH7+ustZAb
         8++C4lPJgIu2eDZNHVoz0uJ4C31EkuIGOJBdVN0c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mfd: axp20x: Use #ifdef for checking CONFIG_ACPI
Date:   Wed,  8 Jul 2020 09:07:24 +0200
Message-Id: <20200708070725.6318-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use #ifdef directive to check whether config symbol is defined and to
fix warning:

    drivers/mfd/axp20x-i2c.c:82:5: warning: "CONFIG_ACPI" is not defined [-Wundef]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/axp20x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index bd271fbe1ec1..3c930316d48b 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -79,7 +79,7 @@ static const struct i2c_device_id axp20x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
 
-#if CONFIG_ACPI
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id axp20x_i2c_acpi_match[] = {
 	{
 		.id = "INT33F4",
-- 
2.17.1

