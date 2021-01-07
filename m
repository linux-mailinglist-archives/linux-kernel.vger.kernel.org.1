Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D62EC80C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbhAGCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:22:25 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48583 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726703AbhAGCWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:22:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UKxLfZz_1609986086;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKxLfZz_1609986086)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Jan 2021 10:21:39 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] net/bluetooth: WARNING: adv_channel_map_fops should be defined with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Thu,  7 Jan 2021 10:21:11 +0800
Message-Id: <1609986071-117076-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adv_channel_map_fops is used in the debug file, we use
DEFINE_DEBUGFS_ATTRIBUTE replaces DEFINE_SIMPLE_ATTRIBUTE,
more clear and intuitive.

Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 net/bluetooth/hci_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 4626e02..1b67cd3 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -981,7 +981,7 @@ static int adv_channel_map_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
+DEFINE_DEBUGFS_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
 			adv_channel_map_set, "%llu\n");
 
 static int adv_min_interval_set(void *data, u64 val)
-- 
1.8.3.1

