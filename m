Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1D1CDA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgEKMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 08:38:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730049AbgEKMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:38:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97C0786391CC538598C0;
        Mon, 11 May 2020 20:38:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 20:38:48 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     <linux@armlinux.org.uk>, <ben.dooks@codethink.co.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: topology: make cpu_corepower_mask static
Date:   Mon, 11 May 2020 20:44:55 +0800
Message-ID: <1589201095-12884-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

arch/arm/kernel/topology.c:184:22: warning: symbol 'cpu_corepower_mask'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index b5adaf7..563fdaa 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -181,7 +181,7 @@ static inline void update_cpu_capacity(unsigned int cpuid) {}
  * The current assumption is that we can power gate each core independently.
  * This will be superseded by DT binding once available.
  */
-const struct cpumask *cpu_corepower_mask(int cpu)
+static const struct cpumask *cpu_corepower_mask(int cpu)
 {
 	return &cpu_topology[cpu].thread_sibling;
 }
--
2.6.2

