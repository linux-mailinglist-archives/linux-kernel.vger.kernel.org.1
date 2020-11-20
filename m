Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668D52BAEC5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgKTPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgKTPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:21:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD6CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s8so10369453wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXiV9Li6Gzw58hiPq/fubdVlImNlOBK+T4IMOGniTMA=;
        b=wqHViqLZic/xzEGbpNGGWb0aACDCsw7OcBXmPBr3/2kvbpOUHhEEXqnm+SJyncRguc
         Rob18eQ+YH8M6FybIfhdjhf9kgIm3UF4uO5wsJVq1N+oarOz5XcVQCUl/3Ew9sgoxHUH
         1jwmBBun/b9yt5TQdHxRhQQZlQLIgiQuJUNi8UkVmfVzm5CvLn86yd9bfSnxXKvEwqrd
         h0pd62kvfhzEP0b+CgV7oHHBXr5yf98LL2mqdqu3NEhloO0jcuFRfDD5/v63/KqZjiFx
         xoRsj+x9kxRgsgsrHHwMWcLxqdKjvwcGNbHtmo782qlfJb4fQgx+q54+3G6yovLVHzPQ
         V5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXiV9Li6Gzw58hiPq/fubdVlImNlOBK+T4IMOGniTMA=;
        b=UgjJ7Fwn0ujZt5X49Ew482mYtKoQa5lg0aDwOkSLyEwQ6L5JgiBBoLBGdg1XeZuJMH
         Ei6EfUBNk8JZjx+EaqJUCAVNvD5KpC4GazlSgY31h/lUq2xIaUWlZNLQ2k2l/1gmhWZN
         MgNIPwGlT2P0sKPZ4LDsR9wIIqFxEnOonpQsXb850YvyNUMKgjZSKQHH+pk8mcsbwYO7
         gSCrxi+if1bRVSfwGTvVvbetLmVDQognVbA80N9cGnraIa2AFiaWI2TfDSuQy0Ibue2t
         gihyh22fKwacf3upYZxc3j6LgcA7Y/NiVmz+G+6hWMDkUZIxNNu4zPieIk/R4QDjj/9n
         QGkg==
X-Gm-Message-State: AOAM530wLLDK8VheGAFlSgZ8Deqp04dCAhJTRo18SKGE5IQ9sFsOj6Eq
        cBSpXDfv38kYZ1zU515+swk59WDDp/b0UA3A
X-Google-Smtp-Source: ABdhPJxN8bdbpq5Skc+DT37MUOGZczE2KTzlo7q/cC86uuv4Og4BqMHQ/+ZewWGZwSO6RzXgpgwT9Q==
X-Received: by 2002:adf:ee12:: with SMTP id y18mr16098633wrn.231.1605885694855;
        Fri, 20 Nov 2020 07:21:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id j71sm4773757wmj.10.2020.11.20.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:21:34 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
Date:   Fri, 20 Nov 2020 16:21:29 +0100
Message-Id: <20201120152131.3918814-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Power Controller and MIPI DSI PHY nodes to AXG, since the corresponding
driver and dt-bindings had been applied for next release.

Dependencies:
- Patch 1: [1] applied for 5.11 in meson-clk tree & [2] merged for 5.10
- Patch 2: [3] & [4] both applied for 5.11 in phy tree

[1] https://lore.kernel.org/r/20200915124553.8056-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20200917064702.1459-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20201116101315.71720-1-narmstrong@baylibre.com
[4] https://lore.kernel.org/r/20201116101647.73448-1-narmstrong@baylibre.com

Neil Armstrong (2):
  arm64: dts: meson-axg: add PWRC node
  arm64: dts: meson-axg: add MIPI DSI PHY nodes

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

-- 
2.25.1

