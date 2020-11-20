Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F02BB053
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKTQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbgKTQWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:00 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E167223FD;
        Fri, 20 Nov 2020 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889319;
        bh=wjN3b+SDMtOkyh6wWNbt4HBO7IkMuKfZOL8pRLi4EwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRfAElqP65lYSoa3TqS0UYRqjivHVE8BZmJLPheAb75Ns0rRp4Gy7SfrbuQUI9k5a
         5o7TkodYj8BmMlumrrvy8wsHqzG6C6z4WIC75XlVsXIrd7oBMPR2tV2rpb1juJooHe
         7l2SM8IaDSOLOkgx3sYjSV5lTu8SYK8VUwOUVvuQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 06/16] mfd: ene-kb3930: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:23 +0100
Message-Id: <20201120162133.472938-6-krzk@kernel.org>
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

  drivers/mfd/ene-kb3930.c:194:34: warning: ‘kb3930_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 1c32ff586816..83243e668e3f 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -202,7 +202,7 @@ static struct i2c_driver kb3930_driver = {
 	.remove = kb3930_remove,
 	.driver = {
 		.name = "ene-kb3930",
-		.of_match_table = of_match_ptr(kb3930_dt_ids),
+		.of_match_table = kb3930_dt_ids,
 	},
 };
 module_i2c_driver(kb3930_driver);
-- 
2.25.1

