Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4FD30093C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbhAVRGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:06:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44196 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbhAVQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:25:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10MGOAUA034159;
        Fri, 22 Jan 2021 10:24:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611332650;
        bh=WihVx4H0dh4jBYUYMCF/X5rQfD60cLqzQ+3WYdEakQs=;
        h=From:To:CC:Subject:Date;
        b=uAUu529QYIdCZcHBlzO8pRvQ0vqP2gs5p52ctGRtJyz7jOsk/vVO9wBkrhMQ8Hih7
         QCcCCnE1yLEu5gpRzOYcCpNbHRlnGbhz4KyRo20zPKlyVW4NYTOqryWuwiEQoCSXhm
         AZ5ZrxMuxTiUtADA7X4Q1ltE9pZLd6+890MUa4VU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10MGOADE088853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:24:10 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 Jan 2021 10:24:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 Jan 2021 10:24:10 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10MGO59g099178;
        Fri, 22 Jan 2021 10:24:06 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mmc: J7200: Add support for higher speed modes in MMCSD subsystems
Date:   Fri, 22 Jan 2021 21:54:01 +0530
Message-ID: <20210122162403.20700-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches
- adds support for HS200 and HS400 speed modes in MMCSD0 subsystem
- adds support for UHS-I speed modes in MMCSD1 subsystem 

Aswath Govindraju (2):
  arm64: dts: ti: k3-j7200-main: Add support for HS200 and HS400 modes
    in MMCSD0 subsystem
  arm64: dts: ti: k3-j7200-main: Add support for UHS-I modes in MMCSD1
    subsystem

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

