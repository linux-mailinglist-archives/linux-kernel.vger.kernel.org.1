Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842472FA171
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbhARN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404510AbhARNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:25:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124E9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:24:57 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l1UWU-0000Fu-4s; Mon, 18 Jan 2021 14:24:46 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1l1UWT-0001h5-2N; Mon, 18 Jan 2021 14:24:45 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>, ceggers@arri.de,
        kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvmem: core: skip child nodes not matching binding
Date:   Mon, 18 Jan 2021 14:24:11 +0100
Message-Id: <20210118132411.6268-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvmem cell binding applies to all eeprom child nodes matching
"^.*@[0-9a-f]+$" without taking a compatible into account.

Linux drivers, like at24, are even more extensive and assume
_all_ at24 eeprom child nodes to be nvmem cells since e888d445ac33
("nvmem: resolve cells from DT at registration time").

Since df5f3b6f5357 ("dt-bindings: nvmem: stm32: new property for
data access"), the additionalProperties: True means it's Ok to have
other properties as long as they don't match "^.*@[0-9a-f]+$".

The barebox bootloader extends the MTD partitions binding to
EEPROM and can fix up following device tree node:

  &eeprom {
    partitions {
      compatible = "fixed-partitions";
    };
  };

This is allowed binding-wise, but drivers using nvmem_register()
like at24 will fail to parse because the function expects all child
nodes to have a reg property present. This results in the whole
EEPROM driver probe failing despite the device tree being correct.

Fix this by skipping nodes lacking a reg property instead of
returning an error. This effectively makes the drivers adhere
to the binding because all nodes with a unit address must have
a reg property and vice versa.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time").
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

---
Previous Discussion: https://lore.kernel.org/lkml/20200428111829.2215-1-a.fatoum@pengutronix.de/
v1:
  - Ignore all nodes with a unit address (i.e. contain @)
v1 -> v2:
  - use ->full_name instead of ->name as to not break existing correct
    cells (Christian)
v2 -> v3:
  - use optional compatible property to weed out nodes instead of name
  - extend binding documentation (Srini)
v3 -> v4:
  - drop optional nvmem-cell compatible because it's redundant (Rob)
  - Make driver adhere to binding instead of changing binding

As review feedback on v3, Rob suggested moving nvmem cells into a
separate MTD partition. This sound good for people who want MTD
partitions and nvmem to coexist, but my problem described above where
MTD partitions are already fixed up top level into an EEPROM node isn't
solved by this. Revisiting the issue, I think the correct way forward is
along the lines of v1 & v2, where the driver is fixed to actually adhere
to the existing binding. Srini didn't like string matching for @ in driver
code, so I now check for presence of reg instead. They are equivalent
per device tree specification. From v0.3:

  "The unit-address must match the first address specified in the
  reg property of the node. If the node has no reg property, the
  @unit-address must be omitted"...

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 177f5bf27c6d..f114df55f403 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -682,7 +682,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 	for_each_child_of_node(parent, child) {
 		addr = of_get_property(child, "reg", &len);
-		if (!addr || (len < 2 * sizeof(u32))) {
+		if (!addr)
+			continue;
+		if (len < 2 * sizeof(u32)) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
 			return -EINVAL;
 		}
-- 
2.30.0

