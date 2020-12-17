Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083E72DCD78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgLQIP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgLQIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:15:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C396C0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:14:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2so18549634pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxXhsJFTOyz+tGYPnV2NQFdQahYXCWz2bAc8QN4Bqq0=;
        b=D5fosdBjph9Sztv0rn3Oj9xrBq3zLGH/GRfxeJNcCJyKj/Ijo++OfTUsGpQ7Bvq8Vi
         nJ5nENN5LSBuSKCPhNBTDS3v4QmyfqPHVZ3GrNeD9QiKHElBiNiI1bOC8rM2lMQ7KRd5
         6kSaimHeQ3dhm8UsBxq5RiCDrzkT8nf9YuG8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxXhsJFTOyz+tGYPnV2NQFdQahYXCWz2bAc8QN4Bqq0=;
        b=WP2+qmKqUvvkHeUuI3TAijMCmrdQOP6M1IfcPFIO5CzymDXokROIqMFOC1x9V4M53i
         3PKNJb1awUvp+NOg5GqEm6d9Zr1rxd+/Ky91C6pHCjxsE8awayX8ugop6IdhxQE4Xnqw
         RKQb7SJZRI+T4C/iBCdTVLety9rfgX6dGdQicmQcvgrQ+J+NHy98nW3PULVzzHfM4BLO
         UkdrgllRi3gO8I7oHHA55dQ7tY2IfrP2RizQ156DxRsOAR6JlhZvnyhVBniyL63A5RYY
         hsCphS8EU3VIMVQUt4BmYebAasm7bZK8l6qwaY2wuMAez1sbCFZwmhjoaQG7YQ+mua4Q
         YGkA==
X-Gm-Message-State: AOAM531v7mXw2GyuzfiY807w0aQLQhK/lOVmdEPZY9yupKc4hAd9DbrE
        Lp57Kd2YtH7OFFxoztX7YRubDA==
X-Google-Smtp-Source: ABdhPJyEDA/48cKMDvGBkWS2/ppRVxVRQdD6yl//MLwex1DHh4BThpixOtfOKx+z08qP3Cy6uoXiIg==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr36488756pgd.246.1608192886171;
        Thu, 17 Dec 2020 00:14:46 -0800 (PST)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id e24sm4224686pjt.16.2020.12.17.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 00:14:45 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] platform/chrome: cros_ec_sysfs: Add cold-ap-off to sysfs reboot.
Date:   Thu, 17 Dec 2020 16:14:20 +0800
Message-Id: <20201217081423.896862-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201217081423.896862-1-pihsun@chromium.org>
References: <20201217081423.896862-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f521a5c65091..8210fb10e839 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -28,7 +28,7 @@ static ssize_t reboot_show(struct device *dev,
 	int count = 0;
 
 	count += scnprintf(buf + count, PAGE_SIZE - count,
-			   "ro|rw|cancel|cold|disable-jump|hibernate");
+			   "ro|rw|cancel|cold|disable-jump|hibernate|cold-ap-off");
 	count += scnprintf(buf + count, PAGE_SIZE - count,
 			   " [at-shutdown]\n");
 	return count;
@@ -46,6 +46,7 @@ static ssize_t reboot_store(struct device *dev,
 		{"cancel",       EC_REBOOT_CANCEL, 0},
 		{"ro",           EC_REBOOT_JUMP_RO, 0},
 		{"rw",           EC_REBOOT_JUMP_RW, 0},
+		{"cold-ap-off",  EC_REBOOT_COLD_AP_OFF, 0},
 		{"cold",         EC_REBOOT_COLD, 0},
 		{"disable-jump", EC_REBOOT_DISABLE_JUMP, 0},
 		{"hibernate",    EC_REBOOT_HIBERNATE, 0},
-- 
2.29.2.684.gfbc64c5ab5-goog

