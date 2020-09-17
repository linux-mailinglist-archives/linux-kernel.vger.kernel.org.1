Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512F26D3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIQGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:47:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7482C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so767029wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7MJ+UVtQpiqh77LaOlNWIMQ2UBN3Iq/YPPC243q1uU=;
        b=rhosCPsIL+txjRR7CWwZAAHAQ9ZMpXPHQM3zYAhr+rS3UdzolUMM/jmzE3H71QiIkw
         j39Ixkq37vxxZUaiw2sc+h641ONHSBxTbp0AETXFyIdAKF0l1o8ktvMmWZ8+854rHCnx
         SxAc54kbsmeYay3PcxpMxWMk/IjizR+Y4KYpajCk0aBXzSA8SPvSIDd/kbNaVWq461W4
         mcIKblH6OThb2NlORpYHcggm8Ic6PG59b3ML38A7D5kcQJyBYu7fyVtqBTxszkA2TsOj
         rrevSQq4HPvCfS34QxdKnBo6bOyxZBFQH3Pd9XkRwiWV8GA90gXMjqG77Jjw83xyGpim
         MCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7MJ+UVtQpiqh77LaOlNWIMQ2UBN3Iq/YPPC243q1uU=;
        b=g/Hr5p3bfY3+TC04LoV/J0I+2JKG0KRvA4q1sMULQYcBA/nS7GRS/bq9rmaFOq8bJ+
         5s1VMDMagxMbQ2qNpigSerxz2TIr5y8Go+rK+8QCbOe81uFpFbEq35Svui0xmQ7cseya
         Dmc67ZFnK/OS4xUxMYKftet9zqLPjZq3d2dmi6IBThQA+RC4oFOvkqwa8m8Spmy8c4wl
         WS7/tnSTpB3NV95ZU1Ke50e3+3MrOQHhrtUr/5TlZJ28CZS6UWNFgNtI/oCEq0DM3stA
         wjU30iLj6y62vWt3FweVu1GBBscVfvGwebYbmy86PR8SZzUDKSh4ikD4u3TvQ0WXy2rj
         Y6jQ==
X-Gm-Message-State: AOAM531JNqZgo5UUpkn56jk+nbAgGRsSAnqInoCIzmcrqkhxfqWyqPyh
        z1J6LMnet8ldukuK3n6c1lJyUQ==
X-Google-Smtp-Source: ABdhPJyuPXRW53dxkIFbsZRAjQoU3OFF79OiKWZIp7zOo6DgOkw6DMhuOPyAEsCdjV1Eg/lYSoP1FA==
X-Received: by 2002:adf:e312:: with SMTP id b18mr7633760wrj.372.1600325227740;
        Wed, 16 Sep 2020 23:47:07 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q4sm38516552wru.65.2020.09.16.23.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:47:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] soc: amlogic: add support for the Meson AXG Power Controller
Date:   Thu, 17 Sep 2020 08:47:00 +0200
Message-Id: <20200917064702.1459-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the bindings and support for the Power Controller found in the
Amlogic AXG SoCs.

The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
but with less VPU memory domains to enable and a supplementary Audio
memory power domain.

Changes since v1 at [1]:
- Collected review & ack tags
- Reordered structs as requested by martin in patch 2

[1] http://lore.kernel.org/r/20200904161654.24141-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power
    controller bindings
  soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs

 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 ++++++++++++++--
 drivers/soc/amlogic/meson-ee-pwrc.c           | 26 +++++++++++++++++++
 include/dt-bindings/power/meson-axg-power.h   | 14 ++++++++++
 3 files changed, 61 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-axg-power.h

-- 
2.22.0

