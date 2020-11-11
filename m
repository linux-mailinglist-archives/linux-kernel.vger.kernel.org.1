Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C42AF3DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKKOk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgKKOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:38:32 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58AC061A4E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:38:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2520687wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TWPvZ8Q5g6TI75wYwlmr663kYENsDmC3EDOVf4VZUws=;
        b=CBTrBBASaPzbM0zto16rBPP1OtKXcFcWsvhLYI02MALLIPA8DBtqGeNIIaBw2f+BYF
         LLSdWMMqLd1cSxXQEsUH2BDaLqw9CDkEnwrTTZW+IKADXbZYpeqKuc2AwrkRnbzBJvzQ
         RffPysPxe41v9IaY+NabRgB08ToFDJIM4T+iuCGZHbRfAx6f9YQYZ4FoGVyO19YkNfuh
         ayoF4L+aUqUl6J5nhl6ahgS90QBIiFDv2cj+q6JANh/QZ7oPo2hoe6gTHDLZws9wELu8
         rylgwYhm1mNBQ9PCWEvkBrWzy1k0xYBYr5egz1ts4u7OvEe1TY4MEstnEl8C8eOmoNIa
         b/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TWPvZ8Q5g6TI75wYwlmr663kYENsDmC3EDOVf4VZUws=;
        b=eL8wIKZUpMzWJirO8q06PoyVaE3FDn+S7dy3SseJmKrCRhu+WTwPjwUTqH9VnW9DT8
         6U0QGSWIiER5sovO/MyqiXyrxBs0Yk2pUC4Gbq2wetio7qmIKL/lhazJsO4/egHrpSzT
         HOMgZplysH0jPSa7UWlvBH4zXGB2kMpWuw/NY6shZoEd3AEQkmV1GWIDoVd4EkvGY6lk
         iJKVlCsRgr8R9ZFQLsLslimmjsOLjhL8/y4l0gennJ9LmD0OBMjewsj5L+n8w6/t/0aG
         BegtNuOYPwOEptMjSaJK6YblwU7tkAVyf3aJ+qOze+ybE7kt1HMSdyIlqltcS01XU0bz
         kHAw==
X-Gm-Message-State: AOAM53184Rwxl9G+52IQ6Scm3GGCiobl1Xg2JNe4vGFUhaZtg/3y97L/
        TlGMz/NA8+iheTdJDAUGdMFUpw==
X-Google-Smtp-Source: ABdhPJzJnrW6sIsYgEniA1h0eOK20YSa2wpZZMzrO2n9cS7E6RV6QQ+uX601nYZo5UQ2XWvRiiHHRQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr4427544wmk.65.1605105509436;
        Wed, 11 Nov 2020 06:38:29 -0800 (PST)
Received: from localhost.localdomain (hst-221-89.medicom.bg. [84.238.221.89])
        by smtp.gmail.com with ESMTPSA id b8sm2991405wrv.57.2020.11.11.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 06:38:29 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 4/8] venus: helpers: Calculate properly compressed buffer size
Date:   Wed, 11 Nov 2020 16:37:51 +0200
Message-Id: <20201111143755.24541-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111143755.24541-1-stanimir.varbanov@linaro.org>
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For resolutions below 720p the size of the compressed buffer must
be bigger. Correct this by checking the resolution when calculating
buffer size and multiply by four.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 688e3e3e8362..490c026b58a3 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -986,6 +986,8 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
 
 	if (compressed) {
 		sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
+		if (width < 1280 || height < 720)
+			sz *= 8;
 		return ALIGN(sz, SZ_4K);
 	}
 
-- 
2.17.1

