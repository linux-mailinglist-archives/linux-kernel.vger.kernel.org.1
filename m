Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13422D236D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLHGFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 01:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgLHGFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 01:05:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B10EC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 22:04:22 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so12867348pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 22:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMuZSE/uoFYolW2OlTfv3RER4FPEswrWEWDqIA4AjXQ=;
        b=Qyoemjm4Cg39/yxDoF8iiqYCMs1sPutlX9o+JmeiG9ZmSBixbBCSYKnEtRR2dUB9uQ
         fOs1eIl4DYk0FSY1Q8Pe1h1nvh3nPi7I71EFegeWGw9gmukg9mCWzgxwp2TXX/0FKtGp
         GMhrNRNvbHHz5YhxyDPIjkrxmppVffuUaiyj9SMO0YAc4ul7QoArir3saw32T0PqVR9L
         ScL5nugtH6t2XBuvLgoBrDR+o2EmkeqvRHRosE2+GDL5DegYFeezOk0ci2eF42cW/sQN
         Izxgj0a3GFjErxSXkai1Of2J7KPa6xRSrHt+6Bx1bJNSxKqr2zVCNhT4+8Ro+dYmVJjP
         EeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMuZSE/uoFYolW2OlTfv3RER4FPEswrWEWDqIA4AjXQ=;
        b=aU+WwAggroxY0sLemrgZERRXXqL+gb9X30N+i+7K+vCmQ2pxq797ocd072UbU8Q6fG
         nxsy8xoGoyyLfRoL5hzVrT5ZlSuanOKg/09ASzxag/jGdYN+n6UpS6pz/XacQJ7dpluh
         3FDX5WrNGBcmnI7hKol+nCtZv6zvR+aW4EaJijGDKe4/S9M47oOtQ6VcGn5fpjnKgWa9
         +e/2FKewfS94Do9NdmVIhuTxkqSBD96BHGg5Ul4iP02Q+FYI+YgWxSRY1dVSglLio+Re
         EewV5EpTnQT5IznXet2WDQsoDaR0dvPZduwd86P3d8d6+Pf6JJqJRZLRJf5Oblp9qymk
         cACA==
X-Gm-Message-State: AOAM531PjUlYCLxxfwYI4PT/JojKJtk7LdsmqIrmX63PwnozePhyE1K4
        xpqDFKdMJnnUUjTDp7X8eHyXJQ==
X-Google-Smtp-Source: ABdhPJxx7alrk0jc+iLSK57paLZQN/zJcOWCv7kDfvNGIjWLPdejZP3xOKqO2/iPOTo4TggKi4kc3w==
X-Received: by 2002:a17:90b:19cf:: with SMTP id nm15mr2603816pjb.63.1607407461666;
        Mon, 07 Dec 2020 22:04:21 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id k189sm18632615pfd.99.2020.12.07.22.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 22:04:21 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for ARCHOS Cesium 140
Date:   Tue,  8 Dec 2020 14:04:14 +0800
Message-Id: <20201208060414.27646-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tha ARCHOS Cesium 140 tablet has problem with the jack-sensing,
thus the heaset functions are not working.

Add quirk for this model to select the correct input map, jack-detect
options and channel map to enable jack sensing and headset microphone.
This device uses IN1 for its internal MIC and JD2 for jack-detect.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f790514a147d..cd6f7caa43c8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -421,6 +421,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 140 CESIUM"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.20.1

