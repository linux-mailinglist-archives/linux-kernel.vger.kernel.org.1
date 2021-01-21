Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F352FF19E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbhAURSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbhAURRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:17:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EADC061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:16:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g3so3695414ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R37OwwWmnd3gx+4QWJQscKseQ469mdd6BDRuEqSONlc=;
        b=CWn25tIicWFL5R/EoP0Lw4d3jigOs6L3lg+H8SEmtOHGMseHtmldYRKeFKZ4IZZPFI
         FbX562x4NKV151mntW0uUcYzfQm7qac71gge153zpsQH6FIr5EtA5YBEBr412WLSwoFP
         ucz1a79Zr9a8/QFF/N0/vZt2L6smCUZGQAxi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R37OwwWmnd3gx+4QWJQscKseQ469mdd6BDRuEqSONlc=;
        b=sAi1kSpW5SW3gsuziJ5LCUOJ8/ACMh7DJ2ebry55244NcEAWJp+XR7J3V+HDgDE7FJ
         t8AG/3X5yT7f6tkOC2F99O7WhIunu74GuyjidKaz8+ufQxsbPSbn2xmteqBdUiFOPjNZ
         D+4OL39xLoT69c4TY61ZmCm+SNv1BR045IRmzP0BBPzN5dE2WQBsg3oBtw67Aglq4Lu2
         ZYcrs8ggIOeEN751EN+7P9d1mizFOmsekvH5WW3+fTYoKoJ2PMMcjEmaixHIYKeOWAxQ
         boXadliXMZgQr9SnMFwgajmwHQ7vjBakGjZwgWHdlcMWB3PcEQS88FsyDzpnMnTmiRZd
         c6Zw==
X-Gm-Message-State: AOAM531lJwR/UttpqW+nebcf7WW1N8gCJenCSwjA3/FtFQBc4E42Nued
        Au9OHmo8MbLR5oR8ev8d3MwHWw==
X-Google-Smtp-Source: ABdhPJy+x6N7BHDOHH5vuQVEJdyydy2XancBgQi0eaeXii6q/njzBaQIRBAtjMRzAtrBnRx1Lvo4BA==
X-Received: by 2002:a17:906:eb12:: with SMTP id mb18mr309753ejb.257.1611249407746;
        Thu, 21 Jan 2021 09:16:47 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id q9sm2484024ejd.113.2021.01.21.09.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 09:16:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
Date:   Thu, 21 Jan 2021 18:16:44 +0100
Message-Id: <20210121171644.131059-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
In-Reply-To: <20210121171644.131059-1-ribalda@chromium.org>
References: <20210121171644.131059-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear struct snd_ctl_elem_value before calling ->put() to avoid any data
leak.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 1ef30ca45410..b824086203b9 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3632,7 +3632,7 @@ static void skl_tplg_complete(struct snd_soc_component *component)
 		sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
 
 		for (i = 0; i < se->items; i++) {
-			struct snd_ctl_elem_value val;
+			struct snd_ctl_elem_value val = {};
 
 			if (strstr(texts[i], chan_text)) {
 				val.value.enumerated.item[0] = i;
-- 
2.30.0.296.g2bfb1c46d8-goog

