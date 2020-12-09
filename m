Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68172D3931
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 04:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgLIDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 22:18:22 -0500
Received: from smtp.h3c.com ([60.191.123.50]:7040 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgLIDSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 22:18:22 -0500
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam02-ex.h3c.com with ESMTP id 0B93GhJE097527;
        Wed, 9 Dec 2020 11:16:43 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 9 Dec 2020 11:16:44 +0800
From:   "Yan.Gao" <gao.yanB@h3c.com>
To:     <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yan.Gao" <gao.yanB@h3c.com>
Subject: [PATCH] tty: Fix whitespace inconsistencies in vt_io_ioctl
Date:   Wed, 9 Dec 2020 11:05:51 +0800
Message-ID: <20201209030551.48029-1-gao.yanB@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0B93GhJE097527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces spaces with tabs for indentation.

Signed-off-by: Yan.Gao <gao.yanB@h3c.com>
---
 drivers/tty/vt/vt_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 5f61b25a9..3813c40f1 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -596,12 +596,12 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 		return con_font_op(vc, &op);
 
 	case PIO_CMAP:
-                if (!perm)
+		if (!perm)
 			return -EPERM;
 		return con_set_cmap(up);
 
 	case GIO_CMAP:
-                return con_get_cmap(up);
+		return con_get_cmap(up);
 
 	case PIO_FONTX:
 		if (!perm)
-- 
2.17.1

