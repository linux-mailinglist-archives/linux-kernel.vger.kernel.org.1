Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3132826909E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgINPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgINPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477EC061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so9150120wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qUo9FGy3DJ1HIJTn23pZSHLPlWdvQkOdenBVqoTjpIg=;
        b=K3ZPLBWVRVTSIxU+c7mMndyVpQPPXct3b6XnpbxZZ+1OsV5CZ86Cdyb2PBnxowJ/Y+
         VbsblkgEKxUK0gyyj+jkmXOT+qkmI35yeO6gFXV/Xh/n/hUOrUkqWRVvhP8qrvopD30l
         2gf7eKf8JiTl9yuqyI/lFQ2Y5bRkP1RQzbxJcaemkk9ouzBSwebxvDqwuj8Y0JIQq5MK
         Ay+yw5QRt955hKqyzVsax67gqvEQmEx1z6ndBDh7DVxn2x19NxR+IcfBkYNavx4fHBt3
         e3lJF5pqze78diidk4IGPwJL5iEybfP75JFs1Za6RSWgNwaWuoWCxhyYeYR0WppXJiJO
         sO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qUo9FGy3DJ1HIJTn23pZSHLPlWdvQkOdenBVqoTjpIg=;
        b=ua4lm8HFqvuyjsewDmHUa6zg4VNrQarpFkMn5Vj3PswLickVs663LLqCCTQh72C32i
         SAv36XlMVvjfKie5QWwvuNqO947JF6uyUPiv4EF9FRK63tr49r6jSOqoPGJVZ1dNKr5v
         zfC8WyVgWpXB4bAj0mz8zNBdwH4RZav/GLoA49C9kNmzZMdFYpkT3Ur2MK0jcV9CXecQ
         2HdhltWP2daqmDE6WorvPJweihv1FxVPfkeSeqF14HUv5QZ8I4T3fQbdCQtiP9sYpd40
         avQspyfYlmqlYmVZL7E0XZ5d8tLsgiiEHZwGZF+4iWZACefKG5GALf058uLf6k8gpSuS
         Z7kg==
X-Gm-Message-State: AOAM532QU/F66023trnBHZEdCJaozE0W2I5ELb+2x+yYjHf1VdCq8jiq
        dLqIj9swbOzZtB4hUVJpr4c/wUAwvSi6yg==
X-Google-Smtp-Source: ABdhPJxxxKyyRa5aJn/A7LZ7NnBJdKU5wwFQ5c5WzMjAF0Dqio7hlGKF8IpL9IFW0tJ+Ci2qpZY35g==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr20196wmg.182.1600098365916;
        Mon, 14 Sep 2020 08:46:05 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/14] rtc: rx8010: remove a stray newline
Date:   Mon, 14 Sep 2020 17:45:49 +0200
Message-Id: <20200914154601.32245-3-brgl@bgdev.pl>
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

Remove an unnecessary newline after requesting the interrupt.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 08c93d492494..c6797ec0aba1 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -454,7 +454,6 @@ static int rx8010_probe(struct i2c_client *client,
 						rx8010_irq_1_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"rx8010", client);
-
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ\n");
 			return err;
-- 
2.26.1

