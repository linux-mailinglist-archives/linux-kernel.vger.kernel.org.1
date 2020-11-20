Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD712BA625
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKTJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKTJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:29:00 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3CDC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:28:59 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so9694163wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne6U1iN+VmwNbZxwYjqa57664T2M7DV98pQLWi7ApwE=;
        b=lOd51iA9903iOxBuLB5MlPVdJyCk1yBKnXKkVkGNiGsTQLu4RWpABG+7fL7mxTzlcO
         9eFU/3TYNawPdtb5XQgudMLSgpfeIdTsUmha/xn81Ih97Po/3EhUGl/NEqpa0DiId5i8
         4OSTNlQftw1x4dXJtDXJ41QwDUJDC2Ae4BkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne6U1iN+VmwNbZxwYjqa57664T2M7DV98pQLWi7ApwE=;
        b=B8nGoEpixXF/KRZVKhaKHK2pm9UdQ2VGJT03xrl4gjOFUuuI5dHeGx2HgwaSfPdTak
         05WJDoROtJaqZdvy1+MZEMN/Ek0cLdk07ww35Rso0b/wPdp+Sj2Gt7Q56GksPT3R/bjb
         TYyGvFzdnjaaHrt7E8baLifWcN0vFgFM0IjDHgwPB9iiG4BhEexpiU7cCo1HzAOdX8IC
         uit65llNjjIBvRWkUfJePLqchBVyzhsUNr1qB7PuN8+CZVVGWdpGDYnerTLJ7GYtEHZs
         07yX5iPIydtLSVKpXVomGJx3G79MghkPkr02kp413mbqJfEbJqsrkC4htFy/yKvOjMIi
         n+lg==
X-Gm-Message-State: AOAM533DRzGg71NZdEhOtfzWmMhg9L3yBe9QJKGo2WHgzgnqQfx1bcud
        FB9/uR1qEFcPC5nbi+dhdo2RTg==
X-Google-Smtp-Source: ABdhPJzDRfjOtVJeeZGHohEgz05mObGSGGcqjEHsfCvj55T8h5x2bLw4rOzlhprHhLNesGONKtsjFw==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr9180590wmf.38.1605864538603;
        Fri, 20 Nov 2020 01:28:58 -0800 (PST)
Received: from vpa2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a14sm3561791wmj.40.2020.11.20.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 01:28:57 -0800 (PST)
From:   vpalatin@chromium.org
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH v2] usb: serial: option: add Fibocom NL668 variants
Date:   Fri, 20 Nov 2020 10:28:28 +0100
Message-Id: <20201120092828.665931-1-vpalatin@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120090107.502832-1-vpalatin@chromium.org>
References: <20201120090107.502832-1-vpalatin@chromium.org>
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
index c773db129bf9..1dfde90765fd 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2036,12 +2036,13 @@ static const struct usb_device_id option_ids[] = {
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
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
-- 
2.29.2.454.gaff20da3a2-goog

