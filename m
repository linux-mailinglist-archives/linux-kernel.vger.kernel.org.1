Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A302DA979
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgLOIuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgLOItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:49:31 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BBC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:48:45 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id h186so3608199pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HasI2CekMBkNHFZsC56cHJTTs0fBRkP7/rNpMsSfsJs=;
        b=k7f72TanMIO+DwCR2FUrZvraKgbs9OE61Q+aS4NCVgjs9ZBDhJK79sygLud2tXbB9/
         R6ji1u68Ujz9hfwBEmamEi+p0ym5VxH9bKL1scMvJYt/ZyFPrrNsSj2yLjF/pu2/OCVw
         7Dp0LUNvHo/6gealSmw1BqQJiki9BPgfn8wI0LosohMmEbhGV7MQPsGdVn05VkFnqHJa
         J0r7+2FVI5Pi7NX/Lcas3DQRj0lSB9Dp+NT2YHo3q3J7dviDLCeaqPsAErTCFAz0sYd9
         KvCdVyotUUPDDyH3m/R1Oyg+yIWDjUMCnUZCZV/OZ/j31BxzLKwjGjWD3YIbHnMn9mLf
         BwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HasI2CekMBkNHFZsC56cHJTTs0fBRkP7/rNpMsSfsJs=;
        b=c5UhYFZqLRFuauusHLxz6iqyhygLzO5/wLIX+XKohmJJjz6Gz04PNkEO5gjBFNd9rh
         OexxOoHqbeXEQiETbjvcecW2fhlt+h3Sp0J4dhrJe4zrFSBMhQub/+uL3blNK5uw2FM4
         ydW2mgk6P/KfN319TSNLw6hmCxqIOWLZpRzBis8NfSELE8Y0TRVMg6hAyT0k47MRFVxr
         idKLU8Y/2q7EakbFNtIupqJZKArgUbyiNop2nIMrQnP1FL31VCVDUoqmoJ3Fpd6xLgLH
         ivn753nZAKcjzclgqnQx9JxTmbzjZ31lxQf6O2q+OrMvdiRO8H/M22f6fnT8wjAlrdVG
         zmcw==
X-Gm-Message-State: AOAM53177JH15qMCKINoYZxAq4fvsHl91NY1jUOfpuJAVU+zNPwY36+3
        49ZXHZteAOF7uL/yJRlzi6U=
X-Google-Smtp-Source: ABdhPJzX+WjD3pNJj07WHbyX7/pElTXxQWlY+O/u06bcjUTqkE6C2cGGdOyI4iDIH3OZXT1ipMw6nw==
X-Received: by 2002:a63:338e:: with SMTP id z136mr27737698pgz.204.1608022124493;
        Tue, 15 Dec 2020 00:48:44 -0800 (PST)
Received: from bj03003pcul13.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x18sm22831005pfr.158.2020.12.15.00.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 00:48:43 -0800 (PST)
From:   Haidong Yao <yaohaidong369@gmail.com>
To:     jassisinghbrar@gmail.com, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, orsonzhai@gmail.com
Cc:     zhang.lyra@gmail.com, Haidong Yao <haidong.yao@unisoc.com>
Subject: [PATCH] add chan->cl check in mbox_chan_received_data()
Date:   Tue, 15 Dec 2020 16:48:38 +0800
Message-Id: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haidong Yao <haidong.yao@unisoc.com>

mailbox outbox irq is coming, but mbox_request_channel
is not be registered, so cl->rx_callback is NULL.

panic log:
[    9.852090]c0  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
[    9.954634]c0  pstate: 60400089 (nZCv daIf +PAN -UAO)
[    9.954651]c0  pc : mbox_chan_received_data+0x1c/0x88
[    9.954666]c0  lr : sprd_mbox_outbox_isr+0x1d0/0x204 [sprd_mailbox]
[    9.967439]c0  sp : ffffffc010003e10
[    9.967443]c0  x29: ffffffc010003e20 x28: ffffffc011c2f6c0-
[    9.984918]c0  x27: ffffffc010e92e08 x26: 0000000000000001-
[   10.140344]c0  x25: 0000000000000378 x24: ffffff80f4064130-
[   10.145880]c0  x23: 0000000000000001 x22: ffffffc0091072c7-
[   10.151418]c0  x21: ffffffc009107212 x20: 0000000000000005-
[   10.156957]c0  x19: ffffff80f4064080 x18: ffffffc010005038-
[   10.162494]c0  x17: 0000000000000000 x16: ffffffc010e6f844-
[   10.168033]c0  x15: ffffffc0117abac7 x14: 000000000000003f-
[   10.173571]c0  x13: ffff0000ffffff00 x12: ffff0a01ffffff10-
[   10.179110]c0  x11: 0000000000000001 x10: 00000000ffffffff-
[   10.184649]c0  x9 : ffffff80f40644a8 x8 : c366877097809900-
[   10.190187]c0  x7 : 207273695f786f62 x6 : ffffffc011d62231-
[   10.195726]c0  x5 : 0000000000000034 x4 : 000000000000000c-
[   10.201265]c0  x3 : ffffffc010e9842c x2 : 0000000000000001-
[   10.206803]c0  x1 : ffffffc010003e40 x0 : 0000000000000000-
[   10.212343]c0  Call trace:
[   10.215029]c0   mbox_chan_received_data+0x1c/0x88
[   10.219705]c0   sprd_mbox_outbox_isr+0x1d0/0x204 [sprd_mailbox]
[   10.225590]c0   __handle_irq_event_percpu+0x164/0x358
[   10.230604]c0   handle_irq_event+0x60/0xd8
[   10.234675]c0   handle_fasteoi_irq+0x128/0x32c
[   10.239086]c0   __handle_domain_irq+0xa0/0x100
[   10.243502]c0   efi_header_end+0xb8/0x15c
[   10.247478]c0   el1_irq+0x104/0x200
[   10.250945]c0   cpuidle_enter_state+0x158/0x2d8
[   10.255440]c0   cpuidle_enter+0x38/0x50
[   10.259253]c0   do_idle.llvm.10091284334483161164+0x1a4/0x294
[   10.264963]c0   cpu_startup_entry+0x24/0x28
[   10.269120]c0   kernel_init+0x0/0x29c
[   10.272752]c0   start_kernel+0x0/0x418
[   10.276468]c0   start_kernel+0x3a0/0x418
[   10.280371]c0  Code: f90013f3 910043fd aa0003e9 f9400800 (f9401008)-
[   10.286684]c0  ---[ end trace b868997a960c667a ]---

Signed-off-by: Haidong Yao <haidong.yao@unisoc.com>
---
 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..58697298a95f 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -152,7 +152,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 {
 	/* No buffering the received data */
-	if (chan->cl->rx_callback)
+	if (chan->cl && chan->cl->rx_callback)
 		chan->cl->rx_callback(chan->cl, mssg);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);
-- 
2.28.0

