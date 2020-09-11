Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F7266992
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgIKUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIKUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:35:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2872C061786
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x69so7146880lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GewCu+r/T2qN6Yi/f+by56zz1JLW6wRKFDlznH/iUyM=;
        b=iLa4rEIbXQFrfjfGM4oxZKiS16n0ZrxeuAUoys+g5/RqE1v0PuoT6IwAljz5Ogi9+l
         jPMVC/YkjM9wwVSK0qbKz0TBEw+eBb6TrBsYP0TCOaynJXI0Pn/K0yKPjTGUX6gsMWJ1
         5IMxEqeTzYr+P8A+C5rPXSvQhDOdcG/hh3eTVQ5kI/noCvbVt9UF+5iT2Jzz/gyTfrl1
         0lCdsCOfjv1d/OOWMOsH0L6ysohcZWHU6ASPR4PUG5ZW2WVT2R9htwo6YMdAM9Gll9QM
         FBXD6KA48eSMvOpU4MLDv5PrVq/ub2yQlMQzpp3OQh6rTxC8KIttHsY02a1M3U09oRxi
         GiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GewCu+r/T2qN6Yi/f+by56zz1JLW6wRKFDlznH/iUyM=;
        b=AdH894cQbCcLuGrtDXVd6ovN+d9GI7j8mEGAnkZHrfoSlPlzq9sm3WRr9Gvp335/7R
         zJvGHiNnSYvFiZJt2eDqWEHQbcJUikuwuxc89RsJgRv2g0ZqZRSTyiP8fXy1bhxuR1NF
         4bF0ehVJzkvBTlM2Wnwlwz8kY++c0NE7CMDSmOb0tMma9My4CarPeqWwtUhhHN9+EdNB
         NhebOupLazNETSq014fGdq+nnrEie+jACeYP3iG9gdP1xqJPmlY+RXyUWreRmesyOVNG
         S+FkPqnIRFiIyYcTKRkMJKKKzm3jpFcAKz8xT2An5nniI/EanX1JPEzTHqzMksat9Qiz
         +o+Q==
X-Gm-Message-State: AOAM531R2BPmOj69mBcPR431kAFOFKec36nXrWrxTZ1UYKAlTBbNT8xT
        s3Cg2X71Eur+0lNcGzSNM7X5vn6YC6PD7A==
X-Google-Smtp-Source: ABdhPJzNkd/1ntz6S7geFXslzcOl06vECqr1OEwLv6xtubc9XDD7LIMnWQIXCbdZR4CGbofox7Q2OQ==
X-Received: by 2002:a19:404:: with SMTP id 4mr772179lfe.343.1599856518314;
        Fri, 11 Sep 2020 13:35:18 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id d1sm214390lfe.180.2020.09.11.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:35:17 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] virtio-mem: Constify mem_id_table
Date:   Fri, 11 Sep 2020 22:35:09 +0200
Message-Id: <20200911203509.26505-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
References: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_id_table is not modified, so make it const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 834b7c13ef3d..1d0f3ab2b509 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1926,7 +1926,7 @@ static unsigned int virtio_mem_features[] = {
 #endif
 };
 
-static struct virtio_device_id virtio_mem_id_table[] = {
+static const struct virtio_device_id virtio_mem_id_table[] = {
 	{ VIRTIO_ID_MEM, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
-- 
2.28.0

