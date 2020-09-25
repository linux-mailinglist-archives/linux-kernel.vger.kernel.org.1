Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589E2277E87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgIYDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:30:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA0EC0613CE;
        Thu, 24 Sep 2020 20:30:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b17so1079727pji.1;
        Thu, 24 Sep 2020 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aisBv4MuoAdzRa1YD5k9n2OvoHveOSiNe5rPI2LCylk=;
        b=EaT5wJjyX/Ce0/9nXMsJp0rwxCSTxdPdB2U1zZBfHUi1lMlkauqKsZgTS6FPZ1kwL+
         POQ3aNGnfR7wOYyDNm3i568OSqGoDNmxCRUrvfx4FzJG4DBDzuUdu6zGY82Ah/3BVvpQ
         Y4jyCr7Z4a5iGDV9RfU+WnD+naUhjlJWiGUgm22UXEG+vPBH5ibn70QxZHrzuGjdOaT5
         wysW5rx6L7N4ryYSNibEIsZC7ESwZBZybFfc+as/GGvbGS+A8XM9ccPoC5UevnzOIPSH
         wN4U7AdaAjRdmr6/RkDs0GvDppnb2cLLW8W1BFF2/KWcnixxBqafYlLkXQDK0Pvin0fh
         p6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aisBv4MuoAdzRa1YD5k9n2OvoHveOSiNe5rPI2LCylk=;
        b=FR+C20Uxyp5+P9C6HOWvUqCO5FpF6j8ziDEiomndu8R6SZUVcF2MtzXb0dmMSoH2ka
         wPbjI7EZMxACypAZS1OUWuLzdMWs9EHK8JHV60VEM3IMgYEJg+NuapwXCe9YrW+HAjB1
         ZTU37rbf5Umst/47z6+W4g2w8Jf52PNo+kgwZNz6IHHDbpi9JpMyebY0Hol/NYldNHuR
         2zuu/fvynOuKzARQ5oVEtM+377rwyWtxCV8uciQmBV1Dyb6QwYhDAGVRStfRsgyQJ2Vs
         9XFvX35sEg9bz2Dotm/xDlgy02Fd5jIVgb8zPpBp91S49gHsL6RFYD43O7E3PIIfi2ad
         kkqQ==
X-Gm-Message-State: AOAM5309/MdUa2K7wscPYV+Nb6II6XntnAxHMNIxTMBVMXy47G/9eqy8
        znQvJkBw8iW6qIbGG2a4ioE=
X-Google-Smtp-Source: ABdhPJzsq2lBfR0WYt1JwMFaDdGzuVNV17XX786+xa+9TS7JCcm6xRPC3A7NqMzy2pso/BBq2OM0QQ==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr745620pjm.12.1601004646462;
        Thu, 24 Sep 2020 20:30:46 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:30:45 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 0/8] dts updates and fixes for Khadas VIM1 VIM2 VIM3 VIML boards
Date:   Fri, 25 Sep 2020 11:30:09 +0800
Message-Id: <20200925033017.1790973-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dts updates and fixes for Khadas VIM1 VIM2 VIM3 VIML boards

Artem Lapkin (8):
  arm64: dts: meson: update spifc node on Khadas VIM2
    meson-gxm-khadas-vim2
  arm64: dts: meson: update leds node on Khadas VIM3/VIM3L boards
    meson-khadas-vim3
  arm64: dts: meson: update leds node on Khadas VIM3/VIM3L board
    meson-khadas-vim3
  arm64: dts: meson: remove fixed memory size for Khadas VIM3/VIM3L
    meson-khadas-vim3
  arm64: dts: meson: remove reset-gpios from ethernet node for VIM2
    meson-gxm-khadas-vim2
  arm64: dts: meson: disable vrtc for VIM3L boards meson-khadas-vim3
  arm64: dts: meson: enable RTC for VIM1 meson-gxl-s905x-khadas-vim
  arm64: dts: meson: enable RTC for VIM2 meson-gxm-khadas-vim2

 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |  2 +-
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 10 +++++-----
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 19 +++++++++++++++----
 3 files changed, 21 insertions(+), 10 deletions(-)

-- 
2.25.1

