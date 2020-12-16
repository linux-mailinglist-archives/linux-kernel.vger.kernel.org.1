Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C72DC481
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLPQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgLPQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:43:11 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC5C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 08:42:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so16935013pfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxeKk484FE197OUQVwNz0QTVE1MbXs6u0Yr28/1OUpc=;
        b=UPpL9wT7RdxjpvJ7B9+DNDks+0tCYHBcyEkfUmPSLvog2zikVgpaMjZ+0EB9VFg9Pe
         huDbOcnsVAOvyMligbJ9K66ultIpHJZJMk8vFicgY9m3W5TgzG6Gw+/b6LnVg6OEgURp
         h6AFsEZmAxNul7oRmQwSUfcr446uANtMzLUDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxeKk484FE197OUQVwNz0QTVE1MbXs6u0Yr28/1OUpc=;
        b=mIRtOU3NJPTKCJuOFA8U4Zx27J2OZflPXBs9Gny6r8Ruv8kCyEJxC/bREth83kdjee
         bts6h+xWpsW/wp0SoV5lOFP5GX6xfuGlRjVvTaxPCgAdB7Zp7xbaOXVx5WhJgvYxhS3a
         q/CNGuiQYO2A/6WVioQKr/j7pvgSb4AHs5iqouAXUn/dr1OUgu6KB5IbOy93Uh6+9nI9
         j7HVmvEO1PCBo1vPzhqe+nATbD3+WURtvS0rb5uO++4q5uc3QRrW9IZnvJ0CT+noI5aU
         MMJP9qDJ+dE8h3ONsArJzlvhAqtYqTdQdsnlRouTiXIFG3H84rYqGPLCRTauIkeaDn6+
         rurA==
X-Gm-Message-State: AOAM532K73ZRdAjxZ57ZhW3WNrHlHxVN4G3UtgU1of1Nvb6aohUvomuF
        /jX/QF2RmSMXZCZI5Uvrsbtj6g==
X-Google-Smtp-Source: ABdhPJx5HUp5Qa6Kmgx4x20aZy6v8WoOvExp9mjEmHH8f4hoi5lY2CDsfBR/p2iAIvAfgSxV3zuMfg==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr22391110pgm.135.1608136951318;
        Wed, 16 Dec 2020 08:42:31 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id nk11sm2533723pjb.26.2020.12.16.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:42:30 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Wed, 16 Dec 2020 08:34:17 -0800
Message-Id: <20201216163416.2969209-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216163416.2969209-1-dnojiri@chromium.org>
References: <20201216163416.2969209-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.29.2.684.gfbc64c5ab5-goog

