Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1034D1CA612
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 10:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEHIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 04:30:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39388 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:30:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488TxlN017999;
        Fri, 8 May 2020 03:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926599;
        bh=A8DNTnJcqk8/+GneEHgZUdVQxrLDd5gDZ4Q92nAF044=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FeUMsVv9gfqzc5PwsoO7pOUUvI8kH6/1MIQnpzGObLtaAba2PZhsCrp/eEs/B1SWW
         /pBRJ4V6Cb1eti6bRvtpVsMxXR5jnFHqRHR5lAkhogt1H1MjySR+8NJNxN76F73sRj
         Zjw7pL5wD56LYINm+QKwtMOpJRpHWVcisKhHSPMk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0488TxH5118767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 03:29:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:58 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TdnG073953;
        Fri, 8 May 2020 03:29:56 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 7/7] arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR line
Date:   Fri, 8 May 2020 11:29:37 +0300
Message-ID: <20200508082937.14171-8-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508082937.14171-1-rogerq@ti.com>
References: <20200508082937.14171-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Type-C compainon chip on the board needs ~133ms (tCCB_DEFAULT)
to debounce the CC lines in order to detect attach and plug orientation
and reflect the correct DIR status. [1]

On the EVM however we need to wait upto 700ms before sampling the
Type-C DIR line else we can get incorrect direction state.

[1] http://www.ti.com/lit/ds/symlink/tusb321.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 55c98688eceb..8c505904d7cb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -350,6 +350,7 @@
 
 &serdes_wiz3 {
 	typec-dir-gpios = <&main_gpio1 3 GPIO_ACTIVE_HIGH>;
+	typec-dir-debounce-ms = <700>;	/* TUSB321, tCCB_DEFAULT 133 ms */
 };
 
 &serdes3 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

