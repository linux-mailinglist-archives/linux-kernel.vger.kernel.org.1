Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2443629E767
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgJ2Jdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:33:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2Jdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:33:45 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T9XeHY086011;
        Thu, 29 Oct 2020 04:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603964020;
        bh=0DKLNbxPpC2xLEU3GQDsArRERgz+6ZJgvCN7r+UkCto=;
        h=From:To:CC:Subject:Date;
        b=lYOhBFuJilSQJaEzPrvCqWlfaYWQWJ5hqQ71bJ9/nY2mb1r9cY1EAdSuTptyfG5x1
         nxRn2Byy2Na7Y+Rc6mr/wgD2kkPj8i5O1kUJzd6Asmk6yalQdTgKFv9COv4iaisAOV
         RF89NFjMEWmoK4VCzpFlKubz0UAuZExcoz7kMVAI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T9Xe4Q021400
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 04:33:40 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 04:33:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 04:33:40 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T9Xc3J038596;
        Thu, 29 Oct 2020 04:33:38 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <soc@kernel.org>
CC:     <ssantosh@kernel.org>, <nm@ti.com>
Subject: [RESEND PATCH] soc: ti: ti_sci_pm_domains: check for proper args count in xlate
Date:   Thu, 29 Oct 2020 11:33:37 +0200
Message-ID: <20201029093337.21170-1-t-kristo@ti.com>
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
Acked-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
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
