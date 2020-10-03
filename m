Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B128248F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgJCOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJCOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:19:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AFEC0613D0;
        Sat,  3 Oct 2020 07:19:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so4563688wme.1;
        Sat, 03 Oct 2020 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAKeLC7pKBrSZOIJOxRnqxVieh8N56D+SKtFZ1KaxX0=;
        b=OM5gZ26qxRLmtq3I0KrEhNN1Ve7bUeZ5qW6c2m+KV3XDw+XP6F5HqAN3aFsBoqh8/R
         r5EXMUPngagmQJ7ZJholjm7QwETF1PfOB3Xb523NuW6hZA6u3QkQMehgAUhPAB470rkm
         WHhTeJ7td0LNj4Gu3DHDpUOMI2dmdf+tSrrZLE5/1d+rwZGtgrHEs/XVMtd2Yp1pQLu+
         7ZGUy0XtT1GdMyKfga3jgcE/Cu8HeGl+a+9PtDYOrkh/mQKaxiGMmUdmQYnNI1Cu/7t1
         BvoDjDzc92Lry8+4eHcryQXaeALTKc3wo9rtquDtuSYTLXigTYuUqVWeCDrMWhtktc5G
         MePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAKeLC7pKBrSZOIJOxRnqxVieh8N56D+SKtFZ1KaxX0=;
        b=d2/NgBJUiNwRw1gLnYkxW4GcPGeIhFt9sYstghmjJJ/OGz0rhrb5ISoNoUEmaNDVif
         EdZahOyMd9M1FOXbsZhj8jSClFgGdNxZEFJU0uAmbVxeQoBrIz+p4LS+QQZCfe4MPZBo
         HEyj0lq7Xcriwvne9fvnRtV4cP3ITAfPOQVrzomyCo3js+yNXzP1wvLHjnTQTH+8YzIX
         xNShjUfWtqNnsuQfoNxZomiYT4YyNlXEK/uraNJGyZvsXkLvQS2VpfZguD4WPBa4BE+4
         0zSmAsGIGo4ZldRbqBvsCMwXIjG+dBbJ0WB6F9X4tC8ogF/2Q4kdv6Xq9AQ3tHZIE7UZ
         tKdA==
X-Gm-Message-State: AOAM5313lbAJFBPDyU+0niGDjT7dUDp2xoB+DcvW9ABsoV1I3hKgto3m
        UwzqjwSd3nSHRFAs/3xC7RE=
X-Google-Smtp-Source: ABdhPJyTeQ1m65Ns5vfNh53o537krrvtVOgQyCvbeT2a8kq2REcyo1Fx0HsdEvdPwNM5+u1CS7dBuQ==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr7667470wmi.149.1601734794185;
        Sat, 03 Oct 2020 07:19:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:19:52 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 00/14] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Sat,  3 Oct 2020 16:19:36 +0200
Message-Id: <20201003141950.455829-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To avoid using set-tdm property of the simple-soundcard we will introduce
a specific soundcard for Allwinner HDMI later.

So I have dropped the simple-soundcard, the title of the serie is no more
relevent...

Regards,
Clement

Change since v5:
- Drop HDMI simple soundcard
- Collect Chen-Yu Tsai tags
- Configure channels from 9 to 15.
- Remove DMA RX for H3/H5
- Fix Documentation for H3/H5

Change since v4:
- add more comment on get_wss() and set_channel_cfg() patch
- merge soundcard and DAI HDMI patches

Change since v3:
- add Samuel Holland patch to reconfigure FIFO_TX_REG when suspend is enabled
- readd inversion to H6 LRCK sun50i_h6_i2s_set_soc_fmt()
- Fix get_wss() for sun4i
- Add a commit to fix checkpatch warning

Change since v2:
- rebase on next-20200918
- drop revert LRCK polarity patch
- readd simple-audio-card,frame-inversion in dts
- Add patch for changing set_chan_cfg params

Change since v1:
- rebase on next-20200828
- add revert LRCK polarity
- remove all simple-audio-card,frame-inversion in dts
- add Ondrej patches for Orange Pi board
- Add arm64 defconfig patch

*** BLURB HERE ***

Clément Péron (6):
  ASoC: sun4i-i2s: Change set_chan_cfg() params
  ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
  ASoC: sun4i-i2s: Fix sun8i volatile regs
  ASoC: sun4i-i2s: fix coding-style for callback definition
  arm64: defconfig: Enable Allwinner i2s driver
  dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel
    possibility

Jernej Skrabec (3):
  ASoC: sun4i-i2s: Add support for H6 I2S
  dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
  arm64: dts: allwinner: h6: Add I2S1 node

Marcus Cooper (4):
  ASoC: sun4i-i2s: Set sign extend sample
  ASoc: sun4i-i2s: Add 20 and 24 bit support
  arm64: dts: allwinner: a64: Add I2S2 node
  arm: dts: sunxi: h3/h5: Add I2S2 node

Samuel Holland (1):
  ASoC: sun4i-i2s: Fix setting of FIFO modes

 .../sound/allwinner,sun4i-a10-i2s.yaml        |   6 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  13 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  14 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  13 +
 arch/arm64/configs/defconfig                  |   1 +
 sound/soc/sunxi/sun4i-i2s.c                   | 376 +++++++++++++++---
 6 files changed, 368 insertions(+), 55 deletions(-)

-- 
2.25.1

