Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F319D772
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbgDCNSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 09:18:45 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39294 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDCNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:18:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 033DH9t9027909;
        Fri, 3 Apr 2020 22:17:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 033DH9t9027909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1585919830;
        bh=6SNvN4uZsUHdhQ28mSp8KyStQBpxyYCWP8kC6l/eSfI=;
        h=From:To:Cc:Subject:Date:From;
        b=uhYpip08oTMfdfXf8KHL6QegqkNA6gfAiFvhui0ahYMcbzpxCL2l+0kBcYQ/mrruC
         lHlvf61boJqmhqeXKM3t6CD4m6rQKDVyYi/7WNYY74AK/KCNYdm9w85nR0Sbx6cJfg
         8M6Zg39W3WGHxd2K+3YYXbg3G5qo24s9ZBJo3eSLQUKFVK5tDG9sgSFD8S9rxL7Jzg
         89AGfwjYIB3TSWE0HADxvPqIe7jKFrQqDLQO/AiV5xCb3kim7DrCfghjmgGPImLw2k
         pgONRMfdu6j3FQ/PIUKsWrAYWGi8CJOXcMtMNCFQxxUzk5UAN2ShA0EEyeG16nu0x6
         9PgHAHnK3q3Aw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Howells <dhowells@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: legacy: fix redundant initialization warnings from cppcheck
Date:   Fri,  3 Apr 2020 22:16:51 +0900
Message-Id: <20200403131652.8183-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following cppcheck warnings:

drivers/usb/gadget/legacy/inode.c:1364:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1331:15: note: value is initialized
 int    value = -EOPNOTSUPP;
              ^
drivers/usb/gadget/legacy/inode.c:1364:8: note: value is overwritten
 value = -EOPNOTSUPP;
       ^
drivers/usb/gadget/legacy/inode.c:1817:8: style: Redundant initialization for 'value'. The initialized value is overwritten$
 value = -EINVAL;
       ^
drivers/usb/gadget/legacy/inode.c:1787:18: note: value is initialized
 ssize_t   value = len, length = len;
                 ^
drivers/usb/gadget/legacy/inode.c:1817:8: note: value is overwritten
 value = -EINVAL;
       ^

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I do not think this is my fault because the addressed commit did not
touch this file, but the kbuild test robot sent me this report somehow:

  https://lkml.org/lkml/2020/4/3/395

Anyway, the warnings are real, so I removed the redundant assignments.
I re-ran cppcheck and confirmed the warnings have been fixed.


 drivers/usb/gadget/legacy/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index aa0de9e35afa..3afddd3bea6e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1361,7 +1361,6 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 	req->buf = dev->rbuf;
 	req->context = NULL;
-	value = -EOPNOTSUPP;
 	switch (ctrl->bRequest) {
 
 	case USB_REQ_GET_DESCRIPTOR:
@@ -1784,7 +1783,7 @@ static ssize_t
 dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 {
 	struct dev_data		*dev = fd->private_data;
-	ssize_t			value = len, length = len;
+	ssize_t			value, length = len;
 	unsigned		total;
 	u32			tag;
 	char			*kbuf;
-- 
2.17.1

