Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A64282B99
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJDP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 11:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 11:58:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F04DC0613CE;
        Sun,  4 Oct 2020 08:58:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so6905523wrv.1;
        Sun, 04 Oct 2020 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbPKtU+2Vj2U0mDyjUNFtD/agRfISoKPjjCAyVi5nTs=;
        b=Q5vRHG1i0DUprP9x6Ktq1Ryb1kUZaIH/9kBaSM61W+wJIWVzXnE5wDqhOGnhuglaw7
         efCgfYyV/5lF1mupvOtqa21RAROI9sQxDxQIBj/J5ZoqNPT/deLnnoyPBDx3z3AxUD5n
         BUdwKdlzv7cpFD3WxVd3AXZYX3/wsybgNRYSfjBCCgO+Z0NXrIknuUQvYulceKoCEvs1
         4srljRsqnMbUqbHlpoEABoYjHv0H51MbMSFf1RNk0GOgob7e/ZQdAdeG+qJtWdMa71Mg
         VQxIjWeZNzlYUhhWDfz/Nq/8yqBaSEKa6hEE132CXd6Woh8ubcu4psnTn6g8Dj/+oMvw
         Rh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbPKtU+2Vj2U0mDyjUNFtD/agRfISoKPjjCAyVi5nTs=;
        b=oTngeuPHhiii7GkCflBc5JpZlGf4iYOjQX4/8RvIkcccX1WdHcj0b2H0/QdpKLOBuw
         j8F8Lh+guGJVou7wqeqlNzXlWLyZqYyip5JDhxMvnmRPIbl7mCO8w3nUjl3rGGIVtcNV
         HG9dPeOBQtlHrGA+bWM0Dr22qpv52ys2Ee8KCup2gnRqgBYlyQZniSLRpxzr/h7FxHXx
         leSWLxDktkhq2slG3IHDw5UpL7t4CZVDbRL8nDxujzgB8/i7ZYyo8GB9sfUy0GtEjspN
         Gv+VY8ReIlif5FdpQb//EyoJGR6cBVmI2XXVsxHBYu1pk8ARBRccA4ev9Blc52DWE63U
         /9vA==
X-Gm-Message-State: AOAM531C7KyqNkwHnKiqybj5aDGkS8iOWQvd2TFU8Zx4qVBa7aRzXno9
        MrZAIrCScIX+eNxa41Vr+1sUGUWFQHWzrw==
X-Google-Smtp-Source: ABdhPJxr2pAMjLNRNNibR57pHqPH95IYVy97bfmRUmPAg07VDzz30I3NJrWTEbF/P71hey69DrVhuw==
X-Received: by 2002:adf:f24f:: with SMTP id b15mr14040574wrp.301.1601827108991;
        Sun, 04 Oct 2020 08:58:28 -0700 (PDT)
Received: from localhost.localdomain (80.178.78.235.adsl.012.net.il. [80.178.78.235])
        by smtp.gmail.com with ESMTPSA id f14sm10078575wrv.72.2020.10.04.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 08:58:28 -0700 (PDT)
From:   Leonid Bloch <lb.workbox@gmail.com>
To:     linux-kernel@vger.kernel.org, Lars Melin <larsm17@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Leonid Bloch <leonidb@asocscloud.com>
Subject: [PATCH v2] USB: serial: option: Add Telit FT980-KS composition
Date:   Sun,  4 Oct 2020 18:58:13 +0300
Message-Id: <20201004155813.2342-1-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the following Telit FT980-KS composition:

0x1054: rndis, diag, adb, nmea, modem, modem, aux

AT commands can be sent to /dev/ttyUSB2.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---

The full composition is not tested, and it is the default one according
to Telit support. What is tested, is that this commit makes
/dev/ttyUSB{0..4} appear upon connecting the FT980-KS, and allows
sending AT commands to /dev/ttyUSB2.

Changes since v1:

* Interface #3 (ADB) is blacklisted.
* NCTRL flag is set to the diag interface.

These changes (relative to v1) also allow ModemManager to recognize the
device.

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0c6f160a214a..fe76710167f8 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1186,6 +1186,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1053, 0xff),	/* Telit FN980 (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1054, 0xff),	/* Telit FT980-KS */
+	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
-- 
2.28.0

