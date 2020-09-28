Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B0427AAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1J00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgI1J00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:26:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79098C061755;
        Mon, 28 Sep 2020 02:26:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so1962456pju.1;
        Mon, 28 Sep 2020 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGDzXokaTr5t9IfkNwc6PyW3nW8aWxgsb1wMnm4Xu5E=;
        b=vNqs15Hj21aVyPH7CGzxoqyQlUKY9LLwvWfUkiElc6/oW2ANZ0aGGhD5VHz97Cwvf0
         llOgYV9wZ6DYzBNsCRcf6bKYk9iNdQCLY9ahP5AECSKxjumE3+dWajKv9piDY0z/X+bK
         BYCpLtXbJauwXzK2ZQHP3FNFLgrUYpYcFXOPnBeif0/tBEIpwFl1QaSDxixDxRTQf2HP
         ZoKHXUNpLctmk9T3geArOyImmZ10wYuVH1jZ5PTGYBQjaIFASQEQDjB0nP3y5QvBHGpz
         SFrwEkg1r78EDyRo4JBZAN5hMA5VmzcJnPbGIwAbvqVOl0jT403LPv9FxxtrBKbGP2+N
         iHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGDzXokaTr5t9IfkNwc6PyW3nW8aWxgsb1wMnm4Xu5E=;
        b=a2p4bgMeFKf8+0oSi5hW2/3nCO64b1+8VLcZbL2DyG6kCFsCC1malct/CL3tsdDLGa
         RxdJh4qvGH3MXAVANZmuVRx3vFqlTKMz5JA6W0xpjV9bWDXIVuHGjN6WUuLnoHQ+wJZJ
         8Ng12Ix6E2Pv0pqJN7Jvd3bOQt+AwloGLb8k52Ffbq/xeyvr7VpqLK9bM2fl72WgphgG
         gFDJ0rXw2fyRssV3hdv483knlRShIT/pd8YUl+t/wPQtLCpgVcL/uhwpYiQbc1pTdm1z
         FA6gnJg5hCEVuElnORoBp34/ktnRK7yB8rA27+jye7njz5m9AWb8WLJj3ZRuk5hvFMnv
         EFAA==
X-Gm-Message-State: AOAM530HbtY0lPhY2RvUmqJbek75c1mgZdTWmq6SUIIutMACw4LBIo2F
        yAfX/KZo+o6K6oblBQgARYXwhblFeFcgz3A1
X-Google-Smtp-Source: ABdhPJy5FcM+10JX+iYSG9ziQoKTcOlBtcoy9UYP+cmh3/gPtKcrvWvfTS3j1EH6NAecuDwDvVxEjg==
X-Received: by 2002:a17:90a:e015:: with SMTP id u21mr493220pjy.33.1601285186073;
        Mon, 28 Sep 2020 02:26:26 -0700 (PDT)
Received: from localhost.localdomain (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id mt8sm638606pjb.17.2020.09.28.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:26:25 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 0/2] arm64: dts: meson: VIM2 updates
Date:   Mon, 28 Sep 2020 17:26:11 +0800
Message-Id: <20200928092613.273998-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

small updates and fixes for Khadas VIM2 board dts

Artem Lapkin (2):
  arm64: dts: meson: rename led name on Khadas VIM2 
    meson-gxm-khadas-vim2
  arm64: dts: meson: change spifc max-frequency on Khadas VIM2
    meson-gxm-khadas-vim2

 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

