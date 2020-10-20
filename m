Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE72935B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405064AbgJTHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbgJTHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:25:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC0FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t9so789110wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEFMnxSYcHzHuFUbo0zFEMoIVWyQpDgYm3OYOo8liu4=;
        b=oqUSsJfYyMR0qdVYAT8DJfdmbIuV4dzSvreEQ0KrMuR5b+nRhm5SEIDw9ka7qJ5Jdy
         4sohRzMrOun2jayvNDiRqP70lQwW9uyx/XpKl32DApxxj3KPr1wgE6W+SN9HMvM5ADNl
         FBE1qtMLOvkt4trdPcdRFb9wMKbNtNPJ1Bi/v+FzvxpmzxDKtwBIEkd9hBPKGbiSDGJE
         4QeVX0hqAnZgCBFUJwEte4QkJsUcLfya79daN9HAFWxSd9SswzOeXVEGWl09r3glKwYn
         QQ2PxYHM9gDGa5JPdZytr9n5g0HRU8IEz7x0uiQ7ud58eH5Jp9gRY4c0ey3pHKW9A2sr
         8TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IEFMnxSYcHzHuFUbo0zFEMoIVWyQpDgYm3OYOo8liu4=;
        b=e20WJJirH0i1kHQpk/OzBr0THAD7YrD1YinAwuETCUjbrjc4A2nGHjLjKtS1nKSPHO
         ga+NptlgS75JU3V6OgEULsv6CgEldN0lvkRW5ZkkT066T+nH6jSriPDR+TBV5oT6DCEi
         NNu8OJJXoHqsc9j3dKnqa2UwBes4Jb4J5ikly/AUtP5OIEPyMzIJjAfpFWTRWTYkvcXy
         CLFDSh12dGp8fJSDgNFNTboPTrM0cFAeqXRTnBTzXPBxuQK/9FXibGr87sRxZGb9BCR7
         JIRvHEp5/A5ulcmJmxrMJkhvqMXdsLvof80oRVNOamgsbtBuv5z7IGbsL/bSwM+dA6ZA
         eCXw==
X-Gm-Message-State: AOAM531B0owjNXQmmidvKIRDz1Y1jv2jTZhGKPK2P5FTm2c8yW4+gNxM
        SybQTGrsW3blPYVhJbJ3Jjm5WA==
X-Google-Smtp-Source: ABdhPJzU3Qj+3oNMENhW9UqVjVo/iWG3zTuPR0LYynPXfimx6ZaX6hftSWYCEzTdIywouToAgX68Qg==
X-Received: by 2002:a5d:684d:: with SMTP id o13mr1945044wrw.302.1603178736579;
        Tue, 20 Oct 2020 00:25:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:3c62:4f82:8f5f:de74])
        by smtp.gmail.com with ESMTPSA id j5sm1487325wrx.88.2020.10.20.00.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 00:25:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
Date:   Tue, 20 Oct 2020 09:25:30 +0200
Message-Id: <20201020072532.949137-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the Amlogic GPIO IRQ controller as a module
by switching it to a platform driver.

The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to allow
building the driver as module.

Neil Armstrong (2):
  irqchip: irq-meson-gpio: make it possible to build as a module
  arm64: meson: remove MESON_IRQ_GPIO selection

 arch/arm64/Kconfig.platforms     |  1 -
 drivers/irqchip/Kconfig          |  5 +-
 drivers/irqchip/irq-meson-gpio.c | 89 ++++++++++++++++++++------------
 3 files changed, 59 insertions(+), 36 deletions(-)

-- 
2.25.1

