Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372A62EFB11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAHWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAHWXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:23:00 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CFC061574;
        Fri,  8 Jan 2021 14:22:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id 6so16546115ejz.5;
        Fri, 08 Jan 2021 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=asHOcN/bxqtMACU7XCvdcfTOOqC6fag8gYJvuKOYVtE=;
        b=XtYnIv08b2zmhlDr2xeqCALMkalVrjIbh4pkvgkelc5LEBV8WBkxap3LZ+qdF43lvK
         RJDe91cIwkyra/+xZaPn5ecYid/KzMqPcI9vkf7Sd85oI73CaK2poC+62qOnGAyF79QH
         NLn5vghzBZ2XPzcLdMc//XcUImObGbO4CS8+SJVfSYljuMsskmxsIa3xD6lhdKDPeAIP
         y9F5wQE7R0OYOeUJS632pXuslWe6d2b/koTiS1nWP7gltarH+xTb36+KbNMFZ5AdWQWe
         dWx8Br0fAMVZS48sBDldhI+fIXs07mgmQM2u0xt7KMa2VlJ5Qbce0YPrKpvP89kMW0VV
         Ui8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=asHOcN/bxqtMACU7XCvdcfTOOqC6fag8gYJvuKOYVtE=;
        b=DYgBP0QP+AU+4lyNCLC53UYg7pyab6LYIiVaIBt9fTcxin/q3lWD85CnwVkwNvtTkQ
         PX2EyBZ66S7+NQsbbfXyDGYzEPgW+ersYJWpmF+BNThLR/AaJyx7bMuzDfnjyiQIOMf4
         zugcTR3puXpF5g+MGgjXs4glaLTlsi8Wo2u4LupeBMtnbZsWsBu2G+0OCBzJNoKVFcBh
         gzQkIqnAL2eZD+Ipwc1wmQE3xhC0A5iiw6eQJBcqUq768enu6hfDXWOAEP3Z9bzCBNV8
         UhnUPsbcBjMIUQ2iDZU8laQrdAKMF3YouYjtWJIlEiJipflBFWCd2e+uYv/VjYP2yaEE
         oLZQ==
X-Gm-Message-State: AOAM533jslHR20FLo5xPt3l2FnysB/pPwhd/A8jWyVay0Jr4CwsRfaA1
        udk2dPm6RCsFdOHuX2FtsQY=
X-Google-Smtp-Source: ABdhPJwzaFAe/l0Ny7ur6dPx9f63EXVb9bVJk0Lz7iAmEj/Vlqe2ofA6UgydosNHliXFk/r1Yu/vmw==
X-Received: by 2002:a17:907:3d90:: with SMTP id he16mr4182657ejc.235.1610144538719;
        Fri, 08 Jan 2021 14:22:18 -0800 (PST)
Received: from localhost (ipv6-8dfc3ce26bc50b06.ost.clients.hamburg.freifunk.net. [2a03:2267:4:0:8dfc:3ce2:6bc5:b06])
        by smtp.gmail.com with ESMTPSA id 35sm4267275ede.0.2021.01.08.14.22.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:22:17 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     m.felsch@pengutronix.de, narmstrong@baylibre.com,
        parthitce@gmail.com, Oliver Graute <oliver.graute@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] Variscite DART-6UL SoM support
Date:   Fri,  8 Jan 2021 23:21:43 +0100
Message-Id: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Variscite DART-6UL SoM

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (3):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
  dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 300 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 270 +++++++++++++++++++
 4 files changed, 598 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

