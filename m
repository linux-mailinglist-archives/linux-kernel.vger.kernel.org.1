Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA42C45BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgKYQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbgKYQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:45:51 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8588E21D7F;
        Wed, 25 Nov 2020 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606322750;
        bh=68bJ8rSvPKEOquLrHU6PV1GQ5+jCM3ciFXGFU+bh9Bk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KFlrcIatgL0kXEZArSXaPAysEnZ03VUxlj3MjPv8qI2o7EzvezkyNOBYX2J7ftYAL
         QGX4PshwKmY1fQ3uN+tQ2/9mz4rd9KX3MZ6MJJKYyvRiBWnAe7lPI14qkasmpLReoq
         ztg9SuV0MFaunIdMfVHS/pglHdz0PmYxL5bdzuB4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 09/39] ASoC: qcom: mark OF related data as maybe unused
Date:   Wed, 25 Nov 2020 17:44:22 +0100
Message-Id: <20201125164452.89239-10-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125164452.89239-1-krzk@kernel.org>
References: <20201125164452.89239-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  sound/soc/qcom/lpass-apq8016.c:294:34: warning: ‘apq8016_lpass_cpu_device_id’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c   | 2 +-
 sound/soc/qcom/lpass-apq8016.c | 2 +-
 sound/soc/qcom/lpass-ipq806x.c | 2 +-
 sound/soc/qcom/lpass-sc7180.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 575e2aefefe3..270986b2f102 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -167,7 +167,7 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
-static const struct of_device_id apq8016_sbc_device_id[]  = {
+static const struct of_device_id apq8016_sbc_device_id[] __maybe_unused = {
 	{ .compatible = "qcom,apq8016-sbc-sndcard" },
 	{},
 };
diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 0aedb3a0a798..8507ef8f6679 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -291,7 +291,7 @@ static struct lpass_variant apq8016_data = {
 	.free_dma_channel	= apq8016_lpass_free_dma_channel,
 };
 
-static const struct of_device_id apq8016_lpass_cpu_device_id[] = {
+static const struct of_device_id apq8016_lpass_cpu_device_id[] __maybe_unused = {
 	{ .compatible = "qcom,lpass-cpu-apq8016", .data = &apq8016_data },
 	{}
 };
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 832a9161484e..92f98b4df47f 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -161,7 +161,7 @@ static struct lpass_variant ipq806x_data = {
 	.free_dma_channel	= ipq806x_lpass_free_dma_channel,
 };
 
-static const struct of_device_id ipq806x_lpass_cpu_device_id[] = {
+static const struct of_device_id ipq806x_lpass_cpu_device_id[] __maybe_unused = {
 	{ .compatible = "qcom,lpass-cpu", .data = &ipq806x_data },
 	{}
 };
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index bc998d501600..86df8a7c6635 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -284,7 +284,7 @@ static struct lpass_variant sc7180_data = {
 	.free_dma_channel	= sc7180_lpass_free_dma_channel,
 };
 
-static const struct of_device_id sc7180_lpass_cpu_device_id[] = {
+static const struct of_device_id sc7180_lpass_cpu_device_id[] __maybe_unused = {
 	{.compatible = "qcom,sc7180-lpass-cpu", .data = &sc7180_data},
 	{}
 };
-- 
2.25.1

