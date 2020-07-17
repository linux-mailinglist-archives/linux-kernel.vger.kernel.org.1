Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4E2236D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgGQIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 04:17:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbgGQIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:17:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 811CDCCE162726C141B8;
        Fri, 17 Jul 2020 16:17:39 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 16:17:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <anarsoul@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: line6: Use kmemdup in podhd_set_monitor_level()
Date:   Fri, 17 Jul 2020 16:17:10 +0800
Message-ID: <20200717081710.39180-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/line6/podhd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 1557483ec657..eef45f7fef0d 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -293,12 +293,10 @@ static void podhd_set_monitor_level(struct usb_line6_podhd *podhd, int value)
 	};
 	unsigned char *buf;
 
-	buf = kmalloc(sizeof(msg), GFP_KERNEL);
+	buf = kmemdup(msg, sizeof(msg), GFP_KERNEL);
 	if (!buf)
 		return;
 
-	memcpy(buf, msg, sizeof(msg));
-
 	if (value < 0)
 		value = 0;
 
-- 
2.17.1


