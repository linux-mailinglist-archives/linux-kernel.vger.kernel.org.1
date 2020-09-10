Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92162644EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJLAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 07:00:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52467 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730312AbgIJKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:54:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A21E5C10C4;
        Thu, 10 Sep 2020 06:54:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Sep 2020 06:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=f4VdJeRI0UCiq
        PdXh4f/FQzWUUOhHo9nR21AJ+6YsDk=; b=arHubH2L2KBiTXNVUo3PegTxuNBPJ
        Tl8pr+vwFnoOGAelQoIr6qsaOeVYjvh/XYanZ2fmHx8c2AFPKYUv6dssDyv2VkIY
        8jC0sDOmw1CI6G1Gza/0SHAPXx/9SpnGzv5g4NMiXzOk4Anm9ZbfJYnpfz+Eyr76
        202p5s93JvZzdTwLoLfYVFHKVRVVYEukGa8Tz8oP9nf/IwBl31T6Xl3APVvT2ov0
        UDKYIcbQHm6mHQPPq/KAutPMoCRWKJUkJhDgKpnlwp7ZQ8TOTSrt9jJeNFsI2Qu8
        0ZVxXPNSMHXI5hjHmH+neGzXQUiksk4sByBrr7e0ECNWSCLz0ljBgcYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=f4VdJeRI0UCiqPdXh4f/FQzWUUOhHo9nR21AJ+6YsDk=; b=JmXCTbHa
        /9ICQ2jVjnKTg32/593Nhf8i5blW8TfQED872BKJsP/c/Bkm9gWi3iqDhrGhP4Y7
        MlgIrtv2gyOURGnWIMF8pS3qAO4jrttEb3L8OQnJk0MEw0E8celcKXZ+MfmhcIkg
        yanrYxLJ+GBQkacA4g2zWZneGzGCYAK3gZjVsrNSrTd/T6R+b1qPfGRRrW/hV/q7
        Z9Ogc5HkgcbxqKEZRTHpReH5aaMNQ+ziui+ofjns0M2cRj3mGVcOumakxYV/7jiu
        tCmkWohFVI481das5+jPqY3hBlTnOill0JqvA9Joey6scU6GiT0Nj/x2I0lraiyh
        ZTHG3nJEE8q3tg==
X-ME-Sender: <xms:_wVaX_nhURj3B039mYx8yBIpa8F9YFZWG7lCX8ryyZPHjXaOSYLc7g>
    <xme:_wVaXy0JZXO32dTM3dYCcqpHShc7pW4e2Lannt_ISHj5BZQxmxQRwK9meifDyRzAa
    -t5FOuV7sdGrU3pRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecuggftrfgrthhtvghrnhepjefgvdevheetkeevgeegleelgfelte
    etjeffleffvdduudevieffgeetleevhfetnecukfhppedugedrvddruddtledrkeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvg
    ifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:_wVaX1quH1uHYXmfOnqH6Wn20atjblTxpkcD0Isd-XWHQjoOyW6vFw>
    <xmx:_wVaX3mE_U59DBN1ERKtNqlFnarqyUQzqhmgZvtjRaddbOzjMQOXWg>
    <xmx:_wVaX93hxbAoucu4X1g7I_1KHj6t-uxwAzrfxUwWent3gngA6-Cpmw>
    <xmx:_wVaX3q3z0DdStk-bAu9c_fLifSoUmf0EnFP2yl1Qh_K07bXltBy_Q>
Received: from localhost.localdomain (ppp14-2-109-85.adl-apt-pir-bras32.tpg.internode.on.net [14.2.109.85])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35C81306467D;
        Thu, 10 Sep 2020 06:54:51 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
Date:   Thu, 10 Sep 2020 20:24:38 +0930
Message-Id: <20200910105440.3087723-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910105440.3087723-1-andrew@aj.id.au>
References: <20200910105440.3087723-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties to control the phase delay for input and output data
sampling.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..75effd411554 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -61,6 +61,14 @@ patternProperties:
       sdhci,auto-cmd12:
         type: boolean
         description: Specifies that controller should use auto CMD12
+      "aspeed,input-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The input clock phase delay value.
+      "aspeed,output-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The output clock phase delay value.
     required:
       - compatible
       - reg
-- 
2.25.1

