Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB375295241
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504117AbgJUSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410323AbgJUSbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EFF2D6E;
        Wed, 21 Oct 2020 11:31:13 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56EE73F66B;
        Wed, 21 Oct 2020 11:31:12 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI performance domains
Date:   Wed, 21 Oct 2020 19:31:03 +0100
Message-Id: <20201021183104.27949-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
-EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
_allocate_opp_table() which is called from dev_pm_opp_add and it
now propagates the error back to the caller.

SCMI performance domain re-used clock bindings to keep it simple. However
with the above mentioned change, if clock property is present in a device
node, opps can't be added until clk_get succeeds. So in order to fix the
issue, we can register dummy clocks which is completely ugly.

Since there are no upstream users for the SCMI performance domain clock
bindings, let us introduce separate performance domain bindings for the
same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

v1[1]->v2:
	- Changed the generic #perf-domain-cells to more SCMI specific
	  property #arm,scmi-perf-domain-cells

Hi Rob/Viresh,

This is actually a fix for the regression I reported here[2].
I am not adding fixes tag as I am targeting in the same release and
also because it is not directly related.

Regards,
Sudeep

[1] https://lore.kernel.org/r/20201020203710.10100-1-sudeep.holla@arm.com
[2] https://lore.kernel.org/r/20201015180555.gacdzkofpibkdn2e@bogus

P.S.:/me records that this binding needs to be moved to yaml in v5.11
diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 55deb68230eb..7af1be54f6c7 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -44,7 +44,7 @@ as described in the following sections. If the platform supports dedicated
 mboxes, mbox-names and shmem shall be present in the sub-node corresponding
 to that protocol.

-Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
+Clock bindings for the clocks based on SCMI Message Protocol
 ------------------------------------------------------------

 This binding uses the common clock binding[1].
@@ -52,6 +52,19 @@ This binding uses the common clock binding[1].
 Required properties:
 - #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.

+Performance bindings for the OPPs based on SCMI Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- #arm,scmi-perf-domain-cells: Should be 1. Contains the performance domain ID
+  value used by SCMI commands.
+
+* Property arm,scmi-perf-domain
+
+Devices supporting SCMI performance domain must set their "arm,scmi-perf-domain"
+property with phandle to a SCMI performance domain controller followed by the
+performance domain.
+
 Power domain bindings for the power domains based on SCMI Message Protocol
 ------------------------------------------------------------

@@ -152,7 +165,7 @@ firmware {

 		scmi_dvfs: protocol@13 {
 			reg = <0x13>;
-			#clock-cells = <1>;
+			#arm,scmi-perf-domain-cells = <1>;
 		};

 		scmi_clk: protocol@14 {
@@ -175,7 +188,7 @@ firmware {
 cpu@0 {
 	...
 	reg = <0 0>;
-	clocks = <&scmi_dvfs 0>;
+	arm,scmi-perf-domain = <&scmi_dvfs 0>;
 };

 hdlcd@7ff60000 {
--
2.17.1

