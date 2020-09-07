Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3612604BA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgIGSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 14:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgIGSdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74662087D;
        Mon,  7 Sep 2020 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503605;
        bh=hF5qOo+c8YduVMjYkX8pXY1qShoCdsqQlH8KvEirjc0=;
        h=From:To:Cc:Subject:Date:From;
        b=ByqyNjZCPL0qV1hBA0kJE4EpOfmRlpLTwOEAp7De7CWk30ty9RK1ERhBQjcZ3D8Au
         qSdi3PbkLAMUsxJ7DYhGK15zT3jdyjtpM71bASZ0c9EhMOEd25PFn1L9C/SONBKR6U
         JWI5LbsjqP7GX+t10am8HHbEnEIlrScR4Fpaj8cc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 00/11] ARM: dts: s3c: dtschema fixes
Date:   Mon,  7 Sep 2020 20:33:02 +0200
Message-Id: <20200907183313.29234-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is last serie of big dtschema cleanups for Samsung DTS.  It fixes
almost all dtschema violations, except:

  s3c6410-mini6410.dt.yaml: srom-cs1-bus@18000000: ethernet@18000000:reg:0: [402653184, 2, 402653188, 2] is too long

which is similar to the case with SMDK5410 (Exynos5410).

The patchset was not tested on HW.

Best regards,
Krzysztof


Krzysztof Kozlowski (11):
  ARM: dts: s5pv210: Correct ethernet unit address in SMDKV210
  ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
  ARM: dts: s3c6410: move fixed clocks under root node in SMDK6410
  ARM: dts: s3c6410: align node SROM bus node name with dtschema in
    Mini6410
  ARM: dts: s3c6410: align node SROM bus node name with dtschema in
    SMDK6410
  ARM: dts: s3c6410: remove additional CPU compatible
  ARM: dts: s3c24xx: fix number of PWM cells
  ARM: dts: s3c24xx: override nods by label
  ARM: dts: s3c24xx: align PWM/timer node name with dtschema
  ARM: dts: s3c24xx: add address to CPU node
  ARM: dts: s3c24xx: move fixed clocks under root node in SMDK2416

 arch/arm/boot/dts/s3c2416-smdk2416.dts |  17 ++--
 arch/arm/boot/dts/s3c2416.dtsi         | 111 +++++++++++++------------
 arch/arm/boot/dts/s3c24xx.dtsi         |  24 +++---
 arch/arm/boot/dts/s3c6410-mini6410.dts |  32 +++----
 arch/arm/boot/dts/s3c6410-smdk6410.dts |  32 +++----
 arch/arm/boot/dts/s3c64xx.dtsi         |   2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts |   2 +-
 7 files changed, 101 insertions(+), 119 deletions(-)

-- 
2.17.1

