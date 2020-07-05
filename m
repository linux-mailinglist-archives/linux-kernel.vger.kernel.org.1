Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128E02153B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGFILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 04:11:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:63412 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgGFILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:11:08 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0668AxES022780
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Jul 2020 01:10:59 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 01:10:46 -0700
From:   <qiang.zhang@windriver.com>
To:     <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb: gadget: function: fix missing spinlock in f_uac1_legacy
Date:   Sun, 5 Jul 2020 14:24:35 +0800
Message-ID: <20200705062435.1554-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Add a missing spinlock protection to the add operation of the play_queue
in "f_audio_out_ep_complete" function.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Add missing changelog.

 drivers/usb/gadget/function/f_uac1_legacy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 349deae7cabd..e2d7f69128a0 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -336,7 +336,9 @@ static int f_audio_out_ep_complete(struct usb_ep *ep, struct usb_request *req)
 
 	/* Copy buffer is full, add it to the play_queue */
 	if (audio_buf_size - copy_buf->actual < req->actual) {
+		spin_lock_irq(&audio->lock);
 		list_add_tail(&copy_buf->list, &audio->play_queue);
+		spin_unlock_irq(&audio->lock);
 		schedule_work(&audio->playback_work);
 		copy_buf = f_audio_buffer_alloc(audio_buf_size);
 		if (IS_ERR(copy_buf))
-- 
2.24.1

