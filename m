Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA021FC46E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 05:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFQDGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 23:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:06:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:06:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so407973pfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dq2SjmoQupE4U9LhXdo/f9IZ6YV5RooIfJwqe+qSBlg=;
        b=cRtzcfZIAK/fnCW3uavu1pTWu4tlI6Gez8w4jjX7ksTVmViB2GmyPtbfv4pHB2N0B7
         52+2ATk8e+AdXsI+gEvmXN+4fq+8vjqv5o1Q0+Vd0gW34QPnbxztqI7LwNR9biWgAZ+K
         iouMSgsyC99J7dM0nr1U+0TzVOj6EhcTo2mWN62PK3JzQGIoX4VIrHq49FgsD5+CV6F5
         qU4zo67ue4q3ETFJqak0LoXVYaD8bpLC4qjg64CJULa32Hlk6S/kdBQ2e+0k+xTrp5Ap
         r2l0ZLwk0wBa1V5SVadZXT7AZlW/xY4KUHIACaXXJvCEgsyULxXV6Kpj0/Uv1SEvLz6T
         rMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dq2SjmoQupE4U9LhXdo/f9IZ6YV5RooIfJwqe+qSBlg=;
        b=eeeTqr0M/0Qsvv8643Hi4vJrGsdOi/I6A7KPkG8gWh8iCCOVk58Loy19EtsgXlY30M
         O2Zj+Msi7KoncsO/yf6BqycVu2SSHQhml9FDYiM3HDhA7u7TZBdizHlUtMSSsbY8yh7C
         Xnh4Ll+dyuCd0eMUUsae3rM00Xc55yeb6ZH+43TqRA//PUqzXuzWhsk/G6dlbgL4Flih
         ASf3TJRTtX/dRh0e0GDXxexI9BtxP03GxQLGPgQwDp9iXNrZGoz3wJEWVDvYKPzEDWG3
         MiM6UddEB2NmazUJ7mPpgQPvcShlZpUJjqMZ0TG6SZeO8s2osp1aMMHfP9cXQ74tp8Op
         lZWw==
X-Gm-Message-State: AOAM532d91S+GKqR2lyw14eQq2PSXtsvefRPQAlxFcNWCCdsnGcWgpa5
        faypRh9ZBcjrZKek4Ir5RvY=
X-Google-Smtp-Source: ABdhPJw//k0NXcYX0XzZ+Ih/gjrZwd7t+FwVka95iS2KhwMy/vQRUu8NT/fZjBz2+jqHCu7RJ8h7ag==
X-Received: by 2002:a63:4822:: with SMTP id v34mr3878745pga.81.1592363210656;
        Tue, 16 Jun 2020 20:06:50 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id g19sm18210446pfo.209.2020.06.16.20.06.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 20:06:49 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Wed, 17 Jun 2020 08:44:58 +0530
Message-Id: <1592363698-4266-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
Hi,

I have compile tested this patch but unable to run-time test,
so any testing help is much appriciated.

Also have a question, why the existing code is not marking the
pages dirty (since it did FOLL_WRITE) ?

 drivers/xen/privcmd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d11..543739e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -594,7 +594,7 @@ static int lock_pages(
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		pinned = get_user_pages_fast(
+		pinned = pin_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
 		if (pinned < 0)
@@ -614,10 +614,7 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 	if (!pages)
 		return;
 
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			put_page(pages[i]);
-	}
+	unpin_user_pages(pages, nr_pages);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
-- 
1.9.1

