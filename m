Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6329EAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgJ2LdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgJ2Lc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B59E1B823;
        Thu, 29 Oct 2020 11:32:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/17] vt: keyboard, use tty_insert_flip_string in puts_queue
Date:   Thu, 29 Oct 2020 12:32:22 +0100
Message-Id: <20201029113222.32640-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'puts_queue' currently loops over characters and employs the full tty
buffer machinery for every character. Do the buffer allocation only once
and copy all the character at once. This is achieved using
tty_insert_flip_string instead of loop+tty_insert_flip_char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 149f1791d7ec..56b5e8f8fe88 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -324,12 +324,9 @@ static void put_queue(struct vc_data *vc, int ch)
 	tty_schedule_flip(&vc->port);
 }
 
-static void puts_queue(struct vc_data *vc, char *cp)
+static void puts_queue(struct vc_data *vc, const char *cp)
 {
-	while (*cp) {
-		tty_insert_flip_char(&vc->port, *cp, 0);
-		cp++;
-	}
+	tty_insert_flip_string(&vc->port, cp, strlen(cp));
 	tty_schedule_flip(&vc->port);
 }
 
-- 
2.29.1

