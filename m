Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC42A8F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKFGlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:41:55 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:37206 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFGlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:41:55 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id CAE41667108;
        Fri,  6 Nov 2020 14:41:48 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] perf: remove duplicate check on fwnode
Date:   Fri,  6 Nov 2020 14:41:42 +0800
Message-Id: <1604644902-29655-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhkfTB9CGk0dGh8fVkpNS09NT09CSkpDQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Vhw6GD8aTh01GDBNTy0h
        EgsKFEpVSlVKTUtPTU9PQkpJSUJIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTktDNwY+
X-HM-Tid: 0a759c4a30299373kuwscae41667108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode is checked IS_ERR_OR_NULL in following check by
is_of_node() or is_acpi_device_node(), remove duplicate check.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/perf/arm_dsu_pmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 98e68ed..0459a34
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -716,9 +716,6 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(dsu_pmu))
 		return PTR_ERR(dsu_pmu);
 
-	if (IS_ERR_OR_NULL(fwnode))
-		return -ENOENT;
-
 	if (is_of_node(fwnode))
 		rc = dsu_pmu_dt_get_cpus(&pdev->dev, &dsu_pmu->associated_cpus);
 	else if (is_acpi_device_node(fwnode))
-- 
2.7.4

