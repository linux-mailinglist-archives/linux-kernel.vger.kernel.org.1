Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FDC1E9477
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 01:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgE3XUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 19:20:42 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51244 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbgE3XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:35 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 8E2D627FEF; Sat, 30 May 2020 19:20:34 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <6991996dd4aaf0b52cfd650172bf0f6fbe37a452.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 7/8] macintosh/adb-iop: Implement sending -> idle state
 transition
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On leaving the 'sending' state, proceed to the 'idle' state if no reply is
expected. Drop redundant test for adb_iop_state == sending && current_req.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index f22792c95d4f..8594e4f9a830 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -77,15 +77,14 @@ static void adb_iop_done(void)
 
 static void adb_iop_complete(struct iop_msg *msg)
 {
-	struct adb_request *req;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	req = current_req;
-	if ((adb_iop_state == sending) && req && req->reply_expected) {
+	if (current_req->reply_expected)
 		adb_iop_state = awaiting_reply;
-	}
+	else
+		adb_iop_done();
 
 	local_irq_restore(flags);
 }
-- 
2.26.2

