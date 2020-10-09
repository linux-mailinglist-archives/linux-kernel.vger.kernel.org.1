Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CD2888E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgJIMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:35:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:51160 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgJIMfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602246947; x=1633782947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AESnrxLmZbTnhnd7ZMZRicXeBptBo7pSE9m/WI+ocoU=;
  b=AarrrWRc70aAGbh8njBQKxfrsNncOzSOsAQW4uFMw2wsO6H0mZQWJaoh
   LafCQF0p9lc4yaQcSrAQhz05wO1SnJoWSv37vQigkntUjNKk7kXbdz2P5
   lOIW7gTsHaIS1Jz47s8KCG07BV3DteDINUkzLFTK0r+zFNAdHtB50vmPC
   Pz2G+GX/G9NM2U5bJ4/IEtbLrf8CRDKhaktwTQgYYh2rtZNC0goqojbvi
   sZQuYpa75TPWjEXnzIErfbMF72XHmEB0Ty5s6NmZy9p7GnfxWqxYt8hXK
   NC+HNn4/TJHc/J9l/J2DX3h9PHAeaGr/+wr2UW432Fw5+Um3f609/SHHm
   g==;
IronPort-SDR: CNb0lpvZ8TrLUpmO2ImDhgrCrYBTvSGcOL+6Csja67DEwSRm/D9S8DaCVgQGkv1RWjp2pM4vU9
 90uPw06o5llwOZuiS6jxsT3H8NzbfZVPerBtg+y7pxMQK/Z5Vyn5gheX8rsAe7KSFR29WonilI
 hMU1oY6jG8ubrmBRKgDv6FayEs0OV+WDtOJNomQ5ta65cULTjaOXqxGik2m3G3eruCFIWOtkG6
 m3+IUqhiM5dd07il/CYFX33//aKTO0+FNAvGXx0OiuUUOLrTYGHldoq0kcF21rF/VgSbV4VFuX
 XuU=
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="89704623"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Oct 2020 05:35:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 9 Oct 2020 05:35:13 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 9 Oct 2020 05:35:02 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: mchp-spdiftx: remove 'TX' from playback stream name
Date:   Fri, 9 Oct 2020 15:35:27 +0300
Message-ID: <20201009123527.2770629-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not include the 'TX' in the stream name since it's obvious for
playback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 36c23eb3a5ad..82c1eecd2528 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -744,7 +744,7 @@ static struct snd_soc_dai_driver mchp_spdiftx_dai = {
 	.probe	= mchp_spdiftx_dai_probe,
 	.remove	= mchp_spdiftx_dai_remove,
 	.playback = {
-		.stream_name = "S/PDIF TX Playback",
+		.stream_name = "S/PDIF Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = MCHP_SPDIFTX_RATES,
-- 
2.25.1

