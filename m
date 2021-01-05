Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4E2EAA55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbhAEMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:03:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:38680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbhAEMDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:03:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4815AD7A;
        Tue,  5 Jan 2021 12:02:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/12] tty: pty, remove BUG_ON from pty_close
Date:   Tue,  5 Jan 2021 13:02:32 +0100
Message-Id: <20210105120239.28031-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty->ops->close is always called with a valid tty, so the BUG_ON cannot
trigger.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/pty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index a59f1e062bc6..5e2374580e27 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -45,7 +45,6 @@ static DEFINE_MUTEX(devpts_mutex);
 
 static void pty_close(struct tty_struct *tty, struct file *filp)
 {
-	BUG_ON(!tty);
 	if (tty->driver->subtype == PTY_TYPE_MASTER)
 		WARN_ON(tty->count > 1);
 	else {
-- 
2.30.0

