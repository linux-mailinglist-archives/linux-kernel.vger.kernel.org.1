Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430982F40CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392360AbhAMAnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392358AbhAMA1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:27:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:26:25 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w2so107242pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5cep6q7xr6t9kLaivrV7idzLK5AQ7vlZX4sAVxDVuo=;
        b=fD2bqF0VHgRb3wN28oaLJ2r6nRVEHcID7ozo+dKpSqImokp7jo1Dnks9lAwMp1OU2e
         LKDvKcQkPpkRqksrGprFTd9tf/s1aBw4CYL5/mMRv6crxJePDqW1d2bOs97Zn2GKBW0Q
         qZh7DnUEyWkliISDzQEVJp4YJEpDuSsx3R2/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5cep6q7xr6t9kLaivrV7idzLK5AQ7vlZX4sAVxDVuo=;
        b=uAJIoxavn5rxN4bLeJ4IJVFTvhr4keKdzRjUafbwXAxjbngsymr/fX9do/V1L2ALu5
         8TFm6Pb43NnoFSujzy+T4/zQVCyDx3nqHrGwDlPh/3qUwh9zuN/UVa/uAiLJ1JVvyP+x
         ME4197//Uz1HKPlwGjrCqNBLjXuQTOJps1ZRh+H797t2oM7TS2TrrvqIMlXZF3a47xmr
         J9DBzaW8LPCZqu+YfsAKUn/7VQwEDck/Rb1R6hPxgECJZfrIo07YaW89HvQDM9131kCz
         7b6fNpS+vt+SUqn0bKiwV9ZE5XtDre09R/cTKI3GWwb7Ms4ojpnHrK8gy0S1c/HPQDVO
         T9JQ==
X-Gm-Message-State: AOAM533gVwqROWur9sUnFM7NqJBAspI5hFImpbWDwMZxaAAlphnCXC69
        uCdd5pCQh5WVRllKuNcygK7mAw==
X-Google-Smtp-Source: ABdhPJyD+hXJ2C6UE9S3spN4vWkdQDn/M2cSB0mVGVds2IGeT6BY0kPf2x1dFVfgMUuecjbhznXfjQ==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr1637187pgx.262.1610497584553;
        Tue, 12 Jan 2021 16:26:24 -0800 (PST)
Received: from localhost (136.247.83.34.bc.googleusercontent.com. [34.83.247.136])
        by smtp.gmail.com with ESMTPSA id h17sm270397pfc.119.2021.01.12.16.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 16:26:23 -0800 (PST)
From:   Fritz Koenig <frkoenig@chromium.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanimir.varbanov@linaro.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org,
        acourbot@chromium.org
Cc:     Fritz Koenig <frkoenig@chromium.org>
Subject: [PATCH] venus: Check for valid device instance
Date:   Wed, 13 Jan 2021 00:26:16 +0000
Message-Id: <20210113002616.1501493-1-frkoenig@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core->dev_dec and core-dev->enc are set up
by the corresponding vdec_probe and venc_probe.
If the probe fails, they will not be set
and so could be null when venus_sys_error_handler
is called.

Fixes: 43e221e485e5 ("media: venus: Rework recovery mechanism")
Signed-off by: Fritz Koenig <frkoenig@chromium.org>
---
 drivers/media/platform/qcom/venus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bdd293faaad0..979fcada4d3b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -62,7 +62,8 @@ static void venus_sys_error_handler(struct work_struct *work)
 
 	mutex_lock(&core->lock);
 
-	while (pm_runtime_active(core->dev_dec) || pm_runtime_active(core->dev_enc))
+	while ((core->dev_dec && pm_runtime_active(core->dev_dec)) ||
+			(core->dev_enc && pm_runtime_active(core->dev_enc)))
 		msleep(10);
 
 	venus_shutdown(core);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

