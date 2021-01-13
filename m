Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83A2F4DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAMOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbhAMOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB4AC0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t16so2415833wra.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f2BPaI0FPEfwHACkMCkRxYDyaBt02TKR4D8xELwApI=;
        b=zc9ZOpEUI+Nh6Qla1WDfrb2vnRL2q84hQM50XEQXQr0xU371apuDwreUQOZKKSgAr5
         g7a1pROIkw2JAlYrfbUiig2HWLqwWHy8HZ/XWWBHtiDNKwj55UxEgroLjJuCBw18hlHe
         92MAeh9s6TSYlS6N3UHBcggv18NhVPSGxCug7FAilAYfafpZsRbkQDlYTKiORivlccUP
         9LS1k+4OMMbCziBfn3XobchtVgfVFJZSPwFyAo4AnK1qxUYR+KRpOnUOlfLckY0T7SBh
         WIy1YBvftA/oJxDxlPln0TX3wEE3MMUxIU12tVxKSgY+5mviYsZit9GALu0OnFxLsu+0
         HhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f2BPaI0FPEfwHACkMCkRxYDyaBt02TKR4D8xELwApI=;
        b=go3i8wqHgBY7hHP/fICqsgo/UMedUaWqaoOy6DCPLzFRAJzyzyO3vrqbD0sCYuAa6g
         ss83kq6cUMqdeKxq3uUo5fzd852yriHT42UKtBj4SVBz26FFcqhH5JF0Kt1UqQSTieum
         JjLfZpcfwPO46jqgOGgQ3i6jqm8TpkCVz8QHTwBZqRHyuHB22llgup2gqL6m6E4nPfCg
         44aY24O5JvPQ+dmNomWmJtnut9hBPLRiD37mLmfKWhGCCM6VYMD6qdhLaWgb5WgBbWJs
         vthmX6lg5rdxtoz+lBwkE6yq2Z6dDAzWv119OeKf7Ptg+4DhZ/AQosgRmxoRj1BFQr5l
         gDDA==
X-Gm-Message-State: AOAM531Ubq2LIpMi3Rkd8BtV0WVAlC4dEh7V8uODw/zjBuyZyAkManQG
        BvVDaWbhRvqZ8C6ZG2de2k/Xs+EhKH2tzrZF
X-Google-Smtp-Source: ABdhPJzvNk0my33Gw7zgd1XA3cpG4wONGFNN2ELceKXzyI59SQd9sR/5sbIBr/pV5XoFHhHHEN2b3g==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr3060914wrp.30.1610549416231;
        Wed, 13 Jan 2021 06:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 02/31] video: of_display_timing: Provide missing description for 'dt'
Date:   Wed, 13 Jan 2021 14:49:40 +0000
Message-Id: <20210113145009.1272040-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/of_display_timing.c:58: warning: Function parameter or member 'dt' not described in 'of_parse_display_timing'

Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/of_display_timing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index abc9ada798ee8..9f21f7dc85292 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -52,6 +52,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
 /**
  * of_parse_display_timing - parse display_timing entry from device_node
  * @np: device_node with the properties
+ * @dt: Display timing information
  **/
 static int of_parse_display_timing(const struct device_node *np,
 		struct display_timing *dt)
-- 
2.25.1

