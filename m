Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFB29562C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894830AbgJVBsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50119 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441518AbgJVBsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BC7975C0251;
        Wed, 21 Oct 2020 21:48:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=KWRqHBkl62qlU
        Qq1D9fLvZ7qk2gwM4TwtKPcrOT/zxQ=; b=AO4gLScK1mz+Uai1e01hQs+Z4coKj
        NTTmV8txh/sfPa/MS2UqBs2jPiW8phqg2IwppupC3A0CZVHL9VOdjp82c4y7IURX
        SZxkpB8YpMZ8u5InVqlsLAhC2XxHJu9nPSID7u5vx/OXifZf9T8Nh/xaSnnoYlN8
        BvUshtJ7flarT3qunroQL0vrcvW2NQ0ntTuHpmXoO49vTOSYddRLT4YD/imKojI9
        ByBnfFN5KbPM4nRzuRcn0WW+twuhjmviBTVN4xyro5n5sY87ZrY114ehgq7zfsoL
        dCyNji9VMoj1/0RaAd8vYo2qWoNMGeDVlHlY0okPc3BkE3RirgWGr5xRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=KWRqHBkl62qlUQq1D9fLvZ7qk2gwM4TwtKPcrOT/zxQ=; b=eLSMa+RN
        6KqO2ZIR8z+iIH1YxRNS7FjaUOkTflEAXJE6zGw5RZnA/ryeYjr5uD/omWNxtE6s
        pVCqz9V71FHe2kPMTgHkHO4CkkE/ebDAur79J6Z4uKyC1AWdO8j78aBV0L5Mji+3
        nmd3P5RbNVuvZF5XisIcymqSDzrl2XFJe7TTuSdPeg42qUEDza1OUxg8osqLOC9/
        EtOVi5pH+4sAhxra7nR5VvvllrVIBcOzXGwd3jUNplrg4exzYeDl+zheaqHyeSUf
        2pKsAEr3LfYPk/MFf4mhwVj2ocS+2dXr5Gccm04y3WkGje4CXpAGRQF/vsM7z+JP
        3wRXJpkpJov7IQ==
X-ME-Sender: <xms:1-SQX4UmVRtJ3qi_MOH-MYs81wMduWnqHZroA-vlmPSRvwTCqEQ8Bw>
    <xme:1-SQX8kAb0RKmi9MUS92gGRMLptMSdKPgAXEJS2tdOIZb91Kt2imeSke8SdfyqzyO
    30mu_9DPpXi5NktTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:1-SQX8ZDpNxcVPEuAduVdYboO_INE-pV37ZUFxrS8pnHntFrobynSg>
    <xmx:1-SQX3UrQPr9Vhmq1B-H_ETxHYypJwfM7DptT1OP-NOqjpO9pJ1BGg>
    <xmx:1-SQXyljffZu2jJTyWS5yUc78P2MN2fcojG1kLW1l50LorzTEVw6ug>
    <xmx:1-SQX0gCP2RhTr2SOckYBPuueapZc22ECkzTnu7PcYCQOBi84OxfzA>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95EE03280068;
        Wed, 21 Oct 2020 21:48:05 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: rainier,tacoma: Fix size comment whitespace
Date:   Thu, 22 Oct 2020 12:17:28 +1030
Message-Id: <20201022014731.2035438-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201022014731.2035438-1-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rainier had multiple spaces, Tacoma used a tab. Let's go with a single
space.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 21ae880c7530..136ff156a512 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -55,7 +55,7 @@ flash_memory: region@B8000000 {
 		vga_memory: region@bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-			reg = <0xbf000000 0x01000000>;  /* 16M */
+			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 67ab57ad4d8d..52f5876c08cf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -34,7 +34,7 @@ flash_memory: region@b8000000 {
 		vga_memory: region@bf000000 {
 			no-map;
 			compatible = "shared-dma-pool";
-			reg = <0xbf000000 0x01000000>;	/* 16M */
+			reg = <0xbf000000 0x01000000>; /* 16M */
 		};
 	};
 
-- 
2.25.1

