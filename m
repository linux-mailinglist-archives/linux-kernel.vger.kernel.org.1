Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951CB2E1AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgLWKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:04:33 -0500
Received: from foss.arm.com ([217.140.110.172]:47940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWKEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:04:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8274A11D4;
        Wed, 23 Dec 2020 02:03:47 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D55C3F718;
        Wed, 23 Dec 2020 02:03:44 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 02/11] coresight: Do not scan for graph if none is present
Date:   Wed, 23 Dec 2020 15:33:34 +0530
Message-Id: <1608717823-18387-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If a graph node is not found for a given node, of_get_next_endpoint()
will emit the following error message :

 OF: graph: no port node found in /<node_name>

If the given component doesn't have any explicit connections (e.g,
ETE) we could simply ignore the graph parsing.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3629b78..c594f45 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -90,6 +90,12 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
 	struct of_endpoint endpoint;
 	int in = 0, out = 0;
 
+	/*
+	 * Avoid warnings in of_graph_get_next_endpoint()
+	 * if the device doesn't have any graph connections
+	 */
+	if (!of_graph_is_present(node))
+		return;
 	do {
 		ep = of_graph_get_next_endpoint(node, ep);
 		if (!ep)
-- 
2.7.4

