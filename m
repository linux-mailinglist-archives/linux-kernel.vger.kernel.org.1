Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083972E75B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 03:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL3Cs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 21:48:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgL3Cs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 21:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609296422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qd6nMabBaDCBXEiCctK4wjRScqdv2pc8J+Ek6ufNcrI=;
        b=Jxp4gpkHqln+T2GxemWNQiSq2P0nHDPopO635kq5L3uKgzE3HQQ+zW0us13CaXvTs2fhXx
        mCU6uRUV5WgQ0otMxn8okHX3kVXNXfxGHaP3SC/Juy9Itf+0HUKTXl1R2FcsGF1W2LNImt
        n7IGZ8+nSPJLezZxAZvGEKFjIHyqSHw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-0F-282P1Npyncibw4-_4iQ-1; Tue, 29 Dec 2020 21:47:00 -0500
X-MC-Unique: 0F-282P1Npyncibw4-_4iQ-1
Received: by mail-oi1-f200.google.com with SMTP id r204so10038231oia.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 18:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qd6nMabBaDCBXEiCctK4wjRScqdv2pc8J+Ek6ufNcrI=;
        b=s79wl+M+PM+p1Fyf4xznWeP9MvxzphasU8uvumWExLetJuE/w2Wzrlvr9c4GvsqJhq
         ay6grw0UW4o5mX/WYPIZUbW3RXlmFJRD8fZFiBEk7/S4IOmP6tjDJ2+XuyFktWMZEJC8
         0/Mpt/KOqKMyAWMoKaQb5K0rHMhnyf2E7xG/eGUSlwe8PWPGGpEhzPtu/68BKct1vHxk
         Sxxrb6OH9gzjxM+/ZxS7D97ygc2xpbkgQ9oob8D6xNc64d+eLB8KezPcsh8ckwfLQSAe
         PrXKqdjJA5RsTYcchHZ+U43lcp4YtsJw/dziX1nUt+Nlqbzm+JAWuoKIGutu029KVNro
         9RTw==
X-Gm-Message-State: AOAM530LQXoQIAOnxExw1qsjuV2YUuUfJKimSKda2sYiNlNSjaXnBy/1
        hcXj+De+tdMUPsh9JStW8HQNXkJKMg+7HfsWppaRZjIy0wtT95yULLtVohQg613OJ98nEc90yJI
        /BuQ14hnxL92MjIWteIscTeA9
X-Received: by 2002:a9d:4793:: with SMTP id b19mr36913686otf.193.1609296419863;
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyi+KRvLyMyUmLuqPNbTkK+ueMj71floi2LMwHGuN3AywqUKApUEtQilDxkXXDP+Bc+Nc7x8w==
X-Received: by 2002:a9d:4793:: with SMTP id b19mr36913679otf.193.1609296419647;
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm10488091otw.41.2020.12.29.18.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 18:46:59 -0800 (PST)
From:   trix@redhat.com
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        maxg@mellanox.com, galpress@amazon.com, michaelgur@nvidia.com,
        monis@mellanox.com, gustavoars@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/ocrdma: fix use after free in ocrdma_dealloc_ucontext_pd()
Date:   Tue, 29 Dec 2020 18:46:53 -0800
Message-Id: <20201230024653.1516495-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
the variable pd and then after uctx->cntxt_pd is freed, the
variable pd is passed to function _ocrdma_dealloc_pd() which
dereferences pd directly or through its call to
ocrdma_mbx_dealloc_pd().

Reorder the free using the variable pd.

Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index bc98bd950d99..3acb5c10b155 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -434,9 +434,9 @@ static void ocrdma_dealloc_ucontext_pd(struct ocrdma_ucontext *uctx)
 		pr_err("%s(%d) Freeing in use pdid=0x%x.\n",
 		       __func__, dev->id, pd->id);
 	}
-	kfree(uctx->cntxt_pd);
 	uctx->cntxt_pd = NULL;
 	_ocrdma_dealloc_pd(dev, pd);
+	kfree(pd);
 }
 
 static struct ocrdma_pd *ocrdma_get_ucontext_pd(struct ocrdma_ucontext *uctx)
-- 
2.27.0

