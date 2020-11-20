Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB032BA55F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgKTJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:01:20 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE269C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:01:19 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so9248216wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05bFW4rjwol2/poevwwsFqOk5/4gMpu/AmH5ruz+3AY=;
        b=VQPlEw0C+IGkvCGpC1/3Jk6/UuyrpluXdL0gf7l/dMydo/CQmEglV/INtWXE6qlCgV
         MbO0gk9rFWhgn4/w1zGZF6SFGvSqabSgZQFi93SigsQtn5vFVYUu8MWt6XryiizSFG5C
         Cd5HHLr2dqgSuR9vPx19VQEsVEJK9Nz9xoRUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05bFW4rjwol2/poevwwsFqOk5/4gMpu/AmH5ruz+3AY=;
        b=KcPSl0+4/9YUHPGNYpa3HhjO0afvku2C/Ng7vEVGr7D61g4rrBe3+DfiSR3mtupbg8
         L5wgKpiz7J79hB5ny4Vwj6Af+hpxFUtWo3dBPhA0Sc4Fxj2VAdf0sbA6ugoZpCXZmoeq
         4rNWNVynRPsKgeDIJgUUmywhqdL1xuGCScKHla4G90LIy2xiQNZNCpMv7aGG+S1l7PwF
         Jcdauf82cxUurpbMeipeyM4un5rftVG/DqaSMp6s5Ia5yMqO/J0ZKo0w0CA7FbcHku6l
         gXVmMm4Cm3z7x/b1G7AFcli7uK0uNCM6DQImsWiqUF9XPfBGIwxBy2FI24qLlPAAz9i/
         rFHg==
X-Gm-Message-State: AOAM53005P9+4M24eB600Uphi1U0A1kczF+2THYGwdcE9UMao5DndOk4
        xkNOUacYvXQ4U/aQ1bu+XK2f6g==
X-Google-Smtp-Source: ABdhPJyAyUnamd7UfM7Ns7qf68fGR+F5QmxsVEb5m6c+S1rQcCTmiF/DToJPqgc8qSlnP9vszuepUA==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr8428111wrt.19.1605862878475;
        Fri, 20 Nov 2020 01:01:18 -0800 (PST)
Received: from vpa2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id b8sm4557738wrv.57.2020.11.20.01.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:01:17 -0800 (PST)
From:   vpalatin@chromium.org
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH] usb: serial: option: add Fibocom NL668 variants
Date:   Fri, 20 Nov 2020 10:01:07 +0100
Message-Id: <20201120090107.502832-1-vpalatin@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

Update the USB serial option driver support for the Fibocom NL668 Cat.4
LTE modules as there are actually several different variants.
Got clarifications from Fibocom, there are distinct products:
- VID:PID 1508:1001, NL668 for IOT (no MBIM interface)
- VID:PID 2cb7:01a0, NL668-AM and NL652-EU are laptop M.2 cards (with
  MBIM interfaces for Windows/Linux/Chrome OS), respectively for Americas
  and Europe.

usb-devices output for the laptop M.2 cards:
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a0 Rev=03.18
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom NL652-EU Modem
S:  SerialNumber=0123456789ABCDEF
C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
---
 drivers/usb/serial/option.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 54ca85cc920d..2a6d59bc0201 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2046,12 +2046,13 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
-	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 */
+	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
+	{ USB_DEVICE(0x2cb7, 0x01a0, 0xff) },					/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
-- 
2.26.2

