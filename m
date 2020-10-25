Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958402982E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417804AbgJYRrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:47:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44311 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417738AbgJYRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:46:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id b1so8902453lfp.11;
        Sun, 25 Oct 2020 10:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77GzeQG87LnkHIGFnWR/f42oB74q65RC2+RYqg9LfxE=;
        b=mHOwOQwkZcz3Iuoa9vTzGH0MgxQL59HvkHP4bKdxuhOkhjbLjlXelby3FxCrGxL588
         6eFyo8z/Bw6d8IzYWxCBbS6ABZNfiVWkQb9uhvI3rFZzguVTkZgxlOk47A5MpmugoBXp
         +CexKGgs/0Ym+ukdiMa4NNe2z7oCzNxhrMseHAaw/8mcXZrDO+b1/UKbf+GfzNnKxmW1
         2qr7n5sfehVacMbX4zy2s4eKdAAX0kYbnxcSjyKQme7Fm7KR+2TVkbe6RyqE7mrfehuM
         TRjPQ55+Gfh8SLPJ3A2Kz5UDyv7izEn/cw7jIcmyZTP4ubGBnRISt0l8YNVXLX22mbCp
         AFmg==
X-Gm-Message-State: AOAM530JLpmZl+Lp1zBPWFNJJBomTe9QSMJJVAVBzJIB9D67k3a6p3zR
        /gAI9tKZZTo8r7hbxqv5l3gINhj5HuKlbw==
X-Google-Smtp-Source: ABdhPJydIn6vU9cPJvKdPOun7F9klGxXe/Dm004xscAiVrPVAdUMDertUE+YHJo4sYIRfoDJcCnQ6w==
X-Received: by 2002:ac2:5c05:: with SMTP id r5mr4115205lfp.27.1603648000975;
        Sun, 25 Oct 2020 10:46:40 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id p14sm824010lfc.40.2020.10.25.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 10:46:37 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kWk6J-0007IC-JZ; Sun, 25 Oct 2020 18:46:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 14/14] USB: serial: keyspan_pda: drop redundant usb-serial pointer
Date:   Sun, 25 Oct 2020 18:46:00 +0100
Message-Id: <20201025174600.27896-15-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025174600.27896-1-johan@kernel.org>
References: <20201025174600.27896-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant struct usb_serial pointer from the driver port data.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/keyspan_pda.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index f582e0a3ae56..e6f933e8d25f 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -76,7 +76,7 @@ static const struct usb_device_id id_table_fake[] = {
 static int keyspan_pda_get_write_room(struct keyspan_pda_private *priv)
 {
 	struct usb_serial_port *port = priv->port;
-	struct usb_serial *serial = priv->serial;
+	struct usb_serial *serial = port->serial;
 	u8 *room;
 	int rc;
 
@@ -114,7 +114,7 @@ static void keyspan_pda_request_unthrottle(struct work_struct *work)
 	struct keyspan_pda_private *priv =
 		container_of(work, struct keyspan_pda_private, unthrottle_work);
 	struct usb_serial_port *port = priv->port;
-	struct usb_serial *serial = priv->serial;
+	struct usb_serial *serial = port->serial;
 	unsigned long flags;
 	int result;
 
@@ -665,7 +665,6 @@ static int keyspan_pda_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	INIT_WORK(&priv->unthrottle_work, keyspan_pda_request_unthrottle);
-	priv->serial = port->serial;
 	priv->port = port;
 
 	usb_set_serial_port_data(port, priv);
-- 
2.26.2

