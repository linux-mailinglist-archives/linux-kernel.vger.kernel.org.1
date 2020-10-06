Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA2284D42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgJFOHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1159E2177B;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=l4ZnRkqZgd8x5ZpSMUuNxg1b7AqKFMTZgq0sXQ4YesA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wP6bAD6xEOcw5oTTYqFoj6kuDr6q1/99hFiEUXQHbYTGTvUc+h3G9o+BHemRMhv43
         k2Ae4CBNHvLKGtpymuRnVCsB5yx2AL8U6PYR/qtXGfltBYsoHdhUsfNCIfwDXetEed
         rdRBmaP6iPmteK2Y4dVzmNmq6uqaC7KNcuXvNEd4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZH-0019FP-W0; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v5 20/52] memblock: get rid of a :c:type leftover
Date:   Tue,  6 Oct 2020 16:03:17 +0200
Message-Id: <79ad9b97a945f48620b200cd9866d2c5bcd44fb7.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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
index 165f40a8a254..326c6b3fec1d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -50,8 +50,8 @@
  *
  * Each region is represented by :c:type:`struct memblock_region` that
  * defines the region extents, its attributes and NUMA node id on NUMA
- * systems. Every memory type is described by the :c:type:`struct
- * memblock_type` which contains an array of memory regions along with
+ * systems. Every memory type is described by the struct memblock_type
+ * which contains an array of memory regions along with
  * the allocator metadata. The "memory" and "reserved" types are nicely
  * wrapped with :c:type:`struct memblock`. This structure is statically
  * initialized at build time. The region arrays are initially sized to
-- 
2.26.2

