Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E229794E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757137AbgJWWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757073AbgJWWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0FFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e10so2636567pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iOMe/5xy4SMRslR/l2Hz8wP9S48IWo9C51DxkgNfuI=;
        b=NvtFx12/JrxOL+oEWptvxfo+rzOlaDH9MNiyIW/0WkBX+oBDwY3PrAQu3ousQ29Srz
         tqZ9QaN1fscTebxg29pUn7A2dYIciTD37r7XqUG3gSU/1ODyU0PIHauGNwPpUptufeub
         +KgV5Xe+x3WTb/85XYbDQabP4eU9+gJFDb+4dXCxIJGKORPc+djxNWKdQ0WSqeeI0IyM
         bEUz678X4mq1E7QPNg+x/QEoJeHUXvPi+WizxlFg0SWlAFk6+ocgWtE+SrmoTIHZA07L
         lKQYoR7LKUKmrMsAt8+yErhPfrutA0w/nQiauCLFeTxLvcNyIwnTgXEdUnvauq2ryf4Y
         F7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iOMe/5xy4SMRslR/l2Hz8wP9S48IWo9C51DxkgNfuI=;
        b=HIDhLJcEdjumvyicJK/MxaZ8BpmgALnTaY4KhZwDMYCk7LZ+y3ZSYtPxNPTpfM3Hxn
         kupZ8HhB09VC458QReyJDE5Z6q4uY8kIysir2a5cJudDiCa7BF3kH19zwCq7yRDDkY6M
         sF+WjPLYJo4DrCJuUBe/Mo6XdCPRvKTvaMOaJjMf3qWXQirs32bjdYItvRGgHZby2SYo
         gy48CsuxoBK7TZj+uzOGCv0RcfrHsRlPynRLHeLbuz0axBD7TszqZBzSBj9t2AHDkQyk
         3N6m2MkE17g/gyRX1PEOkeJQRjF8jbU+4h6f44RddH/Ug453HEM2s0WL+La6TA2GkW3K
         JTVw==
X-Gm-Message-State: AOAM531FaH+EombnxQX0uZrY8277QGX3jZGeisHKyxpL0EFFP1VEABfk
        lYLiyksO/o1F3hI6iB69e+IJ7w==
X-Google-Smtp-Source: ABdhPJzAbiTG74EXzVE00sw6IkoDOH5zgmPkMxfcvLfvLRKoLec2ErEvb219tyqtaxyCQjWmeHAoSg==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr3996649pgi.348.1603492305348;
        Fri, 23 Oct 2020 15:31:45 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:43 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/5] ARM: SoC fixes
Date:   Fri, 23 Oct 2020 15:31:18 -0700
Message-Id: <20201023223122.19189-2-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023223122.19189-1-olof@lixom.net>
References: <20201023223122.19189-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had queued up a batch of fixes that got a bit close to the release for
sending in before the merge window opened, so I'm including them in the
batch of pull requests instead. They're mostly smaller DT tweaks and
fixes, the usual mix that we tend to have through the releases.


Conflicts: None

----------------------------------------------------------------

The following changes since commit f9893351acaecf0a414baf9942b48d5bb5c688c6:

  Merge tag 'kconfig-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 6869f774b1cd2bf20b4e4c5bfa13da311e02d495:

  Merge tag 'omap-for-v5.9/fixes-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes

----------------------------------------------------------------

Biju Das (1):
      ARM: dts: iwg20d-q7-common: Fix touch controller probe failure

Dan Carpenter (1):
      soc: xilinx: Fix error code in zynqmp_pm_probe()

Drew Fustini (1):
      ARM: dts: am33xx: modify AM33XX_IOPAD for #pinctrl-cells = 2

Jernej Skrabec (1):
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix dcdc1 regulator

Konrad Dybcio (2):
      arm64: dts: sdm630: Temporarily disable SMMUs by default
      arm64: dts: qcom: kitakami: Temporarily disable SDHCI1

Krzysztof Kozlowski (1):
      soc: actions: include header to fix missing prototype

Olof Johansson (8):
      Merge tag 'ti-k3-dt-fixes-for-v5.9' of git://git.kernel.org/.../nmenon/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-5.9-1' of https://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'qcom-drivers-fixes-for-5.9' of https://git.kernel.org/.../qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-5.9' of https://git.kernel.org/.../qcom/linux into arm/fixes
      Merge tag 'actions-drivers-fixes-for-v5.9' of git://git.kernel.org/.../mani/linux-actions into arm/fixes
      Merge tag 'zynqmp-soc-for-v5.9-v2' of https://github.com/Xilinx/linux-xlnx into arm/fixes
      Merge tag 'renesas-fixes-for-v5.9-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/fixes
      Merge tag 'omap-for-v5.9/fixes-rc7' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Qiang Yu (1):
      arm64: dts: allwinner: h5: remove Mali GPU PMU module

Rajendra Nayak (1):
      arm64: dts: sdm845: Fixup OPP table for all qup devices

Roger Quadros (1):
      arm64: dts: ti: k3-j721e: Rename mux header and update macro names

Sibi Sankar (1):
      soc: qcom: pdr: Fixup array type of get_domain_list_resp message

Tony Lindgren (1):
      ARM: OMAP2+: Restore MPU power domain if cpu_cluster_pm_enter() fails

Łukasz Patron (1):
      arm64: dts: qcom: pm660: Fix missing pound sign in interrupt-cells


 arch/arm/boot/dts/iwg20d-q7-common.dtsi         | 15 ++++-
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts    | 10 +--
 arch/arm/mach-omap2/cpuidle44xx.c               |  4 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |  6 +-
 .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi  |  7 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi             |  2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi            |  8 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  9 ++-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  | 11 +--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 13 ++--
 drivers/soc/actions/owl-sps-helper.c            |  1 +
 drivers/soc/qcom/pdr_internal.h                 |  2 +-
 drivers/soc/xilinx/zynqmp_power.c               |  2 +-
 include/dt-bindings/mux/mux-j721e-wiz.h         | 53 ---------------
 include/dt-bindings/mux/ti-serdes.h             | 71 ++++++++++++++++++++
 include/dt-bindings/pinctrl/omap.h              |  2 +-
 16 files changed, 134 insertions(+), 82 deletions(-)
 delete mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
 create mode 100644 include/dt-bindings/mux/ti-serdes.h
