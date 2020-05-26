Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A291B08AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDTMCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 08:02:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDTMCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:02:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5369AAC64;
        Mon, 20 Apr 2020 12:02:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 1/2] of: property: Fix create device links for all child-supplier dependencies
Date:   Mon, 20 Apr 2020 14:01:01 +0200
Message-Id: <20200420120101.31405-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420120101.31405-1-nsaenzjulienne@suse.de>
References: <20200420120101.31405-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon adding a new device from a DT node, we scan its properties and its
children's properties in order to create a consumer/supplier
relationship between the device and the property provider.

That said, it's possible for some of the node's children to be disabled,
which will create links that'll never be fulfilled.

To get around this, use the for_each_available_child_of_node() function
instead of for_each_available_node() when iterating over the node's
children.

Fixes: d4387cd11741 ("of: property: Create device links for all child-supplier depencencies")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Saravana Kannan <saravanak@google.com>

---

Changes since v1:
 - Slightly reword description

 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 252e4f6001553..dc034eb45defd 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1298,7 +1298,7 @@ static int of_link_to_suppliers(struct device *dev,
 		if (of_link_property(dev, con_np, p->name))
 			ret = -ENODEV;
 
-	for_each_child_of_node(con_np, child)
+	for_each_available_child_of_node(con_np, child)
 		if (of_link_to_suppliers(dev, child) && !ret)
 			ret = -EAGAIN;
 
-- 
2.26.0

