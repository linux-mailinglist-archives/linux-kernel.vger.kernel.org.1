Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CF2829F1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgJDJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDJ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 05:57:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC66C0613CE;
        Sun,  4 Oct 2020 02:57:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so5888055wmi.0;
        Sun, 04 Oct 2020 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/YkRcUHU/i4GI4eck9DeWji1/SRa9vrnOnW3Bg26A8=;
        b=plD8564XY1SShIHYFvxikeIImFoFl55Vr+05NhTHCvDPLe+UYcjrBWSwDNGrwtudj+
         xWiqAvfiay+KghbMejBff5QjqdUfi3EGYWdzkUGzzSdX7v1ujJsn48v6vxXmgwgKpgg+
         kMhFgPpawEVqL1X/Ap8WsrDLD1akrXx097Yv9f2EkkHM2qMykl+wJaTpDLc1yGHlaPs0
         aJLjSko4+G8Vy3t9H3bIv9k6DtCUinWRa3PTn03nj3pJxVATWyqs4JGOQFeH/yNIT7/y
         xnFgFosLOKM/cKqYknMKHCtJml3rkp8zzHE/8skM0cPtoWLZ5s1X1bysTSc7kCOQToHq
         VaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/YkRcUHU/i4GI4eck9DeWji1/SRa9vrnOnW3Bg26A8=;
        b=TOsdh0z1jr2gzXijh+6VaCoV8MMzAl5e38TRVNx2qNTVriBJy+iDLFqzrev0b5eB+z
         FrMz4Ci8S98Ed88siPcX5Xl/bFTbWd/4xbGd8d9S0zskOZGSaV/khabnnP+Iu55qrxIU
         q/bs8PPVzgUAnVCtlpCd3S+BlqzKBNph8fY7iYouZ07xA8XI5JmrhUS9apXLOUdnSoVX
         TqotA3gxpqmrkrvcJoaCuqbzcqGRwXkdRMv0M80hZ+iDZGm3zum+Lq6OI1DzFNHufKUI
         2tqfiLgrlpj2gf2bP2l3FhFVoOOTZTLvB6lK+tTy6e4qYg62ihhLUmxoXXm2xF2hRsiO
         tkwQ==
X-Gm-Message-State: AOAM531rRyHIIM7wzBiGuSxbmZmldVQBb6bpuDKaZ6kBoevVsMJpFHLi
        dgWKFMAqFrKLK42eVpwiHWYXEvMJP4M=
X-Google-Smtp-Source: ABdhPJybyj6Ipyc5aXJg0jYfVyVl69BFKiE6rJyx3PBjQHxIw4W7kRag1Az9xfhO0PzSTcLau/8wNg==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr11178688wmo.141.1601805446308;
        Sun, 04 Oct 2020 02:57:26 -0700 (PDT)
Received: from localhost.localdomain (80.178.78.235.adsl.012.net.il. [80.178.78.235])
        by smtp.gmail.com with ESMTPSA id m10sm8263416wmc.9.2020.10.04.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 02:57:25 -0700 (PDT)
From:   Leonid Bloch <lb.workbox@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Leonid Bloch <leonidb@asocscloud.com>
Subject: [PATCH] USB: serial: option: Add Telit FT980-KS composition
Date:   Sun,  4 Oct 2020 12:57:03 +0300
Message-Id: <20201004095703.2633-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the following Telit FT980-KS composition:

0x1054: rndis, diag, adb, nmea, modem, modem, aux

AT commands can be sent to /dev/ttyUSB5.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---

The full composition is not tested, and it is the default one according
to Telit support. What is tested, is that this commit makes
/dev/ttyUSB{1..7} appear upon connection of the FT980-KS, and allows
sending AT commands to /dev/ttyUSB5.

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0c6f160a214a..e7a98435ac29 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -301,6 +301,7 @@ static void option_instat_callback(struct urb *urb);
 #define TELIT_PRODUCT_LE920A4_1212		0x1212
 #define TELIT_PRODUCT_LE920A4_1213		0x1213
 #define TELIT_PRODUCT_LE920A4_1214		0x1214
+#define TELIT_PRODUCT_FT980_KS			0x1054
 
 /* ZTE PRODUCTS */
 #define ZTE_VENDOR_ID				0x19d2
@@ -1164,6 +1165,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_CC864_SINGLE) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_DE910_DUAL) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_UE910_V2) },
+	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_FT980_KS) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1031, 0xff),	/* Telit LE910C1-EUX */
 	 .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
-- 
2.28.0

