Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A22AC0F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgKIQe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgKIQeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:34:23 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF5C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:34:23 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so9349818wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Mc/WCoimyInKv5OttzkuOMxxCwc3vdp0zrJE14cUyg=;
        b=gMWiuTB1fJUCC8XR6i+z/VLugKtN4pCLum34HuJFGXtvoQIiVO2S2GtKo8oSk2oyyj
         acCJJlzXYYsXpzUDpXWKFVXVP2UHY+VGPam3AvlzZicLpwQAsq9U2dPV/TnvJBAzMaE7
         Zu2KzElBbJZ/+Q22uz7XSo/zpp2cyTT+xL0PNLU69rlA1EVNlcOK+Ce8BwcSgtTriZPM
         wN17n2n0pNzW6Mbo7BAA6qnuGCwS1RhwiX0z1Q0onGzdB62BydkZJBju38ISiMwO8Qm4
         BUJ1pGVwrfH41SZ++jlBVRcemZafb6Q0XdLpqVwHH1KhBObNM/f1tFK+2Kt90ePy9Brw
         bvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Mc/WCoimyInKv5OttzkuOMxxCwc3vdp0zrJE14cUyg=;
        b=smVfs5X6aLEV29z4YvtPbBeD3ug3x9g+WJr1CQFKIRFn8L8RLWsJNtxpDxeujYxkhR
         KwYf/lPn7Defj/H8GEvsMLzXAMoPxFXFmF7hVNzlZFVopzKwzvosolNFiNEOrD1e6Ofw
         fo8v0apaQ5gM2oTZgDhqPmxxifqvFgG/LevWiVFoqwxyLeES3vO7iziErhDYeLi5LxMj
         2ZEsjEJIhTMkfkGGXyNCyWI7rjLUY62ZJx6fzKL0d2jiO4lef+tjxejQLaZqCdIpC9xw
         Z/OLfFmuOWUFLKu6EYM2LP5a02FdvbK15YQ/BzU1OduHNnJyShG2Ma/RbyfZekHyz+Sp
         Volw==
X-Gm-Message-State: AOAM533o70n6taL/UpZjHapzRtZAtRA9zM/m6sf+s2GZFglVxODXZ8tW
        7bWAqDyaokhBzgR6TTbfqhp7Zr0sbvQFLQ==
X-Google-Smtp-Source: ABdhPJy8ElPMhrg0WMHEclZVVgQClMFRPAkDY7reSfJUdDpF/sAIijxOPDWSrWQK2Sxku0uymdtw/A==
X-Received: by 2002:a05:6000:36f:: with SMTP id f15mr18757371wrf.78.1604939662403;
        Mon, 09 Nov 2020 08:34:22 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id 89sm15072542wrp.58.2020.11.09.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:34:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/8] Documentation: list RTC devres helpers in devres.rst
Date:   Mon,  9 Nov 2020 17:34:04 +0100
Message-Id: <20201109163409.24301-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201109163409.24301-1-brgl@bgdev.pl>
References: <20201109163409.24301-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's customary to list all devres helpers in devres.rst. Add missing RTC
routines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index bb676570acc3..6ffc0f07404f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -411,6 +411,10 @@ RESET
   devm_reset_control_get()
   devm_reset_controller_register()
 
+RTC
+  devm_rtc_device_register()
+  devm_rtc_allocate_device()
+
 SERDEV
   devm_serdev_device_open()
 
-- 
2.29.1

