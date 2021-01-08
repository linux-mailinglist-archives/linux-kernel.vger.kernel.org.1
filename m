Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0A2EF0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbhAHKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbhAHKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:55:09 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55465C0612F6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:54:28 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id EAuS2400s4C55Sk06AuSM5; Fri, 08 Jan 2021 11:54:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxpPW-00201h-IV; Fri, 08 Jan 2021 11:54:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kxpPW-008Vgy-05; Fri, 08 Jan 2021 11:54:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] asm-generic: ffs: Drop bogus reference to ffz location
Date:   Fri,  8 Jan 2021 11:54:25 +0100
Message-Id: <20210108105425.2028405-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic definition of ffz() is not defined in the same header files
as the generic definitions of ffs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/asm-generic/bitops/builtin-ffs.h | 2 +-
 include/asm-generic/bitops/ffs.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bitops/builtin-ffs.h b/include/asm-generic/bitops/builtin-ffs.h
index 1dacfdb4247ee1b7..7b129329046b7337 100644
--- a/include/asm-generic/bitops/builtin-ffs.h
+++ b/include/asm-generic/bitops/builtin-ffs.h
@@ -8,7 +8,7 @@
  *
  * This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
+ * differs in spirit from ffz (man ffs).
  */
 #define ffs(x) __builtin_ffs(x)
 
diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index e81868b2c0f07b87..323fd5d6ae263ab3 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -8,7 +8,7 @@
  *
  * This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
+ * differs in spirit from ffz (man ffs).
  */
 static inline int ffs(int x)
 {
-- 
2.25.1

