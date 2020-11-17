Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7002B7262
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgKQXZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgKQXY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:24:59 -0500
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:59 -0800 (PST)
Received: by mail-ot1-x364.google.com with SMTP id n89so21208587otn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qdDrJWDoHM5C1t4XqMRoNQ2neP9NmJwItgmGwxLWbMo=;
        b=H/1rcnGFfUvdaGgRNzk8FZxK5+4fMsGc3y/9hm7g8vursSgcgWBkvYKC1Jm4jzrOtT
         047O8ZRqbMRsMOojYJL5NQ9LG2dvXj6y+XVqy8sL+uohknWUpH35jVTEPwoquy4Wl264
         DEx+2dM4B864ZTbZesCugkealE6+rHrofZ8dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qdDrJWDoHM5C1t4XqMRoNQ2neP9NmJwItgmGwxLWbMo=;
        b=dCKf9PHRDUaGVUeoUOkdFJ4heLJKEhOZ5OdyYoEh0mBbqu7Ck6ruCwNZO43WYUr+jR
         udtqiDRWrfL7yzaFn6P66YXgg3eosNOMMxZ8hWHVa2JfgOofP2fKF8MiLVuSwxBXC10F
         +MfFMZKIsZ1d8darp9okW9ZxXSRrVn3fv2rqv3VP9RPVjNIj247cGFZk/kYyLGiK8iOE
         AlGqU5clvf1WsU0mYyq21e/S0LyZPhXVo9AqNYdjChjy/851yJfplDK3nkNjwFJ5ehyF
         cbKMUiedpL1qiRIp87jhIQff3NN9jnVOtaWiJzj0DwFxbp4aSSIz9k3RcRfQT4xL3iw5
         bCwQ==
X-Gm-Message-State: AOAM531nTePrBlcTftArPvpMxmABfyuYNkXIr9cVL8eD2hJjhEwi9aA4
        nY1uxNoZqFo9Yvsq0+y3rK2jQfX0+4FyI4Hg7cI3ujmqAaPh
X-Google-Smtp-Source: ABdhPJzPuIhq/Der8RAedXWYBWzWY6cPVti4FztutbzGWnAsnSKSsU1PvZsuOJp0fAtGY7uKWiZk+7Mo8bKs
X-Received: by 2002:a9d:1f5:: with SMTP id e108mr4767468ote.309.1605655498648;
        Tue, 17 Nov 2020 15:24:58 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id q22sm5867076otg.13.2020.11.17.15.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:24:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v7 11/13] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Tue, 17 Nov 2020 15:23:18 -0800
Message-Id: <20201117232320.4958-12-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117232320.4958-1-scott.branden@broadcom.com>
References: <20201117232320.4958-1-scott.branden@broadcom.com>
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

