Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566D2C8D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgK3SoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbgK3SoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:44:02 -0500
Received: from mail-oi1-x263.google.com (mail-oi1-x263.google.com [IPv6:2607:f8b0:4864:20::263])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC5C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:22 -0800 (PST)
Received: by mail-oi1-x263.google.com with SMTP id y74so15248397oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qdDrJWDoHM5C1t4XqMRoNQ2neP9NmJwItgmGwxLWbMo=;
        b=YiTfEUaKErt9RIeyxKquUrEiqL1WnuecQ4lM+HQ/U8tBQRWOZ/ZV+XzD12BzO01ysM
         zClR52d81yOy9QpozQK7LnEA7h9Jrd8ZXzwnLVDxiuc2hBNnf3yyGY/+qHd05pDcsKv4
         Vj0eXf/wOGOFtcnchNvcBG6j18nY3mp7/k20U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qdDrJWDoHM5C1t4XqMRoNQ2neP9NmJwItgmGwxLWbMo=;
        b=W0xk31HbbnHflzk3bQBG6SEQTZeZ48UelQXn7VB0jaNqM3FfoipWiYnss5A0P78284
         Xwea9xgZ+qNfji9Q+Hg+jHZbpjg3va7MxhspL4S9YwBSmnGoXAC0hL5Ly1Itj8AlDpZX
         aNzfIQ+aq3fYhMb8IXWTl76ZnIZ3wD4podN9s05aOkmredz6jRUy5PCnwGfZLYDYgzf+
         qTrX3EXCHqZlYEzsBCAkkXC6w26Ud0SwVCxZ9f49r/8EaMG637vNBMMlRG8wK6fhs2sx
         eo5a103yHZXPxLygmiJJr6IeUEyiAG/faEVzGNTCeFXInlFI7yrcMrKsKW75f+GLuQOv
         /PSw==
X-Gm-Message-State: AOAM533rEyp9uZdpR6d0NaKda03Eep6Q/FybG0DnlGTShpa98zKk/bsI
        PeQIjUNvN2pakxvSQYowivVTfEq/XQ7lTsk8G3/5ZgYeQoMj
X-Google-Smtp-Source: ABdhPJw8AoqDMEH5vG4S+BxaXzsM563tQFKwnsg2NzsTcJDm4e6iY40Bk56OXlriJbgt4qEpS/QJJRlJ6q/x
X-Received: by 2002:aca:df83:: with SMTP id w125mr125766oig.165.1606761802001;
        Mon, 30 Nov 2020 10:43:22 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id z21sm1909069ooe.19.2020.11.30.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:43:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v8 11/13] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Mon, 30 Nov 2020 10:41:58 -0800
Message-Id: <20201130184200.5095-12-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130184200.5095-1-scott.branden@broadcom.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmap function that allows host application to open up BAR2 memory
for remote spooling out messages from the VK logger.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/misc/bcm-vk/bcm_vk_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index e572a7b18fab..cac07419f041 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1199,6 +1199,29 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
 	return ret;
 }
 
+static int bcm_vk_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	unsigned long pg_size;
+
+	/* only BAR2 is mmap possible, which is bar num 4 due to 64bit */
+#define VK_MMAPABLE_BAR 4
+
+	pg_size = ((pci_resource_len(vk->pdev, VK_MMAPABLE_BAR) - 1)
+		    >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > pg_size)
+		return -EINVAL;
+
+	vma->vm_pgoff += (pci_resource_start(vk->pdev, VK_MMAPABLE_BAR)
+			  >> PAGE_SHIFT);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
 static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret = -EINVAL;
@@ -1237,6 +1260,7 @@ static const struct file_operations bcm_vk_fops = {
 	.write = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
+	.mmap = bcm_vk_mmap,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
 
-- 
2.17.1

