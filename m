Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E008F25F5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 10:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgIGI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 04:58:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55126 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbgIGI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:58:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0878wHlO122380;
        Mon, 7 Sep 2020 03:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469097;
        bh=M0Sw270N88O8g6Tf7tN9qgJT3ShUQdNuys/eyfqTLCw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TMD8f3ela9xlxAdoK0026s5U31bNPaFKF+H1cruY2zvIsruB4MlwmV0ea3pFVEo8e
         TnhDgR5Gpq7LOyC59mCbjdpTMAUvtjJJKkdTDXZWVavubMiCFJ1rxOkJAG+ZAIoNzc
         FZJpEWW7FnVHI86IVpOKi2aJFKobYhdCwEmAETbo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0878wH21095027
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 03:58:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 03:58:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 03:58:16 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878wBat040828;
        Mon, 7 Sep 2020 03:58:15 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>
Subject: [PATCH 2/3] clk: keystone: sci-clk: cache results of last query rate operation
Date:   Mon, 7 Sep 2020 11:57:39 +0300
Message-ID: <20200907085740.1083-3-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907085740.1083-1-t-kristo@ti.com>
References: <20200907085740.1083-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache results of the latest query rate operation. This optimizes the
firmware interface a bit, avoiding unnecessary calls to firmware if we
know the result already; the firmware interface is pretty expensive
to use for query rate functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/keystone/sci-clk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index f126b6045afa..b6477b08af04 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -54,6 +54,8 @@ struct sci_clk_provider {
  * @provider:	 Master clock provider
  * @flags:	 Flags for the clock
  * @node:	 Link for handling clocks probed via DT
+ * @cached_req:	 Cached requested freq for determine rate calls
+ * @cached_res:	 Cached result freq for determine rate calls
  */
 struct sci_clk {
 	struct clk_hw hw;
@@ -63,6 +65,8 @@ struct sci_clk {
 	struct sci_clk_provider *provider;
 	u8 flags;
 	struct list_head node;
+	unsigned long cached_req;
+	unsigned long cached_res;
 };
 
 #define to_sci_clk(_hw) container_of(_hw, struct sci_clk, hw)
@@ -175,6 +179,11 @@ static int sci_clk_determine_rate(struct clk_hw *hw,
 	int ret;
 	u64 new_rate;
 
+	if (clk->cached_req && clk->cached_req == req->rate) {
+		req->rate = clk->cached_res;
+		return 0;
+	}
+
 	ret = clk->provider->ops->get_best_match_freq(clk->provider->sci,
 						      clk->dev_id,
 						      clk->clk_id,
@@ -189,6 +198,9 @@ static int sci_clk_determine_rate(struct clk_hw *hw,
 		return ret;
 	}
 
+	clk->cached_req = req->rate;
+	clk->cached_res = new_rate;
+
 	req->rate = new_rate;
 
 	return 0;
@@ -249,6 +261,8 @@ static int sci_clk_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct sci_clk *clk = to_sci_clk(hw);
 
+	clk->cached_req = 0;
+
 	return clk->provider->ops->set_parent(clk->provider->sci, clk->dev_id,
 					      clk->clk_id,
 					      index + 1 + clk->clk_id);
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
