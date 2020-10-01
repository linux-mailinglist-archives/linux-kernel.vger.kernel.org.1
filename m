Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D727F768
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgJAB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbgJAB3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:29:04 -0400
Received: from mail-ua1-x962.google.com (mail-ua1-x962.google.com [IPv6:2607:f8b0:4864:20::962])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0B8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:04 -0700 (PDT)
Received: by mail-ua1-x962.google.com with SMTP id o64so1008117uao.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RDFS9nBtCjgc5+BkS4mdGApbXJbafeUNZemq89KG2/s=;
        b=ODGebNK843K03k6/OHNGc/87fA8cM1eZkRTW9JF9t2ckJGKDsOLSeueJwEqGVJPpTZ
         v5MHs8q8+EHNpCd+cYfViq79IT/92Jb7lY1DEqc30JgDgHMl6eSJgW9uLwg44Toxw/w1
         UUhAiTmdHPd9Cyf3obkq24XLzjWVLbFWmuCNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RDFS9nBtCjgc5+BkS4mdGApbXJbafeUNZemq89KG2/s=;
        b=o4bsrq+6qpETm3MMikSmyFxlrmP+0XuRP75s+bHUYs6byrndkpK3fmgUazDmt6eeVd
         F0se6KNfGPgStrPUprBZHsMv0sQYPjrzvtpBi3moCx5FPieREUB3Jg/ruz9GgiobIMLr
         tmNzcT1xEqtZ5GeCeLzuP30j6UH26t3YexgdwTixfUq/D+Hzi5xZHjZ2UCq9Y5+a2kWM
         bXdDD+A8rerKx0I72kzpkDDTrqlkBwxsdOTydpJWZ4AACY4DCr3HIu+9Hbv2CY/BovZv
         LrqLvgf6M5Wtae7ENumow0mjhnawwm3qxMFfikvgLQsPg7jSuXg4OkzdB0GUv1i/iJBE
         NWkQ==
X-Gm-Message-State: AOAM5304/+KvhejoB0j6Pxp8u6LFFkaiLVE6IsFRxMIPEcQS1Qzd/OgG
        wytnK4XqYQRVDt1UtZwBBIedNZyXHNVJxPTNRBxrVZDJsWL+
X-Google-Smtp-Source: ABdhPJwi4iupx6PXmQ+wEcwb2O6oEtU068FiaQDSJ8SZISS99svVlnblSm6eblv4V76OlIeWZ2CW0ewneTov
X-Received: by 2002:ab0:234b:: with SMTP id h11mr3432267uao.80.1601515743729;
        Wed, 30 Sep 2020 18:29:03 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:29:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v5 13/15] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Wed, 30 Sep 2020 18:28:08 -0700
Message-Id: <20201001012810.4172-14-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
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
index 1e3abb4eadee..9f2e57d505c6 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1177,6 +1177,29 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
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
@@ -1215,6 +1238,7 @@ static const struct file_operations bcm_vk_fops = {
 	.write = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
+	.mmap = bcm_vk_mmap,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
 
-- 
2.17.1

