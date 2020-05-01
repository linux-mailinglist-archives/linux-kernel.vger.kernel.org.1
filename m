Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C561C19DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgEAPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgEAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1601424965;
        Fri,  1 May 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=yq71fZecRFuBE9pJTufX7whCpOlACPLvJF4nfyHNyI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tTa9EunYvRlUJSyIwE9HfhS8C+Cdr9eRbE85TGd2h0Ft6l2dBRP+bE/amdq/BeA2M
         ywyWiKM9Qg+lJsUbDyoyZ77ByyxABCjv1n/H32yyWjEvRZMXFnMGwKnfLLTGFJolPU
         8EANNlm5i6gvYg8GRosO/b5xjWAX44b6OLKIwB24=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE5N-AM; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 14/14] docs: staging: use small font for literal includes
Date:   Fri,  1 May 2020 17:37:58 +0200
Message-Id: <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
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
 Documentation/staging/index.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8cc9d94b0a13..184e6aece0a7 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,17 +19,41 @@ Unsorted Documentation
 Atomic Types
 ============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_t.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Atomic bitops
 =============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../atomic_bitops.txt
    :literal:
 
+.. raw:: latex
+
+    \normalsize
+
 Memory Barriers
 ===============
 
+.. raw:: latex
+
+    \footnotesize
+
 .. include:: ../memory-barriers.txt
    :literal:
+
+.. raw:: latex
+
+    \normalsize
-- 
2.25.4

