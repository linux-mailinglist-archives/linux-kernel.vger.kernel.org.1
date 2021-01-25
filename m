Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC5302548
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbhAYNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:04:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11189 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbhAYMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:54:30 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPTgm2mMCzl9T4;
        Mon, 25 Jan 2021 20:29:08 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 20:30:30 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <benh@kernel.crashing.org>, <sashal@kernel.org>
CC:     <rentao.bupt@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] usb: gadget: Remove unused including <linux/version.h>
Date:   Mon, 25 Jan 2021 20:41:32 +0800
Message-ID: <1611578492-43121-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following versioncheck warning:

drivers/usb/gadget/udc/aspeed-vhub/hub.c:33:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
index 396a7d8..b192d57 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
@@ -30,7 +30,6 @@
 #include <linux/regmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
-#include <linux/version.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
-- 
2.6.2

