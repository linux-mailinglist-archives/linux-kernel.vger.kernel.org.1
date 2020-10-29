Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE129EA99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgJ2Lcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:32:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:57148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgJ2Lc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C46B3AC1D;
        Thu, 29 Oct 2020 11:32:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/17] vt: keyboard, use bool for rep
Date:   Thu, 29 Oct 2020 12:32:14 +0100
Message-Id: <20201029113222.32640-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rep is used as a bool in the code, so declare it as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c4791f33c145..e47a1c6bfa44 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -144,7 +144,7 @@ static bool npadch_active;
 static unsigned int npadch_value;
 
 static unsigned int diacr;
-static char rep;					/* flag telling character repeat */
+static bool rep;			/* flag telling character repeat */
 
 static int shift_state = 0;
 
-- 
2.29.1

