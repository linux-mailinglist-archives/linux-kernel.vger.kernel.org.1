Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5A22F9983
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbhARFvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:51:36 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:52455 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731654AbhARFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:51:29 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 292D7164B;
        Mon, 18 Jan 2021 00:50:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Tf3U4+sbNMvuA
        YGxEmqt8UpNEPXCxCo3M8UWj1JaTcE=; b=q2+94iAFB1zIqpuYhhrubWnC4uE2N
        0vbIG0pjxEF1Nfht9L0G+RmBzJHXKg7nsDVAk9IK5SOY5AW0UOweI+b8dt1dvlG+
        ZNSrl2wDJCqYKZTguiwSyTv7BV9aQvSHGAGH9EWBWRBxKsb/c0get786EJF6X+dM
        2IH0+QiZcDIBr917j/KKVNkDfDCkwUlb/kgJXhJYPdgqb8G33AjqGXcmonNiBKwm
        +tdI6hfkF98j1nXATiV+k1SpybY1NGRFeuU2rerzBe8Cw3bRoriWCNseKoZV+/tK
        /f22g2iGn/EuNecMURKHCXpO1sC9tKZAtVaBJLcHQEJp/MsNqLRpTvjtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Tf3U4+sbNMvuAYGxEmqt8UpNEPXCxCo3M8UWj1JaTcE=; b=ni4SytXg
        CT1flm44jIi4WmUSefih9TLryivzQB3cwj7eJYy0gfBm9IvKlgkWnLK50QpaouQZ
        Cmvpks6np/pCkAgMgfGeAQHktsKQujtV2PckqUguUD6RDSEf/AYA6tw8pyJvDBqQ
        ytxgQs2Zpf3+XQR7y7QTJ88ScZTrNY63U1GtmmOEf+W/sK85dO54hBr+gUFttBcE
        UCvSN0PNxbXfY14120ndJmY6ndCsbS4uD5w2k4HfpcocQ9gW8rpRAXxYxMFqEvli
        2cctAv0V+Lyzd7XizEm14n3fPjziYyPbwkVt2aat8YiQbijHYZFzTRVfGoZOnwjJ
        OF6wKBY+BGNZKg==
X-ME-Sender: <xms:siEFYCKpUQ7cVRRbLlko5x_uSg6XymVvNfYuk89Xh7uogYj0dJMH9w>
    <xme:siEFYKKrByZ6gNw0BKzr6AWJrdWVKb4psa8xWq4A4dJf28qVUAWv2ZJf4YrAhklqX
    vlLc5boSXfelTWlEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:siEFYCv4L8LDjq6tGRi2wUKpjRsVFIH5ZHZhbUl7MNZaP-NzRk_2Nw>
    <xmx:siEFYHa46h1w-tzmcv1RK2g2AwJbvkf3-N8VUAZgavfF6tSBBeZLHw>
    <xmx:siEFYJZStjsUAqJTJbZjSlSgYRL-co1GvhQqrtT2jh3cjMqhVNKSYA>
    <xmx:siEFYLnilmBB6CnzxDfTDQOFxo8zSYy1o9kvl7b0eVaJBjvgONiSNOsdUV0>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BBCF24005A;
        Mon, 18 Jan 2021 00:50:42 -0500 (EST)
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
Subject: [PATCH v5 02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
Date:   Sun, 17 Jan 2021 23:50:32 -0600
Message-Id: <20210118055040.21910-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
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

Acked-by: Maxime Ripard <mripard@kernel.org>
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

