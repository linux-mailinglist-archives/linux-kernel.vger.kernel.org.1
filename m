Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F076D2D6B64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388776AbgLJXAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388575AbgLJW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:59:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C3C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c79so5601965pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcXxPPv1rlzV8Rjv8ELVH0HH8fEaK5OVaY2iXdDPFtA=;
        b=Ch948AI2RckGL/IymAbf4lxV+DjOpC1h+JIvX0hbfQGEbMWJONKPDLNpPteLQVwY6d
         hI1XZ16WwiBWIyHX4rSFbP3v6jUvWMlCMhc5it5fJSPNz0BxlXqKFov4t//nrhWn0c7s
         IFb61TJHKKPyBmKeNJCeKZfTh7tYpnRumTIiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcXxPPv1rlzV8Rjv8ELVH0HH8fEaK5OVaY2iXdDPFtA=;
        b=nMVq7sGvie/NLK4nEVJ6kmjeXBlknW+dnxbZwFTeJPi+0JONb8XMXY+CDNvj4yL4vh
         JaE1HSksZdiM3jIUldXaS3lhPyHWvJkvLQDv0MKtWVHqKOoy7A5l4y2Vkkh4xu1h0Kac
         i+FQtofGdqdquPwOCQP+hv+bafoOA2ObiCeBKa44adgnvymtiAvgKflBYkkjf74RE3to
         wavn2NaL450aDwbzuexeIZy1r49Q6uuz4S3dhPh9hvH10mzX6/YD9zsAhYriPTr4yIRx
         XbbvuqUMeOAqkUgnSgYSWfxEH7zqquN8/CETdrD/xVFrpwyBrvOdgRZ+N6k7veE1qnu8
         thmA==
X-Gm-Message-State: AOAM530odqMuIET6tCPHTdQSc00aZ/sTw8UHwYtbLbs8l0QmfDjyFBvg
        q2j9biUVoQchG6pW23MG0Pz7Uv+UKlLRgw==
X-Google-Smtp-Source: ABdhPJyb1opyZlNzS7DlE5qnVPW+UK17h8Xpj1VNgfHDC8G2nV4VPjqiy/iEVQZEFPJMnJ2283heTw==
X-Received: by 2002:a17:90a:ead1:: with SMTP id ev17mr10212145pjb.51.1607641127341;
        Thu, 10 Dec 2020 14:58:47 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id v17sm7612831pga.58.2020.12.10.14.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:58:46 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/2] platform: cros_ec: Call interrupt bottom half at probe time
Date:   Thu, 10 Dec 2020 14:58:39 -0800
Message-Id: <20201210225839.1212462-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210225839.1212462-1-gwendal@chromium.org>
References: <20201210225839.1212462-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the AP was powered off, the EC may have send messages.
If the message is not serviced within 3s, the EC stops sending message.
Unlock the EC by purging stale messages at probe time.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 4ac33491d0d18..a45d6a6640d50 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -252,6 +252,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	dev_info(dev, "Chrome EC device registered\n");
 
+	/*
+	 * Unlock EC that may be waiting for AP to process MKBP events.
+	 * If the AP takes to long to answer, the EC would stop sending events.
+	 */
+	if (ec_dev->mkbp_event_supported)
+		cros_ec_irq_thread(0, ec_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_register);
-- 
2.29.2.576.ga3fc446d84-goog

