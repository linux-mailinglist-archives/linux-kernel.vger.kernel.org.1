Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F612C84BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgK3NLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgK3NLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:11:41 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:10:55 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so10047708pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHH2kdpiYNn+PeggmJauwzHzIWGxq4fBcVT4N9CWxHo=;
        b=MpRgQ2+fkXZ76LHATFX/HDIGtsyrBBJtz6zARp+RdIe2hZWnRnLGBYfNEKaMVbrkx5
         kipPixnGbdcv1hpvaP5FJ+qxqwIlVI7DJ3fc8AQCrt5c61ylWLhNs7B6viEV+LXNOm8C
         Xm7P3YnReMGSh28pjHNDh7JNNpmgGIEf3ZLuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHH2kdpiYNn+PeggmJauwzHzIWGxq4fBcVT4N9CWxHo=;
        b=oUQZXzw78xv2xAlSWbrmr99N1xs5J1cZvEHidWyrclwfWz+V9TmM6nTuDG23TMQN6k
         DH9ASHUCk+A7HCC8wOwMIZrtupDfmdLj8iW0JjEacT4gXZYsE3piJybAGTTrP3mYnn+d
         3b9tuRGbIdPqK0a+rkhSWb9qsaRN+HLjAXpqkA1wdcyc6ze9DT1j5UvuTI8g8g9nbrxF
         LzDJYkbNUdkk0+io0TcafxWPTYflK4BaZr7CzK+uw02EJX2e6nErgBIxRJ1M7+Vw+qFL
         XJjP34wop85j+bcyY2pDUzXphQLjcPBX+gpZcDy0lcd3clJ1vfk8UV10zJQULu6INQwx
         NVGw==
X-Gm-Message-State: AOAM531ZP6bY9vzlZZdwXHiInBGvzPIkTrGRdAvshyFPJZ7PjysYpO69
        7ZYOSUOovgDn7OzXRAJ1BCMk0Q==
X-Google-Smtp-Source: ABdhPJx2CmkchKSNLPGOZTacgBlZeZkcK0FqHkx9y/dait7SKaDaCgySlLSZebHws9QVK1fyj8gsgg==
X-Received: by 2002:aa7:9341:0:b029:18b:b43:6c7 with SMTP id 1-20020aa793410000b029018b0b4306c7mr18067068pfn.7.1606741855209;
        Mon, 30 Nov 2020 05:10:55 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:10:54 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 0/9] ARM: mstar: Add basic support for i2m and SMP
Date:   Mon, 30 Nov 2020 22:10:38 +0900
Message-Id: <20201130131047.2648960-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the infinity2m series
of chips. For now the SigmaStar SSD202D which is a dual
Cortex A7 in a QFN128 package.

These chips share most of the same hardware with the
currently supported infinity, infinity3 and mercury5
chips.

Daniel Palmer (9):
  dt-bindings: mstar: Add binding details for mstar,smpctrl
  dt-bindings: vendor-prefixes: Add honestar vendor prefix
  dt-bindings: mstar: Add Honestar SSD201_HT_V2 to mstar boards
  ARM: mstar: Add infinity2m support
  ARM: mstar: Add common dtsi for SSD201/SSD202D
  ARM: mstar: Add chip level dtsi for SSD202D
  ARM: mstar: Add dts for Honestar ssd201htv2
  ARM: mstar: Add smp ctrl registers to infinity2m dtsi
  ARM: mstar: SMP support

 .../bindings/arm/mstar/mstar,smpctrl.yaml     | 38 ++++++++++++++
 .../devicetree/bindings/arm/mstar/mstar.yaml  |  6 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 .../mstar-infinity2m-ssd202d-ssd201htv2.dts   | 25 +++++++++
 .../boot/dts/mstar-infinity2m-ssd202d.dtsi    | 14 +++++
 .../boot/dts/mstar-infinity2m-ssd20xd.dtsi    |  7 +++
 arch/arm/boot/dts/mstar-infinity2m.dtsi       | 23 +++++++++
 arch/arm/boot/dts/mstar-v7.dtsi               |  2 +-
 arch/arm/mach-mstar/mstarv7.c                 | 51 +++++++++++++++++++
 10 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-ssd201htv2.dts
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m.dtsi

-- 
2.29.2

