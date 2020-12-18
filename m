Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB92DDCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 02:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgLRBk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 20:40:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9225 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLRBk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 20:40:57 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cxs3c4W9dzkrfv;
        Fri, 18 Dec 2020 09:39:24 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 18 Dec 2020 09:40:08 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <sgarzare@redhat.com>, <mgurtovoy@nvidia.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] vdpa: Mark macaddr_buf with static keyword
Date:   Fri, 18 Dec 2020 09:51:35 +0800
Message-ID: <1608256295-69649-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/vdpa/vdpa_sim/vdpa_sim_net.c:36:4: warning: symbol 'macaddr_buf' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c10b698..f048242 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -33,7 +33,7 @@ static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
 
-u8 macaddr_buf[ETH_ALEN];
+static u8 macaddr_buf[ETH_ALEN];
 
 static struct vdpasim *vdpasim_net_dev;
 
-- 
2.6.2

