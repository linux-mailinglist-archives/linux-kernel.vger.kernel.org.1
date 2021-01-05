Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8FC2EAA6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbhAEMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:04:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:39250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbhAEMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B1D7AE1C;
        Tue,  5 Jan 2021 12:02:42 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/12] tty: drop termiox user definitions
Date:   Tue,  5 Jan 2021 13:02:39 +0100
Message-Id: <20210105120239.28031-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As was concluded in a follow-up discussion of commit e0efb3168d34 (tty:
Remove dead termiox code) [1], termiox ioctls never worked, so there is
barely anyone using this interface. We can safely remove the user
definitions for this never adopted interface.

[1] https://lore.kernel.org/lkml/c1c9fc04-02eb-2260-195b-44c357f057c0@kernel.org/t/#u

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/uapi/linux/termios.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/uapi/linux/termios.h b/include/uapi/linux/termios.h
index 33961d4e4de0..e6da9d4433d1 100644
--- a/include/uapi/linux/termios.h
+++ b/include/uapi/linux/termios.h
@@ -5,19 +5,4 @@
 #include <linux/types.h>
 #include <asm/termios.h>
 
-#define NFF	5
-
-struct termiox
-{
-	__u16	x_hflag;
-	__u16	x_cflag;
-	__u16	x_rflag[NFF];
-	__u16	x_sflag;
-};
-
-#define	RTSXOFF		0x0001		/* RTS flow control on input */
-#define	CTSXON		0x0002		/* CTS flow control on output */
-#define	DTRXOFF		0x0004		/* DTR flow control on input */
-#define DSRXON		0x0008		/* DCD flow control on output */
-
 #endif
-- 
2.30.0

