Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5641B3539
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 04:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDVCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 22:53:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2863 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgDVCxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:53:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 571D6B555698B4456EC4;
        Wed, 22 Apr 2020 10:53:38 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Apr 2020 10:53:27 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ide: Use memdup_user() as a cleanup
Date:   Wed, 22 Apr 2020 10:59:41 +0800
Message-ID: <1587524381-120136-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning which recommends to use memdup_user().

This patch fixes the following coccicheck warnings:

drivers/ide/ide-taskfile.c:492:11-18: WARNING opportunity for memdup_user
drivers/ide/ide-taskfile.c:505:10-17: WARNING opportunity for memdup_user

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/ide/ide-taskfile.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index aab6a10..336b575 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -489,28 +489,16 @@ int ide_taskfile_ioctl(ide_drive_t *drive, unsigned long arg)
 
 	if (taskout) {
 		int outtotal = tasksize;
-		outbuf = kzalloc(taskout, GFP_KERNEL);
-		if (outbuf == NULL) {
-			err = -ENOMEM;
-			goto abort;
-		}
-		if (copy_from_user(outbuf, buf + outtotal, taskout)) {
-			err = -EFAULT;
-			goto abort;
-		}
+		outbuf = memdup_user(buf + outtotal, taskout);
+		if (IS_ERR(outbuf))
+			return PTR_ERR(outbuf);
 	}
 
 	if (taskin) {
 		int intotal = tasksize + taskout;
-		inbuf = kzalloc(taskin, GFP_KERNEL);
-		if (inbuf == NULL) {
-			err = -ENOMEM;
-			goto abort;
-		}
-		if (copy_from_user(inbuf, buf + intotal, taskin)) {
-			err = -EFAULT;
-			goto abort;
-		}
+		inbuf = memdup_user(buf + intotal, taskin);
+		if (IS_ERR(inbuf))
+			return PTR_ERR(inbuf);
 	}
 
 	memset(&cmd, 0, sizeof(cmd));
-- 
2.6.2

