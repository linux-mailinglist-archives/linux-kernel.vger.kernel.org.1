Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8B2A68E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgKDP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:57:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:49005 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgKDP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604505464; x=1636041464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1IXMDBOSCtaUZtiq9izDv17V26Pq9aWYb9Tw2O2fSxs=;
  b=DrjjstWEPmaf1C3NsZIb/ZUVi/GeBkN+FEndaX/j8MCKNQqVjY97ewO3
   5kPHGGDLEV+hcLK8y77s1iEHm7wUmy1+5RzOj26vtdhVQqJi5Q/SF2yRY
   KdwECorro4nuSVYH15+gAsi/+0HAHki14GM1StQ397mbKL31yEJY2Phoz
   IwyT3jcdDPYk/MA0ZmJqlLVcuZF/o6EJdt+EclGacDkO04iFSkt/iuCMG
   glhGkcOSoLPJMUJnHyaUrIBUWS9/EdxPJmNHduPulYj2etGzerqZmx1XK
   HrZSf3k3Y84nFaVxj1SB4BgQ25uzfQN2m1nkIZV7KWKWn1Xjp1fUiKovf
   w==;
IronPort-SDR: xmQk0RwZowrJeY6M1qYOR3nH7hBq/SFUF+bH3yXO4jsDjxPIRtmeRLh7IyMcx7f6vJBgDyTWtZ
 RL+ojKFAhSPa9MMv9a5RpWmut69xdcwpz2KEwJKNIZPIJ7Xg2uHhsB+bkwtBjZmvS7GGN/MyZI
 jcBtIJdLz50OLYiZ8D9JLvgHJzmXrsrnGhGoIVNhhbiNe5TdtWZgP+HMRPIaE0P4hkjyawhySB
 Cms0meRnCremStsCaNiNIIoqHTRHw477jNBZQG58GwARmfW2C3d/N3/5py9k74aHAtlsQzF7LY
 F40=
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="32405234"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2020 08:57:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 08:57:43 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 4 Nov 2020 08:57:40 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: mchp-spdiftx: Do not set Validity bit(s)
Date:   Wed, 4 Nov 2020 17:57:38 +0200
Message-ID: <20201104155738.68403-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Validity bits (bit 28) must not be set in order to have the samples
valid. Some controllers look for this bit and ignore the samples if it
is set.

Fixes: 06ca24e98e6b ("ASoC: mchp-spdiftx: add driver for S/PDIF TX Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 82c1eecd2528..3bd350afb743 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -487,7 +487,6 @@ static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
 	}
 	mchp_spdiftx_channel_status_write(dev);
 	spin_unlock_irqrestore(&ctrl->lock, flags);
-	mr |= SPDIFTX_MR_VALID1 | SPDIFTX_MR_VALID2;
 
 	if (dev->gclk_enabled) {
 		clk_disable_unprepare(dev->gclk);
-- 
2.27.0

