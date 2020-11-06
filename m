Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2662A8D82
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgKFDb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:31:29 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:19401 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKFDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:31:29 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id AD9BB666934;
        Fri,  6 Nov 2020 11:31:23 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] usb: Use IS_ERR_OR_NULL() instead of IS_ERR()
Date:   Fri,  6 Nov 2020 11:31:18 +0800
Message-Id: <1604633478-24729-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHxgeSB4fHhhJQx8ZVkpNS09NSEhPQ09KQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6PBw6ND8qKx0XSSs8OkpD
        ARkwCzBVSlVKTUtPTUhIT0NPTkJKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk5ONwY+
X-HM-Tid: 0a759b9bda699373kuwsad9bb666934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__usb_find_phy may return NULL, so we should use IS_ERR_OR_NULL()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/usb/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index de21967..60c5ea4 100755
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -460,7 +460,7 @@ struct usb_phy *usb_get_phy(enum usb_phy_type type)
 	spin_lock_irqsave(&phy_lock, flags);
 
 	phy = __usb_find_phy(&phy_list, type);
-	if (IS_ERR(phy) || !try_module_get(phy->dev->driver->owner)) {
+	if (IS_ERR_OR_NULL(phy) || !try_module_get(phy->dev->driver->owner)) {
 		pr_debug("PHY: unable to find transceiver of type %s\n",
 			usb_phy_type_string(type));
 		if (!IS_ERR(phy))
-- 
2.7.4

