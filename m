Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E672BB00D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgKTQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgKTQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:26 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F48222470;
        Fri, 20 Nov 2020 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889166;
        bh=Qndidju4iqoGNSvs1izHnQ1sh03cOOHXUD8yp7FDt+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1D9t9V3DBrMGyMiXQU3R3v/lY4f6xyNxyzJy4Hwffs6GjvZbWabQ2SEzNBxNFGLaK
         tPDypw1QTeld/0tObG4i4A1U+HiZyWQ2xgFrPDP9pMpcgrPTvdO7oVBWTVqp1DDs62
         POaA8HtpEmo0iQrtAmf5YKZPthkkJagniEch9CHA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jonghwan Choi <charlie.jh@kakaocorp.com>
Subject: [PATCH 29/38] ASoC: tas2562: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:43 +0100
Message-Id: <20201120161653.445521-29-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/tas2562.c:805:34: warning: ‘tas2562_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/tas2562.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index f1ff204e3ad0..19965fabe949 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -802,6 +802,7 @@ static const struct i2c_device_id tas2562_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tas2562_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
 	{ .compatible = "ti,tas2563", },
@@ -810,6 +811,7 @@ static const struct of_device_id tas2562_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tas2562_of_match);
+#endif
 
 static struct i2c_driver tas2562_i2c_driver = {
 	.driver = {
-- 
2.25.1

