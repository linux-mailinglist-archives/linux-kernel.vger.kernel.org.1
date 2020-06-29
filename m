Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDD20D4DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgF2TME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:12:04 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46628 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbgF2TMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:02 -0400
X-Greylist: delayed 1030 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 15:12:01 EDT
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D75E93AB679
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:00:33 +0000 (UTC)
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 53A10FF80E;
        Mon, 29 Jun 2020 14:00:09 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] kdb: prevent possible null deref in kdb_msg_write
Date:   Mon, 29 Jun 2020 16:59:24 +0300
Message-Id: <20200629135923.14912-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`kdb_msg_write` operates on a global `struct kgdb_io *` called
`dbg_io_ops`.

Although it is initialized in `debug_core.c`, there's a null check in
`kdb_msg_write` which implies that it can be null whenever we dereference
it in this function call.

Coverity scanner caught this as CID 1465042.

I have modified the function to bail out if `dbg_io_ops` is not properly
initialized.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 kernel/debug/kdb/kdb_io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 683a799618ad..85e579812458 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -549,14 +549,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	if (msg_len == 0)
 		return;
 
-	if (dbg_io_ops) {
-		const char *cp = msg;
-		int len = msg_len;
+	if (!dbg_io_ops)
+		return;
 
-		while (len--) {
-			dbg_io_ops->write_char(*cp);
-			cp++;
-		}
+	const char *cp = msg;
+	int len = msg_len;
+
+	while (len--) {
+		dbg_io_ops->write_char(*cp);
+		cp++;
 	}
 
 	for_each_console(c) {
-- 
2.27.0

