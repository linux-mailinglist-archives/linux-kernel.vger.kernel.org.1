Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB82BB058
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgKTQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbgKTQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:12 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5FC223BE;
        Fri, 20 Nov 2020 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889331;
        bh=ff2/0GFZmOkfOpWgo2XaheET+oxDW24eQaCng8TEeRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txLefZFl+Pa19Ah6jARwsNIaAl85zEF8BVTjtIs8gGtaVceu098dLwQAJOKzm6EyP
         DfzYFWOyq1csi11jp2QG10FCsyS7Eq/xfAIK0Jww7vkS+bGf2VlQTx7At6DPFkhijo
         3hjIXMTXdbwjCFa1X3G7ApbZ87Glx5O8Ls3UaM00=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/16] mfd: stmfx: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:29 +0100
Message-Id: <20201120162133.472938-12-krzk@kernel.org>
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

  drivers/mfd/stmfx.c:542:34: warning: ‘stmfx_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 5e680bfdf5c9..38303b534172 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -548,7 +548,7 @@ MODULE_DEVICE_TABLE(of, stmfx_of_match);
 static struct i2c_driver stmfx_driver = {
 	.driver = {
 		.name = "stmfx-core",
-		.of_match_table = of_match_ptr(stmfx_of_match),
+		.of_match_table = stmfx_of_match,
 		.pm = &stmfx_dev_pm_ops,
 	},
 	.probe = stmfx_probe,
-- 
2.25.1

