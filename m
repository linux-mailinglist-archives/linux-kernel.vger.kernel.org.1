Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BF2A25E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKBINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgKBIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:12:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A54C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 00:12:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w65so10428990pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2lbRxRCm6YJ/XgJATRJyEyLX4vRUjWqIBI7bdt9ix0=;
        b=rTYOIXoaERUMqqFWrKz5r963tOK5UvxmwILHg/dNBgIyFKveGTlbRc0W1MgBlZcvtH
         xS9BXyhubL7euN/5c5vZt8N8Rx0hDfpaR/bCaCM8U2BI6f5ylc7QWpsYeacF4CEkHV3r
         gH9Yuf1GSBDKSjaVJGjkUR4ojpI2GvlpGStZwpr3FsA+U5wm9Wj3KkdSP2fuNiXvG3mj
         AkGqzhbpeU08Ix6nU+8Lzs2QhDUMttrQ946on4pzF4gyqHmAYNggwEbmVkDC2LDzULke
         GzP+ooh50vwcK+2Lezl5a7CeZRCdlxlmhI2oT/qvz3cO5nL0Txj2/XnBWR5hnYzJuyJX
         HWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2lbRxRCm6YJ/XgJATRJyEyLX4vRUjWqIBI7bdt9ix0=;
        b=Hwgviucw95haTasoRsac96uK6wIFSfRTBlFe/zACe1OqFOi5CJlNP5j48DzbN3C3Jm
         HlRYZQj9L8+fmE2Wia7eyp4uj4WtJjc9l29HCwxKhJ468P4AlLwhPIWyxydFflTFt8r/
         HnQEaOcCpjPGx+hZSFAphQ54KqIgkD/XqjD0B5CHwEKEZOYUlVhueSv1TqYCBkUa1RSV
         HJazt/RLlfBHeuHL0i+Vt08KwygoarRxH5VW/3WzWpT9Kb9iwUfDeYI9Ifn6qQeYBj4w
         m2rD1BMAhF4s/J7y+M3AU290fOt75+Jdj1Y86VaEn6I/rz3TQI52nd9rv1rGfQBbUPtN
         GBpA==
X-Gm-Message-State: AOAM530ygZGzmae6jHeHJGDFSOkqjHKT/IlsuTo6Xh3Eg9ygEauLC775
        QcTHRY0jhLqgPxuZy3EH3gFH+g==
X-Google-Smtp-Source: ABdhPJzhWRwM9T+K7YXOdYW/f/MLs7UkfWf9rR7zJarQUKacM61QVlTaewhaM0+Q2A5PdiGqQnNf2Q==
X-Received: by 2002:aa7:931a:0:b029:164:115:33ca with SMTP id 26-20020aa7931a0000b0290164011533camr21021035pfj.62.1604304724131;
        Mon, 02 Nov 2020 00:12:04 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id a18sm13885502pfg.54.2020.11.02.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:12:03 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH] Bluetooth: btusb: Add support for 13d3:3560 MediaTek MT7615E device
Date:   Mon,  2 Nov 2020 16:11:57 +0800
Message-Id: <20201102081157.25012-1-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS X532EQ laptop contains AzureWave AW-CB434NF module with an
associated MT7615E BT chip using a USB ID of 13d3:3560.

T:  Bus=03 Lev=01 Prnt=01 Port=09 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3560 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5af2e3f30a5e..a0bfd41fdfee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -367,6 +367,7 @@ static const struct usb_device_id blacklist_table[] = {
 	/* MediaTek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_MEDIATEK },
+	{ USB_DEVICE(0x13d3, 0x3560), .driver_info = BTUSB_MEDIATEK},
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.20.1

