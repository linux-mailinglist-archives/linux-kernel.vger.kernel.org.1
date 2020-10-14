Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5538F28D9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgJNGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:19:46 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:42479 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbgJNGTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:19:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 6D0D3CF3;
        Wed, 14 Oct 2020 02:19:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=Y7oGa4aCrjY2aHl/ApW/8k8+7n
        R+z6GPFZxAKElgUAU=; b=H8j3SlEw5MNWcYqRAUJxXCwWnqlh594GNPumwI6CG+
        ObWnc8IyR18x9sJzzUlQf8XBhl3wV0gcaFHYjSBOfVdIUZubpHLP+762fu3Vh83M
        YmvDplHkYp16Z0IwUnICBYnxfTfN48z+7Y8rPwQlqKj3+jja5toTblz4r10O54j9
        UocyypVRuB5wS0O5Ga1n5kpeVJsm0fcqgmqMPaQfNfKc8nF7xoGYLxPy9oW6WN2G
        2VgUrDj6nYlfMWUkpCLt/tOQqbSnZyeGEm77GG6LWu1hpH6tp94V1aGxewBMMFC1
        B29krAjUCVonALjjK+5LMlkBLsP8BC/2bhY9lNaCLMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y7oGa4aCrjY2aHl/A
        pW/8k8+7nR+z6GPFZxAKElgUAU=; b=AW3Sb36Dkoh6kLSs8gGPFhJHi2eyigPOC
        L0EJ/lOAt5cmQIOlDqGyV4wYnWHlG6vD2RTj6+SBGubZ0BRZtr9FL1VD7ZuFjcxs
        l2YfrdkI/Sy3x3a4+MDYYqWgTfHdH5MG/ouU/2SwU7J56HR2p+mPiFmX2QGhKRzt
        e/F+WZHtgj0Y7/Y7C4EOBeKW0R+QUbpWfgWfVrPILVno8Tc9yZ+Z5rWrAeVCMMyT
        HxQ+ek9fzKa9GB9HISew+yrQudOq6Q5H8XiuRfQPAlVttrdkW2IIxAcJGYve+X3H
        kW6ib7jfAcc6nV/dyXaj5XiBqsTs9ZjrXOGWD28l7KBB0GrVWvy6Q==
X-ME-Sender: <xms:fpiGX7rhBD_yicJmDEMCliQn7nhWv6gJ8K_yNRDjW4Z0K1_wTk4c4g>
    <xme:fpiGX1pUT-MysdDpY-7goIiN49p8f6QYoty7rCTBmqnBGrSRU8Hfx-wNaaxWwD1Yj
    wA67iPCJs2UZCLpfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:fpiGX4Me6NS1PYw30vSDdM4LMIsqHHBYVmjsib4FCHiJgF2ptf-seA>
    <xmx:fpiGX-4b5jFMlwxLHFk4S-vXrvSSRwq_YUqfh5yk3ubQNO0EhwhIVw>
    <xmx:fpiGX658vVtMH1-7bREBrzPDbC42CqwjMiPK0KCzd2VIVnp4ZGrH8g>
    <xmx:f5iGX8utNwrvo59qpfgKdP1LEKxuZ1xE4CCLAqcZnZeYScAHJjgpiEJpAWM>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2E0F328005A;
        Wed, 14 Oct 2020 02:19:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 00/17] ASoC: sun8i-codec: support for AIF2 and AIF3
Date:   Wed, 14 Oct 2020 01:19:24 -0500
Message-Id: <20201014061941.4306-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support the other two AIFs present in the sun8i codec,
which can be used for codec2codec DAI links.

This series first fills out the DAI driver, removing assumptions that
were made for AIF1 (16 bits, 2 channels, certain clock inversions). Some
new logic is required to handle 3 DAIs and the ADC/DAC sharing the same
clock. Finally, it adds the new DAIs, and hooks them up with DAPM
widgets and routes per the hardware topology.

To minimize the number of patches in this series, related device tree
patches (increasing #sound-dai-cells, adding new DAI links) will be sent
separately.

Changes from v1:
  - Patches 1-8 from v1 (DAPM changes) were merged
  - Prefixed AIF constants with "SUN8I_CODEC_" [1, 7, 10, 16, 17]
  - Renamed variables in sun8i_codec_set_fmt for clarity [3]
  - Update sysclk->sysclk_rate if later calls to hw_params change the
    sample rate (thanks Chen-Yu for reminding me of this) [11]
  - Select COMMON_CLK for clk_set_rate_exclusive [12]
  - Add comments and hopefully clarify the clock protection logic [12]
  - Make the error message more concise and put it on one line [12]
  - Drop the "reg" variable holding SUN8I_AIF_CLK_CTRL(dai->id) [15]
  - Rename "div_reg" to "clk_reg" and adjust comments for clarity [17]
  - Improve the AIF2/AIF3 rate mismatch error message [17]
  - Minor grammar/wording fixes in commit messages [2, 4, 7, 8, 16, 17]
  - Added Maxime's Acked-by: [1-2, 4-9, 11, 13-14, 16]

Samuel Holland (17):
  ASoC: sun8i-codec: Prepare to extend the DAI driver
  ASoC: sun8i-codec: Program DAI format before clock inversion
  ASoC: sun8i-codec: Enable all supported clock inversions
  ASoC: sun8i-codec: Use the provided word size
  ASoC: sun8i-codec: Round up the LRCK divisor
  ASoC: sun8i-codec: Correct the BCLK divisor calculation
  ASoC: sun8i-codec: Support the TDM slot binding
  ASoC: sun8i-codec: Enforce symmetric DAI parameters
  ASoC: sun8i-codec: Enable all supported sample rates
  ASoC: sun8i-codec: Automatically set the system sample rate
  ASoC: sun8i-codec: Constrain to compatible sample rates
  ASoC: sun8i-codec: Protect the clock rate while streams are open
  ASoC: sun8i-codec: Require an exact BCLK divisor match
  ASoC: sun8i-codec: Enable all supported PCM formats
  ASoC: sun8i-codec: Generalize AIF clock control
  ASoC: sun8i-codec: Add the AIF2 DAI, widgets, and routes
  ASoC: sun8i-codec: Add the AIF3 DAI, widgets, and routes

 sound/soc/sunxi/Kconfig       |   1 +
 sound/soc/sunxi/sun8i-codec.c | 834 ++++++++++++++++++++++++++++------
 2 files changed, 699 insertions(+), 136 deletions(-)

-- 
2.26.2

