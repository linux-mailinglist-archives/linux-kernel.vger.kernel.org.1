Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311FD245CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHQHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHQHAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:40 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB0620866;
        Mon, 17 Aug 2020 07:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647640;
        bh=GUVKNPgfDB8917lWwEHA4oC9kR2I7j0v7BpHAiKdlMc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ERIe7+9z9OO2G1LOlISUJG631f9KT/bOz4Cn2M2bWClCTuHy2/qZWsNX/PlT/A7wF
         ZxUU6CaORmlcq36aZv+qrxNLE31J5iGpas9HtVJEHmRJAs/ShHHCEb0rkdGKVCWJeJ
         zhArTf43KIMjgHgr3DNgJpDyv79g/oA9nCPJZ5Yg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 11/13] extcon: ptn5150: Convert to module_i2c_driver
Date:   Mon, 17 Aug 2020 09:00:07 +0200
Message-Id: <20200817070009.4631-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
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
index c8611ff90990..690d878c65f1 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -337,12 +337,7 @@ static struct i2c_driver ptn5150_i2c_driver = {
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

