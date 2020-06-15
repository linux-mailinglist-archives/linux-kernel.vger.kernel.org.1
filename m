Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6777F1F8EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgFOGwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 02:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbgFOGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:50:35 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02EE207DD;
        Mon, 15 Jun 2020 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203832;
        bh=EjsPG25wGnnY497nFR1iD2NoJuLKx5vawfb5A0g1KP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efVLdLQDA3ysiD+OM1aqnqwzzT2A6stkzEbAQ3RwviYud1ozLsV0OfyBupMqb3lEd
         xH7wgv2FJU5oN3md3VxQYG6eU/KtDNZuleHIrd7B8dfXHGNFg76hrNV7I/GVcfLz3H
         mCf7W6PRLbjX4XMk/VH4mR4MT1fc3G2dwQBz5DQE=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiww-009o74-PJ; Mon, 15 Jun 2020 08:50:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 21/22] docs: staging: don't use literalinclude
Date:   Mon, 15 Jun 2020 08:50:26 +0200
Message-Id: <9a9043face7ace90e3616ba840a8e09cfc8f143f.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such directive cause troubles with PDF output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/staging/index.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 8e98517675ca..8cc9d94b0a13 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -19,14 +19,17 @@ Unsorted Documentation
 Atomic Types
 ============
 
-.. literalinclude:: ../atomic_t.txt
+.. include:: ../atomic_t.txt
+   :literal:
 
 Atomic bitops
 =============
 
-.. literalinclude:: ../atomic_bitops.txt
+.. include:: ../atomic_bitops.txt
+   :literal:
 
 Memory Barriers
 ===============
 
-.. literalinclude:: ../memory-barriers.txt
+.. include:: ../memory-barriers.txt
+   :literal:
-- 
2.26.2

