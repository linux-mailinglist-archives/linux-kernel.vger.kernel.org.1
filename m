Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30CB2762BE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWVEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIWVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:04:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33EC0613CE;
        Wed, 23 Sep 2020 14:04:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id n10so1175705qtv.3;
        Wed, 23 Sep 2020 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0b3Ah5jR3V8S45p6WTAE0m50plZGQTU7otZXtYapwwU=;
        b=prQOurGkY8ekNZq9Cg40Nvf6/kH2j+rC0ilMYS3++/Hb3tloc1SoHCUv3U+mY6r2OE
         7iAlGSbINz9XLfuDx5qxHfCtCofLb/qw9fr8IA2ZgzmQTiOIeaXHZU+W/Yzwg2ZTAJlF
         0f5YAf0gVdy8t2HdVEta5ZzZsoJvv9DZavugeCD0HioKFlt+/3+2lt3veJda08bRxvo3
         XYT9hScbWWKmFVCFy/SmEFp3yG+b6q2FsN3PPTKCUEpBndXCQdP5e1JWoFTuex+H5Y9j
         iEuu5yX+PMPYKM02VMmfNZXMBAFoo7EZndeLVRCYi1d98fkMmBfpFkBW8dZO80KJRhrr
         vRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0b3Ah5jR3V8S45p6WTAE0m50plZGQTU7otZXtYapwwU=;
        b=fTbLCoiNvcC9RjCHfYAB94K/8lD7JMNLvvYBODEdO2NJvXp5VMYeoB97S/EoRKSy5Z
         ZkUViuFa9nNVObCOrcq9pWIHPZ+Y5hS+BL2Br2TW22PauF1z2VFrip9TbH/8au3cRT9I
         IQ0c0FEDaxTnMRGorJWoCraQ4HjYc7/q5g0lKdu+bfzwod6xt8ImhdoEcmBOtGf+KUNg
         Tau1d6s+gNMBF8zPMJI+Hsk1qkvGjw5Be5M8H2EEumgEuku3GXlgkVVqrrEgaUmgjTpM
         jU+SXNNLX+z5/920zmV5ZKIgNZ1Vo3RQ+EXhODj9UQI43QPNiJZT3/0xsU80Y+oFmszZ
         Vb2A==
X-Gm-Message-State: AOAM532iBLIPIh//MCHHqX9KeUR47gLgYF/z8r/tD3ZmgG2YH52+9VuW
        wwmlczIRETrT8ld5ee2PcQg=
X-Google-Smtp-Source: ABdhPJz16efVt6evdG++qI1k3Y4iqquztSF+4kOaXZePGjDlzMIl8kQdhfBZf98UMtxJVclkQuADVQ==
X-Received: by 2002:aed:24c9:: with SMTP id u9mr2108596qtc.292.1600895043768;
        Wed, 23 Sep 2020 14:04:03 -0700 (PDT)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
        by smtp.gmail.com with ESMTPSA id h18sm753419qkl.12.2020.09.23.14.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 14:04:03 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bob Ham <rah@settrans.net>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Brougham <jusplainmike@gmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 0/3] Support NVIDIA Tegra-based Ouya game console
Date:   Wed, 23 Sep 2020 21:03:49 +0000
Message-Id: <20200923210352.1176386-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

This series introduces upstream kernel support for the Ouya game console device. Please review and apply. Thank you in advance.

Changelog:

v2: - Update pmic and clock handles per Rob Herring's review.
    - Add acks from Rob Herring to patch 2 and 3.

Peter Geis (3):
  ARM: tegra: Add device-tree for Ouya
  dt-bindings: Add vendor prefix for Ouya Inc.
  dt-bindings: ARM: tegra: Add Ouya game console

 .../devicetree/bindings/arm/tegra.yaml        |    3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm/boot/dts/Makefile                    |    3 +-
 arch/arm/boot/dts/tegra30-ouya.dts            | 4498 +++++++++++++++++
 4 files changed, 4505 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/tegra30-ouya.dts

-- 
2.25.1

