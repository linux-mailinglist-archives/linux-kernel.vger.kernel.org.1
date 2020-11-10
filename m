Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369D92ACB10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgKJC2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJC2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:28:47 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F43C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 18:28:47 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 367C8806A8;
        Tue, 10 Nov 2020 15:28:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1604975321;
        bh=9OXKaBwvy5is2HXhWcidySRSEFy37h51UJenVysVcpA=;
        h=From:To:Cc:Subject:Date;
        b=jQFFvHqCfXrfNV0djYhlRoM0F92yCmv0jOzXPJBGWvMVg0ZSFd+xgws8LA0mSmk3C
         vm5rLOu9nyf41dkTtq4BqGmw0dKOA6ZyWLlwjs/FEcfeQPCnMCvGnOJobyI8aBE1Yq
         yKoLj0otz5aUV/JC4gmcb7M5VX5SS2IxsSgLMfgOabN//peb3fi9AWrgqj3vN42Br8
         3zx9jrYqelqYh1fk+VeJlWiM7IwhJeANg97VGen3254mkVAhCWrUn+ceHjRlRoWZUS
         +SnYHwG5XybOCzXz8A4vroROuW5ECa7mNCtd8aIMxP00enjNebz+t04V717gJhTQOf
         kBqC6K+iSIBjw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fa9fad60000>; Tue, 10 Nov 2020 15:28:39 +1300
Received: from evann-dl.ws.atlnz.lc (evann-dl.ws.atlnz.lc [10.33.23.31])
        by smtp (Postfix) with ESMTP id C61B513EE9C;
        Tue, 10 Nov 2020 15:28:38 +1300 (NZDT)
Received: by evann-dl.ws.atlnz.lc (Postfix, from userid 1780)
        id 048B61A4EA2; Tue, 10 Nov 2020 15:28:39 +1300 (NZDT)
From:   Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
To:     frowand.list@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
Subject: [PATCH] of/address: Fix of_node memory leak in of_dma_is_coherent
Date:   Tue, 10 Nov 2020 15:28:25 +1300
Message-Id: <20201110022825.30895-1-evan.nimmo@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dabf6b36b83a ("of: Add OF_DMA_DEFAULT_COHERENT & select it on
powerpc") added a check to of_dma_is_coherent which returns early
if OF_DMA_DEFAULT_COHERENT is enabled. This results in the of_node_put()
being skipped causing a memory leak. Moved the of_node_get() below this
check so we now we only get the node if OF_DMA_DEFAULT_COHERENT is not
enabled.

Fixes: dabf6b36b83a ("of: Add OF_DMA_DEFAULT_COHERENT & select it on
powerpc")

Signed-off-by: Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
---
 drivers/of/address.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index eb9ab4f1e80b..1c3257a2d4e3 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1034,11 +1034,13 @@ int of_dma_get_range(struct device_node *np, cons=
t struct bus_dma_region **map)
  */
 bool of_dma_is_coherent(struct device_node *np)
 {
-	struct device_node *node =3D of_node_get(np);
+	struct device_node *node;
=20
 	if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
 		return true;
=20
+	node =3D of_node_get(np);
+
 	while (node) {
 		if (of_property_read_bool(node, "dma-coherent")) {
 			of_node_put(node);
--=20
2.27.0

