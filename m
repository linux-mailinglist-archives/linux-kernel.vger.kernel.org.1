Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65643268B48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgINMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgINMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:41:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:41:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so11114202wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAHen39CQ6AAGevlcveD0dIrAIrRnYrxYh3e1ejsVDU=;
        b=rtSk9ZshogvpaEs0mHfToSKgzkce7qjV1PwKg3iSKKuLk7yj3GomwXS/Iyy/2IgGG2
         D6Yrnx/31csGg51aBdQQ5DTmu8OMbJwOUsRkAD8+OBY4McYywfIsnw2Wyt1KQHOXAZYk
         ak2N5tCnJT1rPx2xlvNwZw70FPctxWhnzdInpXp8q/lLILASsKbmQDfAWQmTalIvStoW
         OmDTGRRlEfRmxI6GXGA1RpDB8CaVQVR2WFFYp+7thIelUrFCTOYyAixKze4Tf2mDmT9X
         B9matKi5Q1V9owRePi9hrWPobxVTQaoUKAy7N/G3JJKnwhsizAy5W1qDQE4tXeR9EiPI
         ElhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAHen39CQ6AAGevlcveD0dIrAIrRnYrxYh3e1ejsVDU=;
        b=XDhaYJhGzTxhoYarTcSVL1Pd493aDxbgyafBRfd1Oo6X0xdgq+E4w+p+Q+QLRUupDn
         4wP5gISNgUhbVWp+82N/KZjhlwAFNGxX2zk8gZS4e5wBatQiuxbN/Yfl9T2/24CqVbYs
         FGPvLdpe/uKYVOfGP72uFYmRIJzlSK/TcAojbV1swUAKOIYYoKqrpb4DNRg6TUzEXaw/
         ehKpi77IZ1U1LxVy4rJ1Uf9qt/MX8N+Q5ukYNnLmEeIQcVCk/vTkuA5wtvP0j3kgkkAF
         t8OkcX160+z/5rhCaq8JUyvmeI1AxtIca98eA7DjDs1M/VhEVfSJo5Zgac71hm6QlgV+
         WRNA==
X-Gm-Message-State: AOAM530TzSZ4f7x4GgwSmn8lrQFSq65pJdkGM4uY4dJU2DX4eKN5y+hX
        jt37AyvywbICnmh0O+ysEu4=
X-Google-Smtp-Source: ABdhPJyafkncBQDohv0ffJuFFm/BWhBjv4BZS+Wt9MZm4g0m6Ii4HKzzPvfFsqaQL3/E8IZO0mDhVg==
X-Received: by 2002:a1c:9893:: with SMTP id a141mr3595787wme.188.1600087284458;
        Mon, 14 Sep 2020 05:41:24 -0700 (PDT)
Received: from localhost.localdomain ([85.153.229.188])
        by smtp.gmail.com with ESMTPSA id q4sm22239232wru.65.2020.09.14.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 05:41:23 -0700 (PDT)
From:   Necip Fazil Yildiran <fazilyildiran@gmail.com>
To:     nsekhar@ti.com
Cc:     bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pgazz.com, jeho@cs.utexas.edu,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>
Subject: [PATCH] ARM: davinci: fix kconfig dependency warning when !PINCTRL
Date:   Mon, 14 Sep 2020 15:38:50 +0300
Message-Id: <20200914123848.307406-1-fazilyildiran@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ARCH_DAVINCI is enabled and PINCTRL is disabled, it results
in the following Kbuild warning:

WARNING: unmet direct dependencies detected for PINCTRL_SINGLE
  Depends on [n]: PINCTRL [=n] && OF [=y] && HAS_IOMEM [=y]
  Selected by [y]:
  - ARCH_DAVINCI [=y] && ARCH_MULTI_V5 [=y]

The reason is that ARCH_DAVINCI selects PINCTRL_SINGLE without depending on
or selecting PINCTRL while PINCTRL_SINGLE is subordinate to PINCTRL.

Honor the kconfig menu hierarchy to remove kconfig dependency warnings.

Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index f56ff8c24043..e0cbcda6f087 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -11,6 +11,7 @@ menuconfig ARCH_DAVINCI
 	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	select HAVE_IDE
+	select PINCTRL
 	select PINCTRL_SINGLE
 
 if ARCH_DAVINCI
-- 
2.25.1

