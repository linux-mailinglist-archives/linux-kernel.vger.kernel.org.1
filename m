Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1462D2A93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgLHMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:20:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8966 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLHMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:20:09 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CqzkG5jBvzhpHD;
        Tue,  8 Dec 2020 20:19:02 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 20:19:16 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <pawell@cadence.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] usb: cdnsp: Mark cdnsp_gadget_ops with static keyword
Date:   Tue, 8 Dec 2020 20:30:49 +0800
Message-ID: <1607430649-116383-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/usb/cdns3/cdnsp-gadget.c:1546:29: warning: symbol 'cdnsp_gadget_ops' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 9716273..c7c5d0a 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1543,7 +1543,7 @@ static int cdnsp_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-const struct usb_gadget_ops cdnsp_gadget_ops = {
+static const struct usb_gadget_ops cdnsp_gadget_ops = {
 	.get_frame		= cdnsp_gadget_get_frame,
 	.wakeup			= cdnsp_gadget_wakeup,
 	.set_selfpowered	= cdnsp_gadget_set_selfpowered,
-- 
2.6.2

