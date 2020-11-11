Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C102AFA11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgKKUyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:54:38 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:54:37 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so3454251otc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 12:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VgpeWsRTTojekaZd0nKJIZviZMfkuw29mtRuDlp4Q38=;
        b=ueclBL5aYloNM73FTRpAK46UaQtvV4N9obrKltg66JadAKp9kzv2yThjqZNLeAVU5+
         ImPGB4Wrz8k4VnRPx3COlhBID/uCFV1U2ytFIGuvXORDLoJ8t3BYJeNgA5DAItJ8HwWj
         SHuVV3qNKWlWuoq4wYRDIyChUgyZP9U0/tK+8oJBw/X+KJb0LI0WrTG/y9zOnwDvMXt7
         d7zMYfJZcfD/oC2oQwKC9GtHxu7Euv1FeVQizLbwhnsT3EuSDR8qLkJjuqKIVJC5kSMm
         AKPB32BuzpOz9gwT0kbt30kMpCTNrQeFKzPAGVhZ6xyqhfCDKhvI1VR5PJKFV5q7CiZP
         /oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=VgpeWsRTTojekaZd0nKJIZviZMfkuw29mtRuDlp4Q38=;
        b=fifThd88yZQPjcETYo69CrXx578zDok8oNnXKkE99Xwt91OMpMS4W4s+Z48ypGWavk
         fGRzoFBpGjpr4H3nsh0AYsPvFSjT/2GKpCdUt7qmHwRSXCg/5BsOY9uE1ZUp64r5nGsw
         CYcq+IZRSJi+hYjgdcHmsJofIKmXPwC3R/K98XBifyVk5tveX5oPazahMbeBXOfFYUAc
         +eeEy5qwRqx/RKa4mXEQ2Ij5xDdY1Cfn76vQqcvEF3oV2+1j2ZwaQVxR3snSwiTQ3YGF
         SdUI4dsNlRqJYO9B//VpI6E+3pEvc7/sySthGnEt6TAbTSYpanSRNTCpwTTlS5xwxg7l
         qE4w==
X-Gm-Message-State: AOAM533U6leG0YBVTyiTEac0GNo+BFoFIRbmgS2zWFb04MT0SZ3SUxQP
        KNZA3FsgE/KydqcCJ3OOR8M=
X-Google-Smtp-Source: ABdhPJw6aPFYn8VWrBcJU1RgKXK7hcAi8FtKraIiknX01BQ4W8eGnJ7DJs6qh75SuuP4AobdzvaXyA==
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr19495062otd.192.1605128077307;
        Wed, 11 Nov 2020 12:54:37 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p126sm651793oia.24.2020.11.11.12.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 12:54:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to disable disabled clock
Date:   Wed, 11 Nov 2020 12:54:34 -0800
Message-Id: <20201111205434.207610-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kabylake_set_bias_level(), enabling mclk may fail if the clock has
already been enabled by the firmware. Attempts to disable that clock
later will fail with a warning backtrace.

mclk already disabled
WARNING: CPU: 2 PID: 108 at drivers/clk/clk.c:952 clk_core_disable+0x1b6/0x1cf
...
Call Trace:
 clk_disable+0x2d/0x3a
 kabylake_set_bias_level+0x72/0xfd [snd_soc_kbl_rt5663_rt5514_max98927]
 snd_soc_card_set_bias_level+0x2b/0x6f
 snd_soc_dapm_set_bias_level+0xe1/0x209
 dapm_pre_sequence_async+0x63/0x96
 async_run_entry_fn+0x3d/0xd1
 process_one_work+0x2a9/0x526
...

Only disable the clock if it has been enabled.

Fixes: 15747a802075 ("ASoC: eve: implement set_bias_level function for rt5514")
Cc: Brent Lu <brent.lu@intel.com>
Cc: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 922cd0176e1f..f95546c184aa 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -700,6 +700,8 @@ static int kabylake_set_bias_level(struct snd_soc_card *card,
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (dapm->bias_level == SND_SOC_BIAS_ON) {
+			if (!__clk_is_enabled(priv->mclk))
+				return 0;
 			dev_dbg(card->dev, "Disable mclk");
 			clk_disable_unprepare(priv->mclk);
 		} else {
-- 
2.17.1

