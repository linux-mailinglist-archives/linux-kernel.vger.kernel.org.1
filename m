Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B854B2D8AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 00:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439930AbgLLX4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 18:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLLX4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 18:56:18 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A56C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 15:55:37 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id o17so18053425lfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkidxSbyfjazWTOT26iGmUSG6KLeMMJ88g5Y/5sKAWE=;
        b=NE+B30e651TYDS1g07lefGbDGsWhnU+hQSZuHR7LZyjKzJCIZrJa/pYvefuKcUEGaS
         YKp520acgh7eA7ObHnle55a/mPVHTsYpg53rDJDOkKEqHWqMfGCeBr4PBEgyaGewqJB+
         wdsNmHvrSpXjUUdYQDvxpQh5HXRBGvLeWZBjuQSadiyWfy6qko5LNK+JetNT1YFHDliY
         ZJdfWY47WIw+pBrHRLEYEOvWoPhNhnGKOeCUt2y8btRzHGbUIZ/xkfogPvb2M8+/bdJw
         yLTVS/a28Jtu0+PK7Ak5ftHuHEyHlFmXJBQ9EvJNCDsWb0I5FDG8mcdNM1uj8OP+kt5C
         8JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkidxSbyfjazWTOT26iGmUSG6KLeMMJ88g5Y/5sKAWE=;
        b=kJktfskOSq3bWvYAoHMhjoGjTrZiBGuAJVlQ1eLboLdc8Bo+5OqwgSW63bfYeoVgZG
         df5Eh23cS61Uss1tu2+SvgnDvwHiyPWHsY6FHvemdc5sVUWtqAQptUgpYyiA8bgPisja
         ugwIMl4lFLeZK9H5QSia2/jPyvjtwEAnhU/IsP0FiwijneZpztGZbK2MTYbiR8bJ4DkT
         KWCuGcvbmab5jqXMCOnJ931Au5+cPkVOVnE+C4KnMrnHhJoV3J8Ai62/7cyQ5fTVeM/J
         PpY0b9GqczRJiYrmbWvvTQhKTx+5r59V+p+8xz9gH1lY3EMHktyHXIGTagmYCKlZI3Fe
         3d1g==
X-Gm-Message-State: AOAM531h0V1bIo4xzHc19yRs2XKL9WwimIqEd4eplDFETs3fkPX2vnE9
        toOrTGJbgFYo1bENTi9m8gOe9Q==
X-Google-Smtp-Source: ABdhPJx6u2NNxVdESUsjE2iSJo2juthV+ResfzLcVuhxzg0eOVhxITqb4LWlfOp7HwuTkmR2nqqgFQ==
X-Received: by 2002:a2e:9195:: with SMTP id f21mr7691766ljg.191.1607817336472;
        Sat, 12 Dec 2020 15:55:36 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.97])
        by smtp.gmail.com with ESMTPSA id m12sm1724554lji.110.2020.12.12.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 15:55:35 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] driver core: platform: don't oops in platform_shutdown() on unbound devices
Date:   Sun, 13 Dec 2020 02:55:33 +0300
Message-Id: <20201212235533.247537-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On shutdown the driver core calls the bus' shutdown callback also for
unbound devices. A driver's shutdown callback however is only called for
devices bound to this driver. Commit 9c30921fe799 ("driver core:
platform: use bus_type functions") changed the platform bus from driver
callbacks to bus callbacks, so the shutdown function must be prepared to
be called without a driver. Add the corresponding check in the shutdown
function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
---
 drivers/base/platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0358dc3ea3ad..e9477e0bbca5 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1351,9 +1351,13 @@ static int platform_remove(struct device *_dev)
 
 static void platform_shutdown(struct device *_dev)
 {
-	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
+	struct platform_driver *drv;
+
+	if (!_dev->driver)
+		return;
 
+	drv = to_platform_driver(_dev->driver);
 	if (drv->shutdown)
 		drv->shutdown(dev);
 }
-- 
2.29.2

