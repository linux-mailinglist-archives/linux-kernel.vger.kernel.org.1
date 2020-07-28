Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA422FF93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG1CYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 22:24:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgG1CYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:24:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8EFFA78F7F35ED3AEBB2;
        Tue, 28 Jul 2020 10:24:50 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:24:49 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc: use for_each_child_of_node() macro
Date:   Tue, 28 Jul 2020 10:28:07 +0800
Message-ID: <20200728022807.87815-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/powerpc/platforms/pasemi/misc.c         | 3 +--
 arch/powerpc/platforms/powermac/low_i2c.c    | 6 ++----
 arch/powerpc/platforms/powermac/pfunc_base.c | 4 ++--
 arch/powerpc/platforms/powermac/udbg_scc.c   | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/misc.c b/arch/powerpc/platforms/pasemi/misc.c
index 1cd4ca14b..1bf65d02d 100644
--- a/arch/powerpc/platforms/pasemi/misc.c
+++ b/arch/powerpc/platforms/pasemi/misc.c
@@ -56,8 +56,7 @@ static int __init pasemi_register_i2c_devices(void)
 		if (!adap_node)
 			continue;
 
-		node = NULL;
-		while ((node = of_get_next_child(adap_node, node))) {
+		for_each_child_of_node(adap_node, node) {
 			struct i2c_board_info info = {};
 			const u32 *addr;
 			int len;
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index bf4be4b53..f77a59b5c 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -629,8 +629,7 @@ static void __init kw_i2c_probe(void)
 			for (i = 0; i < chans; i++)
 				kw_i2c_add(host, np, np, i);
 		} else {
-			for (child = NULL;
-			     (child = of_get_next_child(np, child)) != NULL;) {
+			for_each_child_of_node(np, child) {
 				const u32 *reg = of_get_property(child,
 						"reg", NULL);
 				if (reg == NULL)
@@ -1193,8 +1192,7 @@ static void pmac_i2c_devscan(void (*callback)(struct device_node *dev,
 	 * platform function instance
 	 */
 	list_for_each_entry(bus, &pmac_i2c_busses, link) {
-		for (np = NULL;
-		     (np = of_get_next_child(bus->busnode, np)) != NULL;) {
+		for_each_child_of_node(bus->busnode, np) {
 			struct whitelist_ent *p;
 			/* If multibus, check if device is on that bus */
 			if (bus->flags & pmac_i2c_multibus)
diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
index 62311e84a..f5422506d 100644
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -114,7 +114,7 @@ static void macio_gpio_init_one(struct macio_chip *macio)
 	 * Ok, got one, we dont need anything special to track them down, so
 	 * we just create them all
 	 */
-	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;) {
+	for_each_child_of_node(gparent, gp) {
 		const u32 *reg = of_get_property(gp, "reg", NULL);
 		unsigned long offset;
 		if (reg == NULL)
@@ -133,7 +133,7 @@ static void macio_gpio_init_one(struct macio_chip *macio)
 	    macio->of_node);
 
 	/* And now we run all the init ones */
-	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;)
+	for_each_child_of_node(gparent, gp)
 		pmf_do_functions(gp, NULL, 0, PMF_FLAGS_ON_INIT, NULL);
 
 	/* Note: We do not at this point implement the "at sleep" or "at wake"
diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index 6b61a18e8..f286bdfe8 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -80,7 +80,7 @@ void udbg_scc_init(int force_scc)
 	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL)
 		stdout = of_find_node_by_path(path);
-	for (ch = NULL; (ch = of_get_next_child(escc, ch)) != NULL;) {
+	for_each_child_of_node(escc, ch) {
 		if (ch == stdout)
 			ch_def = of_node_get(ch);
 		if (of_node_name_eq(ch, "ch-a"))
-- 
2.25.1

