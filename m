Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E351DD652
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgEUSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 14:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgEUSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:52:18 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1258720823;
        Thu, 21 May 2020 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590087138;
        bh=22eFmN3PxHoXvV1xmhf23Ujh/olYK+FBaQOc/JWyKF4=;
        h=Date:From:To:Cc:Subject:From;
        b=cyli121Xo8MCtetN7HlPeb5FuYJUdX9EgmVlj63DR/O2C7orp8cXW6DLqRFjve53v
         W+W2DB0x35sVsAD9+RkWhZItZKXVP56Pl03+NsfVPRAUiH6yxNMoxJCO8RzHG6SO5u
         4zKoz/fekoxxLqds3tkaBugo+C9/smGpWiVN5+1U=
Date:   Thu, 21 May 2020 13:57:07 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] m68k: tools: Replace zero-length array with flexible-array
 member
Message-ID: <20200521185707.GA3661@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/m68k/tools/amiga/dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/tools/amiga/dmesg.c b/arch/m68k/tools/amiga/dmesg.c
index 7340f5b6cf6d..f8005a7efb0b 100644
--- a/arch/m68k/tools/amiga/dmesg.c
+++ b/arch/m68k/tools/amiga/dmesg.c
@@ -34,7 +34,7 @@ struct savekmsg {
     u_long magic2;	/* SAVEKMSG_MAGIC2 */
     u_long magicptr;	/* address of magic1 */
     u_long size;
-    char data[0];
+    char data[];
 };
 
 
-- 
2.26.2

