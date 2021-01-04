Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5853B2E99E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbhADQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:04:18 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbhADQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:04:12 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104FvlpW020449;
        Mon, 4 Jan 2021 17:03:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=w4/gjtHkd2EK3mGDJKe3DGUgymeWaM5SmaC+6x8gEuY=;
 b=anOltMjWWldvqZeeYDe7HesNOJ9BjpnqAX0M1drUPPTlvTdkTeMkKMrr0O+lidWx4NSs
 OKtckD58hKAIJtuH+yz9JeEPwnLLs4FeyMN99IbyKGPrPKE9l7IpjfacP0bH2yIsnaWO
 sBJsgJ6lnv4V0l/U/g3bykYWxIhjXyn/Ea+XcuzzdFw3LLlx4q/S+mxw43QUCYU/velK
 nESCaleMkWQXKzz0FoisWMkYYDsQde8u1b9XACdhNFm96X5QHVpxmZfo8ePeex3X2b3/
 XDEiHITN6dH5v5AVPo4tQaxWfaAqhjSnDbiSTMdmR1I+6R2ByH5ShiUN1Bgyz1JBnmgo Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35tgkmjuyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 17:03:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5BD510002A;
        Mon,  4 Jan 2021 17:03:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CF94225ED1;
        Mon,  4 Jan 2021 17:03:22 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Jan 2021 17:03:22
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/1] mfd: stmfx: remove .of_compatible from stmfx_cells for idd and ts
Date:   Mon, 4 Jan 2021 17:03:21 +0100
Message-ID: <20210104160321.31403-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_10:2021-01-04,2021-01-04 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idd and ts features are not described in stmfx bindings. Remove the
.of_compatible field from relative mfd_cells to avoid having to add
corresponding disabled node in device trees using stmfx:
		stmfx_idd: idd {
			compatible = "st,stmfx-0300-idd";
			status = "disabled";
		};
		stmfx_ts: stmfx_ts {
			compatible = "st,stmfx-0300-ts";
			status = "disabled";
		};
The warning "Failed to locate of_node [id: -1]" won't appear anymore.
.of_compatible could be added as soon as idd or ts bindings are described
and drivers available.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/mfd/stmfx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e095a3930142..b411d2958c18 100644
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

