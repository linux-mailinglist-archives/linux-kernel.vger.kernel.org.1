Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09E248116
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHRI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:57:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbgHRI5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BDAB5B04C;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/16] vc_screen: prune macros
Date:   Tue, 18 Aug 2020 10:57:06 +0200
Message-Id: <20200818085706.12163-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not undefine random words. I guess this was here as there were macros
with such generic names somewhere. I very doubt they still exist. So
drop these.

And remove a spare blank line.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 9d68c6b36ddf..3e3a6a9a7f44 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -50,11 +50,7 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
-#undef attr
-#undef org
-#undef addr
 #define HEADER_SIZE	4u
-
 #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
 
 /*
-- 
2.28.0

