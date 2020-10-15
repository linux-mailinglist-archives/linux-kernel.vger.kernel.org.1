Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3928F179
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgJOLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:43:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgJOLn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:43:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52F4EABBE;
        Thu, 15 Oct 2020 11:43:56 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     f.fainelli@gmail.com, linux-rpi-kernel@lists.infradead.org,
        saravanak@google.com, u.kleine-koenig@pengutronix.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] of/platform: Create device link between simple-mfd and its children
Date:   Thu, 15 Oct 2020 13:43:46 +0200
Message-Id: <20201015114346.15743-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'simple-mfd' usage implies there might be some kind of resource sharing
between the parent device and its children. By creating a device link
with DL_FLAG_AUTOREMOVE_CONSUMER we make sure that at no point in time
the parent device is unbound while leaving its children unaware that
some of their resources disappeared.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Some questions:

- To what extent do we care about cleanly unbinding platform devices at
  runtime? My rationale here is: "It's a platform device, for all you
  know you might be unbinding someting essential to the system. So if
  you're doing it, you better know what you're doing."

- Would this be an abuse of device links?

- If applying this to all simple-mfd devices is a bit too much, would
  this be acceptable for a specific device setup. For example RPi4's
  firmware interface (simple-mfd user) is passed to consumer drivers
  trough a custom API (see rpi_firmware_get()). So, when unbound,
  consumers are left with a firmware handle that points to nothing.

 drivers/of/platform.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..8d5b55b81764 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -390,8 +390,14 @@ static int of_platform_bus_create(struct device_node *bus,
 	}
 
 	dev = of_platform_device_create_pdata(bus, bus_id, platform_data, parent);
-	if (!dev || !of_match_node(matches, bus))
-		return 0;
+	if (!dev)
+	       return 0;
+
+	if (parent && of_device_is_compatible(parent->of_node, "simple-mfd"))
+	       device_link_add(&dev->dev, parent, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	if (!of_match_node(matches, bus))
+	       return 0;
 
 	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
-- 
2.28.0

