Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC91E02C9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgEXUrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 16:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387641AbgEXUrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 16:47:45 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBBF207D8;
        Sun, 24 May 2020 20:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590353265;
        bh=xLbpEBx32jt52xI02x7qdIy2/1JxdlVYwsOdprthQvI=;
        h=Date:From:To:Cc:Subject:From;
        b=TlVUgbBH3fjMERPV1x8Az3T+yIyauWbLBPBP4gK4P2+KdtK2P1E5WdRRsIHnl6UFA
         UZKvQFp5AwcODwrUMJskHsrZlx7TSNDaB6GQ3FcKFCXlSfsCHLWklyUNCL49RU//dL
         Smtjsnr7EeeJtVqHJEqRGrUiJIS3jCBgBXkKvw34=
Date:   Sun, 24 May 2020 15:52:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] audit: Use struct_size() helper in alloc_chunk
Message-ID: <20200524205238.GA17576@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct audit_chunk {
	...
        struct node {
                struct list_head list;
                struct audit_tree *owner;
                unsigned index;         /* index; upper bit indicates 'will prune' */
        } owners[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

offsetof(struct audit_chunk, owners) + count * sizeof(struct node);

with:

struct_size(chunk, owners, count)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/audit_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e49c912f862d0..1b7a2f0417936 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -188,11 +188,9 @@ static struct fsnotify_mark *alloc_mark(void)
 static struct audit_chunk *alloc_chunk(int count)
 {
 	struct audit_chunk *chunk;
-	size_t size;
 	int i;
 
-	size = offsetof(struct audit_chunk, owners) + count * sizeof(struct node);
-	chunk = kzalloc(size, GFP_KERNEL);
+	chunk = kzalloc(struct_size(chunk, owners, count), GFP_KERNEL);
 	if (!chunk)
 		return NULL;
 
-- 
2.26.2

