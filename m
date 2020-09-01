Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E36E258B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIAJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:12:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:37745 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:12:10 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0819Bvhi014880
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 1 Sep 2020 02:11:57 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 02:11:56 -0700
From:   <yanfei.xu@windriver.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64/numa: Fix a typo in comment of arm64_numa_init
Date:   Tue, 1 Sep 2020 17:11:54 +0800
Message-ID: <20200901091154.10112-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Fix a typo in comment of arm64_numa_init. 'encomapssing' should
be 'encompassing'.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 arch/arm64/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 73f8b49d485c..d402da26cdca 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -448,7 +448,7 @@ static int __init dummy_numa_init(void)
  * arm64_numa_init() - Initialize NUMA
  *
  * Try each configured NUMA initialization method until one succeeds. The
- * last fallback is dummy single node config encomapssing whole memory.
+ * last fallback is dummy single node config encompassing whole memory.
  */
 void __init arm64_numa_init(void)
 {
-- 
2.18.2

