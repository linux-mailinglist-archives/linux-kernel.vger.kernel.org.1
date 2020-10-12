Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68428BAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbgJLOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:19:28 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57107 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389085AbgJLOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602512366; x=1634048366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ulG6U2sw9bZhlzrRm51TWflIWae4pvw9z+rp09VqJs=;
  b=He7FkcZRkaq14Bgid/lJISX9w9JWR2V44Mrmvv4e0oL8kT4VjUZs4Ujj
   A4yNZMgGrcU6ZTLPhuYNL8GFjlPG2aGzQgmDKFpb7xshOk1jGXgvj9PEC
   HTL/XNgXs3jUhZNSOMVPDZoqi56wde5cayXhBRTQ3L2ZxQDQgYGE2oxr4
   WLx8YJKVK3/DdCQo7wyeOKfHpyiU6E5Fp6Wqz7FgR/vLiPHdQobN+IPfv
   /uWHip+M5DJ+Mp1bmdVThtOzxYQHTlDnAddj9MmNbp8x0k8iZ1ZnoqgpN
   P6gkXwuJ7lc6E6L7QxJhfKzTy/4r5ds4ugMwYUHMKhqN6H8vlxf7rVEIY
   A==;
IronPort-SDR: Rskd0N6eBXq3JGNtMY8g5/EBEivDeHBx9G8ELiv0ZE6I7LXTbKm4nZyau2x+WK7wAbh67R/X2B
 l2PwWpMhgLHrijNuKJNfGuZScnHIr5TnJW0OAirWBCo4Zd7pxT4xwW33VxNcOO0VcH8ol6jQpm
 LyeDyO9etjLRZAZzf9mVaGDIDINQXa0qkUv3EdD/d8Ri36gq0pzRrzZlcgWR0WTXKzFhFfsRFM
 Y263uk+1wkFt0MzRa0Ow8ZUHtFZ8Pc7pOFzXY5RK1mTTsL42QOoy5SrNUHKh/DbYp4lxvi+f9U
 LKw=
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="95020754"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Oct 2020 07:19:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 12 Oct 2020 07:19:25 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 12 Oct 2020 07:19:20 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <florian.meier@koalo.de>,
        <kernel@martin.sperl.org>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: pcm5102a: Make codec selectable
Date:   Mon, 12 Oct 2020 17:19:11 +0300
Message-ID: <20201012141911.3150996-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI PCM5102A codec driver can be used with the generic sound card
drivers, so it should be selectable. For example, with the addition
of #sound-dai-cells = <0> property in DT, it can be used with simple/graph
card drivers.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a..5791b7056af6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1003,7 +1003,7 @@ config SND_SOC_PCM3168A_SPI
 	select REGMAP_SPI
 
 config SND_SOC_PCM5102A
-	tristate
+	tristate "Texas Instruments PCM5102A CODEC"
 
 config SND_SOC_PCM512x
 	tristate
-- 
2.25.1

