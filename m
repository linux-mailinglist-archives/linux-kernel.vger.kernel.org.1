Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5583727B8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgI2ANh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgI2ANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:13:33 -0400
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com [IPv6:2607:f8b0:4864:20::662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E94C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:32 -0700 (PDT)
Received: by mail-pl1-x662.google.com with SMTP id y20so16418pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ToaTiIP8yzRijutkkGKj+sxGdqOvq2bVY0YY58L/rGY=;
        b=D08w7hiQbyPbiSLGFnarzJ1Dbh4uRyRpDDmErG8JvrFjZ6GrgvdANCUOd3s/ZBHJt0
         DCcoVk4gfdFSq8aWmoGmfzQmXU4d6vl2wvULxCKW4Dq3seznMHQo0hlDuMKyduB5BsLO
         QkPQH18nbqbYYK7ttphxJQM2XV2a291/fxeF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ToaTiIP8yzRijutkkGKj+sxGdqOvq2bVY0YY58L/rGY=;
        b=sDXBXl1Z5vAI2bnzdujX+9NVLQcDESmQ9cc7g5kW4dG30jEzvtoYvzAyA/VKS7z9e8
         bSM48JEQRGhEsTs6tCdeDEVJtEMyt3GcsxHR8s8N1gfADKu1eUfqlqF0P6QURN9Rmuae
         HLP5Ime3fR4A3xdsNAD3mZRK3f0CxRSLXMMfGRNmG9I3T0fvzaVynV8PBcBcRtnlk9wo
         FKMXZDjR3MpkKuTQCJ5wevGjNYgBELiJt9if/xyE2SN3bEV5Xgrw98tjTqubNpptymkr
         eVq/QKyLxKGLOS7zuF8fSf+JyEm7oGHhzu1wArY7G6Qxa+3XDcuQUEjstClw07wLsLSW
         6B5Q==
X-Gm-Message-State: AOAM531X3IgyUr0qfwr/ZzNlJtyc6FpEwT3lkG0zWbz2HTvTX22qyhar
        qazhPJytxL9xVZS+tZk8ropRS0UnVCIY0wmUK3Gnc0MgHrOQ
X-Google-Smtp-Source: ABdhPJyThI1Ew5nvZB9bjubLINT5DQW00sNBH43CkJ/4Ps1J7bovA96UQdDQ0yDzXo1TtsqjZFWOOZaBg4Q4
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr1831921plr.8.1601338412313;
        Mon, 28 Sep 2020 17:13:32 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id t1sm1047973pjr.8.2020.09.28.17.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:13:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v4 15/16] misc: bcm-vk: add mmap function for exposing BAR2
Date:   Mon, 28 Sep 2020 17:12:08 -0700
Message-Id: <20200929001209.16393-16-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929001209.16393-1-scott.branden@broadcom.com>
References: <20200929001209.16393-1-scott.branden@broadcom.com>
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
index 000febe967c1..e83c0e48fdeb 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1178,6 +1178,29 @@ static long bcm_vk_reset(struct bcm_vk *vk, struct vk_reset __user *arg)
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
@@ -1216,6 +1239,7 @@ static const struct file_operations bcm_vk_fops = {
 	.write = bcm_vk_write,
 	.poll = bcm_vk_poll,
 	.release = bcm_vk_release,
+	.mmap = bcm_vk_mmap,
 	.unlocked_ioctl = bcm_vk_ioctl,
 };
 
-- 
2.17.1

