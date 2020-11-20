Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81502BAA4A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgKTMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKTMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:38:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F04C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:38:25 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so10225478wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEmyo3JSr762eH2n2pzrxXah58hd/mU1Bud5fRydKiM=;
        b=rESZQpuGcSrvt2ffCEv2QJy7xTi6ru4+XCkp9AK66faCuMcAB0uWtMyQsTBj5QKy6w
         h/sIJUyvuqpki28CLToer7fI3ySDItHpEqavDnyavzZcAtlG5YxAAzNx7Jbys9TtcHoy
         OIYqZBwS4VThCbKwQXBjZ5MSw0B90BCLJcQ4J20yAuS1rweGL5M16153v90tmSWMPUK5
         xDB1sXMScwaJ2D2I4g97+MzmpUu6GXly5Ln6HE+RKzcZceqi3/mEPp6Xjux8doAyGJrM
         W9rZfUKprlRS1O76qCcuTqOU+cITrZZblOYLYFcxAYoDYCyUgcKx19tEOZCuqOwwEtLs
         8wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEmyo3JSr762eH2n2pzrxXah58hd/mU1Bud5fRydKiM=;
        b=RZRr0+HfCfr/7FkVrB/L/tmSJ5eeqF7WkwqkUArY57D+GQl5OkrNPcmGmH2qReYavT
         tZN2XIfFijn7hyRku4fJE686M5CK1lOmqJf3IgpyYBiyxNlOrzbQltNyhBDn/VEvOaUf
         QoTr1Zxb5LEYo3rXjd1NrovTt65BV+WDyoGNGO+n2MsvnK/cSbT+hAh+D9zEN4hNZOVz
         RCuEpIhXWoO9HiTz+Ym018eYajYPYIO3JveoCuIxyLR3yje9A/YnCESACC7qa94/NbF9
         uu/5C+BBz7+cGT37X8V+whaI6ohWt8tUPV3CwHnZ9BgOHdqDHBC3O4Jo6Kj8y5m4XcZo
         VxlA==
X-Gm-Message-State: AOAM532SHv5LdkLluBgQCXJQB9Fmq18UaqCVk7nPWE68WxDudkdWPNmE
        ZARHH1vD/01RooG0TXgh4VCanA==
X-Google-Smtp-Source: ABdhPJxpTQmnN+5QlUL4e6UoM96c5XQtVIYgBjOBJCzFei03yqOLNhBudG8PwUNYtSxsGDyFGqhWFQ==
X-Received: by 2002:a05:600c:2601:: with SMTP id h1mr5652661wma.35.1605875903730;
        Fri, 20 Nov 2020 04:38:23 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m7sm2717566wmc.22.2020.11.20.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 04:38:22 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: lpass-va-macro: add missing MODULE_DEVICE_TABLE
Date:   Fri, 20 Nov 2020 12:38:13 +0000
Message-Id: <20201120123813.14059-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix module loading due by adding missing MODULE_DEVICE_TABLE.

Fixes: 908e6b1df26e ("ASoC: codecs: lpass-va-macro: Add support to VA Macro")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index b604de07e650..3e6bbef26dcb 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1487,6 +1487,7 @@ static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sm8250-lpass-va-macro" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, va_macro_dt_match);
 
 static struct platform_driver va_macro_driver = {
 	.driver = {
-- 
2.21.0

