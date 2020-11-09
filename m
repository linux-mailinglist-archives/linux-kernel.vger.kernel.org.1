Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057022AB03C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 05:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgKIEmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 23:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgKIEmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:42:43 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9163C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 20:42:43 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t22so4110387plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 20:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvFH19nAMRexQoNRz1lWuwb9YGvDdTva7cU7+IPVjhw=;
        b=sheY4mv8wKuFcfvfxmPrIlma4xNDgOtVbjXT5zteDYdb2z2qQivTNKq5HAq3lN0AGK
         wuvGhSW/xybQsckuE2X03Kl7NP9C5PcW7EeWNPaJko0Huuj0w4L7ay0aVZqw7wCaFDYX
         oo5v6CYbnSWUp84PRnZz1R70aJ8EL1WX2vUGoG8ILEo24ORlh5GoFULCluFFPRVHgYiI
         9u7DN6h3Ggp+AQIMSllh3qkFJ+Ng+xINN5tjoc6fGdwWxCJu/8+lhwwijN9uYc1rlOKi
         1F2kcTT2EdEeAEeXyth1NvwQ8jrEWlvBHzpHiDGcGqhogzURQHwHtNb1xAR8BBP67iNI
         XYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IvFH19nAMRexQoNRz1lWuwb9YGvDdTva7cU7+IPVjhw=;
        b=HIUJ18lOGaXd9wV62Djj+ZPf0IzFZVYdSR703RbLiY3t5LkjXUrBiuGAQXqQcFLpQ/
         g40AtDPMl2vJWGUPMtHiKp5m9z6hOCVt664K78lnZwF1bLHoRMj8tGoICZvJtE93nqck
         v7TWdGeAK4lSdktafdHOqZj1t978OWbbqt4K/nzxo6BELAWVFaIJVdA9LeeLNgYfl59/
         6MNE1kUIC4QmfivR9K6VUssLLUxzmUGVzey3T3IUDdvGEIfQJafHmdVrxw0BiVkPRkTO
         EK2piccbN01xNPAF4KxT4TYWcNGD47qs3CleSXFMaOulDWTGIc1+wKE9HWzuXmBwJl/K
         T/ew==
X-Gm-Message-State: AOAM533qyDi+RBu+I9Ki8YnNmd15zAE+aHGnOp7REwYbqG7LPoZR7mvs
        2+Jnn0HMFniiIIm8PiWSRl0=
X-Google-Smtp-Source: ABdhPJzzNH/LwF4pkIpSziKl6nO/K0i47RkuRsoS+O6DaP11ZTlgYNEg4vQU8RB8b+W6TH8zn3aqvg==
X-Received: by 2002:a17:902:d695:b029:d6:a255:ae32 with SMTP id v21-20020a170902d695b02900d6a255ae32mr11466445ply.43.1604896963219;
        Sun, 08 Nov 2020 20:42:43 -0800 (PST)
Received: from 1G5JKC2.Broadcom.net (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id m12sm9329209pgl.90.2020.11.08.20.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 20:42:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        linux-kernel@vger.kernel.org (open list),
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/2] ARM/ARM64: Enable SCMI in default configurations
Date:   Sun,  8 Nov 2020 20:42:26 -0800
Message-Id: <20201109044228.6836-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables support for the ARM SCMI and the various
drivers provided (cpufreq, clock, sensors, reset) since these are
utilized by Broadcom STB platforms.

Please let me know if you would like me to carry those patches through
the ARM SoC pull requests for v5.11 or if you would like to see those
applied differently.

Thanks!

Florian Fainelli (2):
  ARM: multi_v7_defconfig: Enable ARM SCMI protocol and drivers
  arm64: defconfig: Enable ARM SCMI protocol and drivers

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 arch/arm64/configs/defconfig        | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.25.1

