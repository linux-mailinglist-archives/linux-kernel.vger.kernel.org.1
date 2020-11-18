Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E182B7AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKRJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:50:49 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:21176 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727239AbgKRJus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:50:48 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AI9bmiO022642;
        Wed, 18 Nov 2020 10:50:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+/gZAL0MrUBzalz4QD2SQpG9SHBO/HQD8Qcgh8K4Bwc=;
 b=IHQ43MdbVMwhOt1Dn8WskVv7lywZrvzDMmeh3pqhaFkOoUAt/hqc7hsU0DN39pT8xHmK
 vgR7CA9K+9y6rAdIzdCw4XCx3NdoCErD/lvPIHfmQ9Dbwj/S2aQdtK49nPQ1aYsHkj4v
 bujd63Az1O6hkWz2cuJI1GmA7cp5WYGJtsA3yPT3s+YaaKCA/HhNrv163KWCIgHU6rc0
 xqRVTQELzzZXGbkeenHXnECuyoG5hK1G0lUm+ygqaU2etije4kqxzabFlPD73ua1LYHW
 7vW8rbmtLS5JX9UmxtcCCTUxfm0S4cheDWMba0XGdilDDSGhqi0KJUGNNt16kQlYDUkP kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w1ybe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 10:50:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57B16100039;
        Wed, 18 Nov 2020 10:50:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37F65246E6C;
        Wed, 18 Nov 2020 10:50:18 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov 2020 10:50:17
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux@armlinux.org.uk>, <shawnguo@kernel.org>, <olof@lixom.net>,
        <alexandre.torgue@st.com>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <amelie.delaunay@st.com>,
        <aisheng.dong@nxp.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <christian.gmeiner@gmail.com>, <enric.balletbo@collabora.com>,
        <lionel.debieve@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx support
Date:   Wed, 18 Nov 2020 10:50:11 +0100
Message-ID: <20201118095013.16094-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 SPDIFRX and DFSDM audio support to multi_v7_defconfig

Olivier Moysan (2):
  ARM: multi_v7_defconfig: enable spdifrx support
  ARM: multi_v7_defconfig: enable dfsdm audio support

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

