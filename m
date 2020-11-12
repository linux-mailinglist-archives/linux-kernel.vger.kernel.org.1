Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B82AFC93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgKLBjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgKLAm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:42:57 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DF7C061A49
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:41:43 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so2658678pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 16:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mjmuykYc+6IRfxhnFcBNshn4ZYHI8kwWAl9SmNJjnjo=;
        b=oYREcqIjRfeGgYSa+Ns0rz8Tfd1HDvVS0d5qrfnZXJnQVf5ySnqni8KSmbneWQMwWK
         TYgeRiLAAauZXt5IWSADfbMND/cBsxhNO1rcZPgNHImCUbOxmiPVJaapXKwXDh3VtaYl
         Hyh6GxKxYABOE9tfSgxuAEatQxAx1bcVBA1Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mjmuykYc+6IRfxhnFcBNshn4ZYHI8kwWAl9SmNJjnjo=;
        b=FqJw6O71qtWl8pamsgSBZcuVgE4hKQJETTcLNTY76ZYrNDLdfJwlceFsE5WSuoFfsH
         1ytobBT91xSN9O87tTLnG5v/LZkM4oAqnK6pIqza8X2/nY8Cbmsxul7XTeY1/rF+teqK
         aK1jqOf4VP5DIkAF4qWmJwVpZiAfJFtQVyYbf3aDtfmM9JDM7BzFjrw7HXNZRblicR2V
         yT0024yKs6ARvPnHwr2sOj6XTA/Pevw24getRw7u/QiuTMY+YsWtMbyCho+VaflngjNj
         Fy5A4KADaFFQcrbp80Nr7gf2BvO90TZ43LQFriI7neApiU5/85x6LQzCkmKB8tGjH0Ui
         Y+oA==
X-Gm-Message-State: AOAM532VBHFhDudwtkC3xmvndgPkriXaV42sK7DEpQrRVt9z/6xYPGBs
        TDnHDfTN7UGNDHsD1it1N7KARA==
X-Google-Smtp-Source: ABdhPJxNiNr76eWFWPlZHLuQbAmuo6F5QkCNJ1QV8I9Pl2aPhpzBTSc7Kfd7HnXMo21gM8r5jGxEWg==
X-Received: by 2002:a63:6a82:: with SMTP id f124mr270270pgc.236.1605141702977;
        Wed, 11 Nov 2020 16:41:42 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id t26sm4265522pfl.72.2020.11.11.16.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 16:41:42 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     jkosina@suse.cz, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     andrea@borgia.bo.it, robh+dt@kernel.org,
        kai.heng.feng@canonical.com, swboyd@chromium.org,
        linux-input@vger.kernel.org, hdegoede@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] arm64: defconfig: Update config names for i2c-hid rejigger
Date:   Wed, 11 Nov 2020 16:41:28 -0800
Message-Id: <20201111164027.v6.2.Ic9788bdfc4cce7569f8d25e7fb52a208fb643eac@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112004130.17290-1-dianders@chromium.org>
References: <20201112004130.17290-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-hid driver has been split in two.  Let's enable both halves.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v4)

Changes in v4:
- ("arm64: defconfig: Update config names for i2c-hid rejigger") new for v4.

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5cfe3cf6f2ac..9258d623331e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -725,7 +725,8 @@ CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
-CONFIG_I2C_HID=m
+CONFIG_I2C_HID_ACPI=m
+CONFIG_I2C_HID_OF=m
 CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.29.2.222.g5d2a92d10f8-goog

