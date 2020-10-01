Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD7280276
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgJAPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732342AbgJAPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:20:48 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE99920719;
        Thu,  1 Oct 2020 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601565648;
        bh=5lCCl6B4yzT47k+6ezJr9MTecTe66dy96PwbRGt9TDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uATW9fSgcGDWgcPzaIjrfr4fYKSjgyoTsBYR8+MpIXaxld/jTb4crFDp6ufhmzVkx
         rnm8T/SXKmEfZFwr3kJCooeVLtUh9xYa955GxyHE2EYzPe6yINfnJ6BI7SffGnsjHG
         bhKfXHQvGuKbcp9ieuMzkQacFBdiCzKdbxGzNpX4=
Date:   Thu, 1 Oct 2020 10:26:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/3][next] lib/stackdepot.c: Use array_size() helper in
 jhash2()
Message-ID: <cb8a682e4bba4dbddd2bd8aca7f8c02fea89639b.1601565471.git.gustavoars@kernel.org>
References: <cover.1601565471.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1601565471.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size() helper instead of the open-coded version in jhash2().
These sorts of multiplication factors need to be wrapped in array_size().

Also, use the preferred form for passing the size of an object type.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/stackdepot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 683b6a8ddade..890dcc2e984e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -154,8 +154,8 @@ static struct stack_record *stack_table[STACK_HASH_SIZE] = {
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
 	return jhash2((u32 *)entries,
-			       size * sizeof(unsigned long) / sizeof(u32),
-			       STACK_HASH_SEED);
+		      array_size(size,  sizeof(*entries)) / sizeof(u32),
+		      STACK_HASH_SEED);
 }
 
 /* Use our own, non-instrumented version of memcmp().
-- 
2.27.0

