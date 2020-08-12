Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2030C242DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHLQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgHLQuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:50:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 888F120855;
        Wed, 12 Aug 2020 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597251025;
        bh=d1y8d3X6Gye9u0mJ4HY9FyhQltB7BnKNoY+bges04bM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PX4jmO9MFdaiJBkxcMih7RufEkrYLFe0hl5m9P8OUxLZV4ANSWqzllpQEhplARfQc
         l5JwpGAEMZWME4399yM7jNCVdtZTc/LK6MOSmx0IhceM2LRonj3V3oH8OyOTnSDjD9
         z3y1ADNYzBFlpv2s3pDVRjC5hbcAyTa+ksVQ0VJg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 12/13] extcon: ptn5150: Convert to module_i2c_driver
Date:   Wed, 12 Aug 2020 18:50:12 +0200
Message-Id: <20200812165013.2699-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use module_i2c_driver() to simplify driver init boilerplate.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index fd9723f86d55..559e26214f48 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -338,12 +338,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
 	.probe	= ptn5150_i2c_probe,
 	.id_table = ptn5150_i2c_id,
 };
-
-static int __init ptn5150_i2c_init(void)
-{
-	return i2c_add_driver(&ptn5150_i2c_driver);
-}
-subsys_initcall(ptn5150_i2c_init);
+module_i2c_driver(ptn5150_i2c_driver);
 
 MODULE_DESCRIPTION("NXP PTN5150 CC logic Extcon driver");
 MODULE_AUTHOR("Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>");
-- 
2.17.1

