Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B62690FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgINQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgINPqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0EC061222
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so528855wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avMaqwPGzdeKkSKqRirt6hCdePgw6LORRPG15IF7BP8=;
        b=z5Dq2xz7pXKlDrPAHbbIocObQJ4q+ZhUVYDnRGffL97PkmBw35XlCHi+Ps+RMMZPFm
         pjxEA/tKW45yyLw/yscwWynEWI2bGzpw1uw+f3B3SCChor9bKn0kqFKGIs1Bi5Jc4AUU
         0dodGuafj2OMuafnmBHAu3D7A8//WJ+3QZZI229LYvG3xZGOkeeTuEQn5V5Kid9MF+Ra
         cg3L/glPbxjpkfa+DXZkSg9Zfs7bjAWcuGcA2GRQUJFmNIPt21mO1Fka4YeGPSL74xMR
         mjqt1u/66cjQVNEWBnjwa3jQaMVcXdJ7ADt0sfM//c/kKvWH02toNkZ9hBc0tNoCI1nB
         vEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avMaqwPGzdeKkSKqRirt6hCdePgw6LORRPG15IF7BP8=;
        b=Y6zRlHbOsEmS4/X6kq5tB7tAASqH0WNsQb9wfSm25tc4aub7ZnpvWxSIwG5JC8djtI
         xlrTnLAgdCM0XPY7F905rj6GsX/S61UpwM3+O6yziXyW+1lQomuYdu4JJAbe26Hhtu2X
         jy5emhEOcrvS7kz+nAE8Lt3znGQgG8Gs00H8HESkqBT/J9YgYPZO4SBi5K4/fvapakSL
         4m2YeY7in92/Ua42DjNol/0HEQmJF3cZN6YTjweOoeZR8UA32Ozp0UMn0ZyFqdZVN19j
         2axDF91NZh3b4SsiwbN7SmLk4ER3JbBHjrTSj+Mj3UrParJ7R9JysygfrcALXytmuG0S
         Sprw==
X-Gm-Message-State: AOAM533qFUp1ljl3X5YpC7iKhJYfq76tklsb6u5YVzSSrAR1TJq6BURp
        Ic1XRaKtCpxSDVxgNXUqV7X43Q==
X-Google-Smtp-Source: ABdhPJwGUZouYD38wJ7iS8X9se2XvwqnoGs+3+A93aquGGR79iwQUj2YoEmWPsD1BGx2Hsn9MHru6g==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr22011wmk.178.1600098372266;
        Mon, 14 Sep 2020 08:46:12 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 08/14] rtc: rx8010: drop unnecessary initialization
Date:   Mon, 14 Sep 2020 17:45:55 +0200
Message-Id: <20200914154601.32245-9-brgl@bgdev.pl>
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

The 'err' local variable in rx8010_init_client() doesn't need to be
initialized.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 2c894e7aab6d..64a9964eb5e0 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -194,7 +194,7 @@ static int rx8010_init_client(struct i2c_client *client)
 {
 	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
 	u8 ctrl[2];
-	int need_clear = 0, err = 0;
+	int need_clear = 0, err;
 
 	/* Initialize reserved registers as specified in datasheet */
 	err = i2c_smbus_write_byte_data(client, RX8010_RESV17, 0xD8);
-- 
2.26.1

