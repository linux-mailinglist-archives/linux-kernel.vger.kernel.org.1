Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF76227A991
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1IeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41132 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1IeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YJKI079658;
        Mon, 28 Sep 2020 03:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282059;
        bh=fWqsfENT3V8ySGR52u4nqFw+xhnG6VUGz8rbAf/YYOE=;
        h=From:To:CC:Subject:Date;
        b=vZTUXFKvF76x0/hHZ6eE/9j/R7yQNpkgRFyA6zDZGLr7I1N8EElHjJfbk+Tj4bR21
         N7mPgibVzvWH6JiXfP4sElJX9f0AhD4HsJmlbzJPBlPuLnj0vG5lNJZTD3GMXver5F
         BPI0GFH7k0PDQ/xcCzmC2odOoPGQhM0hJ90e2Hpc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YJlq101411;
        Mon, 28 Sep 2020 03:34:19 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaR065485;
        Mon, 28 Sep 2020 03:34:14 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 00/11] firmware/soc: ti_sci, ringacc/inta: Preparation for AM64 DMA support
Date:   Mon, 28 Sep 2020 11:34:18 +0300
Message-ID: <20200928083429.17390-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series prepares the ti_sci, ringacc, inta to support the new DMAs introduced
with AM64.

Separate series has been sent for the inta irqchip driver:
https://lore.kernel.org/lkml/20200928063930.12012-1-peter.ujfalusi@ti.com/

Patches for the DMA support will be based on this series due to build and
feature dependencies.

To support the new DMSS we need to change the ti_sci ring config API in order to
be able to support the new parameters needed in the future.

We also need to add support for the second range in RM as along with the AM64
support, the resource allocation is going to change for existing SoC which used
only the first range for resource allocation.

The tx_tdtype support has been also missing from ti_sci for a long time and
the AM64 specific extended_ch_type depends on the existence of it in the message
struct.

Santosh: if you plan to take this series for 5.11, then can you create an
immutable branch which I can refer to Vinod for the DMA patches I'm going to
send soon.

Regards,
Peter
---
Peter Ujfalusi (11):
  firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx
    channel
  firmware: ti_sci: Use struct ti_sci_resource_desc in get_range ops
  firmware: ti_sci: rm: Add support for second resource range
  soc: ti: ti_sci_inta_msi: Add support for second range in resource
    ranges
  firmware: ti_sci: rm: Add support for extended_ch_type for tx channel
  firmware: ti_sci: rm: Remove ring_get_config support
  firmware: ti_sci: rm: Add new ops for ring configuration
  soc: ti: k3-ringacc: Use the ti_sci set_cfg callback for ring
    configuration
  firmware: ti_sci: rm: Remove unused config() from
    ti_sci_rm_ringacc_ops
  soc: ti: k3-ringacc: Use correct device for allocation in RING mode
  soc: ti: k3-socinfo: Add entry for AM64 SoC family

 drivers/firmware/ti_sci.c              | 213 ++++++++-----------------
 drivers/firmware/ti_sci.h              |  72 +++------
 drivers/soc/ti/k3-ringacc.c            |  93 +++++------
 drivers/soc/ti/k3-socinfo.c            |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c       |  12 ++
 include/linux/soc/ti/k3-ringacc.h      |   5 +
 include/linux/soc/ti/ti_sci_protocol.h |  85 ++++++----
 7 files changed, 212 insertions(+), 269 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

