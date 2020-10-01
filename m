Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8E2806AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgJASfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJASfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:35:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D7C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NLKA4WpPXheXIY0bbRPMMEUjTjZjozvEydHHIexa+Yk=; b=g/TbC4YbQPH8dALRZx/yj1WJ05
        upa+c9yNoUfwo2RdfDzMsrOlaZSYbuyPQaTvA31dSkO4W1GRTbKLT4XPn4Qp5tvXHDv820PE6tZzL
        sbLcNcaBT/WdBuorAf7p0Sk14FX+bhU9rNXsNKkP3JYN89+F3eogNZmaOKSLXV7gnZ2NCQzHlElYA
        Y/UeEfNV5jt8HRApWBqtM3KafedS14M/8B2CJYbhFR77TsUiuzSsycYLk4EYKK0iR9puVSoG0NbkO
        yDCptntIPc4IEWuUJCQNCFtN70Lbom/o7/KIOB3xI/7a/t7mrlSpJYx+OllGPj9bjKTnuXA7C2r8k
        NMefPFow==;
Received: from [2601:1c0:6280:3f0::863] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kO3Qb-00050P-UE; Thu, 01 Oct 2020 18:35:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH -next] ASoC: qcom: fix SDM845 & QDSP6 dependencies more
Date:   Thu,  1 Oct 2020 11:35:37 -0700
Message-Id: <20201001183537.5781-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error and Kconfig warning in sound/soc/qcom/.

ld: sound/soc/qcom/qdsp6/q6afe-clocks.o: in function `q6afe_clock_dev_probe':
q6afe-clocks.c:(.text+0x182): undefined reference to `devm_clk_hw_register'
ld: q6afe-clocks.c:(.text+0x19d): undefined reference to `of_clk_add_hw_provider'

After adding "depends on COMMON_CLK" for SND_SOC_QDSP6, the Kconfig
warning appears because "select" does not honor any "depends on"
clauses, so fix the dependency for SND_SOC_SDM845 also.

WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
  Selected by [y]:
  - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && I2C [=y] && SOUNDWIRE [=y]

Fixes: 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/qcom/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201001.orig/sound/soc/qcom/Kconfig
+++ linux-next-20201001/sound/soc/qcom/Kconfig
@@ -82,6 +82,7 @@ config SND_SOC_QDSP6_ASM_DAI
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR
+	depends on COMMON_CLK
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
@@ -110,6 +111,7 @@ config SND_SOC_MSM8996
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
 	depends on QCOM_APR && I2C && SOUNDWIRE
+	depends on COMMON_CLK
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
