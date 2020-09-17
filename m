Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1783326D4ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIQHml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:42:41 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:12496 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIQHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:42:19 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id CB3D04E10B9;
        Thu, 17 Sep 2020 15:42:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] w1: Use kobj_to_dev() API
Date:   Thu, 17 Sep 2020 15:42:04 +0800
Message-Id: <1600328527-29162-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHU4fHU9DSUIYSU8fVkpNS0tISUNOSE5LTUxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Azo6MT8uOBQ3NQoQGBBM
        OiwaCxNVSlVKTUtLSElDTkhOT0NCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFKSUxJNwY+
X-HM-Tid: 0a749b038b9a9376kuwscb3d04e10b9
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
+	return dev_to_w1_slave(kobj_to_dev(kobj));
 }
 
 static inline struct w1_master* dev_to_w1_master(struct device *dev)
-- 
2.7.4

