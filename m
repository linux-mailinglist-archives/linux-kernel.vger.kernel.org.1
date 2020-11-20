Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C982BAEFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgKTPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKTPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:32:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CCC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so10721929wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPtNFz54pGGMRSi9xtTjKB8mQ3p80G/kbgan9jWXNMI=;
        b=mqJFFuhS06h704ewqAtsJFpB7SF8d0uemfdgy0lN1W1Zwl22T/KykIYLLBCXxNUI9V
         Q4IaMjEAOZ5sWnXKFo8eSzZVgmnD/6LXl4Mf6tGZum33sHT+c76HtYiZYru31w2NhQj6
         A0Zh9vtT52wt2XGyn3hUx7y/VjfiKuVVBAy89EkaynS28Ssaw/aiu8NglmcDlMNZzJrb
         zpQWU+Sw5agM5oViilF4ipXJEW2ARDMy/p9Ri7UALP/EU0vtrdkSRjwgwVrhMyycrsDJ
         5oMnnC4Kb9KlZ3z9Wi5h6mXL6zde29MN750HLNUGa2JyvGpsupdte/ocVVHuvnV2ohtV
         A71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPtNFz54pGGMRSi9xtTjKB8mQ3p80G/kbgan9jWXNMI=;
        b=un/jxHgXjTYOMnmMlVPwmvk0EX3o9IswnzPiz7azMzToy3vh2/TiNbOb3C0hDig9V5
         UzK9MXoQxYBdSlhyi5bRMDUWhgShaazsWnXOytoehkuqaLO2XvxYXWthYlf4VqnUG0fC
         a+w9C5E6FHW2pBlJbA63PEs4Y2LB5Ft09r3RqChupXryMoGfwbRoVUqjpYqshA/X9G2f
         lBlzK0GxrnWbkeSutFyECJQWdvThd2C5ynGeC/O4aS1BzDaT5TFoPmN6hlf4EUoxvJI3
         /sJb2R4hxwczNkWRSHZDVcNoLblpXozb3DSujkgyHI1STazR4o6GIqRPQwUbwuSDk3sL
         sWoA==
X-Gm-Message-State: AOAM5301EEQ5vdKj27C2kBWm80mI7+fT1WVPcsjv3IJ4yXUdVKrkK23S
        HPT1ONN5f979bCcibTV6Rb7wRQ==
X-Google-Smtp-Source: ABdhPJw07YcQpTr4Hs0NbjodcjQli7NoI0JLjS+1XtT978vtBof3DrAfdWYinxme1GuXaWy28XkVtw==
X-Received: by 2002:a1c:44d4:: with SMTP id r203mr10460587wma.60.1605886352773;
        Fri, 20 Nov 2020 07:32:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id i16sm5398180wru.92.2020.11.20.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:32:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/4] arm64: dts: meson-axg-s400: add support for USB and PCIe
Date:   Fri, 20 Nov 2020 16:32:25 +0100
Message-Id: <20201120153229.3920123-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the USB and PCIe to AXG, and enables USB & the two M.2 PCIe ports on the S400 board.

Dependencies:
- Patch 1, 2, 4: None
- Patch 3: [1] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY

[1] https://lore.kernel.org/r/20201120152131.3918814-1-narmstrong@baylibre.com

Neil Armstrong (4):
  arm64: dts: meson-axg: add USB nodes
  arm64: dts: meson-axg-s400: enable USB OTG
  arm64: dts: meson-axg: add PCIe nodes
  arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  16 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 111 ++++++++++++++++++
 2 files changed, 127 insertions(+)

-- 
2.25.1

