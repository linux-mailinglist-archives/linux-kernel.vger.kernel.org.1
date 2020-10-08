Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C16286C25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgJHAou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgJHAot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:44:49 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C72C061755;
        Wed,  7 Oct 2020 17:44:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n14so2553159pff.6;
        Wed, 07 Oct 2020 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HsOxf8FLpymzKU+uXkOBR/Ti5n329bSmTczvRZ1h+Cg=;
        b=ezGtxoetaqpds7tIPeMpfDX/bl8H2Z0W8Meu8kiVmDiQKyZSHdWkx0rzDDtGRrGFre
         FqILIDJVJ3v+NqkNpm/U+hdzIiPz/IUryeYMjvcp1OiDucE25IDSVqnPGC3e8bB3I+In
         EMWXSNDnq0Yb629SahagN1Hs2J14UrF0wfDcARaYt7p15SX1Fkv+0rbM2GX467xvKn2w
         dLynzxhcjiQXvVAjgd0ipo3W4FVeufNTjLfWK+OzD81hqfIz0PcGFfddPorBYmFyCaV7
         N+9uOe1CyWImGVoOhgUsM8grBSHqYKwE/2fQO/yKYSzMEcvZHk32VftfE5ugKA7+/FmY
         hstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HsOxf8FLpymzKU+uXkOBR/Ti5n329bSmTczvRZ1h+Cg=;
        b=NHp9jJewUNKMNw4Ffp0Jj/KtinWZkMCVka8FOdPbrLTrydwnMKvpgqvMBKzTv2xfAN
         iI+vuD8hGUiHn1OkBMNi4PAgkuM6agyXUzDNaWjrgoaZQ9kPFrNxPPj/s6kj04frf5Ks
         bt6AeAVlW7jZb76jLxri/ObqeT7oSesO9ZpJhU4bf9BxhXJYlTeSGM95ORjtiGpTCTD1
         5owK1NTvNczOBeWVcWqlEyHXZx6kBTC5FNfSAgawl5HuHj7Aa7fQhWAOz9GNMyIHbSfk
         ZOhZJGMw0z78/Sr7tRRxrZQgaxSVdbLH7Xw600IebprJdLX1BrTBPoBjTwmOqpaS3TLB
         Atmg==
X-Gm-Message-State: AOAM532BEw40NAN368pngXUCIghWt1PC+z/HJoJwAX08j/J3MMMLhrTZ
        8BRRH5MPTyHUy5U1bfwJ6l0=
X-Google-Smtp-Source: ABdhPJyRbBQNbRzvh3oAHhJLZngZsv7w0jFvGZFRIp4+AmCaImz/7wDbD8L5w64syGPTvKteehsp+A==
X-Received: by 2002:a65:620e:: with SMTP id d14mr5209764pgv.363.1602117887168;
        Wed, 07 Oct 2020 17:44:47 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z6sm4939922pfg.12.2020.10.07.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 17:44:46 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     krzk@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] memory: tegra: Fix client list and add swgroups
Date:   Wed,  7 Oct 2020 17:37:41 -0700
Message-Id: <20201008003746.25659-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has two fixes of tegra210_mc_clients, and three
changes to add missing swgroups, according to Tegra X1 TRM.

Nicolin Chen (5):
  memory: tegra: Correct la.reg address of seswr
  memory: tegra: Correct tegra210_mc_clients def values
  memory: tegra: Sort tegra210_swgroups by reg address
  dt-bindings: memory: tegra: Add missing swgroups
  memory: tegra: Complete tegra210_swgroups

 drivers/memory/tegra/tegra210.c          | 60 ++++++++++++++----------
 include/dt-bindings/memory/tegra210-mc.h | 10 ++++
 2 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.17.1

