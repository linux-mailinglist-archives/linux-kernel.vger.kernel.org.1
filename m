Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09AA2B756B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgKREi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgKREi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:38:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C4C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:38:59 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so619159pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owERzaYqHwi5W3jNP2ap5wqI6aYFg8h8r6Iq4kQIegs=;
        b=O940nd56EF39C6shvsKKS7HBzyblt8tQFn/ktV4VByDF3Bk4MvBDHLBh6/6DWlKKb2
         3TKGn7hW4DPSD1Yoqk7hTzjznUzG8YnmM1jz+RF7xckxqITG1sWpbnUeBApKS507K4v6
         F6l1Hpgmi4AZL6YUSAnqGw34DuXTeMVLXekVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owERzaYqHwi5W3jNP2ap5wqI6aYFg8h8r6Iq4kQIegs=;
        b=Jxrm+qrZXQDroDrWy7kaZwCv+hvaP/l8J76JfS93Rf6Ljufa/e8NDeMI3/99dy0Bml
         z+J3C7c+SvH9xpc3nu4D3xJ34x1W9Dd7X79DD7CCrY+UeNRFGpAMtqorSuFCPvGwo7eB
         CaoAUP/nAxEklY92pKnePXH7ovQw91D1Gbkdf8vmU7MLBm8waWgIxEGSpqkiF5wstT+P
         I2RV0nGQTw4PWVm7NTjGO6/rS3IXd58Gomfv7yzuk7ADNt2DbJieMWRlPtgYcCmgo4A0
         aXjmt12+O584DsUPxUFEiWqEmX5miZlpx8jdUo6VUK76upprypBHMDCPKP1hqpz+aPyQ
         /+Qg==
X-Gm-Message-State: AOAM531irQvRIlA4zhBllkTBKDb2SbCBOiARkqLTIiJ+h7Hs2N/lhHiZ
        ZUnXdgViOJkHChMkEYNmsscg59L7M/tiKQ==
X-Google-Smtp-Source: ABdhPJyLY/ULmYE7kL4z+NpXB7dygkTdqOpK+q9RIVgz26oFSNkBFFbemBEILFCvjOfFPaMHn/lqfw==
X-Received: by 2002:aa7:84d0:0:b029:18b:fac7:29b with SMTP id x16-20020aa784d00000b029018bfac7029bmr2744535pfn.29.1605674338308;
        Tue, 17 Nov 2020 20:38:58 -0800 (PST)
Received: from localhost ([100.102.99.29])
        by smtp.gmail.com with ESMTPSA id k7sm22725611pfa.184.2020.11.17.20.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 20:38:57 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivasa Rao <srivasam@codeaurora.org>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org, judyhsiao@chromium.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] ASoC: hdmi-codec: Get ELD in before reporting plugged event
Date:   Wed, 18 Nov 2020 12:38:52 +0800
Message-Id: <20201118043852.1338877-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In plugged callback, ELD should be updated from display driver so that
user space can query information from ELD immediately after receiving jack
plugged event.

When jack is unplugged, clear ELD buffer so that user space does not get
obsolete information of unplugged HDMI.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
Change from v1 to v2:
 - Report jack unplug event then clear ELD. This makes sure user will not get a
   cleared ELD during their usage of jack.

 sound/soc/codecs/hdmi-codec.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 403d4c6a49a8..e8410b2433de 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -692,10 +692,16 @@ static void plugged_cb(struct device *dev, bool plugged)
 {
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
 
-	if (plugged)
+	if (plugged) {
+		if (hcp->hcd.ops->get_eld) {
+			hcp->hcd.ops->get_eld(dev->parent, hcp->hcd.data,
+					    hcp->eld, sizeof(hcp->eld));
+		}
 		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
-	else
+	} else {
 		hdmi_codec_jack_report(hcp, 0);
+		memset(hcp->eld, 0, sizeof(hcp->eld));
+	}
 }
 
 static int hdmi_codec_set_jack(struct snd_soc_component *component,
-- 
2.29.2.299.gdc1121823c-goog

