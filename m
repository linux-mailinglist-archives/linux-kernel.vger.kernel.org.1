Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA7293F26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406819AbgJTPCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:02:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39022 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405917AbgJTPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:02:18 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KEvgm6012136;
        Tue, 20 Oct 2020 17:01:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=XgCfUqxaOYwvz9RDx21gH1OGoREoJaNipM7JO27tcpQ=;
 b=pcALPfUlGTVlYjzgy9lQZOr9M/jywqlaRBDLx7FCwCeHIRBaIgXSyKKlk+EEwGcb0jca
 BxSCCUZQTF7U/ZpEN38ebvJPyOa1hdY37nyUHTziP2vgc50Z/XGd08CW7nHJUThXljuX
 ilcRlNsaQKIfHIiA3zVD9xhKpPmKRKkm+9d3+2PK+RYIF8M+fuSBCgP2JVBUBCd0ti0f
 0FaZmGfEURtGM6jFgvSa2V/PrDAlVdO52WRtVnmcJjXSksWL4TlT+i0TOO3sAPQfrRlu
 rpxMtUe2vvNDRem4vYgoIwpPNWh4YQ6KJUgatqCG3PpqJYrFKX8ZnBNQbRZ501/M7ONd Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 347qgg4432-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Oct 2020 17:01:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BA2910002A;
        Tue, 20 Oct 2020 17:01:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 30F6B2E6D30;
        Tue, 20 Oct 2020 17:01:20 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct 2020 17:01:19
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>,
        <arnaud.patard@rtp-net.org>, <olivier.moysan@st.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH v2] ASoC: cs42l51: manage mclk shutdown delay
Date:   Tue, 20 Oct 2020 17:01:09 +0200
Message-ID: <20201020150109.482-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_08:2020-10-20,2020-10-20 signatures=0
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

Changes in v2:
- Manage explicitly DAPM events through a switch case in mclk_event()
---
 sound/soc/codecs/cs42l51.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 097c4e8d9950..c61b17dc2af8 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -254,8 +254,28 @@ static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
 		&cs42l51_adcr_mux_controls),
 };
 
+static int mclk_event(struct snd_soc_dapm_widget *w,
+		      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
+	struct cs42l51_private *cs42l51 = snd_soc_component_get_drvdata(comp);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		return clk_prepare_enable(cs42l51->mclk_handle);
+	case SND_SOC_DAPM_POST_PMD:
+		/* Delay mclk shutdown to fulfill power-down sequence requirements */
+		msleep(20);
+		clk_disable_unprepare(cs42l51->mclk_handle);
+		break;
+	}
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

