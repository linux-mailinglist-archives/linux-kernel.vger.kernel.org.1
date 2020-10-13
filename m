Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4328CD39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgJML5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbgJMLyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:47 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4429C224D1;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=E+HUF3B3F2T5EVRU+RRyU63RjuPp+MoSXQWg3UueGeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W11d4hnwzShn/6gD5fRyBS110rJHitGDGIkVYy6RRCZOjVdehCzm7TuJkpH4DhqtA
         GeG5zWZLdxewjZj4eF1zaAM1Y6eeBjRvDyZ6lZC4UZKsp2NiSieST20hk1ivk3QKhA
         jhc9WKbXX631Pv3aLBtzE/kTmNmILKLrfJeMZwo4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CVn-8x; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v6 55/80] memblock: get rid of a :c:type leftover
Date:   Tue, 13 Oct 2020 13:54:10 +0200
Message-Id: <4d161da11361ce386e7885873f6f4e014f0f2c99.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chanseset b3a7bb1851c8 ("docs: get rid of :c:type explicit declarations for structs")
removed several :c:type: markups, except by one.

Now, Sphinx 3.x complains about it:

	.../Documentation/core-api/boot-time-mm:26: ../mm/memblock.c:51: WARNING: Unparseable C cross-reference: 'struct\nmemblock_type'
	Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
	  struct
	memblock_type
	  ------^

As, on Sphinx 3.x, the right markup is c:struct:`foo`.

So, let's remove it, relying on automarkup.py to convert it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 mm/memblock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 670216826940..a06e68b1e5a0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -50,8 +50,8 @@
  *
  * Each region is represented by struct memblock_region that
  * defines the region extents, its attributes and NUMA node id on NUMA
- * systems. Every memory type is described by the :c:type:`struct
- * memblock_type` which contains an array of memory regions along with
+ * systems. Every memory type is described by the struct memblock_type
+ * which contains an array of memory regions along with
  * the allocator metadata. The "memory" and "reserved" types are nicely
  * wrapped with struct memblock. This structure is statically
  * initialized at build time. The region arrays are initially sized to
-- 
2.26.2

