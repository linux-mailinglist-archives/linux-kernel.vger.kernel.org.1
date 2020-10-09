Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020F2288EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbgJIQUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389451AbgJIQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:20:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1AC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:20:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so7255262pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mP+aJbUAat0UV4esY+1JsE6q/zZ+Jt33VyknqBiKg6E=;
        b=H8vtangYCZZ+rQo2KOQ7hhPSTvZztsIedGeLPsRZ1uamjVukb7XGoPTUeMIx+FIzRu
         b6vFDbHC4nyU2AsQjT8sNUGWq2ZCcmSjFp3vw+lgMY5ATWNuQNZdAK2H/hjU8O3V9CtT
         HallgOMsilAG0KHTairyYihZzET/881krznSKPcC/cjm0uz+ng1KI+JTtuj7oSJxuj/J
         VzmK/OlUs+oT4QptXSWDbMgHNk0OIGU7ojpB9m7mwm31BM+AjreQhCPGeWr7sNZAzubO
         wWfm3H2Ph4/Gno9/d/WoPQYybFh74inmjJDTI76qXPo42YHTlAuP7iv7pACAIj63B9Ds
         CJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mP+aJbUAat0UV4esY+1JsE6q/zZ+Jt33VyknqBiKg6E=;
        b=qWaLMD6PQmNIS6jAGYMRLDALNsP0baJmT3ObO/GLxxSASd8JUUWa2cNAGKxAvouY5z
         EZvpUjSOHTZ9RzQx0zxSP1Ho5EPd4FjRMQV3U66Z0F9fgMvRH48pwYMJohF0ogPxr//G
         Va6FNM+nXq3dH3dlysrd03Qa9Nw7AOMGOyW2o+pIcR2UKJVJHOs1uRfUIR5crQNMCQwy
         0j9iDA+3Tq3SVeO6mdrwaYikx5tGnTB7m7jwEmNm3zN56ORgcyhnbHgT6mWvqhnfykAY
         mWks/OhT8yME3IFDFXsEMHizNqWTOXiYTD4NectblqTMnPIVyEn8xsnVL+ceJw1VxXWr
         gE0A==
X-Gm-Message-State: AOAM531SQRtDkFEpxKETVeKTEc4fg54aEGfIoOtDrQSe3F6BJWl3xjDi
        V64vV7wgs/uFTnFqwuSAiho=
X-Google-Smtp-Source: ABdhPJyARPOvuTSwMuRPOKozcnKxADEWGnflnK+0e+Bke7F1X7H6ejWfNx6wuvsaN93e4Q1NYAr2Lw==
X-Received: by 2002:a17:90a:1861:: with SMTP id r88mr5337711pja.222.1602260439006;
        Fri, 09 Oct 2020 09:20:39 -0700 (PDT)
Received: from localhost.localdomain ([49.207.205.113])
        by smtp.gmail.com with ESMTPSA id h31sm11163325pgh.71.2020.10.09.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:20:38 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb endpoints found
Date:   Fri,  9 Oct 2020 21:50:29 +0530
Message-Id: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
wMaxPacketSize = 0 for the endpoints found.

Some devices have isochronous endpoints that have wMaxPacketSize = 0
(as required by the USB-2 spec).
However, since this doesn't apply here, wMaxPacketSize = 0 can be
considered to be invalid.

Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
The error (as detected by syzbot) is generated in 
vmk80xx_write_packet() (which is called in vmk80xx_reset_device()) when
it tries to assign devpriv->usb_tx_buf[0] = cmd.

This NULL pointer dereference issue arises because
size = usb_endpoint_maxp(devpriv->ep_tx) = 0.

This can be traced back to vmk80xx_find_usb_endpoints(), where the usb 
endpoints are found, and assigned accordingly.
(For some more insight, in vmk80xx_find_usb_endpoints(), 
if one of intf->cur_altsetting->iface_desc->endpoints' desc value = 0, 
and consequently this endpoint is assigned to devpriv->ep_tx,
this issue gets triggered.)

Checking if the wMaxPacketSize of an endpoint is invalid and returning
an error value accordingly, seems to fix the error.

We could also alternatively perform this checking (if the size is 0 or not) 
in vmk80xx_reset_device() itself, but it only seemed like covering up the issue
at that place, rather than fixing it, so I wasn't sure that was any better.

However, if I'm not wrong, this might end up causing the probe to fail, and I'm 
not sure if that's the right thing to do in cases like this, and if it isn't I'd
like some input on what exactly is the required course of action in cases like this.

 drivers/staging/comedi/drivers/vmk80xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/drivers/vmk80xx.c b/drivers/staging/comedi/drivers/vmk80xx.c
index 65dc6c51037e..cb0a965d3c37 100644
--- a/drivers/staging/comedi/drivers/vmk80xx.c
+++ b/drivers/staging/comedi/drivers/vmk80xx.c
@@ -667,6 +667,9 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
 	if (!devpriv->ep_rx || !devpriv->ep_tx)
 		return -ENODEV;
 
+	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

