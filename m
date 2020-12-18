Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D9B2DE6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgLRPgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:36:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10069 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgLRPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608305798; x=1639841798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RsRhBlf1rm42fTpGkzKbxeDmzTPw22LNVyzMVaVPHv4=;
  b=dMwvfXO4I+vY3Lk4Q2eHVMbDv+tAdXtViTfJ8h6UtagZDG1T/SCHl2aM
   JAknBgYB03O1YAxrflqOI14ik5/cCeWnzMxj94iK1pOAs5IMKm30Upbr0
   FNWJmrIH2KcbFuO2P/JAthZofx6zv1bEZeTrCVjUD/+QF5HZL/QYdTIIx
   hjMoCKl14dba6852HdorpG28KosEgKbCmRnm/iJWgIbrb448NxrSGDpp/
   RoJ6rUe163GsefQkeScGM8rT4Tv0hV591EfAPviDaXlAm0PVNgyjgMyz+
   l0B7ObYMnYXPzVnVpneJk0II5uE4jZB4ficx9VvrD6Mz4ComIg3JJlPsg
   w==;
IronPort-SDR: Ch4A+pstylaEOR6xVkvwIKcMaQYrTsmF9Qhsl9/SN9nlz17PdIFIfZR2mzYbFpGReFctXuvPUD
 uLY4JHNmFJeSBXWETafIC93GOFxApSEe7M73yYUrDGc/Si36l3oAnkYfewWZ2AXL4bevSzcwkD
 AQcwalH1ok5EaiE85rtMQDAmx8v0t0BGVC8GlI7hg36mBEcXGwyF5CEno+5PQGJepVDxhFavKN
 Djewjwa5xA7yCm6SU46E2MNtZM/o6wWH2ZdT3ptK6TkAcZuGcim3IvVAlDZIzOyhl4AV37knf0
 JLY=
X-IronPort-AV: E=Sophos;i="5.78,430,1599494400"; 
   d="scan'208";a="155517144"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2020 23:35:32 +0800
IronPort-SDR: k+P7ZcijI5uW5jcXguJ6hzjNmjn673twitIk53VZIhlr9X/w8qft1rLM334ZP0X07OUM3oLnMt
 Wg2ujo8jGnOzvmd7PfNN6hJvB9+saxfLS7YLY7OAP5WJMKTDTCkdbA+XQl6Vrkwy4uSUAIFOR3
 85L5y40LWV4WtgPn2/F2jgZawL+Ylnmpt2G6VHigqyhaMgxVj4okJcLtxISR87ANwv4vm0OMyS
 qJ89dft1JxrNp03zecNRI2Xwp13t4AZRUW6bcVKf/HYVNzt1zmj/lSQkIWk9hWkMbN/nSISYRm
 K4B4mqSHFvHPnJzpThPsRngI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 07:19:05 -0800
IronPort-SDR: RxmgA+m92fA6OziDiykOvbR7SgQSuLfD/50QEEDFM6yqUERO12TnNpGOieCklxh9YifcyFmPD8
 XfqlsOO6vCYxCBPtaRM9Eek/+cTrtoCsV4dL4l53/gRneg819sDb//rhHU09B8D4TW8gs+0fIx
 EwvnH2PpEvb4Us8yJrlmflFfnDlt5KDjRcLbMsywTN+VtasG99qK2nORxbvvq+ieO+u/hUST5M
 wuORW9wrRPImuNe7zkYlvh8N5qQ54OZk2b+YiZIBGkgIUdHHm6Z0mGSCQTSwHR8ycFYdn4NJ45
 EvQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Dec 2020 07:35:32 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Duerr <Hannes.Duerr@duagon.com>
Subject: [PATCH] Documentation: document dma device use for mcb
Date:   Sat, 19 Dec 2020 00:35:25 +0900
Message-Id: <3bdc8f76b30c2b0e2a2bfab06c2e73797ddc9384.1608305690.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes reported a problem with setting up dma transfers on a mcb device.
The problem boiled down to the use of a wrong 'device' for the dma
functions.

Document how to setup dma transfers for a IP core on a mcb carrier.

Reported-by: Hannes Duerr <Hannes.Duerr@duagon.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 Documentation/driver-api/men-chameleon-bus.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/driver-api/men-chameleon-bus.rst b/Documentation/driver-api/men-chameleon-bus.rst
index 1b1f048aa748..6f0b9ee47595 100644
--- a/Documentation/driver-api/men-chameleon-bus.rst
+++ b/Documentation/driver-api/men-chameleon-bus.rst
@@ -18,6 +18,7 @@ MEN Chameleon Bus
        4.1 The driver structure
        4.2 Probing and attaching
        4.3 Initializing the driver
+       4.4 Using DMA
 
 
 Introduction
@@ -173,3 +174,14 @@ module at the MCB core::
 The module_mcb_driver() macro can be used to reduce the above code::
 
 	module_mcb_driver(foo_driver);
+
+Using DMA
+---------
+
+To make use of the kernel's DMA-API's function, you will need to use the
+carrier device's 'struct device'. Fortunately 'struct mcb_device' embeds a
+pointer (->dma_dev) to the carrier's device for DMA purposes::
+
+        ret = dma_set_mask_and_coherent(&mdev->dma_dev, DMA_BIT_MASK(dma_bits));
+        if (rc)
+                /* Handle errors */
-- 
2.26.2

