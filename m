Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1332EF10E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbhAHLFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:05:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAHLFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:05:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BC64AD24;
        Fri,  8 Jan 2021 11:04:42 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] MAINTAINERS: add myself as slab allocators maintainer
Date:   Fri,  8 Jan 2021 12:03:53 +0100
Message-Id: <20210108110353.19971-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to help with slab allocators maintenance, from the perspective of
being responsible for SLAB and more recently also SLUB in an enterprise distro
kernel and supporting its users. Recently I've been focusing on improving
SLUB's debugging features, and patch review in the area, including the kmemcg
accounting rewrite last year.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Hi,

this might look perhaps odd with 4 people (plus Andrew) already listed, but on
closer look we have 2 (or 3 if you count SLOB) allocators and the focus of each
maintainer varies. Maybe this would be also an opportunity to split the area
explicitly, if the maintainers would want that? I'm fine with all of them
personally - while we moved to SLUB in new code streams, olders ones with SLAB
will continue be supported for years anyway.

Thanks,
Vlastimil

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da4892dc52b4..fd657bb4157f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16351,6 +16351,7 @@ M:	Pekka Enberg <penberg@kernel.org>
 M:	David Rientjes <rientjes@google.com>
 M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Vlastimil Babka <vbabka@suse.cz>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/sl?b*.h
-- 
2.29.2

