Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D97295628
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894808AbgJVBsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51893 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441518AbgJVBsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BF8935C023F;
        Wed, 21 Oct 2020 21:48:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=luqU3zeZhPRuz
        f7Oj6ClQigdy6Tpo7XXY1y0vnO0Uws=; b=aXxDOnUowGaA4Ht4jhDyWzhn4vbbk
        Goi0ZVTgrYVnMo6L0C8iDiOje9FB9TxhaL0QNIY+PCvhahTSkyWQoU8lEsa4K1nO
        cNPgNyOT/wxPSfzEcU5OSasCkt7iAZY65IL1MId2DqRRTXX+zcweUjFGSw0IReUi
        INVjlBuQLOLgI5emy0gKPKHn9CxjVLcL966AAj8AmZFxWtALZTFA3UqHjVcoMxmZ
        gOj1JHfK6kemrT/EMDAhfgQIi5IOXQia4u8v2PdQ+2vVOK1krgKXYPQv33VtxD6S
        FCBlpXPzr4pNPLcIVRJAAK0ZtwOuQxWl4Olgp11f7Yt0lbGyYPrX8ubyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=luqU3zeZhPRuzf7Oj6ClQigdy6Tpo7XXY1y0vnO0Uws=; b=G7jKyyC1
        3qQKYDpXponYvy13QAHYhu/A8O717VntToU+DrbHNAR2hbRmQCXh5FfHSAuKru0H
        Nhb5G/G9ZjFnIrOU0JLmdprBoSwjOrWIV4Zpexih9nWkuOCWjI1GzrHzvPITrsq7
        VeHkEDCW1SzGxpZF/8JTfmlPlF0Y8syLsX5a2VVgmTt5f5xGNWtaJdW8qtz3tJSq
        VgdmxZvvEswYwPVqUkWHewdhyfDOQgi8NC1XR98xH5CeWEMC+WDNHxBL9/i7NzHo
        8evVDWivjsUVFNE3kkhb5Hi/PAutZn3aNBDLsck6tCAQwAqhLna1Tk6PNV5Hda2n
        pnPPCPrjLgJ5PQ==
X-ME-Sender: <xms:0uSQXydns51EYIEuvcDd7kJGWj4XT55xClawyEaNEQFe4gS65Y-MQw>
    <xme:0uSQX8MR-oVESTgv7MfT2Xq30kHARiiCloqYNGfoe2WUXvqKI37ItfzZOPdbydxc9
    XunkgjcfZmh29ef4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:0uSQXzgakyhQM7AU6rWZOHDOCiKKwSuIZOXm41ttV22WjRt02dCPIQ>
    <xmx:0uSQX__ls3Ck7xwgSrtzs3YaxtIgUPyZUPb9OO_8ievdYyb78Ue7cA>
    <xmx:0uSQX-vLkwJsni68fTz6023W6-Ges-thq_xGOn_PuG1m5aXrIlALtQ>
    <xmx:0uSQXyJiWFS-dPX_a1lhrKKpXbSBDTX6PLnpc8S4lyFaNg8Zo1SZjA>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 987163280063;
        Wed, 21 Oct 2020 21:48:00 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] ARM: dts: tacoma: Fix node vs reg mismatch for flash memory
Date:   Thu, 22 Oct 2020 12:17:26 +1030
Message-Id: <20201022014731.2035438-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mismatch lead to a miscalculation of regions in another patch, and
shouldn't be mismatched anyway, so make them consistent.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 4d070d6ba09f..e86c22ce6d12 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -26,7 +26,7 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		flash_memory: region@ba000000 {
+		flash_memory: region@b8000000 {
 			no-map;
 			reg = <0xb8000000 0x4000000>; /* 64M */
 		};
-- 
2.25.1

