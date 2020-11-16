Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976D2B4AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbgKPQSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:18:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41294 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbgKPQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:18:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id w142so25891810lff.8;
        Mon, 16 Nov 2020 08:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZzhnBWZAFoUIO32adm4SusNdUmurfDUtsAmqknNGZQ=;
        b=cxDvYqxMsD8GW4bjEmHJa0BJ2xE+JJQmp+AdhTAVwHLhJ6ZgIexpZx/cV4Ckb7hGK/
         EODsWtuvIi3UDNIwj5dwwKQ44AsRIemUUUmAiLINUPtC8DjEPyChtoVrsq3LFhkFpsJ+
         vUSoJLAtfpqW4VPjL5OkTCyxj5hAm2Lq2S/n7a+4wYmx/fXYRSeRlEufcf1bwpBkeLWL
         ez5ndBoL/cGiErTv/SmnIPY/X9x15KYXa3ji3YXwuK7bzcUOBL0aW3Bts8Y+6wnvlxGD
         MiMG3r+HX4hqihWlr+g4wY4yT7Tub55XUyG2ZnddPqOw4RyYXnMZaukbb4vOE+nmFvHX
         hmOg==
X-Gm-Message-State: AOAM531n/gPpC8gCfFVXFrl3be/przASGBExityQzB7yBUUE3GO72aqC
        tS1Husvsr5k31+LheS2uRBoOezKCR902nA==
X-Google-Smtp-Source: ABdhPJx4cQ9SbWkXa0hXcyh7auOlzDtVBtZBnW3C8BReMBV5wvUxhclyN/t7fkNy4NrJ7HoVWgrifA==
X-Received: by 2002:a19:8605:: with SMTP id i5mr56315lfd.15.1605543521110;
        Mon, 16 Nov 2020 08:18:41 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id v195sm2772224lfa.266.2020.11.16.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:18:40 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kehDH-0007ff-Me; Mon, 16 Nov 2020 17:18:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-usb@vger.kernel.org
Cc:     Sheng Long Wang <shenglong.wang.ext@siemens.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/6] USB: serial: cp210x: return early on unchanged termios
Date:   Mon, 16 Nov 2020 17:18:21 +0100
Message-Id: <20201116161826.29417-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201116161826.29417-1-johan@kernel.org>
References: <20201116161826.29417-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return early from set_termios() in case no relevant terminal settings
have changed.

This avoids testing each parameter in turn and specifically allows the
line-control handling to be cleaned up further.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d0c05aa8a0d6..f1fd109d97d5 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1352,6 +1352,15 @@ static void cp210x_disable_event_mode(struct usb_serial_port *port)
 	port_priv->event_mode = false;
 }
 
+static bool cp210x_termios_change(const struct ktermios *a, const struct ktermios *b)
+{
+	bool iflag_change;
+
+	iflag_change = ((a->c_iflag ^ b->c_iflag) & INPCK);
+
+	return tty_termios_hw_change(a, b) || iflag_change;
+}
+
 static void cp210x_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
@@ -1359,6 +1368,9 @@ static void cp210x_set_termios(struct tty_struct *tty,
 	unsigned int cflag, old_cflag;
 	u16 bits;
 
+	if (!cp210x_termios_change(&tty->termios, old_termios))
+		return;
+
 	cflag = tty->termios.c_cflag;
 	old_cflag = old_termios->c_cflag;
 
-- 
2.26.2

