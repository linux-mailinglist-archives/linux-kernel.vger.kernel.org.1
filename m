Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE532BAFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKTQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgKTQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:18:15 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD7F22269;
        Fri, 20 Nov 2020 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889094;
        bh=SVTkXer6++N+JN1kO+v1cmoeZbcg8CF407Fu94SDoCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtH9RgMSF8NZ2dMy7kFcUemuXYl/0T5wMAN/eg7zn/CdCzMm1pET2dPDiJCx5dqBa
         SbJbT1H2G+I+kzk70Dv/mcBdQeyWSVAQ729HPXuGc73SF5kLcjH6+bzj8fDyPa+iA4
         DDbQFjvpkhoA0yT76SgMC6Ebb4Q6iqFZEH7DBt2w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 08/38] ASoC: qcom: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:16:22 +0100
Message-Id: <20201120161653.445521-8-krzk@kernel.org>
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

  sound/soc/qcom/lpass-apq8016.c:294:34: warning: ‘apq8016_lpass_cpu_device_id’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c   | 2 +-
 sound/soc/qcom/lpass-apq8016.c | 2 +-
 sound/soc/qcom/lpass-ipq806x.c | 2 +-
 sound/soc/qcom/lpass-sc7180.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 575e2aefefe3..cc8c3f929683 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -176,7 +176,7 @@ MODULE_DEVICE_TABLE(of, apq8016_sbc_device_id);
 static struct platform_driver apq8016_sbc_platform_driver = {
 	.driver = {
 		.name = "qcom-apq8016-sbc",
-		.of_match_table = of_match_ptr(apq8016_sbc_device_id),
+		.of_match_table = apq8016_sbc_device_id,
 	},
 	.probe = apq8016_sbc_platform_probe,
 };
diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 0aedb3a0a798..4ee1de6588bb 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -300,7 +300,7 @@ MODULE_DEVICE_TABLE(of, apq8016_lpass_cpu_device_id);
 static struct platform_driver apq8016_lpass_cpu_platform_driver = {
 	.driver	= {
 		.name		= "apq8016-lpass-cpu",
-		.of_match_table	= of_match_ptr(apq8016_lpass_cpu_device_id),
+		.of_match_table	= apq8016_lpass_cpu_device_id,
 	},
 	.probe	= asoc_qcom_lpass_cpu_platform_probe,
 	.remove	= asoc_qcom_lpass_cpu_platform_remove,
diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 832a9161484e..421d65a546f3 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -170,7 +170,7 @@ MODULE_DEVICE_TABLE(of, ipq806x_lpass_cpu_device_id);
 static struct platform_driver ipq806x_lpass_cpu_platform_driver = {
 	.driver	= {
 		.name		= "lpass-cpu",
-		.of_match_table	= of_match_ptr(ipq806x_lpass_cpu_device_id),
+		.of_match_table	= ipq806x_lpass_cpu_device_id,
 	},
 	.probe	= asoc_qcom_lpass_cpu_platform_probe,
 	.remove	= asoc_qcom_lpass_cpu_platform_remove,
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index bc998d501600..3f4efd050a29 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -293,7 +293,7 @@ MODULE_DEVICE_TABLE(of, sc7180_lpass_cpu_device_id);
 static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7180-lpass-cpu",
-		.of_match_table = of_match_ptr(sc7180_lpass_cpu_device_id),
+		.of_match_table = sc7180_lpass_cpu_device_id,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
-- 
2.25.1

