Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946DD28FD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgJPEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:36:17 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50519 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbgJPEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:36:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2F111F7C;
        Fri, 16 Oct 2020 00:36:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 16 Oct 2020 00:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=q5CcFs0/EeK4z
        qujRNpYgO1/SVfarI39TTpxy4dUVj4=; b=GeNCDmRcFtRvHTY65800D84wSQ/tN
        C2K9tBarEU20jxdNxGU1YT0yfiboFqUc27KYfP8A/pI1oYHaumahz13cE6YYHVDt
        ud8CRg2KXLUVj1jvTJ2pWP4JHT5YSQQdVvskgsrqhTVqfo/rSfrv3y3bY/4QnN+c
        I6Vlq2ow4RDKhwJgClhb6/uUiaqEb/27DYLEYnfzHHsnnvYLYHmylWqug8L6CdpG
        wHW/XxCGXeFbOF9zJEtMAgMCt54519hAl2EO5VNnbIgsnXulzkw5FH4f/hUrHDhK
        5gKDsJXt7KXy7nmfh5xvxKPWoed3ar9zOiAPVHptq630IouwyoQ19FOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=q5CcFs0/EeK4zqujRNpYgO1/SVfarI39TTpxy4dUVj4=; b=RkGOo10a
        prlpQDsEtITzU28aulICJabebvl+tRkD++XKcU33Y4tYPldLrRXAWHV0aB5i1HL4
        Bx3E3qMIpNBc44eGvWZWGFubprdNJ+63ip22ZD47io9TR3PFSFbll0Nr4oycDJUH
        D7zYoXqocv8cvWfOg5kMpWHiivhrQaTwaodT4C+QR3RIxoUHGdJlOO8D1t8FXOjM
        IUiVVMqRz/HyxdCzDgXSoY/OQ4McPCYb2uZp1penNwA0aI/yynhi1GG90yPHuJWk
        hmDuJdQ+41cbuWF+dvkx+hdENXXfQe51FfU1GIEq6Ey100tzJKfWfYkiSCa8SnUV
        Ehn0jV9XF9zAlQ==
X-ME-Sender: <xms:PiOJX_HyUCi6MLicTk9QEVT3tiBXL2p3aqOVV0CfTzORJ6FX2Kpb9A>
    <xme:PiOJX8US3iCTa3vCDb7VjLExJarRw-Yc9fktvygRhi7HhmkLgw4HrApJnq5q2vTZl
    NoOX-PmEeGJtRTXhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucggtffrrghtthgvrhhnpeejgfdvveehteekveeggeellefgleette
    ejffelffdvudduveeiffegteelvefhteenucfkphepuddukedrvddutddrjedrudektden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurh
    gvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:PiOJXxJUZ546BfkYTk274Wwf3Wy35e8HcncIxmE8mUTmaKGKJbiUyQ>
    <xmx:PiOJX9FjAqlJoGOPUuxeP6sgJrVxKaqs1turw1VhAFxGVqCYrm9WQQ>
    <xmx:PiOJX1UKoprl1Swr46gU6cZgTlsFQumDFJuOGRUzrdVnwZJTgHF-bw>
    <xmx:PiOJX4QzPuPsCa5fITZUUDi4wRrDwhtNzhD9jDP8GAPf7gPsBpZHkA>
Received: from localhost.localdomain (ppp118-210-7-180.adl-adc-lon-bras31.tpg.internode.on.net [118.210.7.180])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46D0B328005D;
        Fri, 16 Oct 2020 00:36:11 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     joel@jms.id.au
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rainier: Add reserved memory for ramoops
Date:   Fri, 16 Oct 2020 15:05:12 +1030
Message-Id: <20201016043513.119841-2-andrew@aj.id.au>
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
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 183e1a4dcc65..89729ee698c5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -47,6 +47,15 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		ramoops@b7e80000 {
+			compatible = "ramoops";
+			reg = <0xb7e80000 0x180000>;
+			record-size = <0x4000>;
+			console-size = <0x4000>;
+			pmsg-size = <0x4000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
 		flash_memory: region@b8000000 {
 			no-map;
 			reg = <0xb8000000 0x04000000>; /* 64M */
-- 
2.25.1

