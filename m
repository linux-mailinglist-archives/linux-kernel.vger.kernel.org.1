Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E93128B41B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbgJLLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:51:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42376 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgJLLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:51:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CBov6Z095345;
        Mon, 12 Oct 2020 06:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602503457;
        bh=/JCUJb6sGAg8bSowlvPoD6xGKRgCiL7WasET+Q4LRsg=;
        h=From:To:CC:Subject:Date;
        b=rax7LHgWzulxN2VgANxO267QYgfrAD9clb+IkavFQE4XTcfinDfSEmHCmmYGsCUqZ
         bQ/oXmLWVp3xGigDJ9AxzczQXfzLsTNKx7Fok5PxRyjStTitjZ+/MKfU68OG6OuklJ
         BjzKgAYtdrhdHBJ+gaoXg8bFOdQbdFX3hv7p9hjo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CBovbx049475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 06:50:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 06:50:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 06:50:57 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CBoswq088613;
        Mon, 12 Oct 2020 06:50:55 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH v3 00/11] firmware/soc: ti_sci, ringacc/inta: Preparation for AM64 DMA support
Date:   Mon, 12 Oct 2020 14:51:08 +0300
Message-ID: <20201012115119.11333-1-peter.ujfalusi@ti.com>
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
- silence checkpatch CHECK for alignment by going over 80 chars in patch 10

Changes since v1:
- Use AM64X as family name in patch 11
- Added Reviewed-by tag from Grygorii for patch 6-10

The series prepares the ti_sci, ringacc, inta to support the new DMAs introduced
with AM64.

Separate series has been sent for the inta irqchip driver (v2):
https://lore.kernel.org/lkml/20200930074559.18028-1-peter.ujfalusi@ti.com/

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
  soc: ti: k3-socinfo: Add entry for AM64X SoC family

 drivers/firmware/ti_sci.c              | 213 ++++++++-----------------
 drivers/firmware/ti_sci.h              |  72 +++------
 drivers/soc/ti/k3-ringacc.c            |  97 ++++++-----
 drivers/soc/ti/k3-socinfo.c            |   1 +
 drivers/soc/ti/ti_sci_inta_msi.c       |  12 ++
 include/linux/soc/ti/k3-ringacc.h      |   5 +
 include/linux/soc/ti/ti_sci_protocol.h |  85 ++++++----
 7 files changed, 214 insertions(+), 271 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

