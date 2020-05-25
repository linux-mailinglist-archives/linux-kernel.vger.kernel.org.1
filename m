Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6D1E05D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgEYEMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 00:12:46 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53583 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgEYEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:12:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9DA91580090;
        Mon, 25 May 2020 00:12:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 May 2020 00:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=KItE/umB2E4IQ
        3k9ieRZkw7YzrbUp3ZSlvt5X/bA8qs=; b=nFR0dsScrHADLEKAwtEfNHfHDq8BL
        b16/ceAicmrWBhOOl/qc8+BAKoC8flNG6l4T7BcQfox6HLU27VCI88BdhY0Iwkcr
        qYKHG3bUcjfC+TtjH9ADJjKHUcx3hglZ1fpFxgdpF/6OBGDbTKhQvW+9xvOfP58K
        4j+oCtlaS0lEVsLyRUUz+AQN4i66J+jyeUe3jCoeRQx9qapu1btJEqLAL3fpPm+H
        7uUoqMaRAwpvErXwZw95IAkMtwRznbfT16/UNBjBMoUr64TR+uhKu+7Nhua/mFBZ
        XEImZCqrdEoC4LuAg/pilk0qQgt/PWjzA00J0F72L+oa+uOWiwVbbptjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=KItE/umB2E4IQ3k9ieRZkw7YzrbUp3ZSlvt5X/bA8qs=; b=aIJaD5gu
        /uwn6ZB0pYKyP1MvFzOkgzxcKqKarzxYp1ywQH2oDrZWEioLt2kDaEIStaLQBbbW
        bfBv6ynRTcUP9IlU7IfFZ30XYaeG6u0aL5QHxyAXvMnj+XiNF2DBYepfd1tSQPLm
        bYTGozXrjklSB4Vi/z0DS+6Al8KrwTBbeoY5TwgHGL43YxJaqt0tZsSuLiOnTPRT
        4YkE795boUlFjzaiaFN+vpzYPsKLY8YlmoO0w4OOdl+zA9Gw+C/TKWXn4qS23C4F
        J7Fpbc4Nz8lIfXY7sfPCcsnX251IGhYFsUYr2fF0vqAetIqjK27Kw1h4ZZjI6fqa
        vEg4c0cGzs+1hw==
X-ME-Sender: <xms:t0XLXqB4kNvDLbXD6CoTnJo3rbHanhdxoZfjNpR2oqkChAhHGPKxBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:t0XLXkg4WYQveJ-QjGazGnb36PfgTrmerVESIkLppO6YuR7uhJ9O8g>
    <xmx:t0XLXtn-TcwRIPF3L-7-mF8Ck42KGPowql0HFsGbD2YJGvUtiSQWWQ>
    <xmx:t0XLXozkG3P_62II_i5rM6duqUW_vv6PDE3PWj0cbp8GQtnYhz8JSw>
    <xmx:t0XLXkJTrxjE5KfFT-IihcBEkX0V2X005LHg3SZUD8i35WBj_--Fnw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E7E523066544;
        Mon, 25 May 2020 00:12:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/9] dt-bindings: irq: Add a compatible for the H3 R_INTC
Date:   Sun, 24 May 2020 23:12:56 -0500
Message-Id: <20200525041302.51213-4-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200525041302.51213-1-samuel@sholland.org>
References: <20200525041302.51213-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
 .../allwinner,sun7i-a20-sc-nmi.yaml                  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index cf09055da78b..973fe5d17af0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -26,15 +26,13 @@ properties:
       - const: allwinner,sun6i-a31-sc-nmi
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
-      - items:
-        - const: allwinner,sun8i-a83t-r-intc
-        - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun9i-a80-sc-nmi
       - items:
-        - const: allwinner,sun50i-a64-r-intc
-        - const: allwinner,sun6i-a31-r-intc
-      - items:
-        - const: allwinner,sun50i-h6-r-intc
+        - enum:
+          - allwinner,sun8i-a83t-r-intc
+          - allwinner,sun8i-h3-r-intc
+          - allwinner,sun50i-a64-r-intc
+          - allwinner,sun50i-h6-r-intc
         - const: allwinner,sun6i-a31-r-intc
 
   reg:
-- 
2.24.1

