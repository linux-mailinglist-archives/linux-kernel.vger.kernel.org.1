Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B02995C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790495AbgJZSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:52:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40653 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790484AbgJZSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id h5so13883765wrv.7;
        Mon, 26 Oct 2020 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQUhXvV9ngizC4642GzTTm7/Hlvt6fgB3K3UUaUSFT8=;
        b=PgQ4zBHoGONM0EuDC+MSQZsCD9loQzQ/78CLuJDg4QV+2Go3bxkFWh9IyXcuIHBroL
         rbIUa+IRjeisxRCJpYXzD8hUNyeJEy13yexO7FQG9+VKCziLjOxCJkYvV0uNeHvVnxMm
         ufM/sUnjs1kE9IZFM3gKlAzTESp7DfjYbofyZ7CBGQX0e3sjDSPbzIWVkqjQV4spTsuP
         4PXu/623TZ+FKcLB03A+TsGN7W6bkZ3qVfpT/yuuchwgFM4TaFHY4C3dTdhz8qvAMuXF
         MNmtzUOWHuYANxu+HF6BtbLrSEdHDFZg/5Ck488Rnww18A7Y/CLeTc7fGEAr1wlAeSwx
         WUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQUhXvV9ngizC4642GzTTm7/Hlvt6fgB3K3UUaUSFT8=;
        b=ukYJfZISmCwzJR1TCaWlkOP4x2NNCIr6CD2pmJiYMwdj60ZPl82k24GRMlI7g1U0D6
         cyaoLXjnypGFovQPrBIXb8hvrJfVy/+FkfJH2RcLvgXJcKgJYK1xViGX5oD1yhB7iMb6
         3KBj5Hv8HT1KC62Vpw2Tzr2kaQcmDeWshrfDrGI1+OFNJ2hYKk6P/IhUngftqsMbGDuf
         bn+FPWrUIKGiWVsR1dIWtUPhIZvMm80EREBsm19PL9ygl4TJuJw7bM780+wqz6UZpZK+
         WWGOnu2+TSOIZ0w+fgtiYIu7nTi64+OzohzkVQNBIx7HXqZbvdtuu3PgO/tObUdR9osH
         iqYA==
X-Gm-Message-State: AOAM533uCJ9Qns0QAbhNHnTROW+cAZsKjWyq71AyVzTUFahfu2BLpp5N
        pEvo7OHN268jrpS0oM0CaRU=
X-Google-Smtp-Source: ABdhPJywDncUnB846jl9ZKKaIOxZYjnQy76ipa3mbrDKAR3UpGtLZXtIwqM4R8XMtakeYjC0yhYG8A==
X-Received: by 2002:adf:b787:: with SMTP id s7mr20509135wre.390.1603738362970;
        Mon, 26 Oct 2020 11:52:42 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:42 -0700 (PDT)
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
Subject: [PATCH v8 00/14] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Mon, 26 Oct 2020 19:52:25 +0100
Message-Id: <20201026185239.379417-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the same as v7 but rebased on next-20201026 and added a comment
about slots and slot_width.

A proper sound card will be introduced later.

This was tested on H6 only.

Regards,
Clement

Change since v7:
- rebase on next-20201026
- comment about slots and slot_width

Change since v6:
- move set_channel_cfg() in first position
- convert return value to decimal

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
 sound/soc/sunxi/sun4i-i2s.c                   | 385 +++++++++++++++---
 6 files changed, 376 insertions(+), 56 deletions(-)

-- 
2.25.1

