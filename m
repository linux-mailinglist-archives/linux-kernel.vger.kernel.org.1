Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB71C4CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 06:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEEEBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 00:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:01:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCAC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:01:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so281703plk.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcuOwTL7vWeGU4BHEEgCAhZYtrZvgsB0gLbKKMhZqVM=;
        b=GiPNnuzUK9FnG/VS1XegNdexL4Voi0zdwNKKzBwte2k3acVUCL9EDxBGjFfpHnwGM9
         U3HUEPcRukJqgs/g4K3X1ytfDAtPMZ+zsuhuv2WLphAXSTkov9EC7OsdRqoHK/Q3bYwr
         mwEsCzhKWmouicpjYsefvdkcrfumYNZx1glZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcuOwTL7vWeGU4BHEEgCAhZYtrZvgsB0gLbKKMhZqVM=;
        b=XNEWihuX0WsyvvwA13B0OljyUxs3HHiRwF6tNEUm5XMW7orioStVzXWJpFot4BC8Mf
         zl2cn6EUbnUeOxbbKSLvVs3i69xWmye7mn4rFW2xZZHppn+bjqXBBC6cg6mPLBLUmyKB
         oSiEc1NAHyEe2QSSgcEQlX0yb2ZlU6vU7W6C4PYG2zcMdD/bdc6lEf8R+zk9hVv9l4Bu
         CTaQy38/xlnt2lMvd2WzjZSP9wgb5VIdLmj/aE0z/HJvqCPNOJN0qQRJUQQLt0YcjGSx
         XRDO1viC2f0kr4+dnZaOBHldnTyabuI48Wzw3CfI5MaPNe56FxJ9FWzvFFuhztv+iJiU
         JWaw==
X-Gm-Message-State: AGi0PuaJ9OoFkGozaqMqQecIb+7/E82Elhid0bsFzUVGk1qO156QcPgN
        dQHRH48PzqY+qHYLa7bF2+IOwOc/48A=
X-Google-Smtp-Source: APiQypL9b1gOcDXoI9Aau8wQwRN9YSmxnUKqOC75g2zmvbguz1b03VlXqH1TYxFDmN7LQ4AbJ86ZJw==
X-Received: by 2002:a17:90a:9f8a:: with SMTP id o10mr489319pjp.118.1588651272798;
        Mon, 04 May 2020 21:01:12 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id c10sm629631pfm.50.2020.05.04.21.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 21:01:12 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
X-Google-Original-From: Eizan Miyamoto <eizan@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@google.com>, eizan@chromium.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 1/5] [media] mtk-mdp: remove mtk_mdp_comp.regs from mtk_mdp_comp.h
Date:   Tue,  5 May 2020 14:00:44 +1000
Message-Id: <20200505125042.v1.1.If0cdd88c5399a38cff7163298cc8794f8c40a401@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200505040048.132493-1-eizan@google.com>
References: <20200505040048.132493-1-eizan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fields are not used and can be removed.

Signed-off-by: eizan@chromium.org
Signed-off-by: Eizan Miyamoto <eizan@google.com>
---

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 1 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 14991685adb7..facc6104b91f 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -106,7 +106,6 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
 	comp->dev_node = of_node_get(node);
 	comp->id = comp_id;
 	comp->type = mtk_mdp_matches[comp_id].type;
-	comp->regs = of_iomap(node, 0);
 
 	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
 		comp->clk[i] = of_clk_get(node, i);
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index 998a4b953025..3b83bd6e0d8b 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -38,7 +38,6 @@ enum mtk_mdp_comp_id {
  * struct mtk_mdp_comp - the MDP's function component data
  * @dev_node:	component device node
  * @clk:	clocks required for component
- * @regs:	Mapped address of component registers.
  * @larb_dev:	SMI device required for component
  * @type:	component type
  * @id:		component ID
@@ -46,7 +45,6 @@ enum mtk_mdp_comp_id {
 struct mtk_mdp_comp {
 	struct device_node	*dev_node;
 	struct clk		*clk[2];
-	void __iomem		*regs;
 	struct device		*larb_dev;
 	enum mtk_mdp_comp_type	type;
 	enum mtk_mdp_comp_id	id;
-- 
2.26.2.526.g744177e7f7-goog

