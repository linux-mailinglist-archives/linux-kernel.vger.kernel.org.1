Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1932BB059
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgKTQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgKTQWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:14 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EB422269;
        Fri, 20 Nov 2020 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889333;
        bh=VuTIxqGQo/EEJgNF9vyLOTgI2ZYJAhjcd4bxSRSfJ0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8rR8EP1giu0rgr9xA4F5eQHNXFj0746rqVonsfatGAuOSGDG9Fb/8uVQLPmjtj1g
         COApqvfm191eZ6UDyIF7OGbAOUml4XNDDB3DFt7TAzUYMCJIPhpQSJLnf+ZjN7kPPg
         YeT4i242sHORazDelHWbWAVDFSacfLL1ROBRFzW0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/16] mfd: sun4i: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:30 +0100
Message-Id: <20201120162133.472938-13-krzk@kernel.org>
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

  drivers/mfd/sun4i-gpadc.c:79:34: warning: ‘sun4i_gpadc_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sun4i-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index b346fbce3c01..10d4172ae74c 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -166,7 +166,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc",
-		.of_match_table = of_match_ptr(sun4i_gpadc_of_match),
+		.of_match_table = sun4i_gpadc_of_match,
 	},
 	.probe = sun4i_gpadc_probe,
 };
-- 
2.25.1

