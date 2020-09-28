Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440A127A7B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1Gjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:39:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43944 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1Gjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:39:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dKjQ126264;
        Mon, 28 Sep 2020 01:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601275160;
        bh=ObPYzVtkXyOyfzJlM4CU/7L6Ac+puM8WVVh6Sgi6wPo=;
        h=From:To:CC:Subject:Date;
        b=oAvqZrNZbpK4Hl5MYxw2W+GGlIfo6YYbeDBOgHi4acDD4Hcoi/A/ViquerEEP1FNx
         vQxUdOtdQz1NVKcXGeb9Nv1qFnkWGOj9sS3cP95DhJVPxsAsDBUGdt1HuU3HkHiqik
         mbPfjGv15ZuMmo7TLuC+Ba12mYnhOKyW42fYd/v8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S6dJml044676
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 01:39:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 01:39:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 01:39:19 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dG3d111672;
        Mon, 28 Sep 2020 01:39:16 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/2] irqchip/ti-sci-inta: Support for unmapped events
Date:   Mon, 28 Sep 2020 09:39:28 +0300
Message-ID: <20200928063930.12012-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

