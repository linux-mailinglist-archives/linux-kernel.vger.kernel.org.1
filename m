Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0D2BB017
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgKTQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgKTQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:55 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B40238E6;
        Fri, 20 Nov 2020 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889195;
        bh=NX1sCI8zxlv2qyzfAYPwh+TfyVm3JU5OnLvy2TqvW/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn06UuLocBhrxPqSQ722nyAWCLcnqH4qY1JOmm0B+106mEU1hPpN5P3T/N4ElgBPT
         xyCR9Mye//OtU4n9SZYgzJIpHwWOQ4kDq06pg63YCKfzUcPLa4gUyKJEP0FCNNcDnU
         AQofqxC08raZp1/0XoBECrltoU4ulvq5W7ZTiD4A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 35/38] ASoC: max98371: drop driver pm=NULL assignment
Date:   Fri, 20 Nov 2020 17:16:49 +0100
Message-Id: <20201120161653.445521-35-krzk@kernel.org>
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
 sound/soc/codecs/max98371.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 0b438303e1d5..e424779db02b 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -419,7 +419,6 @@ MODULE_DEVICE_TABLE(of, max98371_of_match);
 static struct i2c_driver max98371_i2c_driver = {
 	.driver = {
 		.name = "max98371",
-		.pm = NULL,
 		.of_match_table = of_match_ptr(max98371_of_match),
 	},
 	.probe  = max98371_i2c_probe,
-- 
2.25.1

