Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049F42F7115
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732639AbhAODoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732575AbhAODoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:44:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:31 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v3so3995439plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6He9tPGs+/ws70kmAFtHlq88pmaEAaoR8SLKcK4SNg=;
        b=GJ5Qhb9slRBrvf9Om96+ZSgwwXop709x4reSxdwYFvhArCZ3JxK8K7CppeVFX1E93P
         iR9hC/FsprYlbJQiI4OXZmTUdzuVCPNGkW4/EPu7ozcWyhUoB1s3D5RlZmEgqz0CzEb3
         FIeIrmAMceMKjNeUuMEJhBRyPr8WrCBDqZkoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6He9tPGs+/ws70kmAFtHlq88pmaEAaoR8SLKcK4SNg=;
        b=N7qRQCkN3Nxhg1zJRXJJWMTx/r12dSHGuVNG4x+lLiSXOlyN3xeFJZGppcUGDF78tj
         iDoKFeMT4wXc6Wg/CT43fXlg5kAO6uj8DKMkUMEInUcTMxf4bkx2n2WwzcmqRWDMUNaY
         QCKxPERkPQlVfqHfmbeVrPWzGgx32UqNJYCaNJeYrU/1h+wYXPYq/8Hfru4rU6+LmRLh
         z5ePaUHj8XztU/IS69PYhrLZi3a5YcbQI7uDvf8MTaB4277DNXT7c1PhxWQwyxIdU+Qt
         YmQYx16LtiU77FdAHloUBHipypJsXjNiWfnTKoIgIY4wSypHI5IjfomWHDYKakHMb4ro
         Nk/Q==
X-Gm-Message-State: AOAM533OUvdfpvV0NIsxO7kcxyBhtlbDqJS1gIAV+tEVXzhTYzV2pNMy
        0e5S28gPG1ne68UVLXJcMmtiyw==
X-Google-Smtp-Source: ABdhPJyBWMQFKo0YFElvC/23fia/mMyG6g/vnSyuo284t516we9EDHsMfA3/PLuEvFZ8ZcHDB4FoPg==
X-Received: by 2002:a17:90a:68ce:: with SMTP id q14mr8096304pjj.223.1610682210864;
        Thu, 14 Jan 2021 19:43:30 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u12sm6499062pfh.98.2021.01.14.19.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:43:30 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
        alsa-devel@alsa-project.org,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao <srivasam@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/4] ASoC: qcom: Remove useless debug print
Date:   Thu, 14 Jan 2021 19:43:24 -0800
Message-Id: <20210115034327.617223-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a left over debug print that tells us that HDMI is
enabled. Let's remove it as that's definitely not an error to have HDMI
enabled.

Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Cc: Srinivasa Rao <srivasam@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index af684fd19ab9..8437ba31a306 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -742,7 +742,6 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 		}
 		if (id == LPASS_DP_RX) {
 			data->hdmi_port_enable = 1;
-			dev_err(dev, "HDMI Port is enabled: %d\n", id);
 		} else {
 			data->mi2s_playback_sd_mode[id] =
 				of_lpass_cpu_parse_sd_lines(dev, node,
-- 
https://chromeos.dev

