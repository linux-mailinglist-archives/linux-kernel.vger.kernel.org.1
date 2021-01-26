Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90254303DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392495AbhAZM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404088AbhAZMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:49:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C14C035439
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p15so9657199wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+DMI0EXUYJJLvmmH2bAEB7JiPLoVbXeT/sw5HJ1UT8=;
        b=BFvftWxNjJ1f8kZeSk14lsUMun1/l2fh/zf2H/00VdGTMPu6yAgBNrw7KEwZi6M1wS
         mTWkBcyI8MQqtNZJFTW2FOyW10BxStpDjS71ik/aSVyBT2eYIffwIu2tY+uO1TWDUmlm
         wkNPljH37Zm3tX8CbgiHUQcguqlyY8aARKGG+27JgQPjbb5VG7PWKilCrUZaS0NOL3xn
         KSJGvD7Ah0knlmc6gbCugR3iVZaJA+eKz7fqGFmVZavgQZ2j1g/lZxO1iYKLJ/FHD1kV
         JFREmbuOCnycRzarZqSlPOzfAUp/Nz9SIuUpOWHXI/6PUqKUFh001jcQXvq7eM510Oow
         DEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+DMI0EXUYJJLvmmH2bAEB7JiPLoVbXeT/sw5HJ1UT8=;
        b=brkEo4h079dYqtduK31m3tVI4tfZXHTR5A/qm2bjv4odJOvb10RFH4E0hvX9WMvd+2
         t85NKrnJ1BKmFNZFMvHySxL/XN02m4+QYy/0a0ycTFkcs46R14KI8SN6+Zho08VoWS46
         1iYlbsCN4oo4OENqF5jkkNmC+4SSm93qsDsuQXvx+uiXJFlxTqjZwIcuBsIHAa2YW/Lh
         3O6njlVY7kRC0Tez5/ySxoA61/Iu5qUVHgnfTIEpm1nEp+4Dx3vqXvS56hGjCg1NSqq/
         7RcgA0ep4BzZ79fLCoIYHibj5n1iVizBoRNkPz8NWuHxcSQpXu8n5WzkuZpe1bxSfUFv
         AuPQ==
X-Gm-Message-State: AOAM530OU+hDxYVCl3e+NXucdDzbownIViBG23XSm2beoCsoI0YYOjv8
        GYJR95y175nEdKVe/OtbPjsACg==
X-Google-Smtp-Source: ABdhPJwrmxLQr9CLyptuMRo6dOqaAb/sply8hRE70jVFz+f/6LzkND+6LLI0NL6a3EFXnc8j3mCewQ==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr5872456wrq.187.1611665264670;
        Tue, 26 Jan 2021 04:47:44 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 08/20] RDMA/hw/hfi1/netdev_rx: Fix misdocumentation of the 'start_id' param
Date:   Tue, 26 Jan 2021 12:47:20 +0000
Message-Id: <20210126124732.3320971-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/netdev_rx.c:473: warning: Function parameter or member 'start_id' not described in 'hfi1_netdev_get_first_data'
 drivers/infiniband/hw/hfi1/netdev_rx.c:473: warning: Excess function parameter 'id' description in 'hfi1_netdev_get_first_data'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 6d263c9749b36..1fb6e1a0e4e1d 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -467,7 +467,7 @@ void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
  * hfi1_netdev_get_first_dat - Gets first entry with greater or equal id.
  *
  * @dd: hfi1 dev data
- * @id: requested integer id up to INT_MAX
+ * @start_id: requested integer id up to INT_MAX
  */
 void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id)
 {
-- 
2.25.1

