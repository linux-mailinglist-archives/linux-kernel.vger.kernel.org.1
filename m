Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A12204E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgFWJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732162AbgFWJxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50819207D8;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=Bsp2UX/TJRQ3mJE7Y8Q9cm19e5cC2NQN5tgels1xCwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+ugfYYNX0e3Xi3/3Nu5mRUlEO1KbJaBdh/9chjhlypp3jyATcVSoeNvDGs5UY7B7
         o6GISvcVkNuIOziRwou+iqmX7Tw++uEtNx9LSaDfZaXxn2lx4PsddVz7Pr0s2Hmxt1
         ZXuLWaJ8MYr6oREDZiUwZkXGRPlt6H36qHPk6UMk=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfc0-004C3i-FE; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 9/9] docs: staging: use small font for literal includes
Date:   Tue, 23 Jun 2020 11:53:02 +0200
Message-Id: <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The normal font is too big to display 80 columns, causing extra
breaks to be added at weird places.

change to the footnotesize, as this would fit a little bit
better.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8e98517675ca..184e6aece0a7 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,14 +19,41 @@ Unsorted Documentation
 Atomic Types
 ============
 
-.. literalinclude:: ../atomic_t.txt
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../atomic_t.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
 
 Atomic bitops
 =============
 
-.. literalinclude:: ../atomic_bitops.txt
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../atomic_bitops.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
 
 Memory Barriers
 ===============
 
-.. literalinclude:: ../memory-barriers.txt
+.. raw:: latex
+
+    \footnotesize
+
+.. include:: ../memory-barriers.txt
+   :literal:
+
+.. raw:: latex
+
+    \normalsize
-- 
2.26.2

