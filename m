Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EA32DD3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgLQPJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:09:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87760C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:08:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d17so38365008ejy.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75RY4vD+6THVdf7SYejRYxpjyXMqUmJXh8IKgMSDeyE=;
        b=BND8Hy/YuYhie9i+NkI9RB7uFYLhDW7+EAITvHsZH3alEam0zMy38AE88QEdICAXJ0
         OtYI/GROdhnmInH4DWuXCFwm1VYo1Si5Lf3azEQZxpMmad675ymUMVBRs1pGhNLJDdIb
         oLzmO8wTlDhfw48rFKn2+ixfWN1MoqOckgSFeRkuRLpMztuYtTQdajwFauhrmqkyYNZ1
         CnxHKAjIntusZNjXWhsEPARlrovuOrNRS2HMJugNtPbbhOeXgypnarDs5guIrmqyHv5V
         83uJ6TfIAUeky8ja7GFMf3/DirrtAvEk8OlOpipWHiPJSDl+a4K+jk+14sop+7JhUwg6
         q71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=75RY4vD+6THVdf7SYejRYxpjyXMqUmJXh8IKgMSDeyE=;
        b=FaUfxYJMsDi+iu1YIPyFeGKRcrCXGerlhwb1PjiKFUSrsxqJ19ZW5QUhg2++gS4qP3
         mZhtSzb8Xl6enBsqjObx6BefnTLKc1RdNc5M+SndYHejoEh6xEE4lhMw9vLRZcQhZj1c
         iqrkFE5zH5XCup7GM4PACnSnI8V50Ul3eNDYZHpGj7J/7PS4It3fPdkK7MCarMXQXfFd
         gklJWN7YsKujnylt4rAb8R11LhFWEXhA3w6gkWBxK8tJFh9jITJAXz1HJI7+ryqwDDSt
         eMGlxfcj1KWrnMELcEKE5ntopYML4Tgp23Kd07tf/2ipZHrY2rdEbiLIrHRkCmiBzcB+
         gfPw==
X-Gm-Message-State: AOAM533d2NIjjsZf55rWZepcvd6EzghLkLVADGuWdcaKA9sjPvn52Xah
        CjRVnxWCGN4LVB/wT2ZzxrgvxA==
X-Google-Smtp-Source: ABdhPJzyByES9hNl/qPTywwPhbSF8tJ9xCc6PxSLb3zjXhePzkuCgK6L07hmA6u74KYHBNJCULd9SA==
X-Received: by 2002:a17:906:ca08:: with SMTP id jt8mr348286ejb.368.1608217702290;
        Thu, 17 Dec 2020 07:08:22 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id hb18sm3982411ejb.86.2020.12.17.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 07:08:21 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: meson: axg-tdm-interface: fix loopback
Date:   Thu, 17 Dec 2020 16:08:12 +0100
Message-Id: <20201217150812.3247405-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the axg-tdm-interface was introduced, the backend DAI was marked as an
endpoint when DPCM was walking the DAPM graph to find a its BE.

It is no longer the case since this
commit 8dd26dff00c0 ("ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks")
Because of this, when DPCM finds a BE it does everything it needs on the
DAIs but it won't power up the widgets between the FE and the BE if there
is no actual endpoint after the BE.

On meson-axg HWs, the loopback is a special DAI of the tdm-interface BE.
It is only linked to the dummy codec since there no actual HW after it.
From the DAPM perspective, the DAI has no endpoint. Because of this, the TDM
decoder, which is a widget between the FE and BE is not powered up.

From the user perspective, everything seems fine but no data is produced.

Connecting the Loopback DAI to a dummy DAPM endpoint solves the problem.

Fixes: 8dd26dff00c0 ("ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks")
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index c8664ab80d45..87cac440b369 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -467,8 +467,20 @@ static int axg_tdm_iface_set_bias_level(struct snd_soc_component *component,
 	return ret;
 }
 
+static const struct snd_soc_dapm_widget axg_tdm_iface_dapm_widgets[] = {
+	SND_SOC_DAPM_SIGGEN("Playback Signal"),
+};
+
+static const struct snd_soc_dapm_route axg_tdm_iface_dapm_routes[] = {
+	{ "Loopback", NULL, "Playback Signal" },
+};
+
 static const struct snd_soc_component_driver axg_tdm_iface_component_drv = {
-	.set_bias_level	= axg_tdm_iface_set_bias_level,
+	.dapm_widgets		= axg_tdm_iface_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_tdm_iface_dapm_widgets),
+	.dapm_routes		= axg_tdm_iface_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_tdm_iface_dapm_routes),
+	.set_bias_level		= axg_tdm_iface_set_bias_level,
 };
 
 static const struct of_device_id axg_tdm_iface_of_match[] = {
-- 
2.29.2

