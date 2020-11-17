Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1D2B57B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKQDJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:09:02 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:6462 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQDJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:09:02 -0500
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 22:08:59 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55fb33c9b74f-9428c; Tue, 17 Nov 2020 10:59:40 +0800 (CST)
X-RM-TRANSID: 2ee55fb33c9b74f-9428c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15fb33c99892-3cb17;
        Tue, 17 Nov 2020 10:59:38 +0800 (CST)
X-RM-TRANSID: 2ee15fb33c99892-3cb17
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     TheSven73@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fieldbus: use kobj_to_dev() to get device
Date:   Tue, 17 Nov 2020 10:59:33 +0800
Message-Id: <20201117025933.668938-1-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/staging/fieldbus/dev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 1ba0234cc60d..5aab734606ea 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -134,7 +134,7 @@ static struct attribute *fieldbus_attrs[] = {
 static umode_t fieldbus_is_visible(struct kobject *kobj, struct attribute *attr,
 				   int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-- 
2.28.0



