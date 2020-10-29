Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27BF29EA95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgJ2LcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:32:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgJ2LcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1BA6ABF4;
        Thu, 29 Oct 2020 11:32:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/17] vt: keyboard, remove ctrl_alt_del declaration
Date:   Thu, 29 Oct 2020 12:32:06 +0100
Message-Id: <20201029113222.32640-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl_alt_del is already declared in linux/reboot.h which we include. So
remove this second (superfluous) declaration.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 78acc270e39a..69bbb6c1b3de 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -49,8 +49,6 @@
 
 #include <asm/irq_regs.h>
 
-extern void ctrl_alt_del(void);
-
 /*
  * Exported functions/variables
  */
-- 
2.29.1

