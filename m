Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9D2BB049
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgKTQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgKTQUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:20:02 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB8F2245F;
        Fri, 20 Nov 2020 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889202;
        bh=1fhDXmO08NfkJQ4t+guUAX1qFIWAvOwnwGfYMJfpCc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2pO1V354Zxdr4iFbSU2fOGABNdvr1YyszwUycC9eisUVZBOCLvTqI7GNfZ5su1Wg
         BcPGHxK1Yj7mBFMK4lbq4otbnmHe7Ms2obNc2VCIGrZqbjIFXFXalTM7cT93U7c6ZW
         m3DiUdzgngllEeMLBrhcAJ1ALy9z6VSsKm0v/RnI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 37/38] ASoC: max98926: drop driver pm=NULL assignment
Date:   Fri, 20 Nov 2020 17:16:51 +0100
Message-Id: <20201120161653.445521-37-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to explicitly set driver .pm field to NULL.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98926.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 0977e541326d..f286e572263e 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -583,7 +583,6 @@ static struct i2c_driver max98926_i2c_driver = {
 	.driver = {
 		.name = "max98926",
 		.of_match_table = of_match_ptr(max98926_of_match),
-		.pm = NULL,
 	},
 	.probe	= max98926_i2c_probe,
 	.id_table = max98926_i2c_id,
-- 
2.25.1

