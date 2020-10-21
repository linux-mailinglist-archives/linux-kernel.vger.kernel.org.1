Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79C295244
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504127AbgJUSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:38642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504119AbgJUSbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:31:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D61B142F;
        Wed, 21 Oct 2020 11:31:14 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 701D93F66B;
        Wed, 21 Oct 2020 11:31:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 2/2] firmware: arm_scmi: Move away from clock devicetree bindings
Date:   Wed, 21 Oct 2020 19:31:04 +0100
Message-Id: <20201021183104.27949-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201021183104.27949-1-sudeep.holla@arm.com>
References: <20201021183104.27949-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
-EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
_allocate_opp_table() which is called from dev_pm_opp_add and it
now propagates the error back to the caller.

This breaks SCMI performance domains as we will never succeed to add any
OPPs. A quick fix would be to register dummy clocks which is completely
ugly and bigger fix which may break with some other change in future.

It is better to add separate binding for the same and use it. A separate
SCMI performance domain binding is introduced and let us use it here.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3e1e87012c95..a79c095662a7 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -629,13 +629,13 @@ static void scmi_perf_domain_init_fc(const struct scmi_handle *handle,
 /* Device specific ops */
 static int scmi_dev_domain_id(struct device *dev)
 {
-	struct of_phandle_args clkspec;
+	struct of_phandle_args spec;

-	if (of_parse_phandle_with_args(dev->of_node, "clocks", "#clock-cells",
-				       0, &clkspec))
+	if (of_parse_phandle_with_args(dev->of_node, "arm,scmi-perf-domain",
+				       "#arm,scmi-perf-domain-cells", 0, &spec))
 		return -EINVAL;

-	return clkspec.args[0];
+	return spec.args[0];
 }

 static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
--
2.17.1

