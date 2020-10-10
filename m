Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD80E289F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgJJJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgJJIyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:54:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39935C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 01:29:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so8903255pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ujl0XMo+P2qPzI898K3phXYWEBycnuuMtmf0dkiRFm4=;
        b=hEQ4o52s/F1ZVoAggS29VtGDMZDIdG6bVDIOeyJS6dOmt1JlEwrS39DBQl1HR85b1t
         XWtgMhHfwiUum/ivKsrgwpGWqkRFcBKQAkZdGsG910kGaxF3cYOWs3wYwUsHDGxGmptE
         mWcwOWi/RVH4x/aHn+a5PlsSSx7Et1tRI+ItP4JsJUSn9CZd5Ln52SFSMicOJl0Df+lM
         glb58Msd5Ow+M93wFye0MCgkdJKJIsDIFM0aIUXdoKQhhvBToEF/bbe8TmLaNm8aA0aM
         mappevSsOGzb70suuoiIe38J/rZukwVqojWS0YULTkGsjInzm/wHWS7W8iuZBxu/ORMt
         ggYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ujl0XMo+P2qPzI898K3phXYWEBycnuuMtmf0dkiRFm4=;
        b=p5Nr1CEGYnQCePhKZwtoFcCYrmilgMLRxwAGapS8HLZwIFSitfKu7iXp5Gja1UiFHe
         N11I8cQHHfod/yntCXbkbWodzgF3CPW2BIuvxzVQNW/YJPm+b9eGgRZLV91l3nz5BfHn
         nwO7ubU643mtbHF1L5i7EdiVa5E0dI7x/eMmCV2TG0UrXQj9LkM+5B1MvERZlkjMJ1Jj
         oejLL6GVKpeMOWJBkecnpEAQyevbXU/DmIHhxFrAvgt5higJ4eaU67BoEI0ct2fwHYQK
         5sbe8kFPrKtUrfTGAsDE0hwlOXDzfZ2I8ZeYJQQ9rNRd88OcXHCkAJ6FEcCimWryByU7
         Zzdg==
X-Gm-Message-State: AOAM532r8QHe6Guuep1ymL23NWGNTTCNEOrsKlSGoQbxn05Qqny4drpE
        jdwQpuEHkpodCyCmgk5lAho=
X-Google-Smtp-Source: ABdhPJzFAobmdRLZl/VDshqghj1XOTtQifHi3qfxvI/4/S3GKV3QBrbxn36Te3/przQmxHOrcCU1Vg==
X-Received: by 2002:a62:1851:0:b029:154:8ed7:bf5d with SMTP id 78-20020a6218510000b02901548ed7bf5dmr15563861pfy.66.1602318582487;
        Sat, 10 Oct 2020 01:29:42 -0700 (PDT)
Received: from localhost.localdomain ([49.207.200.2])
        by smtp.gmail.com with ESMTPSA id g13sm12991877pgd.82.2020.10.10.01.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 01:29:41 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: comedi: check validity of wMaxPacketSize of usb endpoints found
Date:   Sat, 10 Oct 2020 13:59:32 +0530
Message-Id: <20201010082933.5417-1-anant.thazhemadam@gmail.com>
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
Changes in v3:
	* Correctly list version information

Changes in v2:
	* Fix coding style issue

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

