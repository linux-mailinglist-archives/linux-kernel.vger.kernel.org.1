Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506EF25F5FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 11:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgIGJFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 05:05:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgIGJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:05:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08795ORT124524;
        Mon, 7 Sep 2020 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469524;
        bh=7Xmk6lpXayxifbxWDMTzPsoQ7nvDQcx+K8eN9dnPFnk=;
        h=From:To:CC:Subject:Date;
        b=hzMqNk5d3168kr9JlDp6XIgjzS7ZKraP2K6uthLK91+lhyPjn9APEgRh4KZRFySij
         BnJZbh/Chi2NZZEDTa0ghyJcNlqOj9F2vMCKkWM7ItApip8qt9yloCC3prxJ86V3qO
         2Lb729no5XC9huvtJ8TTQaCv04m0bQuexOVn8vWw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08795Ouv103426
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 04:05:24 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 04:05:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 04:05:24 -0500
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08795LSn000843;
        Mon, 7 Sep 2020 04:05:21 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Add support for MMC/SD on j7200-evm
Date:   Mon, 7 Sep 2020 14:35:18 +0530
Message-ID: <20200907090520.25313-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dt support for MMC/SD on TI's j7200-evm.

Currently, eMMC support upto HS200 speed and SD card supports upto high
speed speed mode.

These patches depend on:
Lokesh's initial support series
https://patchwork.kernel.org/cover/11740039/
Vignesh's I2C support series
https://lore.kernel.org/patchwork/cover/1282152/
Vignesh's Hyperflash series
https://lore.kernel.org/patchwork/cover/1285326/

Faiz Abbas (2):
  arm64: dts: ti: k3-j7200-main: Add support for MMC/SD controller nodes
  arm64: dts: ti: k3-j7200-common-proc-board: Add support for eMMC and
    SD card

 .../dts/ti/k3-j7200-common-proc-board.dts     | 30 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 37 +++++++++++++++++++
 2 files changed, 67 insertions(+)

-- 
2.17.1

