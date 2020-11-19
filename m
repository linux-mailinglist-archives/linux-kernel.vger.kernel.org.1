Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF32B939F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgKSNZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:25:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46066 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:25:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDPcYY072645;
        Thu, 19 Nov 2020 07:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605792338;
        bh=FGWnD7A2xzMjkl93n7jynBlka7l9OpV8ffZzkxm0Fc8=;
        h=From:To:CC:Subject:Date;
        b=UAa/Ygt1wjcSkX4YU4YiflGbEI+UIFkD4o3t2PC/V8nlaqUdoFcWcJLWSd9ZoWm9D
         HhOBrEhoxN+nWgRxUn8IyZ4F300G90zvpIg6KkGwAad/qFT0TLpRLHnSgJQSaW/0N4
         15nzJvWd8jxuY9Qv2HSWBE7VgnCX49ym1obytuv4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJDPcWd130399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 07:25:38 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 07:25:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 07:25:38 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDPZhe038667;
        Thu, 19 Nov 2020 07:25:36 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <vigneshr@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j7200-som/cpb: Correct i2c bus representations
Date:   Thu, 19 Nov 2020 15:26:25 +0200
Message-ID: <20201119132627.8041-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

 .../dts/ti/k3-j7200-common-proc-board.dts     | 16 +++---------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+), 12 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

