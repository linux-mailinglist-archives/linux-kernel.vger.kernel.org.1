Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402AA1E3FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgE0L0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgE0L0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F81C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z6so28403091ljm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWRYWz8j8QnnnM8ufaAXpNzsDpZkkNcBRIK2qhhydRM=;
        b=Xu6sjpfTRcKeL67QCgUgs7cBy6Ma6/R/KaBHq9H5Ngab54V9as90JwaXrpLCNyFuQ2
         LfzdvPQVwIp4icx/gd/fEBON/h49xest5MkZQU3piml2IcOpVpDg6TjIp89fJbJygEWk
         mqh2juZbpw7Y83y3tQL8imqesNsItGL406+aEYDPJyZj9XDfah91mKSl7xWFdR7HBD4+
         /cDoWFNXac2nzEnDVaX9ZEXCBzpjvaZWNx3l7b7YSG1Nyt4uUXmOIiyDdPk+FcnIqPOy
         /0nPh/++3YholLJfcqXm4X9PSQzRWSVCQXSaMeC7AtdUEA17awgYdSw1oGPou6M8s4sJ
         QupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lWRYWz8j8QnnnM8ufaAXpNzsDpZkkNcBRIK2qhhydRM=;
        b=DZu1QK83poMEpIwWEImwpwESWu2ta8jdDI6+0ggizAAzMwUGUV0NtvloazS2do9Jmb
         2oEGXTO/BLeTBL28UZZ5U8udabvtuFjFiUQc8xrSDPKL9ReJjwbA6PQXBqPkcy2c5Tyc
         Lvnlbdnll3xCzX4aFbIJWfxW0mHRBB2MU56tp3BpRavb6ohcD9srvPo//7SuB2cTQhUs
         Rl4rTyu3ctagkGRzv1iVcApAavADv1E0M1Cgu/ZwOhyh3Bz079bDwEPJScBjzEVJZxrH
         FmCMtaJ4ipt0NVvq+VlUsDEGNuBvEDlaHfOHNNTcr8Oxk0b41+SFatZUmNwZ9REXcHCU
         mPoQ==
X-Gm-Message-State: AOAM532JDQi6iulRNkmXXQxKLhQ37h4ZUoy4fBMCY46L6Bzsl+GFOkCd
        KBqYOrGgsY9xr9NtJXY3tF6UFQ==
X-Google-Smtp-Source: ABdhPJwUCC5ItOzijFp1n+ALKMHGKknZgz0Oa6TXm5dDosIRP2//Fby7ngZQ+3NlCiiSDFr+PqMaag==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr2708235ljh.274.1590578774453;
        Wed, 27 May 2020 04:26:14 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id s8sm750146lfd.61.2020.05.27.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:13 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 0/5] vexpress: modularize power reset driver
Date:   Wed, 27 May 2020 13:26:03 +0200
Message-Id: <20200527112608.3886105-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset contains a bugfixe, a cleanup and fixes allmodconfig build breakages
on arm and arm64. Also making the vexpress power reset driver a module.

Cheers,
Anders

Anders Roxell (5):
  power: vexpress: add suppress_bind_attrs to true
  power: vexpress: cleanup: use builtin_platform_driver
  Revert "ARM: vexpress: Don't select VEXPRESS_CONFIG"
  power: reset: vexpress: fix build issue
  power: vexpress: make the reset driver a module

 arch/arm/mach-vexpress/Kconfig          | 2 +-
 drivers/power/reset/Kconfig             | 3 ++-
 drivers/power/reset/vexpress-poweroff.c | 8 +++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.26.2

