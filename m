Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30762BB05E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgKTQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbgKTQWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:19 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A07D422470;
        Fri, 20 Nov 2020 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889335;
        bh=NvHejK6bm1iezB4Z2XWVQ+HMeAvWCR8XMyZn2Cmc0nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zE/TebAFHMNO/ZbNjF8fGrp4w/dLMQcELRPg7gSNajIns1RmDL8BXXY2ryversuo+
         6KXvt47HTX6Je4Tojj+po46iFryER9IHzkUlCb8HD8DtByTMtkcuPTvQDtqrXxRWL8
         D9XcG6wKrn9SnZvjNzA44qtdVURPraILmAqSVR7c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        patches@opensource.cirrus.com
Subject: [PATCH 14/16] mfd: wm8994: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:31 +0100
Message-Id: <20201120162133.472938-14-krzk@kernel.org>
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

  drivers/mfd/wm8994-core.c:618:34: warning: ‘wm8994_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/wm8994-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 3b2b93c5bbcb..d2401e99cdd6 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -683,7 +683,7 @@ static struct i2c_driver wm8994_i2c_driver = {
 	.driver = {
 		.name = "wm8994",
 		.pm = &wm8994_pm_ops,
-		.of_match_table = of_match_ptr(wm8994_of_match),
+		.of_match_table = wm8994_of_match,
 	},
 	.probe = wm8994_i2c_probe,
 	.remove = wm8994_i2c_remove,
-- 
2.25.1

