Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6520D159
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgF2SlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgF2SlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:07 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B49023E22;
        Mon, 29 Jun 2020 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593442248;
        bh=gDKtuF0A6hfDiit14A7/Yov8v2HfNSCmyeyt8+0+eyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCTur54R+1pJ4CI1R0qmy0tsYX9dWRdG6udNDxjNfPtpMaRkibKuMb+1Zd7ozVcUq
         hPzBjmrrUF2dGH2+wLRzHyZmjMAyutWUprjwbMTR2cWWEOz1AOhRZUFjyL8NP2qMTk
         KFqrFDuTk9hSgvKB/5n32hYS04vax1H6PqF8ba4g=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] phy: core: Document function args
Date:   Mon, 29 Jun 2020 20:20:08 +0530
Message-Id: <20200629145010.122675-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629145010.122675-1-vkoul@kernel.org>
References: <20200629145010.122675-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function arguments are missing from documentation prompting
validation kernel doc script to complain:

drivers/phy/phy-core.c:1078: warning: Function parameter or member
'children' not described in '__devm_of_phy_provider_register'
drivers/phy/phy-core.c:1125: warning: Function parameter or member
'phy_provider' not described in 'devm_of_phy_provider_unregister'

Add the documentation for these

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/phy-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b54522f06245..71cb10826326 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1062,6 +1062,7 @@ EXPORT_SYMBOL_GPL(__of_phy_provider_register);
  * __devm_of_phy_provider_register() - create/register phy provider with the
  * framework
  * @dev: struct device of the phy provider
+ * @children: device node containing children (if different from dev->of_node)
  * @owner: the module owner containing of_xlate
  * @of_xlate: function pointer to obtain phy instance from phy provider
  *
@@ -1117,6 +1118,7 @@ EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
 /**
  * devm_of_phy_provider_unregister() - remove phy provider from the framework
  * @dev: struct device of the phy provider
+ * @phy_provider: phy provider returned by of_phy_provider_register()
  *
  * destroys the devres associated with this phy provider and invokes
  * of_phy_provider_unregister to unregister the phy provider.
-- 
2.26.2

