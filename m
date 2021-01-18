Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D632FAD75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbhARWmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbhARWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:41:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BEC06179A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c5so17912874wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orJ4MubFFDrHOBvfCjsG4URIp3hoMSlpV6ATN8JCkIo=;
        b=sZWe1lP5fLhCU3GqoO7akig9dSeHebVeFrHGuu4i5asoHobQN2ThfoWSqFNh+tlK/k
         Fi+siBJRky8inu8KjhGVE1vwJMaAX7GcSkcRjbBZp398Kbls6llygpN77QQCLy2BINQO
         ZpNYhftoOfFiBZ2AFVdwOXvtrbY1TOcmr5XryL2DDoN7LWsrKt/efKBLY8cH4tWVzH0i
         CUTZPO3wR8h6EeOeqhWQEpAkptbf9W+fNhj8zAOw+NdUdpt2xfIeMCzJteK3m9GX7I5X
         pq0Pw7Y1tRrXzRGtQmCNN8UhCTEEXnvUGWk9LxmBUFIl05QU7Ajy4q9ZvBsUYfmxWlca
         k3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orJ4MubFFDrHOBvfCjsG4URIp3hoMSlpV6ATN8JCkIo=;
        b=UPLmD6l8SChMt6SS1JiNBlIr6jW+7ZIEDrqDzEvs/F9a+NbivZnSVu3lex2T1cr7ft
         vhLQumCHs/vct6m9ffgSpylo/Vt+m14qPFUzO5d1l5/U3bmhJMOwJRm/GtlJBdC2WeKo
         jKGQmFbJC3N99qCWUdN3Mf3KluQanCwWAlwJgUpt7xrA2vp1+RYEI+LZCvj3cvoO+vXu
         z1hi9tGFHQ2hWY303mdcibFQVJ/Rlf5lBxeBol5IyXvHGu/SbGJ/yRlBsErLNlJp/0oy
         VugWjKavuBBQLDPiZ0syv5vzxy2CdAqHh3bzwpyiOSACHCWKjpBkcNrmzmG4hk2u4YUE
         nBbw==
X-Gm-Message-State: AOAM531x6y8ofZ1j/vd1RQ+T/4ZWwRWIZPqZbmU9cum1sudNFnRDojg3
        TZ1cldsPxZ/R4DT/r+UL6jShsw==
X-Google-Smtp-Source: ABdhPJxH3Pgx7YHt5GpuujRMO6MRF3pwk+EFgidtQ3/cdtNsO2hfzVmhKUGiBqomPyi5RhvHCqoGHA==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr1382127wrp.377.1611009581912;
        Mon, 18 Jan 2021 14:39:41 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org
Subject: [PATCH 08/20] RDMA/core/roce_gid_mgmt: Fix misnaming of 'rdma_roce_rescan_device()'s param 'ib_dev'
Date:   Mon, 18 Jan 2021 22:39:17 +0000
Message-Id: <20210118223929.512175-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/roce_gid_mgmt.c:511: warning: Function parameter or member 'ib_dev' not described in 'rdma_roce_rescan_device'
 drivers/infiniband/core/roce_gid_mgmt.c:511: warning: Excess function parameter 'device' description in 'rdma_roce_rescan_device'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 6b8364bb032d6..34fff94eaa382 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -505,7 +505,7 @@ static void enum_all_gids_of_dev_cb(struct ib_device *ib_dev,
  * rdma_roce_rescan_device - Rescan all of the network devices in the system
  * and add their gids, as needed, to the relevant RoCE devices.
  *
- * @device:         the rdma device
+ * @ib_dev:         the rdma device
  */
 void rdma_roce_rescan_device(struct ib_device *ib_dev)
 {
-- 
2.25.1

