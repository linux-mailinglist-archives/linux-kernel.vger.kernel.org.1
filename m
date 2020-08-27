Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821132544E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgH0MXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:23:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgH0MEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:04:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3A6F7A30A92F3629DE6;
        Thu, 27 Aug 2020 20:04:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 20:04:24 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <eli@mellanox.com>,
        <dan.carpenter@oracle.com>, <parav@mellanox.com>,
        <natechancellor@gmail.com>, <colin.king@canonical.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] vdpa/mlx5: Remove duplicate include
Date:   Thu, 27 Aug 2020 20:05:47 +0800
Message-ID: <20200827120547.83997-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/mlx5/device.h which is included more than once

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 70676a6d1691..b4bdbe062b7c 100644
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
2.26.0.106.g9fadedd

