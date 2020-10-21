Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45629510B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503005AbgJUQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439134AbgJUQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:42:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:42:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so3778722wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JS933voy/5ulGI3fj+GAntyF9rpzNqa0lFnIF6+V7Ss=;
        b=rOtvEQODVH17lLAdMVAKe/rIbWnNmfZ9BUkou7mb0yCv9F9XG8FRyBqy7VWOePZr3t
         B6bbFjV03umYPLuX1VcNKtC2+CLF3fFCFl2q6l/awYyDs/BPpvcVSF9hOKgrR5iLrW7b
         lEm+Km9Gh6CM0VkcmjHZOWplxr2pFhg6TscQAupU+C1yKCKQCW+rbog6Kl4pnvdbyEOn
         SzNZDXQVvd2fg/Ldq9HJBqhckN6lqdOML4KTnrtIsEdnInApEh5uCDhpgf7zIM3SZdVC
         WBK4gtXt1M8PfiI28v7ZS6ch4/9+wOq0c5udn+GBaDfNq9KzPkdqpzHy/MbqAzoo1fBS
         JMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JS933voy/5ulGI3fj+GAntyF9rpzNqa0lFnIF6+V7Ss=;
        b=SgKrrD3U04U0hgNqmJBybSseYzxGqkCGmtXzvYQGZ/s2kF5tsBrp3tGHZ+5QP1CwEf
         ZXlp9wTU/pYXRLT5voFt/mPrdebz0Lmsi56ZXAipC07ppqFwKODsFi2TZHfqXEOVLGBA
         mMtyALp6CRocey62S8wDydi3oqzCfml/eqCxDR96JS9zqNPI984sY2UvCz3Zy8WbPK0E
         mNUVWC7uh5kM2YVcv5X9/qNtfFV7Zu5iYVHJyYVwSiYeh1oIuoDE4cKES5sJeH07DRqE
         0YVBzV83KmM81NVZQDkJsibDJh7xSmu6OEMDYgC3C5S3TROqz5muJ0F5RX8bOB8Ipzai
         ocZg==
X-Gm-Message-State: AOAM533zjlacFcSkO8y53NhZZGQeBmWsszibem2DtN9MMk5/GyS0+W0t
        mkfAdjI2yBegoOOO6h6cCVrJeg==
X-Google-Smtp-Source: ABdhPJyYyY/I9sCo3RstG+oqSDx3Z55fChra8Y/tiA2UQ+4pfA1kyDm2nohjoWskkdTymeEFd2UeCA==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr5613554wrs.240.1603298558589;
        Wed, 21 Oct 2020 09:42:38 -0700 (PDT)
Received: from localhost.localdomain (58.164.185.81.rev.sfr.net. [81.185.164.58])
        by smtp.gmail.com with ESMTPSA id a3sm5321724wrh.94.2020.10.21.09.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:42:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 3/3] thermal: mtk_thermal: make device_reset optional
Date:   Wed, 21 Oct 2020 18:42:31 +0200
Message-Id: <20201021164231.3029956-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021164231.3029956-1-fparent@baylibre.com>
References: <20201021164231.3029956-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8516 does not support thermal reset. Use device_reset_optional
instead of device_reset.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0bd7aa564bc2..149c6d7fd5a0 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1052,7 +1052,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = device_reset(&pdev->dev);
+	ret = device_reset_optional(&pdev->dev);
 	if (ret)
 		return ret;
 
-- 
2.28.0

