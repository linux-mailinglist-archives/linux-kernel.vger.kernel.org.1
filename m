Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953E62F4ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbhAMMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:00:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39694 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbhAMMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:00:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DBxJhg045928;
        Wed, 13 Jan 2021 05:59:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610539159;
        bh=eUEK69G1k6sHVdIpkBoaIy/oX8qUmyR0wXBF3xfwgGU=;
        h=From:To:CC:Subject:Date;
        b=ah9LYVOIPVahH1kmbYZpSMqKO9pgBmwHK9lrxkb3If98jPdZ0xBSoBUg9qldDGQuq
         Tx0lCakKs4/4d3AwRSTfqOvd9O5GTzI0UJ5b8X6oxeE5jBwmbmXm3N0xD73nytZIYi
         40J0NXvI8X3Q5NS3SKvU86uSHzM976pjodf53FXs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DBxJMT030241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 05:59:19 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 05:59:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 05:59:18 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DBxDdj041723;
        Wed, 13 Jan 2021 05:59:14 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mmc: AM64: Add new compatible string and driver support
Date:   Wed, 13 Jan 2021 17:29:06 +0530
Message-ID: <20210113115908.3882-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches,
- Adds new compatible string for AM64 SoC
- Adds support for AM64 SoC in sdhci_am654 driver

This patch series is a combination of the patches [1] and [2].

[1] - https://lore.kernel.org/patchwork/patch/1361560/
[2] - https://lore.kernel.org/patchwork/patch/1364589/

Aswath Govindraju (1):
  dt-bindings: mmc: sdhci-am654: Add compatible string for AM64 SoC

Faiz Abbas (1):
  mmc: sdhci_am654: Add Support for TI's AM64 SoC

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  2 ++
 drivers/mmc/host/sdhci_am654.c                | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.17.1

