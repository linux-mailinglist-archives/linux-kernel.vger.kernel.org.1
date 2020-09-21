Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F32719C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIUEOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgIUEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:14:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B873FC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:14:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so8150768pff.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7829AfRT6LvbLjz9XeDro4FUjlC8JvfoISGdbWocU0=;
        b=Ax8vlAeB60K7VxwqjgTm+4y+YjZoqTXAE/+iKq0Gl6phrxj06l4z/57g70tDMdKRnt
         P6f8T6MarPu6KuZv6/zdMpnalFdkdizCNkyMPmLLnYT6jLPMZnFtTsG9+Rsfez/TE70I
         xa/ooqfmxB0pDSrrcWDkVI8TmbOoiYZAg5l74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7829AfRT6LvbLjz9XeDro4FUjlC8JvfoISGdbWocU0=;
        b=K4Fz2qF2UHybd8/bpHAZ9ksR7ncRZNZv0Uzh/fiM77qTYx2WuOuZN/oxsQXJDnyjo7
         ww7tlKRJ73EMo7YpRyFNFGeWFYBj9xTZaqCF87cRfVPDBsMCIgl2yY6UragkJIYr/gNy
         PU3Rhyr9zXogLjXz8c7josVD9iiCk8SFOSnv8/eqJ5vCUKf1L0eWmFtBn8iG4EX6Chxi
         MoNYWxlUwgyQ1xxEq2CJFzRoNJ9w74xoUfsLbSKXbKhKMQGc6yufUPGxzzCybTWeavXI
         13i7KvzPVSLeVowBQs8Z6a2cu3d033De42G/f9v285tIpg8fuuPelNL3aOIsP2Yh9CrF
         j65A==
X-Gm-Message-State: AOAM532Af+Q1Anra1a9+rg8rD+bWUfyibhdK29HkxBuPonDtDfSmdn2t
        +JO6FBw0ofys86dibQ4y76rxeg==
X-Google-Smtp-Source: ABdhPJxF2RiligLadfSfXIzQiHaHina12UJBS42E0zRZ9Ka91X39OXKvsPKp2DU/FWZ/lS6FAXuDog==
X-Received: by 2002:a63:6782:: with SMTP id b124mr37636930pgc.308.1600661676013;
        Sun, 20 Sep 2020 21:14:36 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id m13sm10439167pfk.103.2020.09.20.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 21:14:35 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Feng Tang <feng.tang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [RFC PATCH] arm64: dts: mt8183: Add arm,no-tick-in-suspend
Date:   Mon, 21 Sep 2020 12:14:24 +0800
Message-Id: <20200921121420.RFC.1.I30d6887e950575eb1fd92ee56ab5d50ff64c97f3@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The armv8-timer on MT8183 (kukui family) actually ticks in suspend,
but its precision is so low (measured 400+ ppm -- 35 seconds/day)
that it's actually better to use a fallback option (RTC).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
We asked MTK if there is anything that can be done to make the
archtimer more precise in suspend, but that does not seem to
be possible.

Ideally we'd like a arm,tick-in-suspend-but-use-something-else-if-possible
property, but the rating in [1] cannot be used, as the RTC
fallback is handled separately [2].

I don't know if this kind of issues happened in the past, one
possible compromise is to add the option to kukui board only,
since we _know_ there is an RTC there (which, technically, may
not be the case on every single MT8183 platform).

A more complete solution would involved quite a bit of
refactoring in the timekeeping/rtc framework.

[1] https://elixir.bootlin.com/linux/v5.8/source/kernel/time/clocksource.c#L486
[2] https://elixir.bootlin.com/linux/v5.8/source/kernel/time/timekeeping.c#L1693

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index f9b60e3d085c..ebcb2309017d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -219,6 +219,7 @@ timer {
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+		arm,no-tick-in-suspend;
 	};
 
 	soc {
-- 
2.28.0.681.g6f77f65b4e-goog

