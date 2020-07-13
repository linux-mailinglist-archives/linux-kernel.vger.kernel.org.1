Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A352188F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgGHN2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgGHN22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:28 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6807D20720;
        Wed,  8 Jul 2020 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594214908;
        bh=+EXzLaIGuNzcggJX4dbRDub2DW6Hh2v4eTzeQDydLkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI3QpP3Bm0o/hSuSs8yvBest+gUB+6Qu+wI6usDJeDMhGsxGiQ+nF8aHL+PeyPWYh
         qeNjehxwUX60U/yvlrDN4nyPXySsVGNUBiz8z4RSfAl4NCfGI6B8DijRcgfn8Kck0d
         xWd1VeorilBau7z4F2KPfLNdS3DxJel3OukP3HT0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Loc Ho <lho@apm.com>
Subject: [PATCH 3/6] phy: xgene: remove unsigned integer comparison with less than zero
Date:   Wed,  8 Jul 2020 18:58:06 +0530
Message-Id: <20200708132809.265967-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708132809.265967-1-vkoul@kernel.org>
References: <20200708132809.265967-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get warning with W=1 build:
drivers/phy/phy-xgene.c: In function ‘xgene_phy_xlate’:
drivers/phy/phy-xgene.c:1618:20: warning: comparison of unsigned
expression in ‘< 0’ is always false [-Wtype-limits]
 1618 |  if (args->args[0] < MODE_SATA || args->args[0] >= MODE_MAX) |

args is uint32_t so can never be less than zero, so remove this check

Cc: Loc Ho <lho@apm.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/phy-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-xgene.c b/drivers/phy/phy-xgene.c
index 7a33ec12f71b..b88922e7de1d 100644
--- a/drivers/phy/phy-xgene.c
+++ b/drivers/phy/phy-xgene.c
@@ -1615,7 +1615,7 @@ static struct phy *xgene_phy_xlate(struct device *dev,
 
 	if (args->args_count <= 0)
 		return ERR_PTR(-EINVAL);
-	if (args->args[0] < MODE_SATA || args->args[0] >= MODE_MAX)
+	if (args->args[0] >= MODE_MAX)
 		return ERR_PTR(-EINVAL);
 
 	ctx->mode = args->args[0];
-- 
2.26.2

