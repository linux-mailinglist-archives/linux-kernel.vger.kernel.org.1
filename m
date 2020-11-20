Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521DD2BAFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgKTQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgKTQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:08 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361F12245B;
        Fri, 20 Nov 2020 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889088;
        bh=7BJ20HiIHWzZ7e1AQrBa9aWK6V1RKx6mOZWpprT3oG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkP2w3zcdhFoi/8w+5M+3XMvMRMtrqgge7OJl8laZ6rOF/dYyY8XppAr9BlQ1EC1Q
         fRtEBiUgRHOWZGWCYR1vwKhT4f19Ym3RoyvEg3HRrtATAfK1Yh5Evg69UCjs9i2/eZ
         02TojaHKw1cFh6KzO+mdrcR6NhCFvybBOM/0eqAs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 06/38] ASoC: kirkwood: armada-370-db: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:20 +0100
Message-Id: <20201120161653.445521-6-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
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

  sound/soc/kirkwood/armada-370-db.c:137:34: warning: ‘a370db_dt_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/kirkwood/armada-370-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index 8e44ae37ad1e..b12141ad15cb 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -143,7 +143,7 @@ MODULE_DEVICE_TABLE(of, a370db_dt_ids);
 static struct platform_driver a370db_driver = {
 	.driver		= {
 		.name	= "a370db-audio",
-		.of_match_table = of_match_ptr(a370db_dt_ids),
+		.of_match_table = a370db_dt_ids,
 	},
 	.probe		= a370db_probe,
 };
-- 
2.25.1

