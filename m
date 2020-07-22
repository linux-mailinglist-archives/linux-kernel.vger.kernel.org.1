Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5936A229B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732840AbgGVPW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 11:22:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42005 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgGVPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:22:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jyGZc-00036l-Tn; Wed, 22 Jul 2020 15:22:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: remove redundant assignment to variable ret
Date:   Wed, 22 Jul 2020 16:22:24 +0100
Message-Id: <20200722152224.958437-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read because
the next statment returns from the function. The assignment is redundant
and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/server.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index e82e452e2612..429cd226e4da 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -701,7 +701,6 @@ bool afs_check_server_record(struct afs_operation *op, struct afs_server *server
 	retries++;
 	if (retries == 4) {
 		_leave(" = f [stale]");
-		ret = -ESTALE;
 		return false;
 	}
 	goto retry;
-- 
2.27.0

