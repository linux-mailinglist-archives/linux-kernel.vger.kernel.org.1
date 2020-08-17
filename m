Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08D245CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHQHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgHQHAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C54A20758;
        Mon, 17 Aug 2020 07:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647630;
        bh=3bfDu2rrgsQUUDMAmYFHILNOphrIGlyzCv66V1HnZQE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I63P1FcNXsuQY4aeMwlAuNyXbpcagMDe1fxc3eAmejIj0FDVJWDAsDhq8Hi/H9u2Y
         j/5F3JYtb+khaO0SLHDXajJhwLYM1nzyyhkMkLPozWgIydDLpEX72o/qoYOTIQX7IZ
         uw/Ka3IwtG2RQCyoLCY5KeKuJwjlA79yAf9xFnfY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 06/13] extcon: ptn5150: Simplify getting vbus-gpios with flags
Date:   Mon, 17 Aug 2020 09:00:02 +0200
Message-Id: <20200817070009.4631-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of obtaining GPIO as input and configuring it right after to
output-low, just use proper GPIOD_OUT_LOW flag.  Code is smaller and
simpler.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 12e52ddbd77e..3b99ad41b06e 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -239,16 +239,11 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
-	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
+	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_OUT_LOW);
 	if (IS_ERR(info->vbus_gpiod)) {
 		dev_err(dev, "failed to get VBUS GPIO\n");
 		return PTR_ERR(info->vbus_gpiod);
 	}
-	ret = gpiod_direction_output(info->vbus_gpiod, 0);
-	if (ret) {
-		dev_err(dev, "failed to set VBUS GPIO direction\n");
-		return -EINVAL;
-	}
 
 	mutex_init(&info->mutex);
 
-- 
2.17.1

