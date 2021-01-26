Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAF2304F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317791AbhA0Bkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389138AbhAZSlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:41:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2DC0613D6;
        Tue, 26 Jan 2021 10:40:20 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so10240431plr.9;
        Tue, 26 Jan 2021 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMoEajyDR9iy/8AmtoE+xZAQV9/TdmV8a3AZX9/gsow=;
        b=EF26dfb3eED5YtxaqteBfV8MDvCUudo3W9MhQH2ZK388/AzZVFdpsg8UO2AFxPTv7Z
         GiZ99Fqrm5Igv+DWOpyDZ+Bs9WL9asQDedlewINodicAp/+Ch5Xjkav/6YKEKaC5F173
         Tsw/HlEIFaCRywjFnzRNYPvgcZ+jbGREHvF/h9Mc3n+fkf10p3ZEWR/he+uUzaxz5ezd
         Ep+I7+kb0kRhrx5LatHqduLET0e3RQlMQIddpg+sN2y6b+GMCXHj5DSjZQU3CLDmIirc
         b5RqjJGcKLGw81K1hPXO3bMorPfm9OT5Bo5+UjqQclFOMs0vAPyELbZOWYpGjpuh5ILF
         eaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMoEajyDR9iy/8AmtoE+xZAQV9/TdmV8a3AZX9/gsow=;
        b=HgQ118wBlfoQsQkQ2JSa5CQUqclGScNEIgr1OsCjcjP7d+XJmWfbSaDkoR6BaXTm8z
         zzwNToW5QLGORVXgouQdafU8VvYBApl4ZXHIlpNYVO3pDt08h8riuc5+5hbgKpiJff7G
         AqtYxUHNY1kDslkAuuTEf1lLpCo5K2O7kC9yO+6r+NDRpLNr6ycQ+wn63nE9qgl+WjNq
         wMpb7npI9PlBaePrAGJ2mJAgzW0R2T796qunoL7zyFDWGxcLMBYZgyMzZcEYfMQM0DV+
         8ZgfS5sEgdGe0Vk3rsWrV3t2OPBB9Em4B74alf2zZlB0+pGUxXNsIFQGc01ZE4lOJwmJ
         LknQ==
X-Gm-Message-State: AOAM5324E7SexkIw/nRVJA8Vcv57gRZLvZsWpVJpXcUoRMsS35Vep7bN
        ipBDrTtYDfRlRrJi3RdAQoA=
X-Google-Smtp-Source: ABdhPJwl3jRKxfO70x4lMp4CvvCr4Oh4KYm73OCOVv3zzrkC17DlZ8JarQaGzAWHUtCJYPT1cFvfSw==
X-Received: by 2002:a17:902:8213:b029:e0:1096:7eec with SMTP id x19-20020a1709028213b02900e010967eecmr4704370pln.50.1611686419832;
        Tue, 26 Jan 2021 10:40:19 -0800 (PST)
Received: from localhost.localdomain ([49.207.195.86])
        by smtp.gmail.com with ESMTPSA id h3sm19097435pgm.67.2021.01.26.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:40:19 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] usb: misc: trancevibrator: update to use usb_control_msg_send()
Date:   Wed, 27 Jan 2021 00:10:10 +0530
Message-Id: <20210126184010.914841-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/trancevibrator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index a3dfc77578ea..c50807b4f4ef 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -59,11 +59,11 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
 	dev_dbg(&tv->udev->dev, "speed = %d\n", tv->speed);
 
 	/* Set speed */
-	retval = usb_control_msg(tv->udev, usb_sndctrlpipe(tv->udev, 0),
+	retval = usb_control_msg_send(tv->udev, 0,
 				 0x01, /* vendor request: set speed */
 				 USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 				 tv->speed, /* speed value */
-				 0, NULL, 0, USB_CTRL_GET_TIMEOUT);
+				 0, NULL, 0, USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
 	if (retval) {
 		tv->speed = old;
 		dev_dbg(&tv->udev->dev, "retval = %d\n", retval);
-- 
2.25.1

