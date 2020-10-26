Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1F299912
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbgJZVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390552AbgJZVuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:50:12 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D4F207E8;
        Mon, 26 Oct 2020 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749012;
        bh=a5p2zcjEZXDEMV9zHQ1iLUdn3M8KFB1aTdOYacbsc94=;
        h=From:To:Cc:Subject:Date:From;
        b=OJqxDI/F+wMsc8XunJ8uKh3IL2wCmFn6iPJ4hwAMLxSXfP2PEcEWgBLiHMLNaqq9E
         jBBxgS/XFbBWIh8mxcMVpvmuaPE/0QzD4M3rCdxzyE9WyH6ChILIv2iE25hYdQdyMw
         9Jk73mD+TwqF1TxVB0iTj8hL/rXKU7scA8Uy9ro8=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
Date:   Mon, 26 Oct 2020 22:49:59 +0100
Message-Id: <20201026215004.3893088-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On most architectures, gcc -Wextra warns about the list of error
numbers containing both EDEADLK and EDEADLOCK:

lib/errname.c:15:67: warning: initialized field overwritten [-Woverride-init]
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
      |                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro 'E'
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^
lib/errname.c:15:67: note: (near initialization for 'names_0[35]')
   15 | #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
      |                                                                   ^~~
lib/errname.c:172:2: note: in expansion of macro 'E'
  172 |  E(EDEADLK), /* EDEADLOCK */
      |  ^

Make that line conditional on the two values being distinct.

Fixes: 57f5677e535b ("printf: add support for printing symbolic error names")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/errname.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/errname.c b/lib/errname.c
index 0c4d3e66170e..6adff0bf2445 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -169,7 +169,9 @@ static const char *names_0[] = {
 	E(ECANCELED), /* ECANCELLED */
 	E(EAGAIN), /* EWOULDBLOCK */
 	E(ECONNREFUSED), /* EREFUSED */
+#if EDEADLK != EDEADLOCK
 	E(EDEADLK), /* EDEADLOCK */
+#endif
 };
 #undef E
 
-- 
2.27.0

