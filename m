Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2262BB00C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgKTQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgKTQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:19:22 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7C42240B;
        Fri, 20 Nov 2020 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889162;
        bh=4TwJDhvLUQ9SarMg0Cg8dwFxEwAJn3ntoVUmPHve+a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQbjYQRWXtkm2LqPEMITYBQqC8mE7SnZGwJpgscBOVLO9OrboHAHN/HBTnINhd8Z/
         lXKVsw2rnxTClNSsqNs2VwPlXc1J/nE91Xi1glAoDtibCKLuBIfhnOBkE9hRe+7azk
         WbC/jguJyig9x4xWfUBBPGFWWjTg1g3aFY5yX9Gc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 28/38] ASoC: rt5660: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:42 +0100
Message-Id: <20201120161653.445521-28-krzk@kernel.org>
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

  sound/soc/codecs/rt5660.c:1238:34: warning: ‘rt5660_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/rt5660.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 9e3813f7583d..0edf09d3a499 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1235,11 +1235,13 @@ static const struct i2c_device_id rt5660_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5660_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id rt5660_of_match[] = {
 	{ .compatible = "realtek,rt5660", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt5660_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5660_acpi_match[] = {
-- 
2.25.1

