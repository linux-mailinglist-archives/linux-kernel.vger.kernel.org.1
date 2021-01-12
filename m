Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0C2F281A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbhALGAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:00:39 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47321 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730785AbhALGAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:00:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E62E9580557;
        Tue, 12 Jan 2021 00:59:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=YM/SFhIYDAsqt
        Disv/0hlIbi5xpPsvsMGJrDwmkyBZc=; b=snd8gkSRp4qMF1yj0Hrv6+APbtV/N
        HVzP6te1UIqxU6MBAIRhC0HZeKXAYoIouWBudB4Dg6KEzsLdBaOYHdkIy70zFbPj
        ZBFmFss+o6dZs6c5qgXIrje4aPJVgbaJ6ZHVKd703ogI3s+zcXEp3SmBhh2hgev4
        MQnC4ZGQVtytBAotiyLrjbZFp9Hsl1jBps87EPLI6bB8S9eJ76af3/ZBOmNDlZR3
        gYPGTPKzfSWuGJxUqxjRJ8SiuK6Le413grB9ULYqSHCk80rtrFVAI/h8iHzZWWtq
        LK1Bw9WUpPddYPKEYFsCq+epxBreqAv3/6M6E1eY1+nmttdrTTp0PUz6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=YM/SFhIYDAsqtDisv/0hlIbi5xpPsvsMGJrDwmkyBZc=; b=Ydf4Xm5c
        3gukaazBOopUHp05WV377dPGiqgmWONRXg/rhUgHM2ISdsK73pE9bfLmHiuvQcBs
        5oT6LwOJ+mAfHw6C3hNcEtFXwzqHGniHgd1qmASwmNHCCBPe9hgHIWJS/yyEP6Gi
        lm0v/2bxu1WONn4P573jNlGC8jHfdWL+HVYkAeC2oURFPCU5wYdmLeeCysYHBHoE
        HftlKwl3RmjDL01ZGUI/cVN8dXxmbaJDu1U4vW87+8sfFIGhHpzYvMNhWaTZqDZn
        hDd7zEUXKszswMy8jJtxSomqgL4+Gn59MHUXiD/nIsgkqOTVOsp1fZdwokPO1pBM
        ycu5ZmYeKb24CQ==
X-ME-Sender: <xms:2Dr9X3JrqIiX07SJneuGXCdYuvkvuV4LXbuDHpxW5-GRssT0G7GjRg>
    <xme:2Dr9XykjKBtvwNDCQcvx_0XIGFg37BRdz4ybulbSP0v7atpQuZAQwAhR70fbuoWXH
    cobFHnuWi3vz3xPbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2Dr9X9HW98uHW29SraW9Rr-x1EH9Sgre18rJqXdgc00H77W7GtP7uQ>
    <xmx:2Dr9X6HA_LLKurjgSFBzxGdcEQJs-iOtt5gTWLozzcWr7l2_fzqoJQ>
    <xmx:2Dr9XyMmfOf5d2cBC9-rQ5BXUoJkcxld-jXwX4h7VJ6izJT1Eb6lsw>
    <xmx:2Dr9Xy7Aap1c27ggh2oaK_rggtBKEETW7vAjGlu3UiOXxJiP9R_7rw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E9C024005B;
        Tue, 12 Jan 2021 00:59:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
Date:   Mon, 11 Jan 2021 23:59:42 -0600
Message-Id: <20210112055950.21209-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H3 SoC contains an R_INTC that is, as far as we know,
compatible with the R_INTC present in other sun8i SoCs starting with
the A31. Since the R_INTC hardware is undocumented, introduce a new
compatible for the R_INTC variant in this SoC, in case there turns out
to be some difference.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../interrupt-controller/allwinner,sun6i-a31-r-intc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
index 50e607e607c8..4db24b8a9ffe 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun8i-a83t-r-intc
+              - allwinner,sun8i-h3-r-intc
               - allwinner,sun50i-a64-r-intc
           - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun50i-h6-r-intc
-- 
2.26.2

