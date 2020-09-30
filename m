Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2D27E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgI3Hux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:50:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3Hux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:50:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U7jkwu129932;
        Wed, 30 Sep 2020 02:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601451946;
        bh=DTXXTj1Mafi3gwJC2/FQqwnIq0rxpMOZgmEr9nsz2AU=;
        h=From:To:CC:Subject:Date;
        b=tmShxBe2COkLPuOjxTG4/yE5I4QjHIBXBD3Zo+WE7U49OcFhBbCp1wVxUDevrmJMn
         TMqVIMr9sxxQkZrlcs5d+uPnaAGuXyPwublWeZtSey+k6LD7+FbItQ2aYfMXowAL8E
         6kR5kK5Ny2Mq6+BvFNM44LXGtQ33W2f1zRu3XIp0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U7jkXf085957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 02:45:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 02:45:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 02:45:46 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U7jhDl078449;
        Wed, 30 Sep 2020 02:45:43 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] irqchip/ti-sci-inta: Support for unmapped events
Date:   Wed, 30 Sep 2020 10:45:57 +0300
Message-ID: <20200930074559.18028-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

 .../interrupt-controller/ti,sci-inta.yaml     |  5 ++
 drivers/irqchip/irq-ti-sci-inta.c             | 72 +++++++++++++++++--
 2 files changed, 73 insertions(+), 4 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

