Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E462349F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgGaRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 13:13:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39314 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgGaRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:13:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k1YbH-0006cL-66; Fri, 31 Jul 2020 17:13:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, Aurelien Aptel <aaptel@suse.com>,
        Paulo Alcantara <pc@cjr.nz>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cifs: fix double free error on share and prefix
Date:   Fri, 31 Jul 2020 18:13:42 +0100
Message-Id: <20200731171342.36636-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if the call dfs_cache_get_tgt_share fails we cannot
fully guarantee that share and prefix are set to NULL and the
next iteration of the loop can end up potentially double freeing
these pointers. Since the semantics of dfs_cache_get_tgt_share
are ambiguous for failure cases with the setting of share and
prefix (currently now and the possibly the future), it seems
prudent to set the pointers to NULL when the objects are
free'd to avoid any double frees.

Addresses-Coverity: ("Double free")
Fixes: 96296c946a2a ("cifs: handle RESP_GET_DFS_REFERRAL.PathConsumed in reconnect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 3c4dd4e1b9eb..4b2f5f5b3a8e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5574,6 +5574,8 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 		kfree(share);
 		kfree(prefix);
+		share = NULL;
+		prefix = NULL;
 
 		rc = dfs_cache_get_tgt_share(tcon->dfs_path + 1, it, &share, &prefix);
 		if (rc) {
-- 
2.27.0

