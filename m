Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0151A2A6982
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgKDQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbgKDQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:25:06 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF2C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:25:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so3340346wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLzGMSztWgz07v35Jtjii54NsFsWwuKNfNPhB7AbpDE=;
        b=n7NvpaRz/v65F5A+1qpFB3soNR/82EQVavWkMbv96kAU4YMRJbHd7l3KsRnNOodaPZ
         PemLn7Ogcq8PM1/Cr8PBTg5wleTXiAy+X/wEABMnNLO1EnonfgTbrCDp1uA9h8tDB+A1
         oKIKOB8lXxRPgeUtHqOicYWZHvQrn4DfyOPk9iRiEsz1obM2VLKogw0LiVmh9tKMn0Vm
         viL0HhslU49iVhExW1VzATOOLkR4TvgAykDcbPXyV6NKK9e87yF1sPNwEsvOwYMVy3S7
         hBW6/vMbuq7WlQhnD46vMUc24C2aOFVnoIVe5BPNiIQ0+fmfn82uFyY2ocqau7nFmDAG
         kpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLzGMSztWgz07v35Jtjii54NsFsWwuKNfNPhB7AbpDE=;
        b=PDhtJS3rqh6zxkSwYSQKRxsqwChaBrnFHbz0qQIIKIa+nnph36YKg2cR1b7+QkT0uW
         piCEc4K7l9Qfrp4ew1qLYoTdwJpED50w5Ryeut411V8nGRBikeAHeAISR12TI3+uvXrW
         GW8rK6dj/3Yt4nVJtQShtA712EUyEuqGfBw6Mx0MDJ37/28ToAYwQCFmkysiMkAOTo4/
         2xraTxQn2mMvdZqNcypSDkg3FV21jj1DszID4a95aKwNIjSCUfgBvUJRc1Vz99nokkME
         lkTqLGwN2DPEybtiFKw6u2J7lpK5oGzsgMhLJnJHJ56jp1KTzrxLPu8Ze8Sq87fGGcEa
         ij1g==
X-Gm-Message-State: AOAM53206A+S69qT9S24y3ct9Fty5pjU7ozhXwktZPMj6AiALIEoEn1W
        xH2o4ZOjOS3co0TwfvDb5UvZ2g==
X-Google-Smtp-Source: ABdhPJzLYp68/eaXS5ETCQ873RexEl3JnFhUYZxhzam7N4Xf6ESKsOWLHSsfiMqVIIm42mZ0zk2Ozw==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr34508537wrn.326.1604507104315;
        Wed, 04 Nov 2020 08:25:04 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:25:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org
Subject: [PATCH 18/20] input: misc: drv2667: Fix formatting and add missing member docs
Date:   Wed,  4 Nov 2020 16:24:25 +0000
Message-Id: <20201104162427.2984742-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'input_dev' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'client' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'regmap' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'work' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'regulator' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'page' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'magnitude' not described in 'drv2667_data'
 drivers/input/misc/drv2667.c:109: warning: Function parameter or member 'frequency' not described in 'drv2667_data'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/drv2667.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index bb9d5784df17d..dc19eb6a8713f 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -90,12 +90,14 @@
 
 /**
  * struct drv2667_data -
- * @input_dev - Pointer to the input device
- * @client - Pointer to the I2C client
- * @regmap - Register map of the device
- * @work - Work item used to off load the enable/disable of the vibration
- * @regulator - Pointer to the regulator for the IC
- * @magnitude - Magnitude of the vibration event
+ * @input_dev: Pointer to the input device
+ * @client: Pointer to the I2C client
+ * @regmap: Register map of the device
+ * @work: Work item used to off load the enable/disable of the vibration
+ * @regulator: Pointer to the regulator for the IC
+ * @page: Page number
+ * @magnitude: Magnitude of the vibration event
+ * @frequency: Frequency of the vibration event
 **/
 struct drv2667_data {
 	struct input_dev *input_dev;
-- 
2.25.1

