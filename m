Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D531B2F94D6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 20:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbhAQTTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 14:19:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbhAQTMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 14:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610910662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Em1K8iGGVbZwKb6UxAnvYyfV+YtFYb9ZzMNgiaypdCM=;
        b=GbtxJ4K9ABaaJ/swJ6UNmmU+hipoJLYpufDFh7Kp7RWuga3D4zHo39B0IQ0aTDOxH5w/LD
        5lcqJ0/b3P1MrNBBelVbsstitRVEisNT6A6JWx4zK/sIQ1S5z50f/AsYPjJOtWSqdxr1H5
        j2Xx3aN3d4+xKpPu3H00TCm8BfjGUwk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-sg0s4sJkN2-wUr4libT-yg-1; Sun, 17 Jan 2021 14:11:01 -0500
X-MC-Unique: sg0s4sJkN2-wUr4libT-yg-1
Received: by mail-qt1-f197.google.com with SMTP id b24so13162818qtt.22
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 11:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Em1K8iGGVbZwKb6UxAnvYyfV+YtFYb9ZzMNgiaypdCM=;
        b=Q65x7oibYOhBkJqqi6NNAZ3IyZMP08Q7T7IjaWx31TpxOn4Kuu6+OcfylPbNpjG+pb
         OlzM+7lIWNGEnDkBvYBhoM8HcefzI8MFnqG7n7o+WFHVRUdN6OHTjaJ18wDXJMAFV841
         /atHIAYJfOtYRuIRd72f5iY7LZvMWptSPiVnIkp/ZcPkJHPlrM6DAJHzliNiBRFRohBr
         GxA5sE8VQDme4yDcvOeeOMgz3SicnaKvDS7bbZX6QRgIqFcRZJwPjBf9Pw+7PeVlz+yN
         QULUFPzd+IssNULBuEKzGf+AFHVFC8g0lL8TSFJ+EkxbCpZWo4WfX0/HtUp6tKoK1pUC
         SFTw==
X-Gm-Message-State: AOAM533/Nhw1w62WVPZEZSSLrsXhEwMYIHbaoVdwQQ+DBNHGYdcFSVuR
        4dwyZmWm3ADOH62eOnzkKcSkUBG2OY7SxparAtd6kjqpImRiCKanfS3W5mooDOXmXMt4YEtWmDp
        JxGLerauVuJLjijg0M62OOcDj
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr20930350qvb.28.1610910660579;
        Sun, 17 Jan 2021 11:11:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJys+5WmDdhQZSf7Bo92p1Zef8NtD8MJKSQLi9fdPdilJd0j8CLv5wMslW7B15+N4dr1hnGt3Q==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr20930326qvb.28.1610910660403;
        Sun, 17 Jan 2021 11:11:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u26sm9261854qkm.69.2021.01.17.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 11:10:59 -0800 (PST)
From:   trix@redhat.com
To:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, kuba@kernel.org, timur@kernel.org,
        hkallweit1@gmail.com, song.bao.hua@hisilicon.com,
        tariqt@mellanox.com, wanghai38@huawei.com, Jason@zx2c4.com,
        jesse.brandeburg@intel.com, dinghao.liu@zju.edu.cn,
        liguozhu@huawei.com, huangdaode@hisilicon.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: hns: fix variable used when DEBUG is defined
Date:   Sun, 17 Jan 2021 11:10:44 -0800
Message-Id: <20210117191044.533725-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

When DEBUG is defined this error occurs

drivers/net/ethernet/hisilicon/hns/hns_enet.c:1505:36: error:
  ‘struct net_device’ has no member named ‘ae_handle’;
  did you mean ‘rx_handler’?
  assert(skb->queue_mapping < ndev->ae_handle->q_num);
                                    ^~~~~~~~~

ae_handle is an element of struct hns_nic_priv, so change
ndev to priv.

Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 858cb293152a..5d7824d2b4d4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1502,7 +1502,7 @@ static netdev_tx_t hns_nic_net_xmit(struct sk_buff *skb,
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 
-	assert(skb->queue_mapping < ndev->ae_handle->q_num);
+	assert(skb->queue_mapping < priv->ae_handle->q_num);
 
 	return hns_nic_net_xmit_hw(ndev, skb,
 				   &tx_ring_data(priv, skb->queue_mapping));
-- 
2.27.0

