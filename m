Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ADF2DFF72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLUSOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUSOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D9C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k10so10726719wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQbcSVOsPCGaFVLHXPexgbeoL6ycThesvgfDmyuAMdM=;
        b=TjtUeUUL8XFB8w6WM2SKsvg2aJrSoj73Ps+COjP65bpxXKmf+Iux57nUTE5ck/el4E
         DVge4nfCSgjZxjUaztJ0Ly+friOlMb3hp8+9F5BK7Kee6kWndbcgvy4f6mtWVNdYZdw9
         k9kzHYOUDppHyaJeUpmxnqDbYbmixx9+pqkq5fVjzIaHAa5zbG0cnHrkKUZH+j/1ydUt
         j4VeC8GKqaG3uwyWxW6I03yqLRSsbBJn5qyVE1KogmAme0rDftJpZJK5X542UCE7/Vlp
         hcgXskk9u0+Awtr7QAkIMsOWZpx28nTHsWDEgbMeQ+pXx82T8VDw4ndM0/nGnt4+SaB7
         oD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQbcSVOsPCGaFVLHXPexgbeoL6ycThesvgfDmyuAMdM=;
        b=MU1F4jwl9ib+sYlLxpnp4453BIK5un0ikzjnx9dhx6xQ0ySJzI2YAa4g96i/EFNLpp
         hlxwc3cyZ+jOrsxG1MbCXc3/Fv5CxGfIM5hhiGYVJ2EnYCzGtDrZ5Hf8pw63AbueDOpy
         gV6rVnzHo5ZeRe6aJKloaSPL3vsHAT7GN7ZYU6Z18GYI1VpVsh4YAokj5+e+5UrZ6/BY
         r8GBgVkgzkzgzv4rVw/zNgThSveUX4IHjIPjecFhOCKuQt+VoZt4JuffnSZDfXytVwOz
         DOOAdyhtzIeIi9Kinl72PN899SzLkrVJOTQp4+3OxkmTtFM8HSgdLUNPvejUTqRSEKOm
         w0Hg==
X-Gm-Message-State: AOAM5314v68bEKYuC9sbO1G1DOrbOQ1SVVvqID5L1nZK/bCB7FGcz9hR
        Cjs6r5z+hU+l1vKIQp330Oo=
X-Google-Smtp-Source: ABdhPJyeOiJprk7Loi5JMfeVJeXoygn8F3xrMlXyoZ+NdnXtYx5wV+SeSXTz82byTmiVlk7T1BLSYQ==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr17483165wmc.158.1608574417702;
        Mon, 21 Dec 2020 10:13:37 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m11sm23434936wmi.16.2020.12.21.10.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:13:37 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/5] Thermal zone configuration for Meson8/Meson8b/Meson8m2
Date:   Mon, 21 Dec 2020 19:13:01 +0100
Message-Id: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the thermal zone configuration on Meson8/Meson8b/Meson8m2
SoCs. The thermal sensor reading is taken from SAR ADC. With
"generic-adc-thermal" it is then used to configure the thermal zone.

CPU and GPU frequencies can both be managed. The vendor kernel also
manages the number of active GPU pixel processor cores. This is not
supported yet so we skip it.


Martin Blumenstingl (5):
  ARM: dts: meson: move iio-hwmon for the SoC temperature to meson.dtsi
  ARM: dts: meson: add the ADC thermal sensor to meson.dtsi
  ARM: dts: meson8: add the thermal-zones with cooling configuration
  ARM: dts: meson8b: add the thermal-zones with cooling configuration
  ARM: multi_v7_defconfig: Enable support for the ADC thermal sensor

 arch/arm/boot/dts/meson.dtsi              | 12 +++++
 arch/arm/boot/dts/meson8.dtsi             | 54 +++++++++++++++++++++++
 arch/arm/boot/dts/meson8b-ec100.dts       |  5 ---
 arch/arm/boot/dts/meson8b-mxq.dts         |  5 ---
 arch/arm/boot/dts/meson8b-odroidc1.dts    |  5 ---
 arch/arm/boot/dts/meson8b.dtsi            | 54 +++++++++++++++++++++++
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts |  5 ---
 arch/arm/configs/multi_v7_defconfig       |  1 +
 8 files changed, 121 insertions(+), 20 deletions(-)

-- 
2.29.2

