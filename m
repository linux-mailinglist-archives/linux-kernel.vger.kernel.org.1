Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9A91A25F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgDHPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C272621D81;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=2lkqsCAQF54Pdi9xvJJXtrh8wUQHo0cYxp077ryGpVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DjtbswZXsCX5J5p9U6oXJQIuMpt3+Kf5Xbp/LCUIfYNRKcFn8u6/aQnp6bS5B3xf
         5rCnS/LhYqqgmzVq5ovt8RT+pb+MI/S1WW0o8zk67xe7NxaSvnW7AxUaBuRvvIOgE5
         aEvSd1hI598cmwjs2qamWe4ixp657KgmZ+XNZyCQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cCB-VT; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 24/35] docs: mm: slab.h: fix a broken cross-reference
Date:   Wed,  8 Apr 2020 17:46:16 +0200
Message-Id: <0aeac24235d356ebd935d11e147dcc6edbb6465c.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo at the cross-reference link, causing this
warning:

	./include/linux/slab.h:11: WARNING: undefined label: memory-allocation (if the link has no caption the label must precede a section header)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 03a389358562..6d454886bcaf 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -501,7 +501,7 @@ static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
  * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
  *
  * The recommended usage of the @flags is described at
- * :ref:`Documentation/core-api/memory-allocation.rst <memory-allocation>`
+ * :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
  *
  * Below is a brief outline of the most useful GFP flags
  *
-- 
2.25.2

