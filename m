Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16C20192E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbgFSRPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 13:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730935AbgFSRPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:15:48 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1372083B;
        Fri, 19 Jun 2020 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592586947;
        bh=+FyC0mh1S4XX7z9Bu1BeiFerSfQCPVxis2shYUF8fQw=;
        h=Date:From:To:Cc:Subject:From;
        b=QDZweeUl/sMm1oC/exF1AxZFPz74hmvE1UK3P4+gxKBOfxa3YpcvC5ZTRrP1a3ZaE
         knb8+kpYwMt3g2MvH33Jm+9s+NBPWxSSl4pOzYZVIJ97dO/3hPjb7MAYA+wCcFDvWW
         BxpG75TKZIRbLQx3YwutyPixN7BDC5sVe70wanO4=
Date:   Fri, 19 Jun 2020 12:21:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] nvdimm/region: Use struct_size() in kzalloc()
Message-ID: <20200619172112.GA31702@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvdimm/region_devs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4502f9c4708d..8365fb1a9114 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1063,8 +1063,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_blk_region *ndbr;
 
 		ndbr_desc = to_blk_region_desc(ndr_desc);
-		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
-				* ndr_desc->num_mappings,
+		ndbr = kzalloc(struct_size(ndbr, nd_region.mapping, ndr_desc->num_mappings),
 				GFP_KERNEL);
 		if (ndbr) {
 			nd_region = &ndbr->nd_region;
-- 
2.27.0

