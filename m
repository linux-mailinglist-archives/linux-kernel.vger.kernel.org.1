Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283992E9241
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhADI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbhADI6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:58:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EF3E207AE;
        Mon,  4 Jan 2021 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609750690;
        bh=V8PHXZ6MO5UWZbjzEqwye25+ofsH5oNZHJoowbG+BoI=;
        h=From:To:Cc:Subject:Date:From;
        b=rOnolACyk9lJQFhMEpY4NKKtR6xjjHhUxNalQGHRvqs59GyHqgg2OVRH3J4dqwIwq
         5CfreMl8R3msAycB+miXtInUXlLNjHbHKP6n4A27kAFuAgy6qcRWT7wV/LhdxcOu+D
         WpOOPXjPi42bvQZTrp2ehdmttO1J7+DANe2kbg7xo6OFhvjHbrbw7GsykB6hpKPQ8z
         69uAT+t6QETj3Oei9vpsZU9INPZugS7ijTC7BRhrquGFRzrUq8pU02Zw/r8nYHO8hw
         LMxiLfvYz7Mc4bgYKkh1DZgrN4ZgjWgNZilJP6A7IQy7Y0VEGIKutRa33ugafB3AwW
         PdSkqp0B+mhrw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix xchg() warning
Date:   Mon,  4 Jan 2021 09:58:02 +0100
Message-Id: <20210104085806.4176886-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The definition if xchg() causes a harmless warning in some files, like:

In file included from ../arch/ia64/include/uapi/asm/intrinsics.h:22,
                 from ../arch/ia64/include/asm/intrinsics.h:11,
                 from ../arch/ia64/include/asm/bitops.h:19,
                 from ../include/linux/bitops.h:32,
                 from ../include/linux/kernel.h:11,
                 from ../fs/nfs/read.c:12:
../fs/nfs/read.c: In function 'nfs_read_completion':
../arch/ia64/include/uapi/asm/cmpxchg.h:57:2: warning: value computed is not used [-Wunused-value]
   57 | ((__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr))))
      | ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/nfs/read.c:196:5: note: in expansion of macro 'xchg'
  196 |     xchg(&nfs_req_openctx(req)->error, error);
      |     ^~~~

Change it to a compound expression like the other architectures have
to get a clean defconfig build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/uapi/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index d69c979936d4..5d90307fd6e0 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -54,7 +54,7 @@ extern void ia64_xchg_called_with_bad_pointer(void);
 })
 
 #define xchg(ptr, x)							\
-((__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr))))
+({(__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
 
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
-- 
2.29.2

