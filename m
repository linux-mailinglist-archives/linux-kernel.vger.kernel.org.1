Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBA29DC17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390760AbgJ2AVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:21:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50560 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgJ2AVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:21:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09SEH39C119934;
        Wed, 28 Oct 2020 09:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603894623;
        bh=ZMzoURT89dilnEcrR2L4rMYixQ9EzHGDs4HsKQ9J4g4=;
        h=From:To:Subject:Date;
        b=TUhJocUZldCgVasI0BJe8O1fc/ZnFXCjc4AYzZgUjoVAa6gNWmkDtFf1vaHDi+jT+
         MNxckjNLVS2mgXlqG2pZSVKsCrOQCyOwlUBJxPiHRDbADq3d/rY2hQX/ir5lZLtqcc
         YtV/gkqEclwNLAhRfeMT+9pQzLUQLkNuqhT4HChk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09SEH2Qk063291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 09:17:03 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 09:17:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 09:17:03 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09SEH1Fp085604;
        Wed, 28 Oct 2020 09:17:02 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <ssantosh@kernel.org>, <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: ti: ti_sci_pm_domains: check for proper args count in xlate
Date:   Wed, 28 Oct 2020 16:17:00 +0200
Message-ID: <20201028141700.10510-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2G devices still only use single parameter for power-domains property,
so check for this properly in the driver. Without this, every peripheral
fails to probe resulting in boot failure.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Reported-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index af2126d2b2ff..8afb3f45d263 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -91,7 +91,7 @@ static struct generic_pm_domain *ti_sci_pd_xlate(
 	struct genpd_onecell_data *genpd_data = data;
 	unsigned int idx = genpdspec->args[0];
 
-	if (genpdspec->args_count < 2)
+	if (genpdspec->args_count != 1 && genpdspec->args_count != 2)
 		return ERR_PTR(-EINVAL);
 
 	if (idx >= genpd_data->num_domains) {
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
