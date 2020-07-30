Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069262329C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgG3B6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 21:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG3B6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:58:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5148C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 18:58:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p15so4013967qvv.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hD4JVbRoXU8HBHOVfHiuteW8LNmG7l4+fLjJw6+lL+o=;
        b=NNHAiB3GjPKlQ2xd5ZEwvNI3BDPOqBsPbHib1dCO1pZMaDNmrdPoRZI+l+EGuATwEr
         LTtHLGmJFuTcIfU43Sqt7WooR5gHwVSc5mQM6X2YENJvLGONb7TGwcsKR2Ch+t+w9Gsh
         MFH0D0jjOIfYTSTEhLPQD/VhFax+cUjC/QKjVrcbzM0yZRgbYgBELsI2na6TDBicnWRB
         VCx8lSF2ElimO0Kpffa/BFNtv2ids+2NZ6uou8OYNhal1Ac5a+T6nCpM3/F0ySEt3NkI
         5L7dt1j0BSu3dopiQ97Q+CbqhkfRadubUKfaQjHQFkUHP40w1Ve98WSC53EtzifkMmNb
         xH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hD4JVbRoXU8HBHOVfHiuteW8LNmG7l4+fLjJw6+lL+o=;
        b=QOPDS2NPyOs9IZY7ggyxHdzlwlROrK55cT1XEH9XkegBgAZ6StkxfZJFaNLM2Ddru9
         OHH3U2P93HxbegflzT6hwbne+NLmJZGhbFCnyCQvuBR4u9l3tMMsSkGqev0a7PwW3n7U
         apeu/E0BN6Ly4YjW3B8rIQKu6W7fmuW8oBGjU3xLhwLtyEjYwdpUaFNiU671Curqzy8Y
         Y7q3dYYKCMuqBANX3GmDxhJ6I/4zrpWmCbAaZu7P9F1QDmq7rc7S5fhNaqMPr4gX7iO3
         Z1rwMDMqHiToqHCv5QhpMTssTA9HQ/NGGDwNA73PK2XhVIL5eDU6apwkhn3x1T4J8Uc7
         nJGA==
X-Gm-Message-State: AOAM533cQ2/vTsaJXvfD9NNp9JFR1nVUUj74igJIamTrOn5OgaL3IhqS
        jrHnWjQL+xTcI3N3L4490u3ec6EThWDqLQ==
X-Google-Smtp-Source: ABdhPJxtYHASL5siDARRmf7mGdSRr96pDCPaV546UOgYlDtH2NBqg8etyj2L9VQKSHjUZCfKcfpQhSULoZWGyw==
X-Received: by 2002:ad4:4d83:: with SMTP id cv3mr767697qvb.236.1596074282824;
 Wed, 29 Jul 2020 18:58:02 -0700 (PDT)
Date:   Wed, 29 Jul 2020 18:57:55 -0700
Message-Id: <20200730015755.1827498-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH net] RDMA/umem: add a schedule point in ib_umem_get()
From:   Eric Dumazet <edumazet@google.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping as little as 64GB can take more than 10 seconds,
triggering issues on kernels with CONFIG_PREEMPT_NONE=y.

ib_umem_get() already splits the work in 2MB units on x86_64,
adding a cond_resched() in the long-lasting loop is enough
to solve the issue.

Note that sg_alloc_table() can still use more than 100 ms,
which is also problematic. This might be addressed later
in ib_umem_add_sg_table(), adding new blocks in sgl
on demand.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/core/umem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 82455a1392f1d19c96ae956f0bd4e93e3a52d29c..831bff8d52e547834e9e04064127fbb280595126 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -261,6 +261,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	sg = umem->sg_head.sgl;
 
 	while (npages) {
+		cond_resched();
 		ret = pin_user_pages_fast(cur_base,
 					  min_t(unsigned long, npages,
 						PAGE_SIZE /
-- 
2.28.0.rc0.142.g3c755180ce-goog

