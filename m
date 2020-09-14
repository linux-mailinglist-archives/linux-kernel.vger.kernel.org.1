Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49C2690EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgINP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgINPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D2C061A10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so506158wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJ05GIM5VsS2yiXaAJqmcLCOwDz0VZkcOpGm3rJm6lA=;
        b=GdVwKgSs+W+8Lgf7KkHcvg9GafNOENKBc2QdAPDfVpxuCfSnD626g1Gha1BudiWIX4
         naUI3Ud4QH/njSuDHXC0ruyzdcx4Lwo9EMo56ivCyNCWtXTuEXXyeFkLDH+I7BRJQ/hy
         VtufdtVilPrRLN9bEXo/lU27WyPvyEhwvajQnf+9qD7nnfzj2Iag5MhwpckwNTg9W6VM
         0PEjJRlZ4GIyS5A7LrsC2WDINvM1T8O9Y87M2bFebq9w9Jr8FxnytrQASAnQIOluIoKz
         FeYqVj1dkRGCdpENGHdZM+R2wXqSiegcDsmNS42PoOlDIG/qfbgKf2CorEG9E3d6mh8k
         85TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ05GIM5VsS2yiXaAJqmcLCOwDz0VZkcOpGm3rJm6lA=;
        b=d9O6hhVMNPIGJ+W20Me6zrhMbHwW5i6hT26N1MSVvxN8PHydaM5OX+P8OWQO4KzMWl
         f+djVDlunox2JSx0sGTu3wS7XC/4w9BKUQofuCHUnhJB3yUWPucn3R7LSY1laKaplM2u
         mBecLuhqHmP4c6W/2qr6xe2Dicnu+q2Srgh616CDUwNNY0HIWRJTfyGZWzi8BU//EQp2
         6iLaG93+jfkvstELBjsn8tWp09WNJi0Xt58K84MXjliF+8VRRcozIY+Hk3CZAESYuzyF
         XnDZkyNoCWisGA2cKdeoNVdO+7tuJaSSLND5IZm5+C+4Zbf0lBsCNDywD6PGDRR0kgx9
         GMSQ==
X-Gm-Message-State: AOAM533i2YwXZlF9ld8A0faU8AVc3gLdyQ1Os1IJG2BSYl4RnuOnpe+/
        hxTCbdbs9Kfph8tagx0r2kQmSw==
X-Google-Smtp-Source: ABdhPJzoNU6DBG61ZYnZYLOEF4Qk5ctIwlgijgjPwzfzHfVo98LPePhCVsBKavSNPAg/TQsllDUeog==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr15408214wme.179.1600098378278;
        Mon, 14 Sep 2020 08:46:18 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 14/14] rtc: rx8010: use range checking provided by core RTC code
Date:   Mon, 14 Sep 2020 17:46:01 +0200
Message-Id: <20200914154601.32245-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200914154601.32245-1-brgl@bgdev.pl>
References: <20200914154601.32245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need to check the time range manually in set_time(), we can
use range_min and range_max exposed by struct rtc_device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index b8aa98fb62de..01e9017d4025 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -140,9 +140,6 @@ static int rx8010_set_time(struct device *dev, struct rtc_time *dt)
 	u8 date[RX8010_YEAR - RX8010_SEC + 1];
 	int err;
 
-	if ((dt->tm_year < 100) || (dt->tm_year > 199))
-		return -EINVAL;
-
 	/* set STOP bit before changing clock/calendar */
 	err = regmap_set_bits(rx8010->regs, RX8010_CTRL, RX8010_CTRL_STOP);
 	if (err)
@@ -419,6 +416,8 @@ static int rx8010_probe(struct i2c_client *client)
 	}
 
 	rx8010->rtc->max_user_freq = 1;
+	rx8010->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	rx8010->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	return rtc_register_device(rx8010->rtc);
 }
-- 
2.26.1

