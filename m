Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07F274DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWA6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:58:19 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:53310 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:58:18 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id D02D520E00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:52:04 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 40BCF260EB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:52:02 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 3D1233F162;
        Wed, 23 Sep 2020 02:52:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 0A6E12A7E0;
        Wed, 23 Sep 2020 02:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1600822320;
        bh=XWWuNBTm8XySlfPLq/wQr6cf8hUESlECyaiUoBYS4Wo=;
        h=From:To:Cc:Subject:Date:From;
        b=IG/GT/LErh3avA91vqfi07BgACPKmA4ZVaqWV2HNlJrJ2pQXY+dpGFh9S0/auBgSs
         zEWKV5tQYYqbPJEwQ3F+gkdeHnLcdQqVq7D4n9E9M/eCYR8pDG4ZHHDJzuZFcpYUUX
         Fz+TyHfUxoJA2I7h4gSVvZsoWwqGLyZ+koyKeUMU=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tMNw_B-Pi0Gv; Wed, 23 Sep 2020 02:51:58 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Wed, 23 Sep 2020 02:51:58 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 6E36141024;
        Wed, 23 Sep 2020 00:51:57 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="UQPny7rG";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 8D55741024;
        Wed, 23 Sep 2020 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1600822312; bh=XWWuNBTm8XySlfPLq/wQr6cf8hUESlECyaiUoBYS4Wo=;
        h=From:To:Cc:Subject:Date:From;
        b=UQPny7rGuqza6FDbToP/ZOiv8rharcDlE4b/m+HfqvdN9WX+MFJIC3gQqqsGhzZpc
         rX5HSneoPrJQAcKOao8NwRVCON/O6cp+BbE3i/tEAOr6SCVdHcTKz2K+PDMf1luLpg
         5n2OzysMr7SD0f9m3QZ0aHjH0ROF+uJg0mnGxZxI=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Olliver Schinagl <oliver@schinagl.nl>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] regulator: axp20x: fix LDO2/4 description
Date:   Wed, 23 Sep 2020 08:51:42 +0800
Message-Id: <20200923005142.147135-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E36141024
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.155:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         FREEMAIL_TO(0.00)[gmail.com,kernel.org,csie.org,plaes.org,schinagl.nl];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we wrongly set the mask of value of LDO2/4 both to the mask of
LDO2, and the LDO4 voltage configuration is left untouched. This leads
to conflict when LDO2/4 are both in use.

Fix this issue by setting different vsel_mask to both regulators.

Fixes: db4a555f7c4c ("regulator: axp20x: use defines for masks")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/regulator/axp20x-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 1bacb37e8a99..cd1224182ad7 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -42,8 +42,9 @@
 
 #define AXP20X_DCDC2_V_OUT_MASK		GENMASK(5, 0)
 #define AXP20X_DCDC3_V_OUT_MASK		GENMASK(7, 0)
-#define AXP20X_LDO24_V_OUT_MASK		GENMASK(7, 4)
+#define AXP20X_LDO2_V_OUT_MASK		GENMASK(7, 4)
 #define AXP20X_LDO3_V_OUT_MASK		GENMASK(6, 0)
+#define AXP20X_LDO4_V_OUT_MASK		GENMASK(3, 0)
 #define AXP20X_LDO5_V_OUT_MASK		GENMASK(7, 4)
 
 #define AXP20X_PWR_OUT_EXTEN_MASK	BIT_MASK(0)
@@ -542,14 +543,14 @@ static const struct regulator_desc axp20x_regulators[] = {
 		 AXP20X_PWR_OUT_CTRL, AXP20X_PWR_OUT_DCDC3_MASK),
 	AXP_DESC_FIXED(AXP20X, LDO1, "ldo1", "acin", 1300),
 	AXP_DESC(AXP20X, LDO2, "ldo2", "ldo24in", 1800, 3300, 100,
-		 AXP20X_LDO24_V_OUT, AXP20X_LDO24_V_OUT_MASK,
+		 AXP20X_LDO24_V_OUT, AXP20X_LDO2_V_OUT_MASK,
 		 AXP20X_PWR_OUT_CTRL, AXP20X_PWR_OUT_LDO2_MASK),
 	AXP_DESC(AXP20X, LDO3, "ldo3", "ldo3in", 700, 3500, 25,
 		 AXP20X_LDO3_V_OUT, AXP20X_LDO3_V_OUT_MASK,
 		 AXP20X_PWR_OUT_CTRL, AXP20X_PWR_OUT_LDO3_MASK),
 	AXP_DESC_RANGES(AXP20X, LDO4, "ldo4", "ldo24in",
 			axp20x_ldo4_ranges, AXP20X_LDO4_V_OUT_NUM_VOLTAGES,
-			AXP20X_LDO24_V_OUT, AXP20X_LDO24_V_OUT_MASK,
+			AXP20X_LDO24_V_OUT, AXP20X_LDO4_V_OUT_MASK,
 			AXP20X_PWR_OUT_CTRL, AXP20X_PWR_OUT_LDO4_MASK),
 	AXP_DESC_IO(AXP20X, LDO5, "ldo5", "ldo5in", 1800, 3300, 100,
 		    AXP20X_LDO5_V_OUT, AXP20X_LDO5_V_OUT_MASK,
-- 
2.27.0
