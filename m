Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF028541D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgJFVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJFVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:51:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 14:51:50 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so146153ioo.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSCTqSSaowrClPgifoMVMPmt7o3BdWesTezGGK/fWcI=;
        b=cUzTZXB/1CJjFTTolO/0RuHF+1eavPEIRNfxUbFFbNl3XGvP79jZoJM2+H8vm4m60a
         1j+Xee4jAMrA39XGq6XgiErgXK04Lh3hkPhyFnDzFX8gUfcxzsMlbQI0utLLQaWChMbP
         NW0ZrKttZ0kk5QiZBq+lElDJ4iE+UkcZryPA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSCTqSSaowrClPgifoMVMPmt7o3BdWesTezGGK/fWcI=;
        b=bgu3cd7q5sDKEPfHzQPobnP61EI0Cm4jqr4GTZVRuwMuEqkgvLPe9Qglsa6fbKItIU
         3jGtDklD5ZIObJYej5/oUofYFqEKgvDDlSYj/CWBivMMt6M8I/VZBjfRzJ49oYAAioum
         HNuWVZFPQjaj7UnuvYfL+X2EPdGjArPxfV33je0NLgJJ19MjZ6uavtzBcB6iDNrNPH/s
         ZteeqTAwyJjTARuhnTLbbAS7iXrTVebZAXRSUZqq8Jaozsg4grmKQpfc0K+WirQn8SZD
         0ywPXIyl089ivFLKu1YEjNw8TMBe/cy6YlkBI1VLApRLblHwaBzjAMos00xl4NiwyYZ0
         IWqw==
X-Gm-Message-State: AOAM5310n8sm/V1KYju0Nt3hD/vblvvRFJAsSAMjsIztr9YnN1vtwMqZ
        L3c7kW/UCFIaML+X25H4bBCsyA==
X-Google-Smtp-Source: ABdhPJzb5ozGPovahu892+l0m/4MFKcs+Bgc7nt2hbumIO7xCZMbLEjJSaN/5HiQkLjKnYuncJtVjw==
X-Received: by 2002:a5d:9d15:: with SMTP id j21mr2856215ioj.100.1602021109910;
        Tue, 06 Oct 2020 14:51:49 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v17sm41556ilm.48.2020.10.06.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 14:51:49 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        andreyknvl@google.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vhci_hcd: fix calling usb_hcd_giveback_urb() with irqs enabled
Date:   Tue,  6 Oct 2020 15:51:47 -0600
Message-Id: <20201006215147.35146-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning from kcov regarding usb_hcd_giveback_urb()
call being made without disabling interrupts.

usb_hcd_giveback_urb() is called from vhci's urb_enqueue, when it
determines it doesn't need to xmit the urb and can give it back.
This path runs in task context.

Disable irqs around usb_hcd_giveback_urb() call.

WARNING: CPU: 2 PID: 57 at kernel/kcov.c:834
kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.9.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x14b/0x19d lib/dump_stack.c:118
 panic+0x319/0x765 kernel/panic.c:231
 __warn.cold+0x2f/0x2f kernel/panic.c:600
 report_bug+0x273/0x300 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
Code: 84 26 03 00 00 fa 66 0f 1f 44 00 00 65 8b 05 50 13 93 7e a9 00
01 ff 00 41 8b 94 24 50 0a 00 00 75 1a 81 e2 ff ff ff bf 74 12 <0f> 0b
48 83 3d 17 c4 26 08 00 0f 85 62 01 00 00 0f 0b 65 8b 05 20
RSP: 0018:ffffc9000030f600 EFLAGS: 00010002
RAX: 0000000080000000 RBX: 0100000000000003 RCX: ffffc90014cd1000
RDX: 0000000000000002 RSI: ffffffff85199fcc RDI: 0100000000000003
RBP: 0000000000000282 R08: ffff88806d594640 R09: fffff52000061eca
R10: 0000000000000003 R11: fffff52000061ec9 R12: ffff88806d594640
R13: 0000000000000000 R14: 0100000000000003 R15: 0000000000000000
 kcov_remote_start_usb include/linux/kcov.h:52 [inline]
 __usb_hcd_giveback_urb+0x284/0x4b0 drivers/usb/core/hcd.c:1649
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1716
 vhci_urb_enqueue.cold+0x37f/0x4c5 drivers/usb/usbip/vhci_hcd.c:801
 usb_hcd_submit_urb+0x2b1/0x20d0 drivers/usb/core/hcd.c:1547
 usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:570
 usb_start_wait_urb+0x10f/0x2c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 hub_set_address drivers/usb/core/hub.c:4472 [inline]
 hub_port_init+0x23f6/0x2d20 drivers/usb/core/hub.c:4748
 hub_port_connect drivers/usb/core/hub.c:5140 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1cc9/0x38d0 drivers/usb/core/hub.c:5576
 process_one_work+0x7b6/0x1190 kernel/workqueue.c:2269
 worker_thread+0x94/0xdc0 kernel/workqueue.c:2415
 kthread+0x372/0x450 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_hcd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 1b598db5d8b9..66cde5e5f796 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -797,8 +797,14 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
 no_need_unlink:
 	spin_unlock_irqrestore(&vhci->lock, flags);
-	if (!ret)
+	if (!ret) {
+		/* usb_hcd_giveback_urb() should be called with
+		 * irqs disabled
+		 */
+		local_irq_disable();
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
+		local_irq_enable();
+	}
 	return ret;
 }
 
-- 
2.25.1

