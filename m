Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B2C27F7D8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgJACL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:11:56 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51543 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729746AbgJACLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:11:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4A27F5800FE;
        Wed, 30 Sep 2020 22:11:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=k5mtpKP9oNAq+In/8Ew8k5Wo3e
        mD3VL47opFnB6ZQsk=; b=nl4GF0z09NAieUXSBaW9IRsdoHNNnFYIUBu7IuHJWB
        83JX9NyxHDlGYgbFc0POnBwMDkbMqP9AWTnSNFLqxsj1T8R1LbiWh+a8oK3kNcqA
        8gUgNnrlWEjEXBbAF64z0kplKv7KKfxcrDoTfW5+9JTo5ewE5sMmLco0GSwsdYvY
        LWSb+37UEwR1V5DsGo1mg9XcUBlJApjmdvX9Bsg1alPzAzkEmUnNayH13IRKkYvX
        wOYBplBwqgNpBav7NtjCSi02MfA8YGd82uqSyi5FW1LSE+kV/vlavkp/fgXUSF8C
        IUqkRKppZDGj0S1svctn5U3yyHaLfkjVfQdygeQj8adw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k5mtpKP9oNAq+In/8
        Ew8k5Wo3emD3VL47opFnB6ZQsk=; b=JsIK4yQSXzxJYHVubKnroNYcJpfaBssS/
        zqmA4lQy6zrYpKD89eOco92o8F64cNanu65NzLQNqhFT8rKAi+NUarqAi0tbcsUz
        NNQEIagKzH8M0ylluzXgGSUkdx26YU24GyMqPU6b8WwmSYGWVpZwPpAMhclTvzU+
        j03tIgti/qduHHeMFQVUGR5rktKsJHnxD+2ckigdvb63PrA080KxSlWdOgywW15X
        xgS3w9UCIHlF9psZ5dSBocNf39ue2urX2J78eQeAcMHegx8zJ5a/xahWLBJHjGvG
        Pre1q4LlIWAIVuXbQSvrcC4UGOswUS+J4sXe45kpgmye9MYV1geLg==
X-ME-Sender: <xms:5Tp1X7Xa8gcSMAr0KoBTeFHoeyvVN9PiOuXfTJVVmqbEOfHH7kjLXg>
    <xme:5Tp1XznZt28QTAiqQQuV7TWVXrJYU3CeiqbWmMovKGGz4PHCNKscgc43XzOEt1k9b
    BQc-5l_dkA5RQh5Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdho
    rhhg
X-ME-Proxy: <xmx:5Tp1X3YLXWQ0KYm7sTL-w8N2s_BzgQhVcv8tfSdO21TOh7ElCjM3PQ>
    <xmx:5Tp1X2VRlX1hBTHE9vBa1N0E7eBwg-tt7o9V_jhGn5mOGIKV1HZQrg>
    <xmx:5Tp1X1kqFHujiZpVn2s9S71HHtdGGG9ypVjws4nVrbuTXjSlMOjS1g>
    <xmx:6Dp1X3693d4ubFls6I57Y1q7Y6K6np9XUXXtqKjv5-L8S-RC9fZf4Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52A6D306467E;
        Wed, 30 Sep 2020 22:11:49 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 00/25] ASoC: sun8i-codec: support for AIF2 and AIF3
Date:   Wed, 30 Sep 2020 21:11:23 -0500
Message-Id: <20201001021148.15852-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support the other two AIFs present in the sun8i codec,
which can be used for codec2codec DAI links.

This series first cleans up the DAPM component driver so there is an
organized place to put the new widgets. Then it fills out the DAI
driver, removing assumptions that were made for AIF1 (16 bits, 2
channels, certain clock inversions). Some new logic is required to
handle 3 DAIs and the ADC/DAC sharing the same clock. Finally, it adds
the new DAIs, and hooks them up with DAPM widgets and routes per the
hardware topology.

To minimize the number of patches in this series, related device tree
patches (increasing #sound-dai-cells, adding new DAI links) will be sent
separately.

Samuel Holland (25):
  ASoC: sun8i-codec: Set up clock tree at probe time
  ASoC: sun8i-codec: Swap module clock/reset dependencies
  ASoC: sun8i-codec: Sort DAPM controls, widgets, and routes
  ASoC: sun8i-codec: Consistently name DAPM widgets and routes
  ASoC: sun8i-codec: Correct DAPM widget types
  ASoC: sun8i-codec: Fix AIF widget channel references
  ASoC: sun8i-codec: Enable AIF mono/stereo control
  ASoC: sun8i-codec: Use snd_soc_dai_get_drvdata
  ASoC: sun8i-codec: Prepare to extend the DAI driver
  ASoC: sun8i-codec: Program format before clock inversion
  ASoC: sun8i-codec: Enable all supported clock inversions
  ASoC: sun8i-codec: Program the correct word size
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
  ASoC: sun8i-codec: Add a DAI, widgets, and routes for AIF2
  ASoC: sun8i-codec: Add a DAI, widgets, and routes for AIF3

 sound/soc/sunxi/sun8i-codec.c | 1135 ++++++++++++++++++++++++++-------
 1 file changed, 894 insertions(+), 241 deletions(-)

-- 
2.26.2

