Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577DD2B8881
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKRXky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKRXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:40:52 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E8C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:40:52 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u2so1893229pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbXmC12vCkyVcsuizMiLb6hd66fnVjvjA5q9X2HN7hs=;
        b=IRh3QYaLc1sLq4WKPbB+pxnO9Emyq7Ia5jPXAIqMNITYy/CplxB5C9j37uZQq4XFAw
         blJSwLjOMwCIyFQ5Y0jvSEnxYruEZUQmA/juFOQUUVCFuOFgaMzhji45odXNreNAJq+W
         jo5Yw3abrXP7N+nh4OxVcfgUZJ9gPvN4KpSdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbXmC12vCkyVcsuizMiLb6hd66fnVjvjA5q9X2HN7hs=;
        b=BY/+Y3JUwNkuWmOQ3MNdoSWUCq/Pf722kEGasUSC2dBF82EeGf3NZPDhSGdi2zqCT7
         RQdfAEv2oNgFImyYm9rSh7lbKF5mlDuSIlGl6RzxJqYB1TL+89nnmfDDvXRjHgoGRsP3
         PFYxZGECYKRYwW5t7/882gynJkSX6bqanDJ6ON1/8SnYb+/qCfZQjsxyLDhuz6TWdf34
         mZS8wXAyS1kX3z9VbVkfJ1SfVBxGUeizSBz6AR+A0AP3ljHkF6nUOvmoB7joSIMSstrZ
         B4VCIWEw4unwbOytcaq0chPi/0+xc/8dawYSmwI60FOBmfDYTngkYFhp0m05fcNe0JOM
         Etfw==
X-Gm-Message-State: AOAM5327qQaqIxOKIHZ1z8J2aGZvI8ujli0Gk8oQUZihX/LY3dvpj2eH
        WDMXnZ/dv9PKnczblI6f7PgvsT8OoUMiwly/
X-Google-Smtp-Source: ABdhPJxkVUr5lowpShV5uuRPaBia5ZA6H23xv2nxKwOlLdb2YsZ28cJaydQHLSiTLKhftp93Rc9L7A==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id x12-20020a1709029a4cb02900d6a250ab9fmr6762939plv.20.1605742851984;
        Wed, 18 Nov 2020 15:40:51 -0800 (PST)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id t200sm5210979pfc.143.2020.11.18.15.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2020 15:40:51 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Evan Green <evgreen@chromium.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 1/2] i2c: i2c-mux-gpio: Factor out pdev->dev in _probe_dt()
Date:   Wed, 18 Nov 2020 15:40:24 -0800
Message-Id: <20201118153951.RESEND.v3.1.Ia45846771c63de3f2418d2b9c767cd95938a164c@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201118234025.376412-1-evgreen@chromium.org>
References: <20201118234025.376412-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out &pdev->dev into a local variable in preparation for
the ACPI enablement of this function, which will utilize the variable
more.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Introduced minor &pdev->dev to dev refactor (Peter)

 drivers/i2c/muxes/i2c-mux-gpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 4effe563e9e8d..caaa782b50d83 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -53,6 +53,7 @@ static int i2c_mux_gpio_deselect(struct i2c_mux_core *muxc, u32 chan)
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
@@ -77,11 +78,11 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 
 	mux->data.n_values = of_get_child_count(np);
 
-	values = devm_kcalloc(&pdev->dev,
+	values = devm_kcalloc(dev,
 			      mux->data.n_values, sizeof(*mux->data.values),
 			      GFP_KERNEL);
 	if (!values) {
-		dev_err(&pdev->dev, "Cannot allocate values array");
+		dev_err(dev, "Cannot allocate values array");
 		return -ENOMEM;
 	}
 
-- 
2.26.2

