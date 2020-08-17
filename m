Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635D9245CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgHQHDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgHQHAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC442078A;
        Mon, 17 Aug 2020 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647636;
        bh=FeD/w6R4mKoUbO+uetEN3Bu1REEWaeSYyb5+dO5tRGI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jBn/Ft3oBvOlo6nyyQTewMnZHlTchP+WI4UBDQtf7Z7Yv9RSszcGdc1+2ffBurQ2c
         XA+zCvN7t3Fu0myFjM2H2a5Yh4fjWRZJMMQGvEhNwTznaSnsEvHG/OQJE0gO0Dbofd
         MfZdhKrDWfPcgBFxnDCzoGbBrZOr4N7rEtvwNb5w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 09/13] extcon: ptn5150: Make 'vbus-gpios' optional
Date:   Mon, 17 Aug 2020 09:00:05 +0200
Message-Id: <20200817070009.4631-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTN5150 chip can be used in hardware designs with only reporting of
USB Type-C connection, without the VBUS control.  The driver however
unconditionally expected 'vbus-gpios'.

Since all uses of the VBUS GPIO descriptor are NULL safe, the code can
accept missing GPIO and provide only extcon status reporting.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 342973726565..008e664d8d56 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -238,8 +238,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	info->i2c = i2c;
 	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_OUT_LOW);
 	if (IS_ERR(info->vbus_gpiod)) {
-		dev_err(dev, "failed to get VBUS GPIO\n");
-		return PTR_ERR(info->vbus_gpiod);
+		ret = PTR_ERR(info->vbus_gpiod);
+		if (ret == -ENOENT) {
+			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
+			info->vbus_gpiod = NULL;
+		} else {
+			dev_err(dev, "failed to get VBUS GPIO\n");
+			return ret;
+		}
 	}
 
 	mutex_init(&info->mutex);
-- 
2.17.1

