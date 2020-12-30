Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3932E7A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgL3Plu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:41:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgL3Plt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:41:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E702F22227;
        Wed, 30 Dec 2020 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609342869;
        bh=HfZJWC4DgWzxO94oQompi4plJLMZTWGfjqgfqgqfi5U=;
        h=From:To:Cc:Subject:Date:From;
        b=DAO3IEqESCs//Kgrgsgvvma3G1GUlcdqVotmH2gNP9/fmWgdVjTYIvo9wOrKG2Vv7
         r9zr8/4eGzSaAct25yKZ+fvScsiV5OftBVn6GG7ZjcPu1+jWj8yLdkCnctRwbRTis1
         mehMwK6IU2o5KQL/Q0Q80RIce7hefzbhlYirdFA9yziisGTP6nV0LtPnP7uniqNbLL
         ytonIXr2P+j5DnoW5xJE2Nuf24cshMLKoUnlmLTbyeppkIq2Q3If9oNKBk9B7qTCB2
         EMUAgPxOpmXQsjeiQ9oquQxfdJXNtzeCa5D5KNXzudr84xtm5Cfy8ISQ6C2dnWRQxK
         RSnO08W3oF9lA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Brian Geffon <bgeffon@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] mm/mremap: fix BUILD_BUG_ON() error in get_extent
Date:   Wed, 30 Dec 2020 16:40:40 +0100
Message-Id: <20201230154104.522605-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang cannt evaluate this function argument at compile time
when the function is not inlined, which leads to a link
time failure:

ld.lld: error: undefined symbol: __compiletime_assert_414
>>> referenced by mremap.c
>>>               mremap.o:(get_extent) in archive mm/built-in.a

Mark the function as __always_inline to avoid it.

Fixes: 9ad9718bfa41 ("mm/mremap: calculate extent in one place")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c5590afe7165..1cb464a07184 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -336,8 +336,9 @@ enum pgt_entry {
  * valid. Else returns a smaller extent bounded by the end of the source and
  * destination pgt_entry.
  */
-static unsigned long get_extent(enum pgt_entry entry, unsigned long old_addr,
-			unsigned long old_end, unsigned long new_addr)
+static __always_inline unsigned long get_extent(enum pgt_entry entry,
+			unsigned long old_addr, unsigned long old_end,
+			unsigned long new_addr)
 {
 	unsigned long next, extent, mask, size;
 
-- 
2.29.2

