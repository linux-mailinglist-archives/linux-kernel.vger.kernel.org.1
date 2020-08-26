Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF1252DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgHZMEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 08:04:35 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17356 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgHZMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:11 -0400
IronPort-SDR: URNFkK02/qKTkzCsexIPWXqr730J11mIkL6vCp38Rb5cL7k6xEmB8bpMpYfB4oytzBZNXCj6X9
 FfXuWPXinXBwsWuEwieQqEzcE1nise8DbX0DJbKXkbZRTR7cigohPRZ72OOD4jjQ7kO980p9Io
 m7kj4KGZFxaugVTUD5tXtZt+x85KSKOMhSYySgdEegg7LYvOWkCcIygbrbIykvMjG4jbqQPjJP
 QnEDcJjskS5A7d8nuRs5K0n7i52ryWY3d9VI25K6g40QnKiARRMOoZuKvqiBex81oICWfcc6tP
 iro=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13607754"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Aug 2020 14:03:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Aug 2020 14:03:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Aug 2020 14:03:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598443388; x=1629979388;
  h=from:to:cc:subject:date:message-id;
  bh=w5WmpfTmC7AUFRQxsIbP8PaB8d2cw3oNSZ0fBWcQoSg=;
  b=qpMLC0/vBhzJXsDuHEzgh2z7CTIzVoLQ9OYqOZD+EoeU6SaafneL4ESt
   CgaJgyknDyIxeH9F+YC8bY4VeQAChXtslz94wRvXYljrNtrW+qR80Yut9
   756Hm5FmJseCGdnxNrftZ1of69nTHb5qqzRGtRLEOc1STv92c9FySVE/e
   QYyc7rlX5j7M+QhXR2wU9y+jxcNs5CA+MsmcORh1ubu5UEIhGTZoJ8xGD
   LLxbHbwAWUaLhNc+/pGLf+5/DdWFTm3VI+JlGCXg1pqavWyen8H7dr8f8
   ESfChHkrEfXD87N14Yf+xuhW0XQpdwxps/H+AizOz3tjs5HeAiOl/ap98
   Q==;
IronPort-SDR: 6fD0atj3+mV3gr/f5F2lITSzQKoLxCP8yKXDkCMBjXFMWXCEnoZZv6t6lZa6j5HCxCNnhBfn4v
 86mPI2jUovz0aWN1E1UWXy7JEAaIIaTJ71G1pDkEwtfckEApJwZWGuDbg8RXczFusLi53g81KV
 ORI5AB1YceMkIQ0WuphRFHIqY0PzZ1UWC/1bV43+xS5rNRPA5edSWoahfXrsBEikoWBUYjQ0b6
 Rdc94g1gJs3tplRUazGZQlhS7Gw0AYw565NP48uJHhbDec64BOt4U3BuwgCSBwjKZenYcFeGOV
 Sb4=
X-IronPort-AV: E=Sophos;i="5.76,355,1592863200"; 
   d="scan'208";a="13607753"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Aug 2020 14:03:08 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 44BE2280065;
        Wed, 26 Aug 2020 14:03:08 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] of: skip disabled CPU nodes
Date:   Wed, 26 Aug 2020 14:02:54 +0200
Message-Id: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow disabling CPU nodes using status = "disabled".

This allows a bootloader to change the number of available CPUs (for
example when a common DTS is used for SoC variants with different numbers
of cores) without deleting the nodes altogether (which may require
additional fixups where the CPU nodes are referenced, e.g. a cooling
map).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ea44fea99813..d547e9deced1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -796,6 +796,8 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
 		of_node_put(node);
 	}
 	for (; next; next = next->sibling) {
+		if (!__of_device_is_available(next))
+			continue;
 		if (!(of_node_name_eq(next, "cpu") ||
 		      __of_node_is_type(next, "cpu")))
 			continue;
-- 
2.17.1

