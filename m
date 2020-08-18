Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19859248419
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHRLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:46:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbgHRLqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:46:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1C364DDE40549F011D29;
        Tue, 18 Aug 2020 19:46:12 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:46:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eli@mellanox.com>,
        <colin.king@canonical.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] vdpa/mlx5: Remove duplicate include
Date:   Tue, 18 Aug 2020 19:46:01 +0800
Message-ID: <20200818114601.21656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate include file

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9df69d5efe8c..12fb83dc1de9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -8,7 +8,6 @@
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
-#include <linux/mlx5/device.h>
 #include "mlx5_vnet.h"
 #include "mlx5_vdpa_ifc.h"
 #include "mlx5_vdpa.h"
-- 
2.17.1


