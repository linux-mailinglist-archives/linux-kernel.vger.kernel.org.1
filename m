Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA2205376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbgFWNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732594AbgFWNbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:31:44 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83251207DD;
        Tue, 23 Jun 2020 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919103;
        bh=Bsp2UX/TJRQ3mJE7Y8Q9cm19e5cC2NQN5tgels1xCwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVkUE7h0wO6FhZcHwHwm/9ihbIvepFF7JLMdR+Gir5zu/7I8hJPG66W4efqYF4wdx
         V/4xF5fwPPiFj5dZzgnwNzy0gAvZqFp+GPcZ+KDiRSkhl0A6GrQPf5o3e0V1/ukW/o
         PvSfR/INmwu7U6UO/6c47wVisW+T1BEkoXADewMY=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnj1Z-007VJy-KE; Tue, 23 Jun 2020 15:31:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 7/7] docs: staging: use small font for literal includes
Date:   Tue, 23 Jun 2020 15:31:40 +0200
Message-Id: <fe2cc675ec69bfa50aa7e183dcd911077046b01f.1592918949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592918949.git.mchehab+huawei@kernel.org>
References: <cover.1592918949.git.mchehab+huawei@kernel.org>
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

