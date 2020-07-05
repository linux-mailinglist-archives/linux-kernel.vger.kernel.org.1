Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204BD21497B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGEB0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgGEB0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:26:31 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A99C061794;
        Sat,  4 Jul 2020 18:26:31 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i4so35858272iov.11;
        Sat, 04 Jul 2020 18:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ULzjaRt3S4ROXjIhyt59QPtwDnNoQ0tparoq3BlwLj4=;
        b=is11VQq8UOBgnv46a6wN1XSyoFQ8aVokXzCRXdz2awj3nWtbtma77DN58tn/JPir9T
         Gf76GPv2mlQparcwuTDP8QYQJP0ReXfGOqkwtIpo0MvoLnt91eXxgZv6u0qzmJ0Diyeg
         IijaEJiA+D+7rSlwHMuicskp6n6nMlwBfP3Kc4NAwS27WjJ3dUv7hjpffoIb9MYidHKt
         sobOe+ACOETOSJSF8SEL+vFoErnbxUfUKYrRONlXrSLMJwF+msTpIOT/FdEQkEIqkkEo
         +zvG84MzeXS8wh8ijgFtTWDhA+s7ihzKk1mnHMLCtBJxxxky5HlYCckYtAO505V8abp0
         M6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ULzjaRt3S4ROXjIhyt59QPtwDnNoQ0tparoq3BlwLj4=;
        b=nt0kV3cb8/eKiZ/UkenjF91lT3YoC4tGi4gOYYSCH46GxiGir6fNxG7rFxJVrZDk7f
         X5wfFBaIkGRFCeshpmtbaLWlBfUsWynB+qsGK+MyEcjaQi/hw3+SxAd1lPGI2+g7tLSl
         srDVdRP4Dl3KQr3OZta/b7R//tLQzk8tVKbhLQPghYLUkB5EJJmEneEPXhCofqbNBZUG
         OptUgI5MDy58U6IBn6WromyiUMPOHUEsqnCClbEmeoenIxxA+y6Z0uUb0/AT52lJjVgy
         naQSoarJjnqh7aJ7/OfQADjHEudya5juG6wv3FKwxGBeNsPKjaIyBVG09TykwgFWaXZj
         3W3A==
X-Gm-Message-State: AOAM532CkIbTfOWxv/hICojpyS9+y74qbtEe9UgO1ahYAgrDp7uV5g9U
        6oqtDfEy7psAUyLXmDS/Uhqqg4NR0WJxRLFoa7k=
X-Google-Smtp-Source: ABdhPJwo1CfqHMA3oFWFPxGPiMuLd3QKc5H4xN8YM1x1X948BSw0v1dKbKQk2ThHw6Tam6ER7m7K7zD5LgNLwUJc8wc=
X-Received: by 2002:a02:cd06:: with SMTP id g6mr14987658jaq.37.1593912390403;
 Sat, 04 Jul 2020 18:26:30 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 4 Jul 2020 18:26:19 -0700
Message-ID: <CAFXsbZrVZjiyO_G6z6T82t0xT36Zi2gGo0kPnt6n58R-rO3TVg@mail.gmail.com>
Subject: [PATCH] ARM64: dts: update MDIO speed and preamble for zii-ultra device
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MDIO configuration with zii-ultra device to fully utilize
MDIO endpoint capabilities.  Device supports 12.5MHz clock and
doesn't require MDIO preamble.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 6a55165bd76a..98aa67a4c040 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -132,6 +132,8 @@
         #address-cells = <1>;
         #size-cells = <0>;
         status = "okay";
+        suppress-preamble = <1>;
+        clock-frequency = <12500000>;

         switch: switch@0 {
             compatible = "marvell,mv88e6085";
-- 
2.21.3
