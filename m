Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472D61BABE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgD0SEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 14:04:31 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:17580 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgD0SEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:31 -0400
Received: from localhost.localdomain ([93.22.148.32])
        by mwinf5d88 with ME
        id Xu4R2200P0iASfR03u4S9E; Mon, 27 Apr 2020 20:04:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 27 Apr 2020 20:04:29 +0200
X-ME-IP: 93.22.148.32
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        colin.king@canonical.com, stern@rowland.harvard.edu, arnd@arndb.de,
        andrzej.p@samsung.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: gadget: net2272: Fix a memory leak in an error handling path in 'net2272_plat_probe()'
Date:   Mon, 27 Apr 2020 20:04:23 +0200
Message-Id: <20200427180423.88514-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dev' is allocated in 'net2272_probe_init()'. It must be freed in the error
handling path, as already done in the remove function (i.e.
'net2272_plat_remove()')

Fixes: 90fccb529d24 ("usb: gadget: Gadget directory cleanup - group UDC drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/gadget/udc/net2272.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index a8273b589456..5af0fe9c61d7 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2647,6 +2647,8 @@ net2272_plat_probe(struct platform_device *pdev)
  err_req:
 	release_mem_region(base, len);
  err:
+	kfree(dev);
+
 	return ret;
 }
 
-- 
2.25.1

