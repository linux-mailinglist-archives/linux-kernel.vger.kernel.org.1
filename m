Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5E2E20E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgLWTcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbgLWTcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608751848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kJjdbOEEwK1FgkEiEXoUPnsXX70awX/jULTzmJUO6PI=;
        b=avP/GtQfW4Wz3ZuoWZ7T83wDL5p+NgP4kK3nawLJOvFG/UKkw/pgvoU9TtzFlf9PDTAoc6
        joOEUPD0jSECSTJJTwZkz92QEmybJHrZnE2d1fDILw4WaHkKxRgiWkE8XxFPlj2Pnqe+hI
        iJRkVm+dmZFZofLSs0e9ZEdG0MvbI1g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-8_T2ZhD_NvGLPw3welc6Kg-1; Wed, 23 Dec 2020 14:30:47 -0500
X-MC-Unique: 8_T2ZhD_NvGLPw3welc6Kg-1
Received: by mail-qt1-f199.google.com with SMTP id a22so11110qtx.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJjdbOEEwK1FgkEiEXoUPnsXX70awX/jULTzmJUO6PI=;
        b=oKXaVHfTywLDYidHEtPaUd6JrCVKO0Hb/g2nKEv8NQDPNBmjeuzGRXMEpvxoIyyWHZ
         GzqFW/shDTiAjGu1I9xaw2LAdMe8syoKUZ9qph4Hb8AcyvusfOSHGMmSohP3O/zk7S+T
         +YA5Ygp4vwIgMA5Ost3oTK1IbdwrjsOzg3wINqtft+ZyOAHSeTgP+yvJ7ApcH0qh4RrL
         Zn1GEXkZicEawKAGNV/O9P5XiXrwZc9X0k3KReSxVj70Zfb5WOdXKD7Lt7d8XydvHUei
         NdGO5AeKAq0G27bQ44lWAMSEBv6yfA0MRauTg1ZTVy0LHhWDcH/WYlASanFEW4a6m64n
         4Jcw==
X-Gm-Message-State: AOAM530zNjLXpVvozJ0XqFrnJKX32CznXabm6++LP3tKWmj54g1jkTF4
        atUpe0/hjYinHQtTMX08MjB/yT+/3kgrDqg5Hsxt88nMsFpamYsQ7XzH2VKK8enaNyiK6R7i649
        129NN1Z8ncqX5henp4UNeFZ3s
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr11967183qkl.266.1608751846729;
        Wed, 23 Dec 2020 11:30:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKwbFoyymE7Jwel6VxWx8gXu/NpY8kME52DRUvz+9bwXz0mTvx+Pg/WT3rGFg2zGDGixu97w==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr11967160qkl.266.1608751846529;
        Wed, 23 Dec 2020 11:30:46 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e10sm14676767qtr.92.2020.12.23.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:30:45 -0800 (PST)
From:   trix@redhat.com
To:     oulijun@huawei.com, huwei87@hisilicon.com, liweihang@huawei.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/hns: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:30:41 -0800
Message-Id: <20201223193041.122850-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 833e1f259936..4c068899c52b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -361,7 +361,7 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 	} else if (unlikely(hr_qp->state == IB_QPS_RESET ||
 		   hr_qp->state == IB_QPS_INIT ||
 		   hr_qp->state == IB_QPS_RTR)) {
-		ibdev_err(ibdev, "failed to post WQE, QP state %hhu!\n",
+		ibdev_err(ibdev, "failed to post WQE, QP state %u!\n",
 			  hr_qp->state);
 		return -EINVAL;
 	} else if (unlikely(hr_dev->state >= HNS_ROCE_DEVICE_STATE_RST_DOWN)) {
-- 
2.27.0

