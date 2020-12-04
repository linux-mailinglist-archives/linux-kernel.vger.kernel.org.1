Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F35D2CE6A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgLDDld convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 22:41:33 -0500
Received: from smtp.h3c.com ([60.191.123.50]:4813 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgLDDld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:41:33 -0500
X-Greylist: delayed 5785 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 22:41:33 EST
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 0B4257Jt062503
        for <linux-kernel@vger.kernel.org>; Fri, 4 Dec 2020 10:05:07 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam02-ex.h3c.com with ESMTP id 0B423iBQ059703;
        Fri, 4 Dec 2020 10:03:44 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 10:03:45 +0800
From:   "Yan.Gao" <gao.yanB@h3c.com>
To:     <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yan.Gao" <gao.yanB@h3c.com>
Subject: [PATCH] TTY: Fix whitespace inconsistencies in vt_io_ioctl
Date:   Fri, 4 Dec 2020 09:52:01 +0800
Message-ID: <20201204015201.9122-1-gao.yanB@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0B423iBQ059703
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
+               if (!perm)
                        return -EPERM;
                return con_set_cmap(up);

        case GIO_CMAP:
-                return con_get_cmap(up);
+               return con_get_cmap(up);

        case PIO_FONTX:
                if (!perm)
--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
邮件！
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
