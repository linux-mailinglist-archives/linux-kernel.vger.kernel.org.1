Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B362BB055
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgKTQWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729781AbgKTQWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:04 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026762240B;
        Fri, 20 Nov 2020 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889323;
        bh=qXM9X1w2HAHjB+ckf1feJKTku+sj+5EwOS/Y5RnLarQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uU/bv5rVyw51+J+f4AYRvDt9h2Rfz+vunAl+Y1qdMvKj0NjeuqlcXMliPsD7oLdnx
         ByNy31Ko6Tk2WflXefQQlXZVAL1o7kBst5SegueuwyGnaXYsFLNZyBRsWhcbF+qeTm
         u/Ili3Fc+MBXM4nDMJbwVhwIJj5EaNQ19YI+JdSY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/16] mfd: max77650: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:25 +0100
Message-Id: <20201120162133.472938-8-krzk@kernel.org>
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

  drivers/mfd/max77650.c:215:34: warning: ‘max77650_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/max77650.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
index 60e07aca6ae5..777485a33bc0 100644
--- a/drivers/mfd/max77650.c
+++ b/drivers/mfd/max77650.c
@@ -221,7 +221,7 @@ MODULE_DEVICE_TABLE(of, max77650_of_match);
 static struct i2c_driver max77650_i2c_driver = {
 	.driver = {
 		.name = "max77650",
-		.of_match_table = of_match_ptr(max77650_of_match),
+		.of_match_table = max77650_of_match,
 	},
 	.probe_new = max77650_i2c_probe,
 };
-- 
2.25.1

