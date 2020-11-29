Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC312C79ED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgK2QIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbgK2QIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81995C061A51;
        Sun, 29 Nov 2020 08:07:24 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b23so5088975pls.11;
        Sun, 29 Nov 2020 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dyffzvu2x+IL6U+7i1kbp8EqPJ/1pVi63LQoMYA85l0=;
        b=nMsPwpWlX30Gdz+D4p5oJnKAalzTiXcWuDf3LvY4/Wu73B9BkGvZb4XjRCS8IpbBwk
         AlBgYK04qm0F5GbDkzzY/UutaY9u+SK2KzvH/9PvU8P+QCGkUKaoed/VQv6qneu+C2ht
         tnPDf3C/EG+/nglY4Nm1u9c6mXdC9TrUO8GWfUq0UXpFN2whCvlUMY4e/sRoGkYXSpsK
         mNIIRPRdxoopDkfSyo+27Xid300gt/NQ5lrOcAAPeYIcIALkh73aK4agLYbE+A1GEnbp
         7vUtNMeSXozuYEo5Mie1PbxuhZGT+U4AApAKAFxfS37GnJEIJ+Stowlod00WKDYP05aM
         jKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dyffzvu2x+IL6U+7i1kbp8EqPJ/1pVi63LQoMYA85l0=;
        b=jaUZ0O6Xi/9eXypj7EcLu06GfTcrL2meuzICjQQZZLsC7qJZnn3KVfw6WaK6zmMslN
         TF0H3mA85iaAgtdRJnFoqlPcnUMnXzlVqRK+pL5f1hz21JYPDjMJM4mW3uFai+lYDOR9
         s3q/HUxPOcpV98knaupFhGnWZ7BOuVeIdbfzZM6XDOsHL4PCdduB/eh3vGF+nYbUTEki
         Gt1HoS9NgqwQai7hXfXrVa3JePtuXzrYWFevZhI1Y9/36IClUbA6T05SpJmh9QmjiXz0
         Z1QzNrJKQAjN50wRvbbVcRW5q+ZASvxd6N1aMfAnp1j3/B6PMD2m3WTz3EBnnBThmnxY
         Ee2w==
X-Gm-Message-State: AOAM5333Dmx8OfSQ/phKYBPowbKY/IaR20ix06jRZXUis0O+uebN413u
        hJEOU9MRsr7stvH9mvmPS0TUlcgi8gCv0KYsPiM=
X-Google-Smtp-Source: ABdhPJyo3SMxgU0SiNj6hrUlwAvMCQAi4hrhDk3yQETtLUBO9+uDp4nUnHXvo3Dov36OtFQ0WxnOAw==
X-Received: by 2002:a17:902:aa8e:b029:da:1c87:e1a7 with SMTP id d14-20020a170902aa8eb02900da1c87e1a7mr15008136plr.40.1606666043964;
        Sun, 29 Nov 2020 08:07:23 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:23 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] usb: misc: trancevibrator: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:10 +0530
Message-Id: <20201129160612.1908074-14-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() and the return value checking condition has also
been modified appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/trancevibrator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index a3dfc77578ea..2c36ee249b4b 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -59,12 +59,12 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
 	dev_dbg(&tv->udev->dev, "speed = %d\n", tv->speed);
 
 	/* Set speed */
-	retval = usb_control_msg(tv->udev, usb_sndctrlpipe(tv->udev, 0),
+	retval = usb_control_msg_send(tv->udev, 0,
 				 0x01, /* vendor request: set speed */
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 tv->speed, /* speed value */
-				 0, NULL, 0, USB_CTRL_GET_TIMEOUT);
-	if (retval) {
+				 0, NULL, 0, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+	if (retval == 0) {
 		tv->speed = old;
 		dev_dbg(&tv->udev->dev, "retval = %d\n", retval);
 		return retval;
-- 
2.25.1

