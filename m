Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3371A26D17F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:17:11 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:3588 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQDRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:17:08 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 0F1634E16D2;
        Thu, 17 Sep 2020 11:17:05 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] w1: Use kobj_to_dev() API
Date:   Thu, 17 Sep 2020 11:16:58 +0800
Message-Id: <1600312620-27333-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZShkfQkodHUwfQ08YVkpNS0tISklNSU5OQktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6UQw*GD8eHhQMMxgrNUpJ
        IzdPCxdVSlVKTUtLSEpJTUlNS0pDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKSU1MNwY+
X-HM-Tid: 0a749a10c9279376kuws0f1634e16d2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/w1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index cebf346..7f45174
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -311,7 +311,7 @@ static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
 
 static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
 {
-	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
+	return dev_to_w1_slave(kobj_to_dev(kobj););
 }
 
 static inline struct w1_master* dev_to_w1_master(struct device *dev)
-- 
2.7.4

