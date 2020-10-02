Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F594281DA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgJBVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJBVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:25:07 -0400
Received: from mail-ua1-x964.google.com (mail-ua1-x964.google.com [IPv6:2607:f8b0:4864:20::964])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC52C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:25:07 -0700 (PDT)
Received: by mail-ua1-x964.google.com with SMTP id z46so750005uac.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7A/AobzH+FRJXYh7LD0AjUWQzN2kh06wV+p0DOwNKws=;
        b=drpw6QHKbky4UXyUEHvJglX3H0w8zfg3d1Hn0Vbt2I9CNQemUeKz/ZuiI0YT66valP
         dXD+Lbzw+7WD0W6xrqq9gq+Yrv1edn6BcDaQ8MJ/O2M7mXuZI1O0KiaH2vFnfnYP3Ul3
         iKKd1DwCkyn7++GGEAkcDq4x0JkJISeA1Mq2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7A/AobzH+FRJXYh7LD0AjUWQzN2kh06wV+p0DOwNKws=;
        b=cxgJRY4U5KSfLLkA6dnSajxMZPrbdtZe4DHI59o1yBr2tBSK8Q3L1zuLgIjNg6bCS+
         ZJyfhYzOedFXWV9hzTCaWVuympcKw9QpYqv70nQtTuFpPYm80jURWK+CN6zDrVVNjG++
         IwEtXfs4eRayzVvN0see2EiEIHLiOWnK2F12Ep+JdmDZNtQcUKHTLyuVsTzFjmfOvGJZ
         DmqiPjCZusXgxOqCibqhAZkhnpVhF6ct1DOMGZD0Fb5oIM8t6TGWOzaPyZomtJhQgKIR
         a4ZlbIJtG3Bf98GpaDdY0t+L2xJ+S/vEA0xN0/+C9C3KIKdRqYJtUS+d4/ZUbkqOI6Wc
         axzQ==
X-Gm-Message-State: AOAM532MqVfmH8ICYefhsTuGh3FU7ukLLnQl4/Dm3+9PSIRWciZ5hSOx
        seQ0HPojqsp0xj3QUPYqZ8YeQuEb7hqsnEuXxIxhyfd3p2PK
X-Google-Smtp-Source: ABdhPJwqn27ChvTf7JYVf6NDoVVKxcvO/QUWhPTEyzOzzTRUZcAD0YV/wKF7GzvR7obYOkGdibPHFhb5LV/g
X-Received: by 2002:ab0:702a:: with SMTP id u10mr2451089ual.59.1601673906816;
        Fri, 02 Oct 2020 14:25:06 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id x2sm327292vsn.4.2020.10.02.14.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:25:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Desmond Yan <desmond.yan@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH v6 12/14] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Fri,  2 Oct 2020 14:23:25 -0700
Message-Id: <20201002212327.18393-13-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002212327.18393-1-scott.branden@broadcom.com>
References: <20201002212327.18393-1-scott.branden@broadcom.com>
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
index 6c2370723e0a..8b869d7f7b93 100644
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

