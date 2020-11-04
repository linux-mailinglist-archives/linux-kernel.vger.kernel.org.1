Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF032A6526
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgKDN3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:29:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgKDN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:29:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4DT7jD023843;
        Wed, 4 Nov 2020 07:29:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604496547;
        bh=VyXzrj8SZbEcgTrywPh+SdjvXOZbOrTayaQZU9eC4Uo=;
        h=From:To:CC:Subject:Date;
        b=I1wXyqopIDnmrYiJLFZh9pyCtf2KdCf/a1c/k9sVr7Xu7gR8M3Tq/FkfQx/oX6JP3
         58osOirgfKsF6o7+eC0uP8+lhvhMAcuRq3znJTeOJgo2k+hTHmyxcnScZbPeIzAbd/
         P+RWqMld0c736wOKWYPIOqu+Xr1fVSZ8jeqgbFkg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4DT7vk095561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 07:29:07 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 07:29:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 07:29:06 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4DT3nE024388;
        Wed, 4 Nov 2020 07:29:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: J721E: PCIe/SERDES DT Fixes
Date:   Wed, 4 Nov 2020 18:59:00 +0530
Message-ID: <20201104132902.20377-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series includes 2 DT fixes
1) Fix the maximum number of outbound regions
2) Re-name link name as "phy" as commented by Rob in a different patch
   [1] and the YAML schema posted in lkml will check the subnode as
   "phy" [2]

[1] -> http://lore.kernel.org/r/20200909203631.GA3026331@bogus
[2] -> http://lore.kernel.org/r/1603898561-5142-1-git-send-email-sjakhade@cadence.com

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721e-main: Fix PCIe maximum outbound regions
  arm64: dts: ti: k3-j721e-common-proc-board: Re-name link name as "phy"

 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

