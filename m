Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F076295634
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894859AbgJVBsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:48:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50699 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2894844AbgJVBsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:48:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 41CB55C03E5;
        Wed, 21 Oct 2020 21:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Oct 2020 21:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=2iPeJ5v2usE/A
        Ob5Lfmq4TFbvL2qVWuNftG6FVML1KQ=; b=aNj5dml9ERzAUrgJkhwS6HJxmxs3n
        iRFiP9SpbX8QJNeP8ilTU07Nilbk9kLXtTcWg4rvfiWWIzJtW2iMmSz6tNtpmR8n
        ozo12CNgfqD6TffR+MLmCTc4BRNke2vcDzc4FEz0JLqXNfR69JPHysJF0O/ANaPa
        lfI4Lv8lxwyggpagsHGm6fUZInL2fsW+Ze3MVGE/+2mahRM7OJqLpnV2OoLVN+uZ
        D4idObrz5hT2f1v76EyiSdwU3OpNxo08uncHgApLVnTuFTqNfw5Rhqxn8tM67r6+
        f47NU41Ui64VqjDK3BCc78X1u23fhEl390QiOB9Jl/f/1WsJlGmRNnAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2iPeJ5v2usE/AOb5Lfmq4TFbvL2qVWuNftG6FVML1KQ=; b=oCuPdhk7
        1m772d267HfdYOteUufdoTrlkwAVRJS7P99/fCaHPgwodTsxtuF3oVROSZDUXGKg
        3ajiBYWkdb8VPTEgs0gITKZXw3vSuc7GvjfrNTrPOc753IlugXuEfmoeRY1eO01J
        Nb78KNX07PUj5UEr8GyMeOgugiqde4G5Y+lxFpH5vMCzMRzzrEHssBeBMKPYJQCo
        l3qC7J1RWwFvsp2a5xDMCjH733wGLOQAWjW2RsQq9MFMoMwYl3+0WPFJM9H0OdqC
        4gQk2oLu7wlNTtfAZQfe8XdhPYvjkUiLm9/lZd1skKFkCjkmTqe2j4VNiJODsgH2
        Yz42Sd2DwuFGUA==
X-ME-Sender: <xms:3-SQX5FmVEVAqmXRojHKVwQO3ZlN_8gPzsk7avUKuUc85laz36ASRA>
    <xme:3-SQX-UNuOw06vsCUneHXAGhnzh3hKxg07JiJyRjIRG6_v5Wc-F1xqfDTc_B51Sbg
    XEIAI_J4XBA72tsHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:3-SQX7IAVoP0sD0-TbZreWQ-Gu5yUeu1y2FicQmCHU5mu5rsmo4r1g>
    <xmx:3-SQX_GjOXXgb1b0RMYH44ZFv9hN7mcRjHb9eQAOfJjyNAI8q2aTpA>
    <xmx:3-SQX_UXRQ-k3U1rsxQmdZr1lOesNKV2JTjEhh-ujZ2r8N2HX_7vTA>
    <xmx:3-SQX6REAfO2fhkx3aFIb98Dreup-YMuBosnelsmSK-4ZKK3Dyrg5Q>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1A2A23280060;
        Wed, 21 Oct 2020 21:48:12 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: tacoma: Add reserved memory for ramoops
Date:   Thu, 22 Oct 2020 12:17:31 +1030
Message-Id: <20201022014731.2035438-7-andrew@aj.id.au>
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
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 09b561429579..04efabe70d9f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -34,6 +34,15 @@ flash_memory: region@b8000000 {
 
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

