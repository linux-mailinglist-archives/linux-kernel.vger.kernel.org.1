Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73E8280271
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbgJAPT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732410AbgJAPT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:19:56 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F0F207F7;
        Thu,  1 Oct 2020 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565596;
        bh=ZoWJIt7tW81VESqtsxKPRRDnGuYfZzDylCo+K+tvRks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzqzfHEhgWUe0fqq82zQG/SZhoH0zH3JdKuhdJ5FFO6oyna4DB2rBg/AlsK322Zyc
         4yN/7A3EhimttE1706T95hQX7/PosYbSnWDLilAyaBPaGzsmmvAJ73sTt/D+NG8aYH
         wujJNPsFEZ+XS0O4Cccjha9xj+f/ed9zRSEPVt8M=
Date:   Thu, 1 Oct 2020 10:25:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/3][next] lib/stackdepot.c: Use flex_array_size() helper in
 memcpy()
Message-ID: <186e37fe07196ee41a0e562fa8a8cb7a01112ec5.1601565471.git.gustavoars@kernel.org>
References: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601565471.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer
overflows, while at the same time makes it explicitly clear that
we are dealing with a flexible array member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c6106cfb7950..683b6a8ddade 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -135,7 +135,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
-	memcpy(stack->entries, entries, size * sizeof(unsigned long));
+	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	depot_offset += required_size;
 
 	return stack;
-- 
2.27.0

