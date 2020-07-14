Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDC21EE69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgGNK4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 06:56:13 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:19378 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNK4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:56:12 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 4E764778292AA454EF6B;
        Tue, 14 Jul 2020 18:56:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 06EAu4vZ053028;
        Tue, 14 Jul 2020 18:56:04 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020071418561828-4282339 ;
          Tue, 14 Jul 2020 18:56:18 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] cifs: Remove the superfluous break
Date:   Tue, 14 Jul 2020 18:59:12 +0800
Message-Id: <1594724352-11451-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-14 18:56:18,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-14 18:56:07,
        Serialize complete at 2020-07-14 18:56:07
X-MAIL: mse-fl1.zte.com.cn 06EAu4vZ053028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove the superfuous break, as there is a 'return' before it.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 fs/cifs/sess.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 5d05bd2..6708ab0 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -1705,7 +1705,6 @@ static int select_sec(struct cifs_ses *ses, struct sess_data *sess_data)
 #else
 		cifs_dbg(VFS, "Kerberos negotiated but upcall support disabled!\n");
 		return -ENOSYS;
-		break;
 #endif /* CONFIG_CIFS_UPCALL */
 	case RawNTLMSSP:
 		sess_data->func = sess_auth_rawntlmssp_negotiate;
-- 
2.9.5

