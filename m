Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05E2DB9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLPETB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLPETB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:19:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C2C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:18:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so12199151plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 20:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQRIGP+PG0ZGJkN4c+NOuc/o2U0jNbHtsQVJKi1bUrA=;
        b=IaQ61WqqgZR/LZ5nzcnqn65kMZT/iS1vgHrAtwE8ZwXmgbY9wNxV619VptREtFKSZc
         apIe9BOoBBRAdXEqsw38cCXAmZooQxG3P6xADa/euQaVI5mtKueBdc7E+pl4yiS698ES
         yBq74qWOadPpsi6UIr0QZxtFnKOvwwwXdR8qFONAxnZuz5JiMBNEvspOA0rFzfh/zU9Z
         fcsszAHXXXzhvY4imvOTJnDY0xW8drcPA0/wnWtoZTmJKwZ3tSYt1pfpMZyv+QMkuhOe
         tBy22Wp0dF3hE4LIaE3ld/WlVaqE0boAV99jgdT1bxVJ1DdUpGKAkiGaz2VkroT6zr1E
         LUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQRIGP+PG0ZGJkN4c+NOuc/o2U0jNbHtsQVJKi1bUrA=;
        b=lsZDhCudDDMiPwF9vVJM1RQ/GAC+r+sm1urI40BgaGE9KCjsvRBbU1HuMQ720QrSQh
         YXi7JxQgta23+otZL2y0mHNXlcPUeXx8QV60UEaCDo29KEK1qePJbEpsOQDf8nHuDke8
         hUcLyzBoPLlG1DCIxuo072zF46yflCzF2t9mSklH3IDWf2yQIo3qFEOFlnnnPFuqqT2r
         vV3tXzu2GpqpzCNkzhTbK75FAkR5+oHCfxO+dRsHxeagHC4qkJGtroR3lf5uungRpKfI
         WYomtrUYwmrZyXtkDlrDa8ogLnK20T4aylpvduNDsDBMkLTdkiEn/iPGLf0cnbjtAVfR
         IjMw==
X-Gm-Message-State: AOAM532hPnttNuydO9I7V14mA3xSDZTjSzP2qzv+rIRGccf4hUqYdSPX
        zBWsJCys74PkpBLQkHb1PcWFqg==
X-Google-Smtp-Source: ABdhPJywXM77ofwOhEKYkaEuA6j1U7P/GCEIQi4ZkFGZ+MZBzU+URw8DsUa7qttMpW/CqoWuOipkIA==
X-Received: by 2002:a17:902:850c:b029:da:e4a6:3641 with SMTP id bj12-20020a170902850cb02900dae4a63641mr920477plb.57.1608092300343;
        Tue, 15 Dec 2020 20:18:20 -0800 (PST)
Received: from localhost.localdomain (111-240-118-79.dynamic-ip.hinet.net. [111.240.118.79])
        by smtp.googlemail.com with ESMTPSA id 37sm442703pjz.41.2020.12.15.20.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 20:18:19 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
Date:   Wed, 16 Dec 2020 12:16:01 +0800
Message-Id: <20201216041601.5993-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
quirks to select the correct input map, jack-detect options to enable
jack sensing and internal/headset microphones.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 688b5e0a49e3..9df09e26b05a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_SSP0_AIF1 |
 					BYT_RT5651_MONO_SPEAKER),
 	},
+	{
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
+		},
+		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
+	},
 	{}
 };
 
-- 
2.20.1

