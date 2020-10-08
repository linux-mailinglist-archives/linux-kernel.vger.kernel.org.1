Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727CC28717F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgJHJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:30:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727155AbgJHJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:30:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B01BF31CD77A4671959;
        Thu,  8 Oct 2020 17:30:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 17:30:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <zhangshaokun@hisilicon.com>,
        <qiangqing.zhang@nxp.com>
CC:     <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <acme@kernel.org>,
        <jolsa@redhat.com>, <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] perf drivers: Add sysfs identifier file
Date:   Thu, 8 Oct 2020 17:26:17 +0800
Message-ID: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow perf tool to identify a specific implementation of a PMU for
event alias matching and metric support, expose a per-PMU identifier file.

There is no standard format for the identifier string. It just should be
unique per HW implementation.

Typical methods to retrieve the information for the identifier string
can include:
- Hardcoding in the driver, matched via DT bindings compat string,
  ACPI HID, or similar
- Directly from DT bindings property
- Read from some HW identification register

In this series, for the SMMUv3 PMU and HiSi uncore drivers, a HW ID
register is read for the identifier. For the imx8 ddr driver, the
identifier is hardcoded, matched via DT compat string.

Joakim Zhang (2):
  bindings/perf/imx-ddr: update compatible string
  perf/imx_ddr: Add system PMU identifier for userspace

John Garry (2):
  drivers/perf: hisi: Add identifier sysfs file
  perf/smmuv3: Support sysfs identifier file

 .../devicetree/bindings/perf/fsl-imx-ddr.txt  |  3 ++
 drivers/perf/arm_smmuv3_pmu.c                 | 39 ++++++++++++++++
 drivers/perf/fsl_imx8_ddr_perf.c              | 45 +++++++++++++++++--
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 16 +++++++
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 16 +++++++
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 16 +++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c      | 10 +++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |  7 +++
 8 files changed, 149 insertions(+), 3 deletions(-)

-- 
2.26.2

