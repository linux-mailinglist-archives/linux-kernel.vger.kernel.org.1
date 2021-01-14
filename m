Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6742F6477
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbhANPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbhANPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:24:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D75C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:23:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so2508115wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/gXgNDu1uyW35GFMajH90cFbEvxlmWXIJTYckxzqVk=;
        b=krtlsG+aLWRAIX9zV+NsYdLbI48e1rxdpWZNPphUG+hAJz96nZsRel763lARXW5V8z
         TX0t8kxqdYeuJC7UkKpw6mWnnxI+AFmCQIjRKT3s0VpTYlfLBpqT+1ufUY2RN9mpobIZ
         TiQfQuMBRP9ixaLxo6a6ohljtZNq95lk5ko8yI8+TwSyPN7LL5H/9Ppa2YmwDmA0AWDB
         rlFWie1u6F8XbK0IqXCFx2upanbDm9JC+GGh8nr66ylcpg2qBLoIKGMcSLPVph76w19Y
         MYiT6Vzm71CwHtvd5MdAZNYr2nGIPkt09IEdHs9ZpZAjxqgFk/EFxTzlQRIDtRXrzQ+h
         QdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/gXgNDu1uyW35GFMajH90cFbEvxlmWXIJTYckxzqVk=;
        b=ceGi3ryn6a+Z1N6pkWFXY5G7ymybnmkv5FJzdDk1GP9Aezv5zegCN9dF7tR5Nss/7U
         Phu0jkAH4ke4Og39RxQE/DpPOqFxz/e1z2SkTZdxNXfqK0pY/pTfVPaxiEVAuRMxoFCw
         /8OAQcfSQP2pD4+20YHTvNMaH0nKFb7+Ev19BBpOKH0g0GXsuVnJFIgJeF9xWV9Pu9u4
         1Sq/kfVZI/K6eiAL/M1aJtaSl6LPpjM0NwBAlyN7FL9tgxXj2/fTL2Z4MhWr6hi76M0+
         oufDfiPwJud/qbbO95w8PfDmTR7+lHQbZMCPiimuD/t5Bbi6rvOylWftjJvMqeX4ouE5
         /jtg==
X-Gm-Message-State: AOAM531S6mdDyms4QaWVBe1yM0VsCogQK5Knu3tpgjLwYnh98wO+CYdH
        gkHJN68C1sdEEm8+3hmA8kgUJg==
X-Google-Smtp-Source: ABdhPJw+mdqQdSv/cG7KLNxvSCpUa7jSfXXjrft1iLVMvVdpmSN7RS5FfXzrLw2Q4OMUNOP/c2LklQ==
X-Received: by 2002:a5d:4e89:: with SMTP id e9mr8367193wru.201.1610637816788;
        Thu, 14 Jan 2021 07:23:36 -0800 (PST)
Received: from dell.default ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id e15sm10777713wrx.86.2021.01.14.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:23:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Daniel Ritz <daniel.ritz@gmx.ch>, linux-input@vger.kernel.org
Subject: [PATCH 3/5] input: touchscreen: usbtouchscreen: Actually check return value of usb_submit_urb()
Date:   Thu, 14 Jan 2021 15:23:21 +0000
Message-Id: <20210114152323.2382283-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114152323.2382283-1-lee.jones@linaro.org>
References: <20210114152323.2382283-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/usbtouchscreen.c: In function ‘nexio_read_data’:
 drivers/input/touchscreen/usbtouchscreen.c:1052:50: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 397cb1d3f481b..44a5454d04533 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1044,6 +1044,7 @@ static void nexio_exit(struct usbtouch_usb *usbtouch)
 
 static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 {
+	struct device *dev = &usbtouch->interface->dev;
 	struct nexio_touch_packet *packet = (void *) pkt;
 	struct nexio_priv *priv = usbtouch->priv;
 	unsigned int data_len = be16_to_cpu(packet->data_len);
@@ -1062,6 +1063,8 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
+	if (ret)
+		dev_warn(dev, "Failed to submit USB Request Block\n");
 
 	if (!usbtouch->type->max_xc) {
 		usbtouch->type->max_xc = 2 * x_len;
-- 
2.25.1

