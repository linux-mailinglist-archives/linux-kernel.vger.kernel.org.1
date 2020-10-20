Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE3B2935C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405140AbgJTHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:32:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47440 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405114AbgJTHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:32:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WG5D045155;
        Tue, 20 Oct 2020 02:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603179136;
        bh=w6KRfGRpZ8Qe5ljgTSyonGbPDQ0/NIWbexukOG/APXU=;
        h=From:To:CC:Subject:Date;
        b=HC8mbtVOEzLqRTglwanl05hMpC1Uayu1Yptd1e2LvS+b1eCF+W2A2HhX3yiZysVly
         uVYpGyrUUHqewENPQNTSM8kk6Xoav7dQDkcW3T31PHcC9npSpCcCVVzZ+sfv8zlGA+
         Ci6Q4jl6O2ao3jbPTXtVUbwp25+3VKqfX8UNPPjw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09K7WGgg127773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 02:32:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 20
 Oct 2020 02:32:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 20 Oct 2020 02:32:15 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WCib069455;
        Tue, 20 Oct 2020 02:32:13 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] irqchip/ti-sci-inta: Support for unmapped events
Date:   Tue, 20 Oct 2020 10:32:41 +0300
Message-ID: <20201020073243.19255-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2:
- Extended the block diagram of INTA in the DT documentation
- Use less creative variable names for unmapped events in the driver
- Short comment section to describe the unmapped event handling in driver
- Use u16 array to store the TI-SCI device identifiers instead of u32
- Use printk format specifier instead of_node_full_name

Changes since v1:
- Reviewed-by added to the first patch from Rob
- return 0 if ti,unmapped-event-sources is not present in DT

The version of INTA within DMSS (in AM64) changed how the events from the DMAs
are handled and how sysfw is presenting these events to be used for interrupts.

The DMA related events are directly mapped within INTA as unmapped events in
contrast to previous devices with NAVSS where the events were tied to their
source devices (UDMAP, ringacc).

This series adds support for handling the new version of INTA by introducing a
new property: ti,unmapped-event-sources which should hold a list of phandles
pointing to the sources of these unmapped events.

Regards,
Peter
---
Peter Ujfalusi (2):
  dt-bindings: irqchip: ti,sci-inta: Update for unmapped event handling
  irqchip/ti-sci-inta: Add support for unmapped event handling

 .../interrupt-controller/ti,sci-inta.yaml     | 10 +++
 drivers/irqchip/irq-ti-sci-inta.c             | 83 ++++++++++++++++++-
 2 files changed, 90 insertions(+), 3 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

