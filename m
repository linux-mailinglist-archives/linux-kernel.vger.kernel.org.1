Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337922BAFFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgKTQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgKTQSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:44 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1A924137;
        Fri, 20 Nov 2020 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889124;
        bh=hUJkunHo8Nfcr2uWL1x9GpPMBlvI204ks175M5PYJr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMPhRu0Os3XEKHUs+gGQOmsihnr3R/UocQ7H0e1Ol0a61S50PPPs4pbp3QjRPE2C1
         0UPxFy/E5EGty3PwH1bNn4cuHw67Z4+7SoMFvJxT/ee9E+xlkkZq17Mh5Q80DzTJvi
         xfJYeQ6OstFhB5AZ3cuGsLKEDoK+FJBVdnz2s8t4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 17/38] ASoC: da7219: skip of_device_id table when !CONFIG_OF
Date:   Fri, 20 Nov 2020 17:16:31 +0100
Message-Id: <20201120161653.445521-17-krzk@kernel.org>
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

  sound/soc/codecs/da7219.c:1705:34: warning: ‘da7219_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 0b3b7909efc9..e9b45daec0ca 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1702,11 +1702,13 @@ static struct snd_soc_dai_driver da7219_dai = {
  * DT/ACPI
  */
 
+#ifdef CONFIG_OF
 static const struct of_device_id da7219_of_match[] = {
 	{ .compatible = "dlg,da7219", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7219_of_match);
+#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id da7219_acpi_match[] = {
-- 
2.25.1

