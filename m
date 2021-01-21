Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A02FE879
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbhAULNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:13:24 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:46893 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730243AbhAULK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:10:26 -0500
IronPort-SDR: 6Y+ZmjVsSC6E+RQq1epqzfL/s/107k++Yd7h32RmlUvjISd01Qtbp4UY0SRb6sy15zbz8vAR2D
 +4iAGFythupBOzMwI1eZzQWE+tiXGLAkODpg+3+oGjLt1PbVvk0crauEBzqtHbWbPlOp2bCsDv
 X19jjIh77aO/XziVBMpofxp/5wTMPxXYDO34SUzWia4mEjMlDWFNRMM73+N6H8aXPOWmezmdt6
 T09PSeq3Sr3EpQh7vONVPynexmFwnEag2vOG5Ya9DDE1QtHJc9f9Ve33S6CfQpzgwblIIy/h9F
 C1Q=
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="15913512"
X-IronPort-AV: E=Sophos;i="5.79,363,1602514800"; 
   d="scan'208";a="15913512"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 21 Jan 2021 20:00:15 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 45E97395742
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:13 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D36D44ABAB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:00:12 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1012)
        id 55679846; Thu, 21 Jan 2021 19:54:25 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
To:     john.garry@huawei.com
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>
Subject: [PATCH v2 0/3] perf vendor events: Support PMU events for A64FX
Date:   Thu, 21 Jan 2021 19:54:22 +0900
Message-Id: <20210121105425.2695843-1-nakamura.shun@jp.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I forgot to add Signed-off. Will resend. Sorry about that.)

This patch series supports A64FX PMU event v1.2.

The first patch adds L1 data cache refill prefetch, L2 data cache refill prefetch, 
and DCZVA instruction events.

The second patch fixes the lexical definition of event name so that 
perf can recognize event name that start with a number.

The third patch adds PMU events for A64FX.

Shunsuke Nakamura (3):
  perf vendor events: Add cache refill and DCZVA events
  perf tools: Fix lexical definition of event name
  perf vendor events: Add Fujitsu A64FX V1.2 pmu event

 .../pmu-events/arch/arm64/armv8-recommended.json   |  18 ++
 .../arch/arm64/fujitsu/a64fx/branch.json           |  14 ++
 .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 ++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 164 ++++++++++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   8 +
 .../arch/arm64/fujitsu/a64fx/execution.json        |  32 +++
 .../arch/arm64/fujitsu/a64fx/instruction.json      | 143 ++++++++++++++
 .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 ++++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json         | 200 +++++++++++++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 218 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/util/parse-events.l                     |   2 +-
 13 files changed, 1057 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/execution.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json

-- 
1.8.3.1

