Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E17D2D83BE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 02:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406017AbgLLBPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 20:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405885AbgLLBPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 20:15:11 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 17:14:30 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so15991997lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 17:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcmTZ/mw8MKHSHPl1tvtO9d9erBhTQfIRpaizwC1Wbg=;
        b=V6LYZOQcaG1SZuJcD2dfVU87E+VKuevH0kPUd8wxAR5ZYFKq4cG4CKZTsN5rUW+AVe
         rkIDBt7FjiS5S8fCtS9dCXcMZ5EOL0MwXsrc2plc4KqA3FErlVJ+vGdmAUHM5jjvRUyB
         mYdLIPIYOePYw3t6Uaq9SoRuovuT6QLlh42/Np2EPTyWORS6iMOOCLDANLJdC0RzDEC6
         IH1dXtPhAXLCbhMOm1OQPA9EY2l374M+3+SPET87Ge761iGiRFJ+PPu9vS4+qqKc8wJI
         lbL6UQN+yPN2iJJXf4SgDpfVcotac2pB6mlD+JKxB+cGw/Bd5DKJk8nw3w1MvqEE16yT
         3vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcmTZ/mw8MKHSHPl1tvtO9d9erBhTQfIRpaizwC1Wbg=;
        b=opjlyJcrSJv8FSx1OTQeli4kqb4JBPWokyBt6HgcEM1wI9dToPqvk3JSMMUNw31+eF
         aC1O26hkC/k7HkdutSZ8g+tk8cnLtCfTcN3WDZNi/X/qOuBcDWj4o6L/iBCUOwdsE8dz
         OrsFz1pjTzzvAW8vXUpAhKtaXgW5El+QgwxtxJ/4ZGrsycZrdh6fxE5306th7M58TuR+
         EWAPkmhnxU+mEPM7/kK465H+5oFh4CPoA8ehgYcgIAnAVqKR11vIzRSz3oQp0Z7d7OQc
         vJ8kwL+JRYOU3Lqf/cwtkXgurTg4uhI0C7YmlmPNZSVTXtYzJ8ufPgX/4z95RvG2iq5b
         KNaw==
X-Gm-Message-State: AOAM531UAGv7wI78hU+c0Go/YZF2sM5tB9dro2GZdPj+HAl9imjlrrAQ
        z7ZKBx1LI3vBrfxxdoipF1PvvL2vp0XjxA==
X-Google-Smtp-Source: ABdhPJzPSnrT8BPMLsOLml4axcPebE+XovlWSMlSfroPkwhxsdlR8WJ55osujH53SL15mj+6OxXXug==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr6105108ljn.471.1607735669073;
        Fri, 11 Dec 2020 17:14:29 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.52])
        by smtp.gmail.com with ESMTPSA id v11sm437319ljg.128.2020.12.11.17.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 17:14:28 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: platform: don't oops on unbound devices
Date:   Sat, 12 Dec 2020 04:14:26 +0300
Message-Id: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform code stopped checking if the device is bound to the actual
platform driver, thus calling non-existing drv->shutdown(). Verify that
_dev->driver is not NULL before calling remove/shutdown callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 0358dc3ea3ad..93f44e69b472 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1342,7 +1342,7 @@ static int platform_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret = 0;
 
-	if (drv->remove)
+	if (_dev->driver && drv->remove)
 		ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
 
@@ -1354,7 +1354,7 @@ static void platform_shutdown(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->shutdown)
+	if (_dev->driver && drv->shutdown)
 		drv->shutdown(dev);
 }
 
-- 
2.29.2

