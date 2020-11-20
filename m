Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4568B2BA35D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgKTHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:34:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40522 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgKTHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:34:51 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7YirX046965;
        Fri, 20 Nov 2020 01:34:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605857684;
        bh=3GvLPMFXelZ9pmLfnzNAJkXMA/hqqG8mfS0ZD1F81uo=;
        h=From:To:CC:Subject:Date;
        b=Vq76LfIzq9MevsKHZ77m3p8jvJhteMvnTdT0OR/ANbsWbZ9PYkOx2XUV61Ow88qgj
         nUVFWTR8bmKRLXey6DKmDtHtk6q+qPqKXV9c0JpKMwflUf6Nli+7v+Dzms4rBS9oFL
         j+V3rs9iqPaD1x9vM9w1szk327Ov9Py6loT2P2mU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AK7YiUC092659
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 01:34:44 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 01:34:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 01:34:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AK7YftV089749;
        Fri, 20 Nov 2020 01:34:42 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j7200-som/cpb: Correct i2c bus representations
Date:   Fri, 20 Nov 2020 09:35:31 +0200
Message-ID: <20201120073533.24486-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
- Added REviewed-by from Vignesh
- Comment block to explain main_i2c1 connection to CPB

The main_i2c0 missed the ioexpander present on the SOM itself to control muxes
to route signals to CPB connectors.

The main_i2c1 of J7200 is _not_ connected to the i2c1 of CPB, it is connected to
i2c3, so the devices on the CPB's i2c1 bus are not avalible, but the ones on the
CPB i2c3 are available under the main_i2c1.

Add nice line names at the same time to these.

Regards,
Peter
---
Peter Ujfalusi (2):
  arm64: dts: ti: k3-j7200-som-p0: main_i2c0 have an ioexpander on the
    SOM
  arm64: dts: ti: k3-j7200-common-proc-board: Correct the name of io
    expander on main_i2c1

 .../dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++--------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 26 +++++++++++++++++++
 2 files changed, 37 insertions(+), 12 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

