Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA62D391F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 04:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgLIDJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 22:09:29 -0500
Received: from mail-m971.mail.163.com ([123.126.97.1]:33926 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgLIDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QFtydwgfyRi+IX9p2r
        TxhYZn0Y8ll8fBQpyozTWD1dA=; b=DXpVAXhZdZPgSiKujHkPWaniYwJXbVTWrx
        VLFYgL7+Sk/v3oU0M26Ni9W9CbdchOzcmMWaN0IUawLCMSTB7W/rK7cSUvYKBMvY
        ZYXONony2QvWVXXLj8U6b/GhZBHUMCoQFuE1wIOBsY3fABJOjDfURqKHF8fSfmcq
        9irMe8Kg4=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp1 (Coremail) with SMTP id GdxpCgBnrDZoP9Bff9VtAQ--.234S4;
        Wed, 09 Dec 2020 11:07:24 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tcpm: Fix possible buffer overflows in tcpm_queue_vdm
Date:   Wed,  9 Dec 2020 11:07:16 +0800
Message-Id: <20201209030716.3764-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgBnrDZoP9Bff9VtAQ--.234S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW5ZF45uF15tr4rtrW3trb_yoWftFb_uw
        1v93WFvrW8uFWxJrn8G3W3Zw1Ykw48WF1kWFn2qa1fArWjvwnFgr1vqr4xXryYgFnFqF93
        XryDAr1Ykw4xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUYFAJUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbipQz1MFUMbEFd7AAAsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

tcpm_queue_vdm() calls memcpy() without checking the destination
size may trigger a buffer overflower.

Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 55535c4f6..fcd331f33 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1045,7 +1045,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
 
 	port->vdo_count = cnt + 1;
 	port->vdo_data[0] = header;
-	memcpy(&port->vdo_data[1], data, sizeof(u32) * cnt);
+	memcpy(&port->vdo_data[1], data, min_t(int, sizeof(u32) * cnt, VDO_MAX_SIZE - 1));
 	/* Set ready, vdm state machine will actually send */
 	port->vdm_retries = 0;
 	port->vdm_state = VDM_STATE_READY;
-- 
2.17.1

