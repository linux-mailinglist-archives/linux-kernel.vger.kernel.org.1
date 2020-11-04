Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24202A5E57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgKDGsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKDGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:19 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF27C061A4D;
        Tue,  3 Nov 2020 22:48:19 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id u2so3886084pls.10;
        Tue, 03 Nov 2020 22:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txw7VexweucfLOC8DKUSmw/Pbo6mBmR3atijpGysA14=;
        b=iCE670pQ4lYbvgpa2WSgZrx62oRISLwyeX3gsg+drYwun6OT/Ax86dlZecFvfEOuNV
         N0LfEiiuNKLNQlQ55gkerkqxqsKGPM5awSOpMM4FIVz4/XEM0F4WC+TslImeVeb/vBML
         gIr+G5w8kUpy0/aBLvtEBpXUnzoDZET2SOyQpoUvVUoj1xrzPFh5YzpuyTQDaMgMKQBo
         sMMr2JEYJAtBLAp2eolhN0zpS6ZpfU/SPSOis8DFrhfwzhlJVrLkvVrZH/h8bZB4qzJT
         doIl5IOpvb6Y5RryTCtpyf3U6eGB2bCEM/QA23LpGynYLRXwuzJVoyb5hqRMk8iNeRN9
         vs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txw7VexweucfLOC8DKUSmw/Pbo6mBmR3atijpGysA14=;
        b=SYMIEMpxt+ieRDwTadNM0uL0QL1TztDHWJBBCg/Qgg6dpURPi0NAxzT7NQ0x+teoya
         FGaEoQpS1Sm3BFqwh3oT1YSzcXbXNpbz9UYwpixe0Ce7hqjm3wwPwN9jcl6h/8SHmwLi
         1VpAe1clPqmnb1G/DfO9+U2TdfWyM3WgW7VqFecsHyLno+ySZZW3M7RIZw0xyaTMK0YZ
         QhVYZBZLiZtVc9MVqYAu3ahj6PyNlbL3F1PBAFfdNHj4E8iJh2/Cvq4lpJy7/AwudMYz
         v5mlcvmolGWADMrVdcfT31bHlmSlomRAPS4Ps+2u/JrQtVrj377nUptyBrNY9CFLuyyV
         Foyw==
X-Gm-Message-State: AOAM531c6WzGOySTgs5I+pdP9w5WOyTnvtuLHp0NtqTR3wCn1u1DHF2+
        +Vj2jGZm1bm33oOLICXk0+Q=
X-Google-Smtp-Source: ABdhPJw3Mli9dEzf7RX1ydq7l+a9Gpmq8nGi25EshURUUZ7k4Dp5tWy8+ySE6k0jE13aXGKJXoLRLA==
X-Received: by 2002:a17:902:ab85:b029:d6:b5d2:b6fd with SMTP id f5-20020a170902ab85b02900d6b5d2b6fdmr17595747plr.9.1604472498960;
        Tue, 03 Nov 2020 22:48:18 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:18 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 13/15] usb: serial: iuu_phoenix: use usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:17:01 +0530
Message-Id: <20201104064703.15123-14-himadrispandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104064703.15123-1-himadrispandya@gmail.com>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new usb_control_msg_send() nicely wraps usb_control_msg() with proper
error check. Hence use the wrapper instead of calling usb_control_msg()
directly.

Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
---
 drivers/usb/serial/iuu_phoenix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index b4ba79123d9d..dfbcdcec94e7 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -968,9 +968,8 @@ static int iuu_open(struct tty_struct *tty, struct usb_serial_port *port)
 	priv->poll = 0;
 
 #define SOUP(a, b, c, d)  do { \
-	result = usb_control_msg(port->serial->dev,	\
-				usb_sndctrlpipe(port->serial->dev, 0),	\
-				b, a, c, d, NULL, 0, 1000); \
+	result = usb_control_msg_send(port->serial->dev, 0, b, a, c, d, NULL,\
+				      0, 1000, GFP_KERNEL);		     \
 	dev_dbg(dev, "0x%x:0x%x:0x%x:0x%x  %d\n", a, b, c, d, result); } while (0)
 
 	/*  This is not UART related but IUU USB driver related or something */
-- 
2.17.1

