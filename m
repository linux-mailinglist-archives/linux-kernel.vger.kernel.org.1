Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F074621B27E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGJJov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgGJJov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:44:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24BD5AC7A;
        Fri, 10 Jul 2020 09:44:50 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
Date:   Fri, 10 Jul 2020 11:44:32 +0200
Message-Id: <20200710094432.19655-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness has started major rework of the printk code. Add him
as reviewer so that he is aware of all other coming changes and
could influence their integration.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..8e82d9db2a21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13770,6 +13770,7 @@ PRINTK
 M:	Petr Mladek <pmladek@suse.com>
 M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
+R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
 F:	include/linux/printk.h
 F:	kernel/printk/
-- 
2.26.2

