Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D462B5E37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgKQL0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgKQL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:26:11 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:26:11 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so15911388pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QH8l3HzZjblS+KPiXb77NBbNTh6S8myLIAJDUGNsj8=;
        b=O5bBWmVTPEBh/wG/pGQE0dEyVrFSP9Ty3BF956K66kZY8Ga5Bv0ZO+dPKZdFwQnUU6
         8Re+odTtvmBPW/Pe/ey4gvN2NwnMSTVjO0THOf/mTGSSmHPJE1u1htYGpGgjUweZl0hu
         Y3d/hvn8/ZvmSbXbLF2FhktSTDJEfHaB5FbPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QH8l3HzZjblS+KPiXb77NBbNTh6S8myLIAJDUGNsj8=;
        b=fxEy4Z+bHmDVcyMivKLRAnqa1qnbRD4o9/akrH+rK7scYeCjFxrvk9PqUkZNkDUvvW
         nLC5NPGtStwHGqCpkyarmnH6HjMr9R0DxFfR30oVUvGKABdCUmu7zpDhLvBN/q0EZiV4
         R8Ska9I3kGo3RMROcbkJ8Z4fluEIa5qYK3bJi1xxSWrKpynvKKjTwbo9fl+fCXZUt+Jb
         w89JrcGt/pLZ3W0g9shq1DdSgekhrymuZnJWK6Erf/j9vZ+jwJYtxuY1L/ZYGyPTEgA8
         uwPERItbMyVywAVeAqufsXQTwa5EZ6EKRpYBgkjzwqNAj3NkFt9cKLWcq3gCHoe/C/Pn
         yXLg==
X-Gm-Message-State: AOAM533XaveFu3A2rrcGJE7p204I9MWyh8QYI1L2ZU0JbjRtjbznuxwf
        NkG3Se2XwtsP9i6rGIjnnBp+rAoKYezpJw==
X-Google-Smtp-Source: ABdhPJyrnAjBQ/jtFgnI1ZSF/1TLY+kjZEhSgcrRqfC80FgaKc4a5J8gFviPhqMlAnXOMeI4QK8f7A==
X-Received: by 2002:aa7:9414:0:b029:18c:23f6:bc6d with SMTP id x20-20020aa794140000b029018c23f6bc6dmr18205106pfo.21.1605612370295;
        Tue, 17 Nov 2020 03:26:10 -0800 (PST)
Received: from localhost ([100.102.99.29])
        by smtp.gmail.com with ESMTPSA id t20sm2843368pjg.25.2020.11.17.03.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 03:26:09 -0800 (PST)
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
Subject: [PATCH] ASoC: hdmi-codec: Get ELD in before reporting plugged event
Date:   Tue, 17 Nov 2020 19:26:03 +0800
Message-Id: <20201117112603.210620-1-cychiang@chromium.org>
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
 sound/soc/codecs/hdmi-codec.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 403d4c6a49a8..f0e0e1836000 100644
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
+		memset(hcp->eld, 0, sizeof(hcp->eld));
 		hdmi_codec_jack_report(hcp, 0);
+	}
 }
 
 static int hdmi_codec_set_jack(struct snd_soc_component *component,
-- 
2.29.2.299.gdc1121823c-goog

