Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694A52928FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgJSOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgJSOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:10:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C30C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:10:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j8so5794367pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+WsrhoyC+JrQFZTcl3DCWJnD0CqoqCFHUTm6b9tCCw=;
        b=qcGN5/o5r/XV13JNsNqld4FWnPXR67wk9dguz8TXU8HqXbrA40SPGrCvBi4NJoGSV1
         4hWuPp50jFDwmGLpjfmcvHBXANVL2HPnPWiTfyL2DGaqU2zYNWHuWQ0NNld34/P5kW6M
         0aBfFmwKlmX9U4HrmBCznpf9+H8NfBNvsYh/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+WsrhoyC+JrQFZTcl3DCWJnD0CqoqCFHUTm6b9tCCw=;
        b=hqbuuNQBvIdIlvTrjKMEtZXpBvVR0uSrYGSGubESg7ffTih/hdYB8+N/5OxbruI9NA
         dARP2cuuoiFiQTtvGBlo2KR1zk4ckfKnmI5u6SHTSOYfBijaqvifPmyhHe3UfAAOcb0z
         vCoTF/QDBNG1L2pPBnXGG+H5UUr9i5Q+Yq3/l1Vyw7IthUq/+rWrAC4DHi5FXX54ubPn
         gjJaWnywj1FpjtSeRvdWQ5+rniOXeFhfmDNt5LFshPj9y0tKLoOR4gTkeSLZpgkBzrow
         GBqDLu8Lsa54wEfQNR+bXEHySVem2E8TQh6rmgRgc1EydnEqDppLgrjpnL34kK6P4NDt
         AKxA==
X-Gm-Message-State: AOAM530qkCIwvuHDvf2ToJVs8YE5Uv8Ei4uXy7CHwnY3clQm5vvcFrKS
        cSkGKR6145CQK5Z7KnKoi+km/A==
X-Google-Smtp-Source: ABdhPJxhT0SgjSefK46NYqt2jQXMLGLYqIJCdoFCundLghVKFKCMm+XeLTi0PyXihiutMjbKZgaQGA==
X-Received: by 2002:a17:90a:7d12:: with SMTP id g18mr17918776pjl.89.1603116616076;
        Mon, 19 Oct 2020 07:10:16 -0700 (PDT)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id 131sm78999pfy.5.2020.10.19.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:10:15 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 0/5] Add GPIO support for MStar/SigmaStar ARMv7
Date:   Mon, 19 Oct 2020 23:10:03 +0900
Message-Id: <20201019141008.871177-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the MStar/SigmaStar support is only really
capable of shell from an initramfs and not much else.

Most of the interesting drivers are blocked on clock and pinctrl
drivers and those are going to take me a little while to get cleaned
up.

Clock and pinctrl aren't needed for basic GPIO to work (all pins
start off as GPIOs..) and it makes it possible to actually do something
so this series adds everything that is needed for the main GPIO
block in these chips.

Changes since v1:

- Moves the binding header commit before the yaml commit
  
- Fixes the license on the binding header to include BSD-2-Clause

- The driver has been reworked to use the gpiolib irqchip functionality
  as suggested by Linus[0]. I think I got this right. The gpio controller
  doesn't actually do anything with interrupts itself.. It just happens
  to have 4 lines that are also wired to lines on one of the interrupt
  controllers.

- Now that the driver is an interrupt controller in it's own right for
  the gpio lines that have associated interrupts the binding description
  has been updated to add the interrupt-controller bits and remove the
  description of the interrupt-names that described how the interrupts
  used to be passed in.

Daniel Palmer (5):
  dt-bindings: gpio: Add a binding header for the MSC313 GPIO driver
  dt-bindings: gpio: Binding for MStar MSC313 GPIO controller
  gpio: msc313: MStar MSC313 GPIO driver
  ARM: mstar: Add gpio controller to MStar base dtsi
  ARM: mstar: Fill in GPIO controller properties for infinity

 .../bindings/gpio/mstar,msc313-gpio.yaml      |  61 +++
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/mstar-infinity.dtsi         |   7 +
 arch/arm/boot/dts/mstar-v7.dtsi               |  10 +
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-msc313.c                    | 406 ++++++++++++++++++
 include/dt-bindings/gpio/msc313-gpio.h        |  95 ++++
 8 files changed, 592 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 create mode 100644 drivers/gpio/gpio-msc313.c
 create mode 100644 include/dt-bindings/gpio/msc313-gpio.h

-- 
2.28.0

