Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BB28AA36
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgJKUWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgJKUWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D7C0613CE;
        Sun, 11 Oct 2020 13:22:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s4so16037595qkf.7;
        Sun, 11 Oct 2020 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tASCTYBxcthY6OHyZcpvEZ2WGLxMD6Z6m5Bm5NnAUZQ=;
        b=Dv1lSgAiqpMC+u/tF2AgZlaLQqTUsG6LtAn2oJpLSQ5nxXcyySAqoPQBzql8egLIOJ
         2TqXFv5N+06kL8+5/4obvGMNM+yhrOEQWIjbH+P5nKXCILkgWE7l4eQcwvATc6ZtIgNV
         kipf2CK6NshRLdCVbkxsT/M/Rhke9pxyDRhImnHRui/OkCEyUD0bpNQbgBML1iMrNRz9
         VX2IqA5IhjTMEEByg/cITnfh0Th0ZUoX/tgu/t/dkAcomLSWjcqmZiLv1Htk4GE4m9bT
         MI/4FwePmlpsMAufc/jXuATMmGLbIV6LE55nvgE6sni6+ms7GJOXiVwVLqoMOobCTTPJ
         B0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tASCTYBxcthY6OHyZcpvEZ2WGLxMD6Z6m5Bm5NnAUZQ=;
        b=T1GP358FZrFu00IzvcT6MC3mBWI9TN5NNRqW0sRBYytTxhzo13sVX6IIUkUMJD2Z1Q
         NhOxkVQ0VJIVgxPcv2aQ5M9UObTzam7jUTTDSJUz+rKcRs6zOKDNE83QqTOYCXA7Rmuu
         WDIkabDUaJcEVoQYsZoURfum2uu7QeHQpsKkREsa7a3QepgebkuxNfWfylbLNkGMPtMp
         X9sFp8yTKIeRMPO0dDPpcAr+uERF2CdCO95QFEjPS84kVQ3EimYTMwPwthy3UUCQONDP
         r/eBJ694EZkc1xcvKbWzoAAvuUHCWMte9IYjG2WWm6ymyeIT0QDkMvQLdQt0J1AL6WrF
         CBdA==
X-Gm-Message-State: AOAM533IfmCMeiE0F/zVRnq4Hrbr9Z38nkkkMtDgnjEA5M7OI4Bz4C2u
        5HKCSbW2nDU6Kz56EiJoOd8=
X-Google-Smtp-Source: ABdhPJy8+5x9bAXKsOMAy506+SFXzMiqLE0rZegNwLCZFuT6OQC4+9gTbGyZkXPwfSNLC6JG8E9dbw==
X-Received: by 2002:ae9:dc03:: with SMTP id q3mr7328008qkf.288.1602447752182;
        Sun, 11 Oct 2020 13:22:32 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:31 -0700 (PDT)
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
Subject: [PATCH v7 00/14] Add Allwinner H3/H5/H6/A64 HDMI audio
Date:   Sun, 11 Oct 2020 22:22:10 +0200
Message-Id: <20201011202224.47544-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just some minor changes compare to v6.

As explain in v6 there is no more HDMI soundcard,
I will try to introduce a dedicated Allwinner soundcard
in a next series.

Clément

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
 sound/soc/sunxi/sun4i-i2s.c                   | 376 +++++++++++++++---
 6 files changed, 368 insertions(+), 55 deletions(-)

-- 
2.25.1

