Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778F92690F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgINP7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgINPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE8C061226
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so515351wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEV41DUq4hDo9kX8U4tlHDYu2D0bOWfkfHs9aykeSRY=;
        b=Az3F1nlAe83fNePJ2s+NbIHrFXMuKbqDZ3xUKNKgg/U+sx6cssF12dPi+scUgEojyH
         /436BeRU2pd4LIP4bQItOUWN1LH09OGMaWmlkNtBcp7WxXGnoqviDrYWMQ7oNIRN9eZM
         suIYND/LIYAQMfaZCLtFbQFq4mWAD3nejN7No/yMkyMz8ov/i4I/e9YSWKFhMgekz+rb
         J1B9MzfEFMPJsodPV5gJ5eP8dKGoE3/bLpC0V6ev26q7pK9qSHvcX5EBeyRIRfpWNgZE
         itVpUomd3P+/xiKS4pxZQaKBIt6LR3Iyla9TCGngYkUD6Sx4rAxVqOUPgaM58AIj16V4
         qwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEV41DUq4hDo9kX8U4tlHDYu2D0bOWfkfHs9aykeSRY=;
        b=VYJPlbekI0gQvzlcTCaGJV6AgAtu2haJYdjbGuJUtXTOJ/5o10GFo0pJ0kx89HtHpB
         FvOLrGOYTAqBiU1S3ORqxHFaOE6gishWjhM5hE3Nb+CZhhoHpD0xIhjOqcf1X74du0s2
         wy/HVHeATw4HWuRFDfbLd8auJ5uEKRn/l5b9/IF1I1S1K2W+NX2fqB2vufTMjWHz6Z0m
         sfPXLbhvbga99PR3MF3xAPI7JM3vKrnCHykZAcoL1uHBMJGKL9QMJECxDDgSl+ZMNsIO
         Ucr7ZFInvMoIaOgzVHYUI4kN8pt+dSj2xFVLBlbGzQacTxEdb7EkEBWa0GEA7/xjmsvF
         frzQ==
X-Gm-Message-State: AOAM5306aKEbgbexOuAYjf+V4rne5fynPufqv50wKGDCEBa/UVZiFrsk
        umb1O0g/1vXc0VV2+67LOW2+dGNTb3XbSg==
X-Google-Smtp-Source: ABdhPJwFuDev5spRwtlUmLIoM8tFRiwMtQscTE6sB+Fnu9QqYcucjXQOatNfrRrq/Tqg0Bw/PBxKTQ==
X-Received: by 2002:a1c:2dcc:: with SMTP id t195mr20845wmt.166.1600098374174;
        Mon, 14 Sep 2020 08:46:14 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 10/14] rtc: rx8010: prefer sizeof(*val) over sizeof(struct type_of_val)
Date:   Mon, 14 Sep 2020 17:45:57 +0200
Message-Id: <20200914154601.32245-11-brgl@bgdev.pl>
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

Using the size of the variable is preferred over using the size of its
type when allocating memory. Convert the call to devm_kzalloc() in
probe().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index dba7c3f87d9e..aa357f800ad4 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -429,7 +429,7 @@ static int rx8010_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	rx8010 = devm_kzalloc(dev, sizeof(struct rx8010_data), GFP_KERNEL);
+	rx8010 = devm_kzalloc(dev, sizeof(*rx8010), GFP_KERNEL);
 	if (!rx8010)
 		return -ENOMEM;
 
-- 
2.26.1

