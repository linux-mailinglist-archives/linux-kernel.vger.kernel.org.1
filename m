Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906F823A2EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHCKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 06:53:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38834 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCKws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:52:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073Aqe5i097193;
        Mon, 3 Aug 2020 05:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596451960;
        bh=LJ1OPnlok1eseLvoRq3pBBp3ohTqpcbukbiI05bOI0g=;
        h=From:To:CC:Subject:Date;
        b=T7VsBYVpp2uMU8wIiMzQgzknB2lnKlu6IYdlCLF/vhyFiGVph3dy6YjKg6T7GWIXE
         n9IwdtHSnBEcFu1vRyt/eFzOMbXuZct6IWONCpsi+V9aD+SKVaAYxHNqux0f7AuYGw
         i0cVmxcaC3srxMZKq3UCzhd0rG3ERmc2GDXbdLWc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 073Aqdat025761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 05:52:39 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 05:52:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 05:52:39 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073AqaiF118231;
        Mon, 3 Aug 2020 05:52:37 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>,
        <t-kristo@ti.com>
CC:     <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>
Subject: [PATCH] soc: ti: k3-socinfo: Add entry for J7200
Date:   Mon, 3 Aug 2020 13:53:59 +0300
Message-ID: <20200803105359.16744-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update K3 chipinfo driver to support new TI J7200 SoC.
It's JTAG PARTNO is 0xBB6D.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index af0ba5288e58..bbbc2d2b7091 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -39,6 +39,7 @@ static const struct k3_soc_id {
 } k3_soc_ids[] = {
 	{ 0xBB5A, "AM65X" },
 	{ 0xBB64, "J721E" },
+	{ 0xBB6D, "J7200" },
 };
 
 static int
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

