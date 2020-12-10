Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2B2D681D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393720AbgLJUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:07:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44169 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404538AbgLJUD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:03:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id d189so7104358oig.11;
        Thu, 10 Dec 2020 12:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BtR9F6p1ys0YkETvTwwNV2ZO40Vezo7i8tec8Hr766Q=;
        b=CFz11nhyjWfFtJkwHws1wQ9EhJ3RiUvgLpYWfwZ9egMMqdwo3l5vHql5ZZPvQ5jmLn
         9dKR6aGTY/P46TeI0VDMU9q/e+IRUPRXDbBoerACc7nlc9bjFhIup4jZphpxzcW5Ji5H
         D8/YThEtUsQe5YvynsbgqZm6Hld+jBDttI04dAJ0uIar2q9U2ctv56L3RLhWKUXcjTNP
         B6bWQzN9WY6SdKIGBrELSEsQnm+5K6T+KsIcDXewIjYKAJykLU0aTUCHHBNxJFOQzjmZ
         HSgyG2NUrt7TcyFb2sNU9OLbP0Ypuf4Rrif8aPEsHYHzUlJIY4kwDfevzuPg5eIX5oF4
         IRpw==
X-Gm-Message-State: AOAM530uwy/pahiCl+39uuiKIwzGgKsc+pDP95rruXVV/1+PDYs2eO31
        KM6M7Nk/uwPfYfVzxyMN6NIh7Cy0Fg==
X-Google-Smtp-Source: ABdhPJydQtd6sep0NfygPaKwINOdAqbJ8No1je6RXTu8rcLYonG8EvpVSZkgmcSslyjfqjgtpt8U9Q==
X-Received: by 2002:aca:383:: with SMTP id 125mr6508871oid.122.1607630597802;
        Thu, 10 Dec 2020 12:03:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o82sm1220636oih.5.2020.12.10.12.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:03:17 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jamie Iles <jamie@jamieiles.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/4] Remove PicoXcell
Date:   Thu, 10 Dec 2020 14:03:11 -0600
Message-Id: <20201210200315.2965567-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PicoXcell has had nothing but treewide cleanups for at least the last 8
years and no signs of activity. The most recent activity is a yocto vendor
kernel based on v3.0 in 2015.

These patches can go via the respective maintainers' trees.

Rob

Rob Herring (4):
  ARM: dts: Remove PicoXcell platforms
  ARM: Remove PicoXcell platform support
  crypto: Remove PicoXcell driver
  dt-bindings: Remove PicoXcell bindings

 .../devicetree/bindings/arm/picoxcell.txt     |   24 -
 .../bindings/crypto/picochip-spacc.txt        |   21 -
 .../devicetree/bindings/net/macb.txt          |    2 -
 .../bindings/timer/snps,dw-apb-timer.yaml     |    7 -
 MAINTAINERS                                   |    9 -
 arch/arm/Kconfig                              |    2 -
 arch/arm/Kconfig.debug                        |   13 +-
 arch/arm/Makefile                             |    1 -
 arch/arm/boot/dts/Makefile                    |    3 -
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi        |  239 ---
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi        |  355 ----
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts  |   78 -
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts  |   84 -
 arch/arm/mach-picoxcell/Kconfig               |    9 -
 arch/arm/mach-picoxcell/Makefile              |    2 -
 arch/arm/mach-picoxcell/common.c              |   81 -
 drivers/crypto/Kconfig                        |   18 -
 drivers/crypto/Makefile                       |    1 -
 drivers/crypto/picoxcell_crypto.c             | 1806 -----------------
 drivers/crypto/picoxcell_crypto_regs.h        |  115 --
 20 files changed, 1 insertion(+), 2869 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/picoxcell.txt
 delete mode 100644 Documentation/devicetree/bindings/crypto/picochip-spacc.txt
 delete mode 100644 arch/arm/boot/dts/picoxcell-pc3x2.dtsi
 delete mode 100644 arch/arm/boot/dts/picoxcell-pc3x3.dtsi
 delete mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
 delete mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
 delete mode 100644 arch/arm/mach-picoxcell/Kconfig
 delete mode 100644 arch/arm/mach-picoxcell/Makefile
 delete mode 100644 arch/arm/mach-picoxcell/common.c
 delete mode 100644 drivers/crypto/picoxcell_crypto.c
 delete mode 100644 drivers/crypto/picoxcell_crypto_regs.h

--
2.25.1
