Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52029562F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894851AbgJVBsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:19 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34135 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894838AbgJVBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:13 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD2F55C0294;
        Wed, 21 Oct 2020 21:48:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LeYg3ovVd+ANv
        CklcliZyb+l/2FOsOhdoIPAGLxaS+0=; b=FmwTa0NFUW8gpmahGFfIhNJxJL7GD
        MuxOJdTLH60IAfx/oy55yskb3tpipfSsj6ypKzpmgrNbLMRnI8gS4ko70KQONX6I
        Z+Py5Gnh7PshNXxXLu+kaR5BDzZWiMHFcqjDrRmOvLl422lDJVNbBYfBpBpP97Db
        fmXBpaAgouQnj79xD6vjrZJOQXi8rIvoFEgTwy+hh+Q9MOIDyz0I6DZZPe0cev3a
        edLWH6v2YgidIU+biAWYDY4shT6UMeYMWBQ2jPjDGdQMaz2jg2XAZFieCAjdEXOL
        4P6J8ynCfvBWvNLxAFZi4yhoLZamdbcxWBZsd2LL27tzpqZkalV1HnOnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LeYg3ovVd+ANvCklcliZyb+l/2FOsOhdoIPAGLxaS+0=; b=CPFfekN+
        afoxsTw2ReZK8VXfhXywv35VOu+Lwo9mEuR33aLKjjHotU+l98Iq0JfFFpR98DT0
        1NpsiPNHicP3/FbnlsvLCjL46AmYnNbeG+/yo6P7YfACcZoa7cYTd189e4U/PE8N
        TWvXzKtX3rSgaI7hSAJe1fBf14va63AmIkooDDBCcIXMMUNZV0JIaRI8UC52mAXq
        IKaQRkIT9fe64fbiR1Rj16fZZFexcuwnXrj42QZDSCczU/Au9E77DUPDS87cUTye
        41bJbgbK0c/jNLxaJoZpGRgDO6Q17wBK+y0/X16ZD51IgwyFA2tfEqGriqUu7N1A
        sHq6THzL0ZQ3GA==
X-ME-Sender: <xms:3OSQX-Ue77OQVrgmlVzRil_YfFEDPE1SYZlaVMQFZwvz0md8zzABqQ>
    <xme:3OSQX6kBpMsnzR2GKYHjXgDNyRXs6U2OXMqOcTMFkwkXV3YgaDObe7xURkmfZw8dl
    Pn2pY_weyCEWn-CMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:3OSQXybjfhurgzFq8EQ4GhTOYppzWZKI19BNB-wlF6_KRBheYSDBwA>
    <xmx:3OSQX1VHBlX1WDkz8ahHjGDBLQXChT9hSdB0bOIt_dwO3x7bdtCThg>
    <xmx:3OSQX4mBYow1j71fu2DSDZb4CaG05kEFICHdCmME5d1C7snjz6ESkQ>
    <xmx:3OSQXygtGofrFxFdDKzFwKnO8iKtVmkOSTa8D-oyj-UtRyvlKEZ-Ow>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9A0C23280060;
        Wed, 21 Oct 2020 21:48:10 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: rainier: Add reserved memory for ramoops
Date:   Thu, 22 Oct 2020 12:17:30 +1030
Message-Id: <20201022014731.2035438-6-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve a 1.5MiB region of memory to record kmsg dumps, console and
userspace message state into 16kiB ring-buffer slots. The sizing allows
for up to 16 dumps to be captured and read out.

Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 802027a3c43c..8431cf1b32e6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -55,6 +55,15 @@ flash_memory: region@B8000000 {
 
 		/* 48MB region from the end of flash to start of vga memory */
 
+		ramoops@bc000000 {
+			compatible = "ramoops";
+			reg = <0xbc000000 0x180000>; /* 16 * (3 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
 		/* VGA region is dictated by hardware strapping */
 		vga_memory: region@bf000000 {
 			no-map;
-- 
2.25.1

