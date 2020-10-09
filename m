Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B885288E94
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbgJIQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389410AbgJIQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:17:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:17:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bb1so4681719plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bmx9gH8QKYILpVv8/AwBKiqUZ1W2aX/bT7meRLse05U=;
        b=cPgy8ppfUqoug6Hor5S2QVmhFZWHFrqJXMkkIlCfoLjsNgIXVupZCDSidSxzpRprlj
         rfjpDWTuGxujG0WGnuwCUd6DtrIqIe0Q4piEXyARszAGEaARe7MERlHX28vBE6rjBXwn
         wmM+lgmATC9rUzbL/+UIHkSlNXi/qBUfCT9r6Mi6QAD4XJCyy6XEmUsTKED84w+Y3gj3
         8j/Y8BiwF6GBByc7N15bCx8BOlnz2THm/VCh31ARuX6A4D//SleD+C8Zo0UXPmgVQdBI
         mMt4n+Q+5NQjk4XxRrSDeY/BaUvWQymMw6xAi760bKR2bgDfqkEBy2f7SpGyHP+Vad6P
         l0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bmx9gH8QKYILpVv8/AwBKiqUZ1W2aX/bT7meRLse05U=;
        b=r1TpF7/OYFNfHbrqHs0e3rJ7ouaxe2SCB9gil8Yx4vBJJCLIqsqxjZMzz+dBomQ0h/
         KfvjZaihKH8pmjJAiew5z2OvigUesKaLpHaE6bn6MR+XC2wBFUmMcG5PJFdlAMhVcCsa
         SI3H4KvokbpC/10xWU3b/zv0KhhktfdGdQ1HDKc8urNPAtIMXupazYZoPrlcD1iTSya3
         9X9R4mIwajwibszVXazEcPqMR/ukYbdryIFq9C3XatlwBLclb2CeDSJJmWSKm4gbT+LM
         Gc6Y/aBgiyKWZPAQ38YYYGMuz30V6vJi3/LzsHMaBYH2EvJDe6f7B6X6+qkdQKqouwhf
         0ZLQ==
X-Gm-Message-State: AOAM533Xz70xOmKx541vAhCx6VcXhpDBaY9Kkjgj/TSG8RKPRFba46wq
        RllgfTi3phyFgRzl8Kzq/qM=
X-Google-Smtp-Source: ABdhPJxAPI/0Ac3xxOCN4zvAfkmbcnL5mU1jLjyIiq9aO2HXzi8cW2Uw5SZniELgmxOPso9AYka+6A==
X-Received: by 2002:a17:902:21:b029:d2:564a:5dc6 with SMTP id 30-20020a1709020021b02900d2564a5dc6mr12808284pla.14.1602260230641;
        Fri, 09 Oct 2020 09:17:10 -0700 (PDT)
Received: from localhost.localdomain ([49.207.205.113])
        by smtp.gmail.com with ESMTPSA id s6sm9367662pfd.157.2020.10.09.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:17:09 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb endpoints found
Date:   Fri,  9 Oct 2020 21:46:44 +0530
Message-Id: <20201009161646.286286-1-anant.thazhemadam@gmail.com>
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
 
+	if(!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

