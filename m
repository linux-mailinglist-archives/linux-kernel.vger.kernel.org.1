Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F461B08AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDTMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:02:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDTMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78F56AE17;
        Mon, 20 Apr 2020 12:02:13 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 2/2] of: property: Do not link to disabled devices
Date:   Mon, 20 Apr 2020 14:01:02 +0200
Message-Id: <20200420120101.31405-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420120101.31405-1-nsaenzjulienne@suse.de>
References: <20200420120101.31405-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a consumer/supplier relationship between two devices,
make sure the supplier node is actually active. Otherwise this will
create a link relationship that will never be fulfilled. This, in the
worst case scenario, will hang the system during boot.

Note that, in practice, the fact that a device-tree represented
consumer/supplier relationship isn't fulfilled will not prevent devices
from successfully probing.

Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
 - Correct code comment
 - Use already available return handling code

Changes since v1:
 - Move availability check into the compatible search code and stop if
   node disabled

 drivers/of/property.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index dc034eb45defd..7bcf31ba717d8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1045,8 +1045,20 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 	 * Find the device node that contains the supplier phandle.  It may be
 	 * @sup_np or it may be an ancestor of @sup_np.
 	 */
-	while (sup_np && !of_find_property(sup_np, "compatible", NULL))
+	while (sup_np) {
+
+		/* Don't allow linking to a disabled supplier */
+		if (!of_device_is_available(sup_np)) {
+			of_node_put(sup_np);
+			sup_np = NULL;
+		}
+
+		if (of_find_property(sup_np, "compatible", NULL))
+			break;
+
 		sup_np = of_get_next_parent(sup_np);
+	}
+
 	if (!sup_np) {
 		dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
 		return -ENODEV;
-- 
2.26.0

