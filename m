Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38876278322
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgIYItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgIYIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:49:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BAFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so2673931wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFObvGVxUiO7ZQOKSb6NTaW6nVN+3z3dJw0CyCNRlFw=;
        b=bv1LJ7nuM0SfITtrDoZwsRoR2XvivIc7Ncyo8pRv5SIT5j/0a2E5Z2H7g3n00TFWI8
         PU7zBulgKoH+VVNkhVMIF95G42dy4K2DAHxrWOteeIJfLAvWTEcszXZcjfCKd9EcMy4y
         zJOqUj8euAPyDN1vbBZZcRdz9f/r6A83y+mc4ZeOm/eF94OOi55InVZ69MXWpZLo50kY
         DAww8Z1KGtOEcnC0j8+jKyP0SS3DFtTdRvbbeKhx4/R/DxUwbQiPk4BytijOeV+2dqWD
         VSUhk0wk/tC3FFOQ31Thz0MhXM/KUOxfMPrycqrMHlEW9y8WpFTqDTjMocGoP44tMHT4
         MXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFObvGVxUiO7ZQOKSb6NTaW6nVN+3z3dJw0CyCNRlFw=;
        b=B960X/nwsvGPRw1JXzE00/qzw1k8lf8OS5hk2I5dIOOq0EWdSot1BuoHHbgVssNHho
         WrnYmemUIvIkQGr1JxIzOsCNOMiDWrEcCPIT1tg/ye4ydm0YcodXcxhqqBF9uJjcPuTb
         l9mUS11AZMGNicJnMpZ7ibmBYLEEW//M9eyTgh3i2Xz3ehJLyp3CcY0gUn1PaZMgs7QC
         TnGgJKLJEgPXFrdzGusPMRdoo7LTupsKDKfvppeJwRWXGJPBa3zAM4Vbyqmy/O2es7F0
         jCsLMBFp1JH9U/tCoRumW7WSxIjhwS/S/eHAZ6bDxn1sjv9GvhtddocpTg3W1S2Ep2Wt
         9Lcg==
X-Gm-Message-State: AOAM531DaHjCVPY93D0GICQ53xSxYJ4RjDZA05exi9MkX/6WGpi+GleI
        BJA6VpgmlZZrYFy5Pt54pjDYcg==
X-Google-Smtp-Source: ABdhPJxjOK6sUTocv5STTWTkchaKJQ0i+jcL5x/4vOJT76TjVE9/DpJ9ph6a42QoRnDBqC2D+pYn2A==
X-Received: by 2002:adf:f986:: with SMTP id f6mr3144816wrr.270.1601023775576;
        Fri, 25 Sep 2020 01:49:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u66sm2048623wme.12.2020.09.25.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:49:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ASoC: qdsp6: Drop of_match_ptr to fix -Wunused-const-variable
Date:   Fri, 25 Sep 2020 09:49:24 +0100
Message-Id: <20200925084925.26926-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
References: <20200925084925.26926-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_device_id is included unconditionally by of.h header and used
in the driver as well.  Remove of_match_ptr to fix W=1 compile test
warning with !CONFIG_OF:

sound/soc/qcom/qdsp6/q6afe-clocks.c:254:34: warning: unused variable
 'q6afe_clock_device_id' [-Wunused-const-variable]

Fix this warning for all qdsp6 drivers.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c        | 2 +-
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 2 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6afe.c        | 2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c    | 2 +-
 sound/soc/qcom/qdsp6/q6asm.c        | 2 +-
 sound/soc/qcom/qdsp6/q6core.c       | 2 +-
 sound/soc/qcom/qdsp6/q6routing.c    | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 2f3ea6beb066..23611db59d5e 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -623,7 +623,7 @@ static struct apr_driver qcom_q6adm_driver = {
 	.callback = q6adm_callback,
 	.driver = {
 		.name = "qcom-q6adm",
-		.of_match_table = of_match_ptr(q6adm_device_id),
+		.of_match_table = q6adm_device_id
 	},
 };
 
diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index 2967f4546af5..e652a69869f9 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -260,7 +260,7 @@ MODULE_DEVICE_TABLE(of, q6afe_clock_device_id);
 static struct platform_driver q6afe_clock_platform_driver = {
 	.driver = {
 		.name = "q6afe-clock",
-		.of_match_table = of_match_ptr(q6afe_clock_device_id),
+		.of_match_table = q6afe_clock_device_id
 	},
 	.probe = q6afe_clock_dev_probe,
 };
diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index d58b86a98114..ce39d97bbc13 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1698,7 +1698,7 @@ MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
 static struct platform_driver q6afe_dai_platform_driver = {
 	.driver = {
 		.name = "q6afe-dai",
-		.of_match_table = of_match_ptr(q6afe_dai_device_id),
+		.of_match_table = q6afe_dai_device_id
 	},
 	.probe = q6afe_dai_dev_probe,
 };
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 688878a002a4..bce4b2134c0a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1762,7 +1762,7 @@ static struct apr_driver qcom_q6afe_driver = {
 	.callback = q6afe_callback,
 	.driver = {
 		.name = "qcom-q6afe",
-		.of_match_table = of_match_ptr(q6afe_device_id),
+		.of_match_table = q6afe_device_id,
 
 	},
 };
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a1dd31f306ce..28f056c404bb 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -1343,7 +1343,7 @@ MODULE_DEVICE_TABLE(of, q6asm_dai_device_id);
 static struct platform_driver q6asm_dai_platform_driver = {
 	.driver = {
 		.name = "q6asm-dai",
-		.of_match_table = of_match_ptr(q6asm_dai_device_id),
+		.of_match_table = q6asm_dai_device_id,
 	},
 	.probe = q6asm_dai_probe,
 };
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index d745a02fcd5f..34a6e894242e 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -1745,7 +1745,7 @@ static struct apr_driver qcom_q6asm_driver = {
 	.callback = q6asm_srvc_callback,
 	.driver = {
 		.name = "qcom-q6asm",
-		.of_match_table = of_match_ptr(q6asm_device_id),
+		.of_match_table = q6asm_device_id,
 	},
 };
 
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index ae314a652efe..99fe36447525 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -366,7 +366,7 @@ static struct apr_driver qcom_q6core_driver = {
 	.callback = q6core_callback,
 	.driver = {
 		.name = "qcom-q6core",
-		.of_match_table = of_match_ptr(q6core_device_id),
+		.of_match_table = q6core_device_id
 	},
 };
 
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index b12539fae6ed..cc731c19a8ab 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -1152,7 +1152,7 @@ MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
 		.name = "q6routing",
-		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
+		.of_match_table = q6pcm_routing_device_id,
 	},
 	.probe = q6pcm_routing_probe,
 	.remove = q6pcm_routing_remove,
-- 
2.21.0

