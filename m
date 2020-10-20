Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0029378E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbgJTJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:06:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392385AbgJTJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:06:01 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K91xnn019320;
        Tue, 20 Oct 2020 11:05:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=NZzu2K/oEgGHbi70pVpopywkpHKaiBZ4Zxl3bo9Olfs=;
 b=XYZuNQbEtfUOVgDytzvOn26G0q3yIPSasW1oziDkVRwDjie6UBT2ayjd59NHeISTaS4Q
 s8PFeqGu4xOihkZ/lHm/uAwV1cY8VEk8di7a6W6y9fYruQ8WlfbiV0LT4MV2DvNnyYSU
 g8c8y0SadqnurXcckZvZj1WpA3cmK3c149c8yfeXr+nkg6rJvmZ7dEzs9bCuDNaCwNON
 4ifFh3fn2f7JUcGaEmlc6ieyP9vFhrI7tIWcwReC8kTYO1GCFVs7hZeXi87dB44DMaJu
 juLE6QyLQPkiaieKKSjl+hcZG3qvVmD3hGYpKvJn5ON/hFuLThnowLwv/FDI4HAHPWBr hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 347pcwse1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 11:05:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6843B10002A;
        Tue, 20 Oct 2020 11:05:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36D882BCA3D;
        Tue, 20 Oct 2020 11:05:24 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct 2020 11:05:23
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <arnaud.patard@rtp-net.org>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH] ASoC: cs42l51: manage mclk shutdown delay
Date:   Tue, 20 Oct 2020 11:04:57 +0200
Message-ID: <20201020090457.340-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_04:2020-10-20,2020-10-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A delay must be introduced before the shutdown down of the mclk,
as stated in CS42L51 datasheet. Otherwise the codec may
produce some noise after the end of DAPM power down sequence.
The delay between DAC and CLOCK_SUPPLY widgets is too short.
Add a delay in mclk shutdown request to manage the shutdown delay
explicitly. From experiments, at least 10ms delay is necessary.
Set delay to 20ms as recommended in Documentation/timers/timers-howto.rst
when using msleep().

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
Recommended Power-Down Sequence:
(see https://statics.cirrus.com/pubs/proDatasheet/CS42L51_F2.pdf)
1.    Mute the DACs and ADCs.
2.    Disable soft ramp and zero-cross volume transitions
3.    Set the PDN bit to 1.
4.    Wait at least 100 μs.
The codec will be fully powered down after this 100 μs delay.
Prior to the removal of the master clock(MCLK),
this delay of at least 100 μs must be implemented after step 3
to avoid premature disruption of the codec’s power down sequence.
---
 sound/soc/codecs/cs42l51.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 097c4e8d9950..d151a1aa313e 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -254,8 +254,25 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
 		&cs42l51_adcr_mux_controls),
 };
 
+static int mclk_event(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	struct cs42l51_private *cs42l51 = snd_soc_component_get_drvdata(comp);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		return clk_prepare_enable(cs42l51->mclk_handle);
+
+	/* Delay mclk shutdown to fulfill power-down sequence requirements */
+	msleep(20);
+	clk_disable_unprepare(cs42l51->mclk_handle);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget cs42l51_dapm_mclk_widgets[] = {
-	SND_SOC_DAPM_CLOCK_SUPPLY("MCLK")
+	SND_SOC_DAPM_SUPPLY("MCLK", SND_SOC_NOPM, 0, 0, mclk_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cs42l51_routes[] = {
-- 
2.17.1

