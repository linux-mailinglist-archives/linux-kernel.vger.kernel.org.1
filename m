Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20202A8D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKFDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:16:14 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:41335 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:16:14 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id D39B8666B4D;
        Fri,  6 Nov 2020 11:16:09 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20usb=3A=20Assign=20NULL=20=E2=80=8B=E2=80=8Bto=20phy=20that=20may=20be=20returned?=
Date:   Fri,  6 Nov 2020 11:15:55 +0800
Message-Id: <1604632555-18497-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSxodTUsYQ01OH05MVkpNS09NSElOTEtKTkxVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6ATo*Ij8dKx0hSg43FD0I
        GVFPFENVSlVKTUtPTUhJTkxLTkxNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTU5KNwY+
X-HM-Tid: 0a759b8de8b99373kuwsd39b8666b4d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign initial values ​​to local variables that may be returned

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/usb/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index b47285f..de21967
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -59,7 +59,7 @@ static struct usb_phy *__usb_find_phy(struct list_head *list,
 
 static struct usb_phy *__of_usb_find_phy(struct device_node *node)
 {
-	struct usb_phy  *phy;
+	struct usb_phy  *phy = NULL;
 
 	if (!of_device_is_available(node))
 		return ERR_PTR(-ENODEV);
-- 
2.7.4

