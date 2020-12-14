Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F252D990B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgLNNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:39:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9444 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgLNNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:38:44 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CvjB51W43zhsnb;
        Mon, 14 Dec 2020 21:37:33 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:37:53 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty/hvc/hvsi_lib: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:38:24 +0800
Message-ID: <20201214133824.3999-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/hvc/hvsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvsi_lib.c b/drivers/tty/hvc/hvsi_lib.c
index 09289c8154ae..8c4ad495f819 100644
--- a/drivers/tty/hvc/hvsi_lib.c
+++ b/drivers/tty/hvc/hvsi_lib.c
@@ -301,7 +301,7 @@ int hvsilib_write_mctrl(struct hvsi_priv *pv, int dtr)
 	pr_devel("HVSI@%x: %s DTR...\n", pv->termno,
 		 dtr ? "Setting" : "Clearing");
 
-	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER,
+	ctrl.hdr.type = VS_CONTROL_PACKET_HEADER;
 	ctrl.hdr.len = sizeof(struct hvsi_control);
 	ctrl.verb = cpu_to_be16(VSV_SET_MODEM_CTL);
 	ctrl.mask = cpu_to_be32(HVSI_TSDTR);
-- 
2.22.0

