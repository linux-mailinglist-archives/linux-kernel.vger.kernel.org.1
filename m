Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22342F5CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbhANJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:12:33 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47830 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727274AbhANJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:12:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ULhWEzz_1610615501;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULhWEzz_1610615501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Jan 2021 17:11:45 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] fs/cifs: Simplify bool comparisoni.
Date:   Thu, 14 Jan 2021 17:11:40 +0800
Message-Id: <1610615500-72377-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the follow coccicheck warnings:

./fs/cifs/connect.c: WARNING: Comparison of 0/1 to bool variable

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 fs/cifs/connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index b9df855..b7869a2 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2628,7 +2628,7 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 	} else if (ctx)
 		tcon->unix_ext = 1; /* Unix Extensions supported */
 
-	if (tcon->unix_ext == 0) {
+	if (!tcon->unix_ext) {
 		cifs_dbg(FYI, "Unix extensions disabled so not set on reconnect\n");
 		return;
 	}
@@ -3740,7 +3740,7 @@ static void delayed_free(struct rcu_head *p)
 
 	if (!ses->binding) {
 		ses->capabilities = server->capabilities;
-		if (linuxExtEnabled == 0)
+		if (!linuxExtEnabled)
 			ses->capabilities &= (~server->vals->cap_unix);
 
 		if (ses->auth_key.response) {
-- 
1.8.3.1

