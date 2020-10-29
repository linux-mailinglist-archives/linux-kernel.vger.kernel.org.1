Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8689D29EAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgJ2LdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbgJ2Lc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C24D7B224;
        Thu, 29 Oct 2020 11:32:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/17] vt: keyboard, remove unneeded func_* declarations
Date:   Thu, 29 Oct 2020 12:32:18 +0100
Message-Id: <20201029113222.32640-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we removed the ugly handling of func_buf, remove unneeded
declarations of func_* variables. The definitions are in the generated
defkeymap.c_shipped, so we cannot really remove them (but we would love
to).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/kbd_kern.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index bb2246c8ec13..82f29aa35062 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -9,9 +9,6 @@
 extern struct tasklet_struct keyboard_tasklet;
 
 extern char *func_table[MAX_NR_FUNC];
-extern char func_buf[];
-extern char *funcbufptr;
-extern int funcbufsize, funcbufleft;
 
 /*
  * kbd->xxx contains the VC-local things (flag settings etc..)
-- 
2.29.1

