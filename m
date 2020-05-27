Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3EA1E413F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbgE0MGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 08:06:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57978 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0MGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:06:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jdup3-0003ka-CY; Wed, 27 May 2020 12:06:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: remove redundant assignment to variable ret
Date:   Wed, 27 May 2020 13:06:13 +0100
Message-Id: <20200527120613.172967-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read. The
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d1e1caa23c8b..5608665ccb71 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -579,7 +579,6 @@ static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
 		return ret;
 	}
 
-	ret = -ENOENT;
 	if (!cookie.found) {
 		_leave(" = -ENOENT [not found]");
 		return -ENOENT;
-- 
2.25.1

