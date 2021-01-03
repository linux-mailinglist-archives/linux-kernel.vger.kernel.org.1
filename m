Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3439A2E8BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhACKbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:31:50 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45179 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbhACKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:31:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0948F5803B9;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=qtCpKCua/JMCg
        qQMUNFRQptKxdAQZ5qnuZ6O8CnTxWQ=; b=aloildomtOaGUcbzMv+/4nyvsCsOv
        HSbodpxK05XxoAR7xLw4X4VKz98TArhHzeYCF1EDifbvNYgpNtZ1gxRUXnQWYgp5
        1jwEMIBpeVPD6cSYjv78EFbHOJf0rehFpvP7ohFthnktJQ0ax3TYQeCWd1vbftOv
        8ShSUkSTiagh+UCp0jEYqy93UpQeuVvWSTsaCjAdbMABKd3UAstHPhjeQKznPV17
        QoeHBJTj3WsZA5o0A4U912sBX+PsZEc1Ff2kRgllgpRvszAC+ptvvxSa6ZT05ucH
        6jn8lKZdHdry56a/Fy3iAmYnSkgeG6didaKE9cv/+trieVwujLQ8DB5/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=qtCpKCua/JMCgqQMUNFRQptKxdAQZ5qnuZ6O8CnTxWQ=; b=En+oUeC/
        KBHQlyfTaiseygZEmhsuC87n3o8SH4W9zjngnrRo5bK1mMn1NEJHAV4MimazKCrw
        Y5P6JEh9Boir5V8Xm/qliTw9yW2kmiNgz2dwdsLqG+UJjeN9bldhrnDPTaNtea2V
        oYdY4Q3HcZ+DKZM/9QCjiCCwTeZApJtC/uLsyH9jaxieexnqLH8/05XKweg4e9VI
        5HiZIp1Xgx5ddkpnaK0dbzWCGP+S8eDWwEp69uLdMKpVoord8OCEtJ53DSRwGbYt
        /J15JcjaMkPnuES1zVVnoq+TsQWh4Y8HmP7pA0OdHXui2jrqH/Fkqvos8KQ7Z33w
        vNrruPx3XCeBOA==
X-ME-Sender: <xms:55zxXz16krd2PS71LsZmboZGIztt8YTFjmntBGv4LlC_hlI0AsViHg>
    <xme:55zxXyH2YqFtdN3rGHL22qKfGjO535uEATGg6ivBKwPUkugoHp4oeWdnmlvFguFv4
    EVy8k99APCPSQVr-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:55zxXz7KEBz3I1HKvLSPiPY_3mQcpdoEWCLVcB3LlQp7bhcFRmPcEA>
    <xmx:55zxX4085YKApPZAsXjBwOAzTO4UaUMR6zqjeYBrf4rOHQQ9_i0YYw>
    <xmx:55zxX2E6QQQxBTgl7HPoR-KfHAhjt6KvsC9G1YtbUjQ8ENvJseNg8Q>
    <xmx:6JzxX9cI83HHp3if4Kwm2_I9k6EugCroT40dGeK5Hbz4ewUO1hX_4A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B1A81080067;
        Sun,  3 Jan 2021 05:31:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
Date:   Sun,  3 Jan 2021 04:30:53 -0600
Message-Id: <20210103103101.33603-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H3 SoC contains an R_INTC that is, as far as we know,
compatible with the R_INTC present in other sun8i/sun50i SoCs starting
with the A31. Since the R_INTC hardware is undocumented, introduce a new
compatible for the R_INTC variant in this SoC, in case there turns out
to be some difference.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../interrupt-controller/allwinner,sun6i-a31-r-intc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
index 18805b6555c2..9de1fb2a63d1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-a83t-r-intc
+              - allwinner,sun8i-h3-r-intc
               - allwinner,sun50i-a64-r-intc
               - allwinner,sun50i-h6-r-intc
           - const: allwinner,sun6i-a31-r-intc
-- 
2.26.2

