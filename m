Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C22FAD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbhARWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbhARWk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:40:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v184so10832129wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0puy8o7LHNVbEzkyY59cGvZqMSuCg/PeXRGc8n18wAg=;
        b=ODEVOMHlxe7SGHsihCkX7hiljk7MVMMUM3rJ2TKfImIU8XsPRzldc0/1cjzc7x3j+G
         l8IpoJKX12cTxSaJDcvYyprVEgImw0m6ELitWfdQyAv/dN8ddK7DBhhYirKCtSjn5DDQ
         QjGO+3uSUwx/N9r3ewIaEBokfkPBu+0vuTkh12s2UzHTTWV0iLNaH5Egbv8kHJEB4Slf
         X5CeDUPHJLPxLrKgHTnrOrhVJ6Puj51aIKfDGNQG/Dx/lRXyoAiJ7BhHZIEGEChgKbQA
         XCUy1u2GLMTXgN4Fzz+eB74tuA4FcxLD2sgMMojpy7TASuUlDBQWQUu/YrvTiDUALDQS
         VGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0puy8o7LHNVbEzkyY59cGvZqMSuCg/PeXRGc8n18wAg=;
        b=HMhNn9oJKHBQWik77Lhyfu8xcyckPN+VuFuY+aeqHqdLq2kkiexq5tP5NdbeWctROu
         18aPWuCYrO1K71bvxNMxB83f3JK5p7YMhy6gutyBAC5/NPGG4Q3HJdPTNPHwuVX0WAp5
         ulMjwJH1cbpuY9lQA4Aq15pzL4hbT6X7iPDkTSP7QEbp26pCmwC+etA1WdcLJC7MQHct
         ARtumw85Lcsu0dN5XPwmF/vuoYL0Ao9CveDuVw4gQUDs9lMKW8b0UPfhhG1utH1bAJzg
         VnSoPAUAKEL7UYJ5eC9E8+HGSEqBQ5lmFZpQS1V7axd3kMaQBQheWd1JGg4+lihnT0Cr
         BRUA==
X-Gm-Message-State: AOAM5329/pZPUIxFRBJkLwOeXlUKDQy+6MAfKFNbL6GDIknY13j8nz6V
        6ko/+Umd+cqDs78mcjLIOZRyVw==
X-Google-Smtp-Source: ABdhPJzFeMmq2VFdzOVQqg0w8Xj/sR8Jb/x6la5bbSfxKnlZSshuvA/mtI0tmNuWHeQ1X2+c1XbAkg==
X-Received: by 2002:a05:600c:4148:: with SMTP id h8mr1262579wmm.137.1611009578591;
        Mon, 18 Jan 2021 14:39:38 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 05/20] RDMA/core/cache: Fix some misspellings, missing and superfluous param descriptions
Date:   Mon, 18 Jan 2021 22:39:14 +0000
Message-Id: <20210118223929.512175-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/cache.c:688: warning: Function parameter or member 'ib_dev' not described in 'rdma_find_gid_by_port'
 drivers/infiniband/core/cache.c:688: warning: Function parameter or member 'port' not described in 'rdma_find_gid_by_port'
 drivers/infiniband/core/cache.c:688: warning: Excess function parameter 'device' description in 'rdma_find_gid_by_port'
 drivers/infiniband/core/cache.c:688: warning: Excess function parameter 'port_num' description in 'rdma_find_gid_by_port'
 drivers/infiniband/core/cache.c:741: warning: Function parameter or member 'ib_dev' not described in 'rdma_find_gid_by_filter'
 drivers/infiniband/core/cache.c:741: warning: Function parameter or member 'context' not described in 'rdma_find_gid_by_filter'
 drivers/infiniband/core/cache.c:741: warning: Excess function parameter 'device' description in 'rdma_find_gid_by_filter'
 drivers/infiniband/core/cache.c:1263: warning: Excess function parameter 'num_entries' description in 'rdma_query_gid_table'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/cache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 7989b7e1d1c04..5c9fac7cf4203 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -669,11 +669,10 @@ int ib_cache_gid_del_all_netdev_gids(struct ib_device *ib_dev, u8 port,
  * rdma_find_gid_by_port - Returns the GID entry attributes when it finds
  * a valid GID entry for given search parameters. It searches for the specified
  * GID value in the local software cache.
- * @device: The device to query.
+ * @ib_dev: The device to query.
  * @gid: The GID value to search for.
  * @gid_type: The GID type to search for.
- * @port_num: The port number of the device where the GID value should be
- *   searched.
+ * @port: The port number of the device where the GID value should be searched.
  * @ndev: In RoCE, the net device of the device. NULL means ignore.
  *
  * Returns sgid attributes if the GID is found with valid reference or
@@ -719,7 +718,7 @@ EXPORT_SYMBOL(rdma_find_gid_by_port);
 /**
  * rdma_find_gid_by_filter - Returns the GID table attribute where a
  * specified GID value occurs
- * @device: The device to query.
+ * @ib_dev: The device to query.
  * @gid: The GID value to search for.
  * @port: The port number of the device where the GID value could be
  *   searched.
@@ -728,6 +727,7 @@ EXPORT_SYMBOL(rdma_find_gid_by_port);
  *   otherwise, we continue searching the GID table. It's guaranteed that
  *   while filter is executed, ndev field is valid and the structure won't
  *   change. filter is executed in an atomic context. filter must not be NULL.
+ * @context: Private data to pass into the call-back.
  *
  * rdma_find_gid_by_filter() searches for the specified GID value
  * of which the filter function returns true in the port's GID table.
@@ -1253,7 +1253,6 @@ EXPORT_SYMBOL(rdma_get_gid_attr);
  * @entries: Entries where GID entries are returned.
  * @max_entries: Maximum number of entries that can be returned.
  * Entries array must be allocated to hold max_entries number of entries.
- * @num_entries: Updated to the number of entries that were successfully read.
  *
  * Returns number of entries on success or appropriate error code.
  */
-- 
2.25.1

