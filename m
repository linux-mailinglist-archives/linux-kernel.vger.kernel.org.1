Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3B1D1FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbgEMUPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 16:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388033AbgEMUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:15:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:15:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so240926pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=saf/dg73iQUEG32PJPB+LsnpbZToQT0BzCAbRbBNs70=;
        b=STKdRmSnETqjJhs6vMObw3hhA8VDOKkp84e8+JmEIZHKqrczIq3bwDlgWuQFS57iO+
         SEgg4lklR/kkwwVrZYXGC4PBIejoQFAFslRIefmmC3wsFPUp32lShPM8CXCh4mv+9dKw
         05PZe5x07ktKjVnAx1wCyg1lWI9As4CBQDQ+kdX3JOQ2CGOaBQdmWSBwId8N5TJZhVv5
         gCZ7G1Gg+3W5/7W8l1CAhkmzdXdQFnU+sc+MjBCrl131Z9xUPMcyAnhuYntdrTP2QRd7
         PQ3+NlA6N+1p6HKBe5+IVNiaczHLFyGXQenNl8jgFxv1eXFpUUqqW8+sokL37o7OwsRV
         5Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=saf/dg73iQUEG32PJPB+LsnpbZToQT0BzCAbRbBNs70=;
        b=ZL4IugANTUbmBfdOpEXI3VP9gQKFkJJGUv+Ep78HUTrTKuzXcAZkqxdCuFJuUOYmr6
         b/OqXGh2uQ4rzmcSyV/RyqMUn9iFGB1gOWsBhx7cTzJMXjfX8y41dOBPb5HGgH4VKra5
         H200TpDKaBnfZ5epzwWAaYS3ND1+hsXItE0miIkkrZd4S+wMaRIQNhziXB3MYG9EqbEY
         i2jXvxxoJYwqjZru/L9lbbCivUcW1ocrJzyURzAzS4VBnU4VKOfwv2ezGrVyAzsdNyeq
         bm7xbdmeAgEhzvnelMRfBxa6jNUYuXpbenXjNcimzp3LzXK3+/OFT9KLYDxY8eaiNMY1
         PrNg==
X-Gm-Message-State: AOAM530iKt7N7X2+QJIFW+BQfO6Imh/cWS67RYUShy+903WrJdzQbY/5
        uFWZQ57FTluNOJy9SuIylNE=
X-Google-Smtp-Source: ABdhPJxcCgJHd9Dv4D5IY2/U3ipK8lTO2C2aeNWbi79YGoKK9FPttu3p3OkjxftAMq6m6F5RV/LCDQ==
X-Received: by 2002:a63:2244:: with SMTP id t4mr891818pgm.375.1589400911936;
        Wed, 13 May 2020 13:15:11 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.196.79])
        by smtp.gmail.com with ESMTPSA id u9sm327161pfn.197.2020.05.13.13.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 13:15:11 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, dan.carpenter@oracle.com, jgg@ziepe.ca,
        dsterba@suse.com, arnd@arndb.de, ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drivers/virt/fsl_hypervisor: Correcting error handling path
Date:   Thu, 14 May 2020 01:53:16 +0530
Message-Id: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, when memory allocation for sg_list_unaligned failed, there
is no point of calling put_pages() as we haven't pinned any pages.

Second, if get_user_pages_fast() failed we should unpinned num_pinned
pages, no point of checking till num_pages.

This will address both.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/virt/fsl_hypervisor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 1b0b11b..ea344d7 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 	unsigned int i;
 	long ret = 0;
-	int num_pinned; /* return value from get_user_pages() */
+	int num_pinned = 0; /* return value from get_user_pages() */
 	phys_addr_t remote_paddr; /* The next address in the remote buffer */
 	uint32_t count; /* The number of bytes left to copy */
 
@@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 exit:
 	if (pages) {
-		for (i = 0; i < num_pages; i++)
+		for (i = 0; i < num_pinned; i++)
 			if (pages[i])
 				put_page(pages[i]);
 	}
-- 
1.9.1

