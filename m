Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFB294D42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442892AbgJUNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:11:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52413 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442845AbgJUNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:11:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kVDtt-00089p-Hz; Wed, 21 Oct 2020 13:11:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] afs: fix a dereference on pointer cell before cell is null checked
Date:   Wed, 21 Oct 2020 14:11:33 +0100
Message-Id: <20201021131133.128016-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the assignment of debug_id dereferences pointer cell before
cell has been null checked.  Fix this by removing debug_id and use
cell->debug_id after cell has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: dca54a7bbb8c ("afs: Add tracing for cell refcount and active user count")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/cell.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 52233fa6195f..4449ff100a3c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -589,7 +589,6 @@ struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  */
 void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_trace reason)
 {
-	unsigned int debug_id = cell->debug_id;
 	time64_t now, expire_delay;
 	int u, a;
 
@@ -606,7 +605,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 
 	u = atomic_read(&cell->ref);
 	a = atomic_dec_return(&cell->active);
-	trace_afs_cell(debug_id, u, a, reason);
+	trace_afs_cell(cell->debug_id, u, a, reason);
 	WARN_ON(a == 0);
 	if (a == 1)
 		/* 'cell' may now be garbage collected. */
-- 
2.27.0

