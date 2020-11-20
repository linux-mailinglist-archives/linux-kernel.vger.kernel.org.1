Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055962BB057
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgKTQWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgKTQWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:09 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D5422470;
        Fri, 20 Nov 2020 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889329;
        bh=Oux3w4phNArvsEGZkj50lir+cGOmXDXFa+FOX2iT/rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjtcXXBjPG/o0wBc6Dea04Tz18qniZBQt2ntWtoeBSfVnPv6w+eF/6GRUtr3NIbRa
         6k7rEOPTTLOv4kl9vs37mMudgGSrb6oRV/m08WcSNa2sNz6pBpqmZadGPBrw2DBYLH
         2+gEbd6qPdGHOOHijYx5XXIP1B9gZC+AqImzcSkY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 11/16] mfd: rt5033: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:28 +0100
Message-Id: <20201120162133.472938-11-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  drivers/mfd/rt5033.c:116:34: warning: ‘rt5033_dt_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/rt5033.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 48381d9bf740..f1236a9acf30 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -122,7 +122,7 @@ MODULE_DEVICE_TABLE(of, rt5033_dt_match);
 static struct i2c_driver rt5033_driver = {
 	.driver = {
 		.name = "rt5033",
-		.of_match_table = of_match_ptr(rt5033_dt_match),
+		.of_match_table = rt5033_dt_match,
 	},
 	.probe = rt5033_i2c_probe,
 	.id_table = rt5033_i2c_id,
-- 
2.25.1

