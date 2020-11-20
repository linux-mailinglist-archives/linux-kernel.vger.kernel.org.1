Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40742BB052
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgKTQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgKTQV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:21:58 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691262240B;
        Fri, 20 Nov 2020 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889318;
        bh=5nlUtR/EHV/na0YbJv7yTM4dLwfZMaMallh00KeXDS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gbEZpJyZyxQH90/GY0YI0zCqFawZ557kMqslGGuagQSzmZFeyYc7Xrcaw2spUvNr
         CHD0pP4SS4X4iffNTb1DDnkhrGN3E2lI5IsElToCvmXMCI9la68q4G7rUwQWBhCILw
         ZNN/QhkWum/VfPVcypUnfWke5JwuKIyDWESBvRpU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 05/16] mfd: da9150: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:22 +0100
Message-Id: <20201120162133.472938-5-krzk@kernel.org>
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

  drivers/mfd/da9150-core.c:505:34: warning: ‘da9150_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/da9150-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 7f0aa1e8db96..196486a2152d 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -511,7 +511,7 @@ MODULE_DEVICE_TABLE(of, da9150_of_match);
 static struct i2c_driver da9150_driver = {
 	.driver	= {
 		.name	= "da9150",
-		.of_match_table = of_match_ptr(da9150_of_match),
+		.of_match_table = da9150_of_match,
 	},
 	.probe		= da9150_probe,
 	.remove		= da9150_remove,
-- 
2.25.1

