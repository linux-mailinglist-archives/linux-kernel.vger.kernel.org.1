Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0561DA74D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgETBng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:43:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75353C061A0E;
        Tue, 19 May 2020 18:43:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so1085199wmf.1;
        Tue, 19 May 2020 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=b+VrtRTRQbda5F/nBoWdgPtbxBORPAR0TPt2Xyx+4zo=;
        b=XWUbGOnKCkXgHXl7jp7d8APw0c98NN8lMuqbg4CYseGAwUC62wzAW3W5yy1yLOUZDN
         5bPIFG+dqBGKjxITeWBf53MRiahijTiolotvO+SuCxFF++8Bn399qzIr/3prtLHysArS
         whVCvnhKl+R8LCByU2/dU0qznqu/fzLGFR04qnaiObd/x1F2qfddduB2DiLQspCf8GpW
         Lh0pxTd0dFNYUPB12Kg1F6S74oKiU4gi+BsH2MhRLLQhzp7/PVEfXXhJRrP33GWtxh8t
         w6virPox++TBPqoSO/LgZZF9LkPliqY7zraux3W/MqEXgaFm0I5VqnkPyjHxZwyTAy+V
         s+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b+VrtRTRQbda5F/nBoWdgPtbxBORPAR0TPt2Xyx+4zo=;
        b=pU4oeYDMvsic0ceL4theW5B/DFBkWQYoGinuiiRHx3rf9e+ZjHadDTzsb6xG4QvSpy
         SA8emKmLYgcru24i0IlpT7wW/ggKCF3ZJnscZJ+17Dxaoyw9NhDtgRDGchq0nCrXf13N
         fUGLq3Q9d4sOSZ4Qfz0pT57VHxPUvjZem9BkH4Xkf3MRORXtlUm6GgFbNvouPIOBkvep
         5TDBANZy3sBB+qAxkyQYr9lUdwhH6eIKgkq4BZ3pC0SjvkHPeW7US9ID6fdYvuJwL7cx
         QGnPRpX9DptOZ/IJJmvy6O2l2i5JKyrG0rtmKisjIlNVyg/OoxtjslUUnR/aIC6edaaA
         +MTg==
X-Gm-Message-State: AOAM530F2xVGWK//xrCpbx/HXN9W88UDumjDK4QLuLomkmmW2Rfef+1s
        sgUG6CNXtJWUSuCE2VM5wqDqVEiL
X-Google-Smtp-Source: ABdhPJx9nBW+NDfV/mrgsUts8T80+Hh62UiaVMTnz55H7gHZyY4vEc/xhrq22gkKFKEnVD1Nb20ufA==
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr2238314wmi.79.1589939014142;
        Tue, 19 May 2020 18:43:34 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z10sm1493351wmi.2.2020.05.19.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:43:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 0/5] arm64: dts: meson: add W400 dtsi and GT-King/Pro devices
Date:   Wed, 20 May 2020 01:43:24 +0000
Message-Id: <20200520014329.12469-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines patch 2 from [1] which converts the existing Ugoos
AM6 device-tree to a common W400 dtsi and dts, and then reworks the
Beelink GT-King/GT-King Pro series from [2] to use the dtsi, but this
time without the offending common audio dtsi approach. I've carried
forwards acks on bindings from Rob as these did not change.

v4 - rebased against Kevin's v5.8/dt64 branch

v3 - amend author full-name on bindings patch

[1] https://patchwork.kernel.org/patch/11497105/
[2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=273483

Christian Hewitt (5):
  arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
  dt-bindings: arm: amlogic: add support for the Beelink GT-King
  arm64: dts: meson-g12b-gtking: add initial device-tree
  dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
  arm64: dts: meson-g12b-gtking-pro: add initial device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 125 ++++++
 .../boot/dts/amlogic/meson-g12b-gtking.dts    | 145 ++++++
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 375 +---------------
 .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++++++
 6 files changed, 698 insertions(+), 374 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi

-- 
2.17.1

