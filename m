Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F131325DD12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgIDPVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730798AbgIDPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:21:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC103C06125F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:21:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so6452329wmm.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTzOsHSC+gZF9PSWWpuSmxUozEdf7QQLb/WCmyturHc=;
        b=MfZkEE7Gfj0EtpOJBT7E7Tf2l0qG42PZBryzfeuryiCZ74FGcKYrek3oeHE6kk7niZ
         d95jS1ajKAMD3cSEE3LnGLsKhc/+uB2M3h/3qc8fJx82Vc9qJf7rtt5ICZ/EpHdIyJ/p
         gobCsWFnQc2hRa7E+c90WvWV62/pGlk09hWK1IIPvZus1bT4XkoLrx7mL/9hHlA/qzhj
         qTkQxQQ4mIsiqIOH3waewQkRPI+GEs/8kcwYCMSdi/5Az7ISYmcKvymWygDvTvrgoGYW
         cuG+NX1fx9ZTnVdkkZkw20h0bv4odID5CMSRzGhs1+niyMAZ0/TjBWzjxOFYIT0S1rTb
         r0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTzOsHSC+gZF9PSWWpuSmxUozEdf7QQLb/WCmyturHc=;
        b=I8w6jfajwqqHN5HJ/9IBLXqqdVPQtz99wtrrajHDZR2yIATIZVNTJVj3zJtPn2giYO
         x5c1yDdsvLSqlorNizKMLH4y+cXyKBKg3bjSeG09LPljB00lyYTlTXqICNY1QXWJMy6c
         fko1uIAj6m9g5R+/pCalalhCpV/xdno0gdqcJs/QJ/ewAxv7jnRV87Hf2FgUw0r7LFQe
         jf+JbzxWsfRTkAmcx3dLh3Wul3WQpXX3BQPc9EoFfqJkh+536jlcTARba4eloQj0FJE0
         B6Ds37zImZj8AXmcSKMbRRDpC0Lvfoc+ACjLKIV5adVRhBQgmzl/gNSAP8dkr8t/TpGv
         0eiA==
X-Gm-Message-State: AOAM532ov4XY/L8oXmCp4xM2lla7fpPRI99vVWWEZ96aFXupe03Rj9UM
        ragJOIedJ/uilhqfYWj9lHaFOA==
X-Google-Smtp-Source: ABdhPJz85fPQMFzckhhoTot2QaK8gl2HFrn/KMmGkiQzh+8CaGPlQpEFpsbRrgx1VteJY1b1GXeTvA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr5770367wmg.179.1599232888476;
        Fri, 04 Sep 2020 08:21:28 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id a11sm7789534wmm.18.2020.09.04.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:21:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 6/8] rtc: rx8010: drop unnecessary initialization
Date:   Fri,  4 Sep 2020 17:21:14 +0200
Message-Id: <20200904152116.2157-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904152116.2157-1-brgl@bgdev.pl>
References: <20200904152116.2157-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The 'err' local variable in rx8010_init_client() doesn't need to be
initialized.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index f3bed7be2533..181fc21cefa8 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -196,7 +196,7 @@ static int rx8010_init_client(struct i2c_client *client)
 {
 	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
 	u8 ctrl[2];
-	int need_clear = 0, err = 0;
+	int need_clear = 0, err;
 
 	/* Initialize reserved registers as specified in datasheet */
 	err = i2c_smbus_write_byte_data(client, RX8010_RESV17, 0xD8);
-- 
2.26.1

