Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80F2F9E03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbhARLYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390205AbhARLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:21:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A502C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:20:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d26so16060195wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/7fg9ZprR2DPa+4Jsl6UVEuZoNjc7tPVVMDh2sLrbZc=;
        b=MI82XlpW2CglNKbsqGQ0jQwpJcb1UJzgBvNOwn7KdkNCtge+NFANxEhnjPBQlo7rKn
         RZumD1IWmsu4r4KSxgFt86Ea68hXlGIZEFyXImQibURSrf6nVwg4MVIKBgrd6pA58DPy
         ioK7BZwc/0p9fRCQV5jWD+lb3lpVQF2YtqL9UJ1zZiYu9ju+L4PkDnBxF0xL2sM1NmFE
         RuXNZbBaDvJ4f7c486y6pjOZqu46jMiqYy+3Ceeaw65KAZtKkg4VGal+AjQqBpKBhI2O
         g+9wvfdA5hDX2pRzus41yCkN4xhAGKf/99lM7extU/rCBaDr7PIlX+0r2BSirxabAYfB
         7VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/7fg9ZprR2DPa+4Jsl6UVEuZoNjc7tPVVMDh2sLrbZc=;
        b=P9wOmnGrEwcpYFYcGJ6cgn8FCvqiFCrL3c4orazYhYldBL6HO0pKWWOmF3DeJGSoCF
         VIOt70JgBdlRERgV3Z0BVHKBHhXi4/rJn7b4Fv+R25o1JsaM50O3aymaP6Cn4cD9Dd7s
         uI09YVOQHPRHEUoQqzk17etrAlD7fsReSvkWa01ngsYa/jXf0+Vux8bHyGbM0c/PvNEC
         2qlAis9UUgbSpo7Ujm8sfsKNjknPzL5DGj+1k88HxSlwkJXtilGl1p1HtFsGWzLPHVwc
         s9SIgXLkqKYiEon/hrR5PWVEx0q21iwdcTWwxwsXYCJ4ojLlnqzD6dkXZ1GgPh9Zosut
         YOZA==
X-Gm-Message-State: AOAM5310fyzzgl0JR/qfQa+93Wbk1BQ+YNKhWkZSYk+gfqeiKqYG6aRg
        AbIwoFeDqwah2b2bjlNXtmvxvg==
X-Google-Smtp-Source: ABdhPJxlSpMzvy/BRCmNGkmKYq/7wCKxtDAy2SEf84RNvxAKynFcWBIW//nHetwqErxnZgIB16UI/w==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr19904157wrd.118.1610968838789;
        Mon, 18 Jan 2021 03:20:38 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id s3sm23986809wmc.44.2021.01.18.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:20:38 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     ink@jurassic.park.msu.ru, mattst88@gmail.com, rth@twiddle.net
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] alpha: defconfig: add necessary configs for boot testing
Date:   Mon, 18 Jan 2021 11:20:29 +0000
Message-Id: <20210118112029.19894-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentoo's KernelCI will soon boot test alpha kernel and we need
CONFIG_DEVTMPFS=y to be set for that.
Note that CONFIG_DEVTMPFS=y is already necessary for lot of other
distribution/tools like recent udev/systemd.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/alpha/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/configs/defconfig b/arch/alpha/configs/defconfig
index 6293675db164..b52ed626ab55 100644
--- a/arch/alpha/configs/defconfig
+++ b/arch/alpha/configs/defconfig
@@ -72,3 +72,4 @@ CONFIG_DEBUG_INFO=y
 CONFIG_ALPHA_LEGACY_START_ADDRESS=y
 CONFIG_MATHEMU=y
 CONFIG_CRYPTO_HMAC=y
+CONFIG_DEVTMPFS=y
-- 
2.26.2

