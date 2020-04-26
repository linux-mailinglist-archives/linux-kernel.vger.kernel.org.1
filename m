Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF291B9195
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZQQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 12:16:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33943 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbgDZQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:16:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE81A5C0113;
        Sun, 26 Apr 2020 12:16:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 26 Apr 2020 12:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=RQVYJCx+9TANj3Ikx+7eZ177he
        ek4dmBB4uSOz8PcYM=; b=gwcmGtC/Hfv8Ho/AVICzxglVJ/h680Yvx82w2TMMRr
        KwkPgrwpThqADSKNg3ziKcS5G1GsafFGPZ6cMYPeIdOEztYdYQpYTuzt/ZLCYbl9
        LtTLDY2EoJYw1I0a3XoTjffnIB1G9TGjz5CXOAcFAyJfVt7/iattWlOYOY++tpu5
        thoi6waHAfpeigeoYkTGojjH3UdWdjD1tbaZAGJXEnXv/HzWpwH2h8qUd1FVjlX2
        tPWFM5FC1v/TtJSQYKFHWsfprQDspNXQ3fW4s+uQO2k6LBPAX1QY6PCZdIL7TJ5P
        JKbNFGMf7TTh2HjmKRIiYdXuBX9Tio63d1+BOioBbuQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RQVYJCx+9TANj3Ikx
        +7eZ177heek4dmBB4uSOz8PcYM=; b=rYYLYsI0cBzxGNNyM2NtPxMIU1XuZxcfG
        tsYkJ6ev90Q7Q9BjDPDDu2Vch76//+qEVRZem5uuXYD94mDwElT2uYLNJTQeIzd5
        IdLhp78ItPxAJf1M5ttjLoXLoIhhb1aaaEOlbObFeA4gFYGxPElWU9Wmxzf4Ltu+
        yQAM8ndV2CDSJ6Zo5gII13LTIxhjGWJtFmRILIr3h2BexLWXixLBiXy1dUEFaA2n
        N2O0DgAwlrsROwcDrmXzU+tXO6uztO0zj6JDoAef1tZtpwViu/WnWLRjAv7elDNs
        G/CrrDgfvXn4xp1HiDWINs0nReF0+3wfZBuuuX3yJqpSAeN9GdOIg==
X-ME-Sender: <xms:2LOlXsVULnl6PxqmlouCcWtxe0rA_lWDKq-yyyffl2QY7qh_L0WfAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:2LOlXtjTC8hs3Cru7xM5iYVrgOsfDWgJKRVbIf1dCjPMdC-WMVEJQQ>
    <xmx:2LOlXsBgZt0slompcnvQXAm66jItiuRIgdKuwHQuA8jG_nmBTIxFfg>
    <xmx:2LOlXjtAwhhDuTN1GVwPAlW0iE6ytGbUPpa6snlwiDx2-ka6c1F_bw>
    <xmx:2LOlXnjX4vZ_OIEh4V7G3ytUFEMrkx232jxYfEYgU0hPIvJ36GzKSw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BBFBE3065E34;
        Sun, 26 Apr 2020 12:16:23 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] dt-bindings: timer: Document allwinner,erratum-unknown1 property
Date:   Sun, 26 Apr 2020 11:20:32 -0500
Message-Id: <20200426162032.52220-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This arch_timer property was added in commit c950ca8c35ee
("clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer instability")
but I omitted the device tree binding documentation. Now
`make dtbs_check` prints the following warning for all A64 boards:

timer: 'allwinner,erratum-unknown1' does not match any of the regexes: 'pinctrl-[0-9]+'

Resolve this by documenting the erratum property.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index fa255672e8e5..cf520c7e9094 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -51,6 +51,12 @@ properties:
     description: If present, the timer is powered through an always-on power
       domain, therefore it never loses context.
 
+  allwinner,erratum-unknown1:
+    type: boolean
+    description: Indicates the presence of an erratum found in Allwinner SoCs,
+      where reading certain values from the counter is unreliable. This also
+      affects writes to the tval register, due to the implicit counter read.
+
   fsl,erratum-a008585:
     type: boolean
     description: Indicates the presence of QorIQ erratum A-008585, which says
-- 
2.24.1

