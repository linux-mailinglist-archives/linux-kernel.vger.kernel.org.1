Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EE82A5E53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKDGsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKDGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:48:11 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3FC061A4D;
        Tue,  3 Nov 2020 22:48:11 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so16499954pfp.5;
        Tue, 03 Nov 2020 22:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfvrxPrBJGjeJqjA+QKlO7xKcbqowzvBic2gE6WrBIc=;
        b=gQFg7+IEGHm8KUsDcV9DwYXkLpSQcQqwrfaZqR4PhGzF1/B4B8fDXv0ZR/yGwbCcR9
         F7m64I/YV8+35M/mAPTTnVtYE8dh3Xm5YesJCv1yXxLHl8iW/6AwSzcXqVWZMUSfavda
         tH4nGCnqQOJ0f76yCxY7G2nV++UMFtI4AovOrpWDhfKalQOhZmDHxRJvvV958135e9MT
         3e+EhL+9cokTGCxSj00YFCscNPj0vIY38kbqzU+BHVnMmmHakdfSPvLyPhGp/ZWTqJDg
         0FCHvE3wYXJyTIypz/6jlclGlTti3+uzOa8//eLBjLWbjPIyD9BP9PwH9/KuF5phLP3J
         ghFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfvrxPrBJGjeJqjA+QKlO7xKcbqowzvBic2gE6WrBIc=;
        b=NubL0AmV4rCh0xvGDaN6cPn0/NI3grA63zU/DG4HrrDIvqCa9V5Qj0dWz+32QQM7Td
         kkQOv5cLtELNC5RJ1oRi82IaVeqwtuxiQW1Bh9VGGqFjtm5eGScrUHvgllNdRfwvX68V
         e/7IqCPcgNwcnQx19CHAK55m/lr5AJIEF916P/FZQ8NEnTEa0tfFk+9OMQy/NP878mwf
         GlEfSjtS5wBtescMlehsdA11pFJDoRUgtLjYrXQBG+/R83FG+LMm+UMWkUE90Av9tMst
         1A/ZMGScIXeOiLsPqg4ZtQSXNph8z1kS54b5boN5oI7sWKJkjKK+XkzICQMZTb/Gzn5k
         2F7g==
X-Gm-Message-State: AOAM533ItZOtA0nNm9iSkk0FmHIS2HmJGEBb+zdR5724mFYLJ065Qizi
        u90Pq9ZqQALT/i+MLGg5zTSY7dAUf0c=
X-Google-Smtp-Source: ABdhPJwlvOvRv2wJs5gb4nk7XbX/MNXQuf3Ps9uRJ5YdGrj5SrKXcXdqV8qanXEDbiLy5h9bT+bpgA==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr16243150pgr.335.1604472490875;
        Tue, 03 Nov 2020 22:48:10 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:16e6:8166:e462:9fba:da9c:beed])
        by smtp.gmail.com with ESMTPSA id s18sm1036873pgh.60.2020.11.03.22.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:48:10 -0800 (PST)
From:   Himadri Pandya <himadrispandya@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Himadri Pandya <himadrispandya@gmail.com>
Subject: [PATCH 11/15] usb: serial: ipaq: use usb_control_msg_send()
Date:   Wed,  4 Nov 2020 12:16:59 +0530
Message-Id: <20201104064703.15123-12-himadrispandya@gmail.com>
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
 drivers/usb/serial/ipaq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index f81746c3c26c..99505a76035d 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -530,15 +530,14 @@ static int ipaq_open(struct tty_struct *tty,
 	 */
 	while (retries) {
 		retries--;
-		result = usb_control_msg(serial->dev,
-				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
-				0x1, 0, NULL, 0, 100);
-		if (!result)
+		result = usb_control_msg_send(serial->dev, 0, 0x22, 0x21, 0x1,
+					      0, NULL, 0, 100, GFP_KERNEL);
+		if (result == 0)
 			break;
 
 		msleep(1000);
 	}
-	if (!retries && result) {
+	if (result) {
 		dev_err(&port->dev, "%s - failed doing control urb, error %d\n",
 							__func__, result);
 		return result;
-- 
2.17.1

