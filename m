Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E802711D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgITCwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITCwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 22:52:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A128C061755
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 19:52:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so6125290pfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 19:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zJSnVOCqAFf0VQA2TxrthxMOgiiBuc+ZeZVZU7jVUzQ=;
        b=q6RWV+yTRZWPAMpvMuYwzXWOoBYb/a0Bf3CEQ0I4j2F3YBoycbZdso3bSivcFkLBcg
         7VoeCiYcl4sI7oSX0KHT4YdDeZLRUvoC+eg9q50jCmvaTLQSxrpYE5YKnhgQcgOFrujh
         JLUnQpEq5vdsoMD6OOpOg7OKvqcz8ymqAxoRfdm+kUgDmqzEss2tKjFpxpC9mXCH4HBx
         4EQ8ZvHaj1RJyY8fcKhbhlbsiy9JIiCaO75K+T8mpHyoCiBIicDPWHnutZlt2TPD94bd
         vA6zndJnrTYltJITiNiMLCJVcQLA+9Gy4Q2nb3ifg0VWq3EWe81ZQaggg6JM9NhM37s8
         Wy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJSnVOCqAFf0VQA2TxrthxMOgiiBuc+ZeZVZU7jVUzQ=;
        b=ONw3b3qISRaA93AwStKp11sQc0CXHsOOUDwodeJzVTlzZi4BvxoFd5EjuXfkZh1dXN
         CtyJ9IvhtsJbw6os3la5SMTcVqgZxJCUn6rKlBaLqWfrjO/JJc64ZMx7Es9tY3yrvlvq
         UUkdOuyjELMpdgEYcrOrEo4Yf8MbuByQkXBY2sDVwEWWnxblFSZlU1C3BTGLloGQzNUt
         9LYIaqEvIMMOJFggLvz/6vNSmMHzygGWXhFJQ8xu+oGaZOsrxtFoig/k8bqYcxljaic/
         GaS/bZ8JJ3Qw048Y3i3M3LrAH6vLKTt42GtYcZKT2ifVfThQYYzj1+H/WHkk21dNwFtx
         y/EA==
X-Gm-Message-State: AOAM531CJLNY3rQQOJAqXXijbVdWiQEbvDXXVQg4ZncKpVGS3AaV8QK8
        4MDmwkXi+gEqfb+x7d9nMQs=
X-Google-Smtp-Source: ABdhPJx8LsOAA69Nn+EL4ZOkV9KaYtxhzUVAQByeXS7kZbHy2knP6l9hbZG48YkNsS0lyMQvCZq+rA==
X-Received: by 2002:a62:5bc2:0:b029:13e:d13d:a130 with SMTP id p185-20020a625bc20000b029013ed13da130mr37575026pfb.24.1600570361925;
        Sat, 19 Sep 2020 19:52:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([136.185.116.161])
        by smtp.gmail.com with ESMTPSA id ga3sm7032733pjb.18.2020.09.19.19.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Sep 2020 19:52:41 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        lee.jones@linaro.org, gustavoars@kernel.org, nikhil.rao@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] misc: mic: scif: Fix error handling path
Date:   Sun, 20 Sep 2020 08:21:35 +0530
Message-Id: <1600570295-29546-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside __scif_pin_pages(), when map_flags != SCIF_MAP_KERNEL it
will call pin_user_pages_fast() to map nr_pages. However,
pin_user_pages_fast() might fail with a return value -ERRNO.

The return value is stored in pinned_pages->nr_pages. which in
turn is passed to unpin_user_pages(), which expects
pinned_pages->nr_pages >=0, else disaster.

Fix this by assigning pinned_pages->nr_pages to 0 if
pin_user_pages_fast() returns -ERRNO.

Fixes:	ba612aa8b487 ("misc: mic: SCIF memory registration and
unregistration")
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/mic/scif/scif_rma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index 2da3b47..18fb9d8 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -1392,6 +1392,8 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
 				(prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
 				pinned_pages->pages);
 		if (nr_pages != pinned_pages->nr_pages) {
+			if (pinned_pages->nr_pages < 0)
+				pinned_pages->nr_pages = 0;
 			if (try_upgrade) {
 				if (ulimit)
 					__scif_dec_pinned_vm_lock(mm, nr_pages);
@@ -1408,7 +1410,6 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
 
 	if (pinned_pages->nr_pages < nr_pages) {
 		err = -EFAULT;
-		pinned_pages->nr_pages = nr_pages;
 		goto dec_pinned;
 	}
 
@@ -1421,7 +1422,6 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
 		__scif_dec_pinned_vm_lock(mm, nr_pages);
 	/* Something went wrong! Rollback */
 error_unmap:
-	pinned_pages->nr_pages = nr_pages;
 	scif_destroy_pinned_pages(pinned_pages);
 	*pages = NULL;
 	dev_dbg(scif_info.mdev.this_device,
-- 
1.9.1

