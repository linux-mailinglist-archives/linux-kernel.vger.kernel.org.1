Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724442A5E45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgKDGrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgKDGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:47:49 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFCC061A4D;
        Tue,  3 Nov 2020 22:47:48 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o3so15722215pgr.11;
        Tue, 03 Nov 2020 22:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TSlwhbTV17TkpJXdKDkhYenknX5pNJ6noEIgEUfNOLo=;
        b=TRRDSpAYA+9b7oCBslKQ1lWAPU2pWq6ePYfuMk7OWIOmCYO2KISt5kjdyQpzts62fb
         8cZOOiZ2ykFmtNemz4KVrHYmB5z6GLxRGFbyxFu+S+u7pRTCB7fI3B00KMK5p1usfE1i
         gWD+Zs9HSeMqduwUmrepY0nmP9KgocDkjAKIYSejUn3u2SS6F2Q82WH7+1hbIaozMHr/
         JDfsWVCSQgojY/XyyC+qQ8nql3/CZ0q3nOa/5CojdFeX33+uhD97CQTGl0HuLjgUTU1v
         3UldhNgw7eXu6XjfSwDWdpFy/Lqop1JX7nNkHVwJ7Fh3MbqsMCBrZl6EBrXO0NWIhh18
         RQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TSlwhbTV17TkpJXdKDkhYenknX5pNJ6noEIgEUfNOLo=;
        b=DzmfmPxbzOOuukG4/jrdhiLOe9AkmEAnzUFzEAK9EI1ErkT+flVo9M0/kOafqM6UuX
         B0gXcygs0sDdJXf0e2iFZxkWh126UBO1dlpIQx4A08b8sslxqRSwTcLEfpp8wwd0lN58
         6QbMOBR0Tbz7bCw0FKr0AH+ytz8GTRL0rKtjk3AU5h44CLnAH0dVbz5TswZglpjeFKj2
         M8V4wz9fAH//vlXsfCPY/heBZ0hvI43T8QwtI1CBh7LzXfTGQRNGqIg38PNF89wOmzIw
         MiPMLbFZmTJ3807z4XOmEVLRymlm6z0oTb19leP8j2uBY3W4Xs0n4aJrmLQsPbJSHRB5
         fxZA==
X-Gm-Message-State: AOAM532EZ+EHuzvsHSPKnscKBA2vo88YQqYHOAfjOJkudEF2imT11ObZ
        +wgTeUkF3sgRi2H8zkoeGIo=
X-Google-Smtp-Source: ABdhPJy0TMDgkqBlyzvxX29fFTS8osZu0OWFz7ImWJTXyD7yV/BujyK/XeYXPKrUXl/A7NUMSWAb+g==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr2897977pjw.168.1604472468086;
        Tue, 03 Nov 2020 22:47:48 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:47:47 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 05/15] usb: serial: cypress_m8: use usb_control_msg_recv() and usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:53 +0530
Message-Id: <20201104064703.15123-6-himadrispandya@gmail.com>
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
 drivers/usb/serial/cypress_m8.c | 38 +++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index cc028601c388..4d66cab8eece 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -341,20 +341,21 @@ static int cypress_serial_control(struct tty_struct *tty,
 			feature_buffer[4]);
 
 		do {
-			retval = usb_control_msg(port->serial->dev,
-					usb_sndctrlpipe(port->serial->dev, 0),
-					HID_REQ_SET_REPORT,
-					USB_DIR_OUT | USB_RECIP_INTERFACE | USB_TYPE_CLASS,
-					0x0300, 0, feature_buffer,
-					feature_len, 500);
+			retval = usb_control_msg_send(port->serial->dev, 0,
+						      HID_REQ_SET_REPORT,
+						      USB_DIR_OUT |
+						      USB_RECIP_INTERFACE |
+						      USB_TYPE_CLASS, 0x0300,
+						      0, feature_buffer,
+						      feature_len, 500,
+						      GFP_KERNEL);
 
 			if (tries++ >= 3)
 				break;
 
-		} while (retval != feature_len &&
-			 retval != -ENODEV);
+		} while (retval != -ENODEV);
 
-		if (retval != feature_len) {
+		if (retval) {
 			dev_err(dev, "%s - failed sending serial line settings - %d\n",
 				__func__, retval);
 			cypress_set_dead(port);
@@ -379,19 +380,20 @@ static int cypress_serial_control(struct tty_struct *tty,
 		}
 		dev_dbg(dev, "%s - retrieving serial line settings\n", __func__);
 		do {
-			retval = usb_control_msg(port->serial->dev,
-					usb_rcvctrlpipe(port->serial->dev, 0),
-					HID_REQ_GET_REPORT,
-					USB_DIR_IN | USB_RECIP_INTERFACE | USB_TYPE_CLASS,
-					0x0300, 0, feature_buffer,
-					feature_len, 500);
+			retval = usb_control_msg_recv(port->serial->dev, 0,
+						      HID_REQ_GET_REPORT,
+						      USB_DIR_IN |
+						      USB_RECIP_INTERFACE |
+						      USB_TYPE_CLASS, 0x0300,
+						      0, feature_buffer,
+						      feature_len, 500,
+						      GFP_KERNEL);
 
 			if (tries++ >= 3)
 				break;
-		} while (retval != feature_len
-						&& retval != -ENODEV);
+		} while (retval != -ENODEV);
 
-		if (retval != feature_len) {
+		if (retval) {
 			dev_err(dev, "%s - failed to retrieve serial line settings - %d\n",
 				__func__, retval);
 			cypress_set_dead(port);
-- 
2.17.1

