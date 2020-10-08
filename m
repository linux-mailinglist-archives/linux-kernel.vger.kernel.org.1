Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA13287179
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgJHJaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:30:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgJHJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:30:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54306FA8F27CEE140F91;
        Thu,  8 Oct 2020 17:30:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 17:30:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <zhangshaokun@hisilicon.com>,
        <qiangqing.zhang@nxp.com>
CC:     <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <acme@kernel.org>,
        <jolsa@redhat.com>, <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/4] bindings/perf/imx-ddr: update compatible string
Date:   Thu, 8 Oct 2020 17:26:19 +0800
Message-ID: <1602149181-237415-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Update compatible string according to driver change.

[jpg: keep "fsl,imx8m-ddr-pmu", which was being removed]

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
index 7822a806ea0a..cc38c7fd7049 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.txt
@@ -5,6 +5,9 @@ Required properties:
 - compatible: should be one of:
 	"fsl,imx8-ddr-pmu"
 	"fsl,imx8m-ddr-pmu"
+	"fsl,imx8mq-ddr-pmu"
+	"fsl,imx8mm-ddr-pmu"
+	"fsl,imx8mn-ddr-pmu"
 	"fsl,imx8mp-ddr-pmu"
 
 - reg: physical address and size
-- 
2.26.2

