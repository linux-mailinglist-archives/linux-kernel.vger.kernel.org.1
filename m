Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28E52F7119
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbhAODov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732642AbhAODou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:44:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF3FC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:32 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so3997681plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 19:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEcGePAoFBMEH4d16WagZZsbSiItfDYhk9eQpSDkRIk=;
        b=Xv/VoopIlhpPDTaZXWhUJSubJ7194wHJiA+DPMiM6GrPvyQKoTT7oX52iV9fm+cLGO
         LEpTIEtuI+2XvvH7qPvgJAlLr3pJ8z/TDjomiVFipG1nTS7WP6Kz30rDrs7AoSBwz8dW
         U9NARIqZNqA9ZDZ7Fpk0dafYrQc3y5WRuAzVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEcGePAoFBMEH4d16WagZZsbSiItfDYhk9eQpSDkRIk=;
        b=GU0z9pl8MqCi7fZgdK8tvoMzztyUEvPYnilP9o3JBEsu0o+fOhn/pVWImveVEASk19
         /LlLW+dNOB5oOxvba8wt6HjWrTw7FpW6DBLxwoSXuV45nUIUllFGCMlfdmK/84rkWYMv
         i9agXTeztGXJZ8/lZaZpCw+Tsk27g/kcSFF+qw5jh7x3tXvkkQmeBL206Glglmo9i/DZ
         Vh5P0yCb0+amp1o+OJaCkUwTCnIXZCD5D5ER5Ka6IPpiaeQDU6zsEnCRf51HieXmUXxI
         w64eNY3xDaxbnmfuzVz429avZrcRxDMZOp/HVaQYiJim8sDNfQykVKXi03Crm2udEZXu
         713g==
X-Gm-Message-State: AOAM530zxyWPeLktGvCNAVxwaAIh0KpUOk6TQsfBNL5VINKIuNWg0FUz
        MLKjdqOgAS4T8dH4YtkGhJ17UQ==
X-Google-Smtp-Source: ABdhPJxDvp9I0x93wxUPOVxBAF5Bcl1BTk4Q2oKk5fQ95NoxiwvSrD7NXUc79TFu6VwSIU6d6PzViw==
X-Received: by 2002:a17:90a:cb84:: with SMTP id a4mr8599334pju.50.1610682212225;
        Thu, 14 Jan 2021 19:43:32 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u12sm6499062pfh.98.2021.01.14.19.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:43:31 -0800 (PST)
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
Subject: [PATCH 2/4] ASoC: qcom: Add some names to regmap configs
Date:   Thu, 14 Jan 2021 19:43:25 -0800
Message-Id: <20210115034327.617223-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device can sometimes have multiple regmaps. Let's add a name so
that we can differentiate in debugfs more easily.

Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Cc: Srinivasa Rao <srivasam@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/qcom/lpass-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 8437ba31a306..40126202a4a3 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -474,6 +474,7 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 }
 
 static struct regmap_config lpass_cpu_regmap_config = {
+	.name = "lpass_cpu",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -674,6 +675,7 @@ static bool lpass_hdmi_regmap_volatile(struct device *dev, unsigned int reg)
 }
 
 static struct regmap_config lpass_hdmi_regmap_config = {
+	.name = "lpass_hdmi",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
https://chromeos.dev

