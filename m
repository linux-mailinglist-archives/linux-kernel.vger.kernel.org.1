Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F829C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827427AbgJ0SX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:23:58 -0400
Received: from leibniz.telenet-ops.be ([195.130.137.77]:44300 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1827299AbgJ0SWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:22:52 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4CLKnN5gJszMqh3d
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 19:22:48 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id l6Nn2300G4C55Sk016NnPV; Tue, 27 Oct 2020 19:22:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXTcN-000eE4-HB; Tue, 27 Oct 2020 19:22:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXTcM-002jbP-SL; Tue, 27 Oct 2020 19:22:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/process_vm_access: Add missing #include <linux/compat.h>
Date:   Tue, 27 Oct 2020 19:22:46 +0100
Message-Id: <20201027182246.651908-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With e.g. m68k/defconfig:

    mm/process_vm_access.c: In function ‘process_vm_rw’:
    mm/process_vm_access.c:277:5: error: implicit declaration of function ‘in_compat_syscall’ [-Werror=implicit-function-declaration]
      277 |     in_compat_syscall());
	  |     ^~~~~~~~~~~~~~~~~

Fix this by adding #include <linux/compat.h>.

Reported-by: noreply@ellerman.id.au
Fixes: 38dc5079da7081e8 ("Fix compat regression in process_vm_rw()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 mm/process_vm_access.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 05676722d9cd6afb..702250f148e73adc 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2010-2011 Christopher Yeoh <cyeoh@au1.ibm.com>, IBM Corp.
  */
 
+#include <linux/compat.h>
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/sched.h>
-- 
2.25.1

