Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEE2F9E20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbhARL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390094AbhARLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:17:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE914C0613ED;
        Mon, 18 Jan 2021 03:15:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so10831967wry.2;
        Mon, 18 Jan 2021 03:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0h1i352EiVbHiUM8JHOCOF/H+GACCn8PizeJpCi8MZk=;
        b=F2CYbEyEXwQGfdqcrbmovXlv9qqvFFdfI+1XieT55dWKUke8Wv+eXrWrPD2ZgoYDBe
         9uhTtLHazLCucke3uj7QUY+AIx7lC19ZQPYsnQtkCtWucV4hyEttt3p/A+/wmV8jx1g5
         MpxIP+u7aEKiPhFpNTfQBsCfoGbvFx05pj4NZVg3evYw1ql63xnnyBnf7F60W0/Zu8X9
         75i/Cbn8LdOqmBnMa+IzHgZA1IaHxRHvkGdK0nYeqbK4Hm1HMvA9ZJdf46SWH41o7Uv7
         24uYQIjSyps1USHOySYs7r4PTtxrubT2JtkXRBQo21YDbuW1AEk6mfCr0OYTVZP7xGY/
         AkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0h1i352EiVbHiUM8JHOCOF/H+GACCn8PizeJpCi8MZk=;
        b=SLFMeGKpHMuu7/Ym9GuD3LV6j0OJv0WCtemRLII+hc2diq6YqdRKWrGf7rnYh+AkHq
         R+wE6Y+yZrIHYbWbVWIOFl5z1BBQ0TYXL10QGxcbJRJIIkXA3wJdLCRU8l6jTR9zwR2t
         zzzCKnzp/AYTcIDjyYMebsIbgjIqR+RzuQywmmxG3pdrVfhWalDDCTt666yVRTa+k/Lh
         GFkUKSgZINnblC5yGUQl9OqZe7p4d/k1D2YgdZifNkhcHWdA1UXIqHhinmvAogqR2Rmt
         AN8cPudsnO0irY84PbjuJ6JbJGPRbAcUu4ndPC1WAmGUX2It/q+LVEC8FkeYGPxyNw4Z
         sjrQ==
X-Gm-Message-State: AOAM531jwnB6bciXoskkHYt/EKko+nXAundPF4GKJMQiYwDpSAqaIjRT
        1L5PdBQFfQROpnOmuNYfpGY=
X-Google-Smtp-Source: ABdhPJwgAK+FAy6FwNo9C9xaA0grlmR2OjOv3U3cw7OLWr3F7meQ7e9jvAIodhO2RqLRbQHD4OD3pA==
X-Received: by 2002:adf:8290:: with SMTP id 16mr24504028wrc.27.1610968539530;
        Mon, 18 Jan 2021 03:15:39 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd2700989047bbcea0de57.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9890:47bb:cea0:de57])
        by smtp.gmail.com with ESMTPSA id b132sm26778440wmh.21.2021.01.18.03.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:15:38 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     shawnguo@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 3/3] arm64: defconfig: Enable PF8x00 as builtin
Date:   Mon, 18 Jan 2021 12:15:31 +0100
Message-Id: <20210118111531.903154-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118111531.903154-1-adrien.grassein@gmail.com>
References: <20210118111531.903154-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is mandatory for the nitrogen8m mini board
when booting from the sdcard slot.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 15fe99544c67..fe7f82ceba9d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -607,6 +607,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

