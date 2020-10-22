Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7E29562D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894840AbgJVBsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33707 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894828AbgJVBsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4ED5C015E;
        Wed, 21 Oct 2020 21:48:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tUHYwtIxaM6ck
        HbC9dCkhEpa/U/JJI5HJTKQyDZ8vu4=; b=po0V6KL+rctLeAnabW1bGG9wZiqUB
        +Son43Jzhs0nU02smfLGWR9G8KJYyhPL64Kc0f7YEHcU9HH+5ZkH0JTYf7Kse5qC
        3K/yKPgFjv4pJtBmB8gP10DxdwKNYy9ynXGXgAbtiMsHZ1Z+reDnKLQcHePcphWd
        ILI83zAVwiEGIkdmA4hJfWIVgEEn78+2Kz9k8w8mKONnvvPkTe6tCM3DKaUlxgmF
        FNMTxPtcM3rMu3zrGvplfGdBj96eLBphPKEudUzAb4ZvsyY3UQRHoGmO+/hYhuR/
        Ogjm64drLjJmwKlBdL+Lyc7s6bACGaySrJWeu3vpMy5dDeq4Mc7KwHdeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=tUHYwtIxaM6ckHbC9dCkhEpa/U/JJI5HJTKQyDZ8vu4=; b=kBOv+hQY
        OoTHIKqzFyT5zF6OIj94OX5OGILIFrqdu68lYoLVDwQq68BdgLgKtAQ32Vs0AzZG
        wFAjRyzm0KVOcD+XnqB1IkHvtQEV6cKwzBOdnsdrAiPhNhSZEpoGec4nOPAh+Fqm
        5GzmcB2povaGhPtlnnSFgFkVyrACgYOh6GzyLz7rUTBnd+9o//lqaXWiqN+U9aMZ
        OG0JK7bmdr37lRTxbABb9O7PYBEcsJLH0zRgDW6O6Btb5s9WbUd0s4mphJllFyyp
        kaLzmv+0ASx72ep+lKJPoME7MzADCB9g5dBvTiVaw2/ewNGGtLHhE4Tr+6b8KBOd
        l+TTLX5xJLL6eA==
X-ME-Sender: <xms:2uSQX50lFhxl-REYddiZ2ZauiXO7lftmRYeo71v8csLooNSSmb6avQ>
    <xme:2uSQXwEu6_VATN0UnFPWRtIjkQcLbATfEGVhYqnTthXxBf2gznDIv_0uMojMtOYZ2
    Usl8NfYf0yshN5Cuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:2uSQX57Uwz4y66tfkDLfu6NMcqfcihec1iyKf_G-I-aHp9_NGn92-w>
    <xmx:2uSQX23n8vTBokcFTjUfsFzphsybiwQ496uyykt72rv2NXEu1EvQLw>
    <xmx:2uSQX8E7GKL26WGd_uhtcxBfx1zkBDp_ry5UrQkYn4H7zC02j3kPcA>
    <xmx:2uSQXwAqAWayPqjMzvy-zIvbkdi0InPVI2uBIkb5GGRqVfv-gQVOCg>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15AB3328005E;
        Wed, 21 Oct 2020 21:48:07 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: dts: rainier,tacoma: Comment reserved memory regions
Date:   Thu, 22 Oct 2020 12:17:29 +1030
Message-Id: <20201022014731.2035438-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some nuances to their address and size, so lets try document
that a bit better to reveal the hole between the reserved memory for the
LPC FW cycle bridge and the reserved memory for the VGA device.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 136ff156a512..802027a3c43c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -47,11 +47,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		/* LPC FW cycle bridge region requires natural alignment */
 		flash_memory: region@B8000000 {
 			no-map;
 			reg = <0xB8000000 0x04000000>; /* 64M */
 		};
 
+		/* 48MB region from the end of flash to start of vga memory */
+
+		/* VGA region is dictated by hardware strapping */
 		vga_memory: region@bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 52f5876c08cf..09b561429579 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -26,11 +26,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		/* LPC FW cycle bridge region requires natural alignment */
 		flash_memory: region@b8000000 {
 			no-map;
 			reg = <0xb8000000 0x04000000>; /* 64M */
 		};
 
+		/* 48MB region from the end of flash to start of vga memory */
+
+		/* VGA region is dictated by hardware strapping */
 		vga_memory: region@bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-- 
2.25.1

