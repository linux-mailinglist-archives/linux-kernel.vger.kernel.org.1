Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BFF2A5E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgKDGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgKDGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD82C061A4D;
        Tue,  3 Nov 2020 22:47:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so15741226pgm.8;
        Tue, 03 Nov 2020 22:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGCdR2zg93PxLfowoIUOGeqadZduI79Y1jQCNcPvnfw=;
        b=Ce47NTPV8niNPcpAYfYF2OEl7IvkfZ+6P937ZnFxssbhp64mXlNjGNiz95ujP+8EN/
         /SzZ6hKE78Ip6regihBDTo/GHyKcgiCX3OjPbPyUvKhjMN4woLcTXPSYymIKhu85RX62
         tptBy7wqqkFdBhIo4n6xArDqUpVuyuSwQ7gX1qFdt19ns4M3UDSlFK5g4/5y6Mv4UvY5
         IqcOSLDJRN84MNmN5CgBsHPmjV/PSLWJIbGqlkkE4yM6N29bvIVInwYcl/5XyGmb4zmU
         JiK+Bsi4qWzpPDXhMJJqpXoL/DSDYRyxsAQX9PQnV+4HM65NudqM9Xj/xipmCCpaRYnn
         kOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGCdR2zg93PxLfowoIUOGeqadZduI79Y1jQCNcPvnfw=;
        b=iQ1qSvjncwL29dZICTr0haOGDxfKpJ6UnPizpyPNZoqykhNoaDdfkE+OePqQmozvrT
         2ULaSkVDwXmT9SL5ezP+KLyK4FJjqsTNdCb73AfoavxgX/ZwZYucw3gVuu1GCTHojizG
         /QsGlxtzafdz3176p4HbE9Oz4uL9TotUH15pIzXyclqTlDvrN0dI6F55RZxJKEdjvwWb
         Bdlm5Y+2HzDN+ciRMG7L+76cm+DG3lCCLkcdOgyCSIX6vAEeHko6xNUkFqb3Bf8UBekI
         qRc3jTc9QX7rageFdu6WUsmVudGI37iWW9IB0V5i/VJXXJ5B3uo4OnBLl6Qy7w13UjoE
         Hrcw==
X-Gm-Message-State: AOAM531hts/qU4jDlwTfGvhq0yEHZGWzAZ0qgOe83VxBe/zF5FqnHFkA
        nN2e+r7cIbUtTJD/Z08qZWM=
X-Google-Smtp-Source: ABdhPJwHD78ybryi7ZO7u5PSZtfGLkLqwqQ6nfgHB3CPsSeV4quBSMb/+N7R9bIwgcw9R1hc1N5whQ==
X-Received: by 2002:a17:90a:5285:: with SMTP id w5mr3010576pjh.50.1604472452997;
        Tue, 03 Nov 2020 22:47:32 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:32 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 01/15] usb: serial: ark3116: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:49 +0530
Message-Id: <20201104064703.15123-2-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
usb_control_msg() with proper error check. Hence use the wrappers
instead of calling usb_control_msg() directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/ark3116.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 71a9206ea1e2..51302892c779 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -77,38 +77,17 @@ struct ark3116_private {
 static int ark3116_write_reg(struct usb_serial *serial,
 			     unsigned reg, __u8 val)
 {
-	int result;
 	 /* 0xfe 0x40 are magic values taken from original driver */
-	result = usb_control_msg(serial->dev,
-				 usb_sndctrlpipe(serial->dev, 0),
-				 0xfe, 0x40, val, reg,
-				 NULL, 0, ARK_TIMEOUT);
-	if (result)
-		return result;
-
-	return 0;
+	return usb_control_msg_send(serial->dev, 0, 0xfe, 0x40, val, reg, NULL, 0,
+				    ARK_TIMEOUT, GFP_KERNEL);
 }
 
 static int ark3116_read_reg(struct usb_serial *serial,
 			    unsigned reg, unsigned char *buf)
 {
-	int result;
 	/* 0xfe 0xc0 are magic values taken from original driver */
-	result = usb_control_msg(serial->dev,
-				 usb_rcvctrlpipe(serial->dev, 0),
-				 0xfe, 0xc0, 0, reg,
-				 buf, 1, ARK_TIMEOUT);
-	if (result < 1) {
-		dev_err(&serial->interface->dev,
-				"failed to read register %u: %d\n",
-				reg, result);
-		if (result >= 0)
-			result = -EIO;
-
-		return result;
-	}
-
-	return 0;
+	return usb_control_msg_recv(serial->dev, 0, 0xfe, 0xc0, 0, reg, buf, 1,
+				    ARK_TIMEOUT, GFP_KERNEL);
 }
 
 static inline int calc_divisor(int bps)
-- 
2.17.1

