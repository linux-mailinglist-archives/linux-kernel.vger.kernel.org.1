Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793C628FD5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgJPEgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:36:20 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49385 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbgJPEgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:36:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EF479F8E;
        Fri, 16 Oct 2020 00:36:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 16 Oct 2020 00:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=WXebYGUOxo1OO
        laEW5dDl3iLC0qxgbnBraqL8r8/PQA=; b=ibn3w8QeOpGy5z6YxsRL4s7DugbjY
        pcC2qXS0x5AsdKtiQZLbSoKE1TEDOz898Q7UwmaK5Xx4v9btkkqAeQ6f6TLIctm7
        6iL53dDQjmBt0p3dX6hTXBcqDJfJuGGyeZBHQT2pBjeAbmGOrxhYSVfnahvEPVBi
        egHW3ZYOQlkUXjy+xpfQ3psulga+ShRzdnyjiFe19RsXxzhIR5r9bgJguXOUjCNr
        pB2W7n9m9rue2Z+funoiLx66P+RGBXJJTfQRTSC6aZiEZNWq5r8sX7so0h7Qmxd8
        +iXJ6aCLI9zAGochRlwiJnz2jk/TUFz/TKWpTuhZZv4DSYkYHDDXYaU3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WXebYGUOxo1OOlaEW5dDl3iLC0qxgbnBraqL8r8/PQA=; b=W7ay5OM4
        gZTxeKzs4zVaV3+LIL+QVsxtM055iwA08B2HcOxuHX3M5V2n/XDs9eizH0waIVyr
        P19cfSmTT2CMMnXSjEdg3w1HmrYLcYdFT/l7mHkxdgFwNRJF/2M+fPr5qwHxoUwW
        +myVNM/kS9gJoV+faPRbvW/COMkNCMJYAu7GAjhXixe0qHS5WYIMk1q0l/FAY3dS
        02pcsGCp5D7HzKZu7nEIvkE8BPhegMSuyNo8Qij9/GUJM3hCrNanfgAJhjWuRosu
        RRzVEe3FyLh40s5Tlnoi6Ic+wuRoJI6b6kvke/YcU1QEpmFCXpcR7YiI45MEIyJg
        AHdsOQqAEn/aEQ==
X-ME-Sender: <xms:QSOJX78dpbHmPOvuwIKe81TMf_JpNMDxBrJ83RWb05HRGfNql80acA>
    <xme:QSOJX3tgEVJjzPV1-2RuDascabuw5eYzty82KAVzTrPLnppPERqlX4TbfZpBJVDW8
    up2w4wJQsuW3s_Sjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:QSOJX5Du2CDI9BOqQJ92pP72W5hVtXySe9rS9M6LFNiLX4atifAoHg>
    <xmx:QSOJX3dfVvSj67SvFIVgHmmgRfyVBkd9CyoAfpPh5KYVrf6ejOEXGQ>
    <xmx:QSOJXwNUgxLzj1IQkwpuXdlkuEaUxgj4jMvxEUc6JNyAkHIarLdjww>
    <xmx:QSOJX1rzA80USFqw2VPqb3NjxQpT1Ny0284pluUMw6K-HW45yIneAg>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3F7483280059;
        Fri, 16 Oct 2020 00:36:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: tacoma: Add reserved memory for ramoops
Date:   Fri, 16 Oct 2020 15:05:13 +1030
Message-Id: <20201016043513.119841-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016043513.119841-1-andrew@aj.id.au>
References: <20201016043513.119841-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve a 1.5MiB region of memory to record kmsg dumps, console and
userspace message state into 16kiB ring-buffer slots. The sizing allows
for up to 32 dumps to be captured and read out.

Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index 46f2f538baba..4f7e9b490e1a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -26,6 +26,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		ramoops@b9e80000 {
+			compatible = "ramoops";
+			reg = <0xb9e80000 0x180000>;
+			record-size = <0x4000>;
+			console-size = <0x4000>;
+			pmsg-size = <0x4000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
 		flash_memory: region@ba000000 {
 			no-map;
 			reg = <0xb8000000 0x4000000>; /* 64M */
-- 
2.25.1

