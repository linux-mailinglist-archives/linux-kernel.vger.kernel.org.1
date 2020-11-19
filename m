Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E007C2B9B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgKSTLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:11:37 -0500
Received: from foss.arm.com ([217.140.110.172]:37988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgKSTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:11:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AB7015DB;
        Thu, 19 Nov 2020 11:11:31 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3352B3F70D;
        Thu, 19 Nov 2020 11:11:29 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        broonie@kernel.org, robh@kernel.org, satyakim@qti.qualcomm.com,
        etienne.carriere@linaro.org, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v6 3/5] regulator: core: add of_match_full_name boolean flag
Date:   Thu, 19 Nov 2020 19:10:49 +0000
Message-Id: <20201119191051.46363-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119191051.46363-1-cristian.marussi@arm.com>
References: <20201119191051.46363-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During regulators registration, if .of_match and .regulators_node are
defined as non-null strings in struct regulator_desc the core searches the
DT subtree rooted at .regulators_node trying to match, at first, .of_match
against the 'regulator-compatible' property and, then, falling back to use
the name of the node itself to determine a good match.

Property 'regulator-compatible', though, is now deprecated and falling back
to match against the node name, works fine only as long as the involved
nodes are named in an unique way across the searched subtree; if that's not
the case, like when using <common-name>@<unit> style naming for properties
indexed via 'reg' property (as advised by the standard), the above matching
mechanism based on the simple common name will lead to multiple matches and
the only viable alternative would be to properly define the now deprecated
'regulator-compatible' as the node full name, i.e. <common-name>@<unit>.

In order to address this case without using such deprecated binding, define
a new boolean flag .of_match_full_name in struct regulator_desc to force
the core to match against the node full-name instead of the plain name.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/regulator/of_regulator.c | 8 ++++++--
 include/linux/regulator/driver.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 06c0b15fe4c0..564f928eb1db 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -413,8 +413,12 @@ device_node *regulator_of_get_init_node(struct device *dev,
 
 	for_each_available_child_of_node(search, child) {
 		name = of_get_property(child, "regulator-compatible", NULL);
-		if (!name)
-			name = child->name;
+		if (!name) {
+			if (!desc->of_match_full_name)
+				name = child->name;
+			else
+				name = child->full_name;
+		}
 
 		if (!strcmp(desc->of_match, name)) {
 			of_node_put(search);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 11cade73726c..d7c77ee370f3 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -223,6 +223,8 @@ enum regulator_type {
  * @name: Identifying name for the regulator.
  * @supply_name: Identifying the regulator supply
  * @of_match: Name used to identify regulator in DT.
+ * @of_match_full_name: A flag to indicate that the of_match string, if
+ *			present, should be matched against the node full_name.
  * @regulators_node: Name of node containing regulator definitions in DT.
  * @of_parse_cb: Optional callback called only if of_match is present.
  *               Will be called for each regulator parsed from DT, during
@@ -314,6 +316,7 @@ struct regulator_desc {
 	const char *name;
 	const char *supply_name;
 	const char *of_match;
+	bool of_match_full_name;
 	const char *regulators_node;
 	int (*of_parse_cb)(struct device_node *,
 			    const struct regulator_desc *,
-- 
2.17.1

