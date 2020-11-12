Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A25A2B036A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgKLLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKLLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:02:21 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E1C0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:20 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so4912796wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4itWujiotoYQisXSQ7fjROwshRjEA26YsYFt2SDX4IY=;
        b=TQdfJpcQKSbZ8SfiZ3c4WrInJ4vysLX2BTlR6ITcAftbm9emW2wWJZyumBo26ThtBu
         u0PgKCubGc/pqCWfeoq4v4Jdb2fTvLOA2gaAZsDIq56g1weE+9k7iFXv37Cu1vLVqAG8
         cZHmTZUnLk39zs8xMq1gM1hOoJGZUlOGZLkFbJxtNbUw8xuJ4bKMkNVqQzVIixFdx4x8
         vt8sWr2UXPzQVijeTL//XnZqu2zsbZk6uOJXKhgsPntQWPhsDJIqdlNBP791RqhpAqAO
         z87YHk8+XdIqWoRoaHoKIxbVjmQ0VTDCCQJrpiHjbXdtLJfOR05ThvAsjYNWHcsQUnVV
         kPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4itWujiotoYQisXSQ7fjROwshRjEA26YsYFt2SDX4IY=;
        b=uXrHTSSmlWGxcLE3gDGuyNQKTndElXjJOavwc6Jzhm3+Wdovj0lB4XtRExUE7m8fYj
         lKyPtJwjzX3Wly63vWCl6fu+dTyCV+indPRfBXyQ9UkuYZ41mKmds1Ca7/Vyrw8dxqsZ
         /EXNSLM4Unud6cbzVtOb2TM0GBgcp5nxHKiBNLnh1DinCltPunhtPifpuPVvin8SUCMp
         LTumglMSyICTwBduuxIKNm6YAa2EE2ynvxrpoj+JHx8dP6RjYDY9pECHMJS2S6Be8w/f
         KGDxkAo3HBLUsGkt4+qidGn94jb4Fp6SdvHk6F/cbVbFY1jLJrznCWfXpnHUPeZ6iD/P
         GWbQ==
X-Gm-Message-State: AOAM531DCOrfpQn95M3yg5GIHQ5HADjEPBBf1V+EdixceqtYfAihFccA
        39TDy9HGEl5mnca2yJtO6YOI5A==
X-Google-Smtp-Source: ABdhPJxbX43EeFV7frl73sbQcSTXcq5whw8kL0kNaJb6Dysa8x99FtnS8yGivRJfQt3K9q+WsEVTcg==
X-Received: by 2002:a1c:e1c6:: with SMTP id y189mr8772221wmg.94.1605178938847;
        Thu, 12 Nov 2020 03:02:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x81sm6515329wmg.5.2020.11.12.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:02:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 08/15] input: touchscreen: surface3_spi: Remove set but unused variable 'timestamp'
Date:   Thu, 12 Nov 2020 11:01:57 +0000
Message-Id: <20201112110204.2083435-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112110204.2083435-1-lee.jones@linaro.org>
References: <20201112110204.2083435-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/surface3_spi.c: In function ‘surface3_spi_process_touch’:
 drivers/input/touchscreen/surface3_spi.c:97:6: warning: variable ‘timestamp’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/surface3_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index ce4828b1415a8..72dc4c562a4e1 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -94,9 +94,7 @@ static void surface3_spi_report_touch(struct surface3_ts_data *ts_data,
 
 static void surface3_spi_process_touch(struct surface3_ts_data *ts_data, u8 *data)
 {
-	u16 timestamp;
 	unsigned int i;
-	timestamp = get_unaligned_le16(&data[15]);
 
 	for (i = 0; i < 13; i++) {
 		struct surface3_ts_data_finger *finger;
-- 
2.25.1

