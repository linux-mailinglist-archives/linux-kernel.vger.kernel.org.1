Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C48B245CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHQHBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgHQHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:42 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FB020758;
        Mon, 17 Aug 2020 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647642;
        bh=g3IVMF+ZVvdBPOEwT/MiWL1aWCkOV5IH14nThQgHDgA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UaO20VuITytOXCKqv7NKyiuFnOrG4/IND4PAavj1RfcaO5ChQUBjXRkcekkQR2LW/
         s1nXg0rjVPYux+0fsZ2MWCJbvJN3MOZWhXHrP7Z5XpG0uzft2ozjPh7k9d3EGVE6aX
         yLWq07GWHJJgCIkb30T58+Td+Jm8TN2Fw34756JQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 12/13] extcon: ptn5150: Convert to .probe_new
Date:   Mon, 17 Aug 2020 09:00:08 +0200
Message-Id: <20200817070009.4631-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'struct i2c_device_id' argument of probe function is not used, so
convert the driver to simpler 'probe_new' interface.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 690d878c65f1..8ba706fad887 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -218,8 +218,7 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
 	return 0;
 }
 
-static int ptn5150_i2c_probe(struct i2c_client *i2c,
-				 const struct i2c_device_id *id)
+static int ptn5150_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct device_node *np = i2c->dev.of_node;
@@ -334,7 +333,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 		.name	= "ptn5150",
 		.of_match_table = ptn5150_dt_match,
 	},
-	.probe	= ptn5150_i2c_probe,
+	.probe_new	= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
 module_i2c_driver(ptn5150_i2c_driver);
-- 
2.17.1

