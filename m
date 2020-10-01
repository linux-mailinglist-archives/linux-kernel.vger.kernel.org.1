Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0116428026E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgJAPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732516AbgJAPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:19:23 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A078207F7;
        Thu,  1 Oct 2020 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565562;
        bh=8VKZGEFHrKs7cF0eqpZCnnNWBUjSkjDN23cuZvEmuO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gexSBMbvvhnkTqrEfdKdtHNaOoRqAy0b38hOAPnMpLt4p0iFwqOYaXy9FGu534KsL
         xt/PlLW+UNuQOebGd678VBr7hIYF/uIcjPjUc15OY+Nrnht88gmAbK+XHr3rBz1pRz
         LKAuRnulRE7BXc80OpUDI0GCEYOERpf39xQdbl2c=
Date:   Thu, 1 Oct 2020 10:25:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/3][next] lib/stackdepot.c: Replace one-element array with
 flexible-array member
Message-ID: <2f1e6a17aaa891ad9c58817cf0a10b8ab8894f59.1601565471.git.gustavoars@kernel.org>
References: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1601565471.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in
struct stack_record, instead of a one-element array, and use the
struct_size() helper to calculate the size for the allocation.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays

Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f75876b.x9zdN10esiC0qLHV%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/stackdepot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2caffc64e4c8..c6106cfb7950 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -62,7 +62,7 @@ struct stack_record {
 	u32 hash;			/* Hash in the hastable */
 	u32 size;			/* Number of frames in the stack */
 	union handle_parts handle;
-	unsigned long entries[1];	/* Variable-sized array of entries. */
+	unsigned long entries[];	/* Variable-sized array of entries. */
 };
 
 static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
@@ -104,9 +104,8 @@ static bool init_stack_slab(void **prealloc)
 static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 		u32 hash, void **prealloc, gfp_t alloc_flags)
 {
-	int required_size = offsetof(struct stack_record, entries) +
-		sizeof(unsigned long) * size;
 	struct stack_record *stack;
+	size_t required_size = struct_size(stack, entries, size);
 
 	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
 
-- 
2.27.0

