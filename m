Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8582BB050
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgKTQV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbgKTQVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:21:55 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AF2223FD;
        Fri, 20 Nov 2020 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889314;
        bh=yHK+dUg87FWm90sWQJnOubtfeDzb13EWCJCk1WB+OtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2st2oueqsHMRtL1iBhD+6Ros6cFS9+0B6XIUm/ZLCkXui1c0bscUV9pLE9YWjgJx
         nxdaM6MgTEkrXYBwCrMwHNMLXah0czAHIDgE1R/exoX/joMp2Smobo5CYbfz6TUTae
         XI7Ku7aNQA/rqq1ftuc7CFoYdz8AkLUj78CithL4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 03/16] mfd: da9062: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:20 +0100
Message-Id: <20201120162133.472938-3-krzk@kernel.org>
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

  drivers/mfd/da9062-core.c:614:34: warning: ‘da9062_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/da9062-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fc30726e2e27..60196e5befe1 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -736,7 +736,7 @@ MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
 static struct i2c_driver da9062_i2c_driver = {
 	.driver = {
 		.name = "da9062",
-		.of_match_table = of_match_ptr(da9062_dt_ids),
+		.of_match_table = da9062_dt_ids,
 	},
 	.probe    = da9062_i2c_probe,
 	.remove   = da9062_i2c_remove,
-- 
2.25.1

