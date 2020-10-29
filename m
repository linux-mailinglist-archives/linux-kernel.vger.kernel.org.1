Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0548B29EA98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgJ2Lc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:32:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbgJ2Lc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8958CB21F;
        Thu, 29 Oct 2020 11:32:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/17] vt: keyboard, use DECLARE_BITMAP for key_down
Date:   Thu, 29 Oct 2020 12:32:13 +0100
Message-Id: <20201029113222.32640-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key_down is sued as a bitmap using test_bit, set_bit and similar.
So declare it using DECLARE_BITMAP to make it obvious even from the
declaration.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 823df9bb52b1..c4791f33c145 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -135,7 +135,7 @@ static struct input_handler kbd_handler;
 static DEFINE_SPINLOCK(kbd_event_lock);
 static DEFINE_SPINLOCK(led_lock);
 static DEFINE_SPINLOCK(func_buf_lock); /* guard 'func_buf'  and friends */
-static unsigned long key_down[BITS_TO_LONGS(KEY_CNT)];	/* keyboard key bitmap */
+static DECLARE_BITMAP(key_down, KEY_CNT);	/* keyboard key bitmap */
 static unsigned char shift_down[NR_SHIFT];		/* shift state counters.. */
 static bool dead_key_next;
 
-- 
2.29.1

