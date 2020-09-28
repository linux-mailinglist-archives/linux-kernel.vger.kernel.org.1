Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116FB27A998
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgI1Ieo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgI1Ien (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YeQJ080100;
        Mon, 28 Sep 2020 03:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282080;
        bh=44o30+qhpVj56QwrPlfO9h5ONdeSyaYUVH/XIVq4hEo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mskCmNe2C2xI0QdYBrlNI73gwYb3KsB/zdB00/qwLyJ47yY7KGMJp9z7KQpco48s2
         4N3Bv48FtaU4iHneCAo7TnyAUvonbb2qcH1N0o4WmkcPgySIZ4hUASoaAdshNnlEFx
         9WSfOEtKkhwC/I8U4Ji5oju9bc67fhHz1aXWy4b8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S8YeQn124620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 03:34:40 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:39 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEac065485;
        Mon, 28 Sep 2020 03:34:38 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 11/11] soc: ti: k3-socinfo: Add entry for AM64 SoC family
Date:   Mon, 28 Sep 2020 11:34:29 +0300
Message-ID: <20200928083429.17390-12-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928083429.17390-1-peter.ujfalusi@ti.com>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's JTAG PARTNO is 0xBB38.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index bbbc2d2b7091..a14ec68846dd 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -40,6 +40,7 @@ static const struct k3_soc_id {
 	{ 0xBB5A, "AM65X" },
 	{ 0xBB64, "J721E" },
 	{ 0xBB6D, "J7200" },
+	{ 0xBB38, "AM64" }
 };
 
 static int
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

