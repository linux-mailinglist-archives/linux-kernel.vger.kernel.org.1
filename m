Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA924923F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHSBVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:21:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgHSBVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:21:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0BCF02E87E7A37FE1993;
        Wed, 19 Aug 2020 09:21:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 09:21:27 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <johan@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] USB: usblcd: Remove the superfluous break
Date:   Wed, 19 Aug 2020 09:23:16 +0800
Message-ID: <20200819012316.170388-1-jingxiangfeng@huawei.com>
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

Remove the superfuous break, as there is a 'return' before it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/usb/misc/usblcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/misc/usblcd.c b/drivers/usb/misc/usblcd.c
index 61e9e987fe4a..bb546f624a45 100644
--- a/drivers/usb/misc/usblcd.c
+++ b/drivers/usb/misc/usblcd.c
@@ -187,7 +187,6 @@ static long lcd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	default:
 		return -ENOTTY;
-		break;
 	}
 
 	return 0;
-- 
2.17.1

