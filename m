Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEE2B49AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgKPPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:42:11 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41583 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730586AbgKPPmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:42:09 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGFXOLI030034;
        Mon, 16 Nov 2020 16:42:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=n4Z6cOmuyWZ3+2oiSgb/gZnSp5m1Rsk8w+tHlYHMIRQ=;
 b=J81fDplMLAklcuf251YD0CY27i4Gl84JgtlMdsk4V6YE5+hvTNUwIzJLyx2XxVC89OvW
 F2wnkFZiw03QEybVDoptibop9geTpSaNKigY3T9E+zSPmFThaRgFdG/sfgrTnZMhgTcs
 701JaX2B2RT5EDHZLA+eOqQlhlKL+T41KjftMKcuLTknsdJeHSn6EcW2/EFkMy8HdVJI
 k9LdbK7DDeXd/X8Fmfc4UVY/WfHvzPHb0TAgUcsjk6IeQRqcGMetb+dYbU2YNBkJhucl
 k49qjmRNGE4PRn0Z85MQheHE03TpLVezJqf82sa1HVmv8JZiaLVY3+r6xvJabOFsOsJH mQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5k4uqg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 16:42:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 372B710002A;
        Mon, 16 Nov 2020 16:42:00 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29461264DCD;
        Mon, 16 Nov 2020 16:42:00 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov 2020 16:41:59
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/1] mfd: stmfx: remove .of_compatible from stmfx_cells for idd and ts
Date:   Mon, 16 Nov 2020 16:41:59 +0100
Message-ID: <20201116154159.4342-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_08:2020-11-13,2020-11-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idd and ts features are not described in stmfx bindings. Remove the
.of_compatible field from relative mfd_cells to avoid having to add
corresponding disabled node in device trees using stmfx:
		stmfx_idd: idd {
			status = "disabled";
		};
		stmfx_ts: stmfx_ts {
			status = "disabled";
		};
Then, the warning "Failed to locate of_node [id: -1]" wont appear anymore.
.of_compatible could be added as soon as idd or ts bindings are described
and drivers available.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/mfd/stmfx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 988e2ba6dd0f..39b2fc952b7d 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -81,13 +81,11 @@ static struct mfd_cell stmfx_cells[] = {
 		.num_resources = ARRAY_SIZE(stmfx_pinctrl_resources),
 	},
 	{
-		.of_compatible = "st,stmfx-0300-idd",
 		.name = "stmfx-idd",
 		.resources = stmfx_idd_resources,
 		.num_resources = ARRAY_SIZE(stmfx_idd_resources),
 	},
 	{
-		.of_compatible = "st,stmfx-0300-ts",
 		.name = "stmfx-ts",
 		.resources = stmfx_ts_resources,
 		.num_resources = ARRAY_SIZE(stmfx_ts_resources),
-- 
2.17.1

