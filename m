Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C81B26B2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgIOW4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgIOPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:24:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:24:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so3766567wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YvlYC1RkwagSWOgfzPVUM6G4NaBTVomn2Uo8AkuMv8=;
        b=1EPC+KP0aZPtdyM3wms/b47DbGt0Tncted7tEwXyqUDHklpcp76Dda0a18+eYz0yeE
         DwvK+rYufHdxRRKmqIcP7pT62QPTelg+haVhayfv54o66zS092EnBEV1PzliwfBBGDZE
         dlJcOv/gPGvysfE6xkTkGfio0MdZT7zWOlEsxDbuj0zgAy4/cShVq///XdVmhaCjVq9S
         1v+o6Il0aD/yxGEbZ3xymJlaL+VK8+IPkUOgo6KWpEpvw+8njbBSj+zWIYNLc0j+YQnB
         Pi4mZXFirf05Y/qmS88Cfw/HNAjdxJSJ2+KxGa0uW9QkpuZZc5kEoN4NUD4mew4GiXS/
         cC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/YvlYC1RkwagSWOgfzPVUM6G4NaBTVomn2Uo8AkuMv8=;
        b=MOLu0dzoQWaLi07n8l/0GqDqkIk6bQczIrDDI6xTwz3LbxguskG9KMmudWHMGEQxrb
         YG9FKI5rHQj8Hgb7By2KU7/Bk2JEWjFVlulz3MBjx6kidJlkyXWNt1pRPs8gVeH59cxu
         KeU/cffXeKyKsxZkDLlYIGZnzsWMLD+g92XXy8KNDofgeaWZEqvsoa9a3AL7d2HudESP
         drv7tGqKpYGBElZ8AiBi8P8GoW9xH9bqwJ3FCnpIF4i8fNBJDz4IHm89M8z1y6bfZ0vF
         Wco/L1vQleU1IGaUAOUPjbVeyN3rRLMRENNVsxqTY/PKzUOVJvUKlEVWgvkMfBr0rpWZ
         nPzg==
X-Gm-Message-State: AOAM533gYSdx2DYTJgZYJRvgDeQPP1uvp/XJlQ5LoL7fqcAAiLKRRlio
        4IsMBJ1LH6aBYMAAwsFSAcFNKg==
X-Google-Smtp-Source: ABdhPJyo5nS8QJrtlCFkixQwydV3HaRNx9OMlTFcstqWtdH/QmwI9+Dl+S+Kj3zh8r8GLuayAi6S7g==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr5517065wml.50.1600183477852;
        Tue, 15 Sep 2020 08:24:37 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 189sm25984960wmb.3.2020.09.15.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:24:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, tobetter@hardkernel.com,
        christianshewitt@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: meson: add support for ODROID-N2+
Date:   Tue, 15 Sep 2020 17:24:29 +0200
Message-Id: <20200915152432.30616-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series splits the existing meson-g12b-odroid-n2.dts into a common
dtsi and dts, and then adds new bindings and dts for the ODROID-N2+
which uses an Amlogic S922X rev.C chip that Hardkernel supports with
the same OPPs as the A311D.

Changes since v1 at [1]:
- rebase on khilman's v5.10/dt64
- get all review tags from v1
- use the A311D OPPs, after review of Vendor kernel, the Rev, C uses the same OPPs (freq + voltage)
	as the A311D SoC of the same family

[1] https://lkml.kernel.org/r/20200719141034.8403-1-christianshewitt@gmail.com

Christian Hewitt (3):
  arm64: dts: meson: convert ODROID-N2 to dtsi
  dt-bindings: arm: amlogic: add support for the ODROID-N2+
  arm64: dts: meson: add support for the ODROID-N2+

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts |  31 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 618 +----------------
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 625 ++++++++++++++++++
 5 files changed, 659 insertions(+), 617 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi

-- 
2.22.0

