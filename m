Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A67F2A8E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKFEPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:15:17 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:54161 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFEPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:15:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49583580549;
        Thu,  5 Nov 2020 23:15:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=+qDI3QewsKGWtoQxG+q8X0EcPM
        jQpIpbBevGLhPz5J4=; b=tQH0+bRth6goR3jRxdivrAy8c0dRlWyq9Ym4pN5F3Y
        frGMxZCqc7Rci1k3BXDtEr9sOerPVLN+leTNrpxLeCouQRiyfsmOlGB/ssYO8OeY
        qL4PwT7VtVWSwh20Mb0bhSLKLMr7qDjB45vH4QnvHzfxJlREyz9XfiyFVp1Nojnd
        Qz0iEpT3mQGu/8O/44SfrWpddSmfV34y3GegUi0Ukqw8Ct+cnl2DHnmP3d2mK2Qc
        8Og20ydr9kNF9PTAqYMyAb2xVMEPkGCuat4ALFyOtpGqJHQN9bvdvw1V8lWxsll3
        xnQXmsVHL3iU17reSm3Y9qBVVoQGY8i2V+0je0cXDPLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+qDI3QewsKGWtoQxG
        +q8X0EcPMjQpIpbBevGLhPz5J4=; b=qhjir15cQmcG2e7U8sW/NJgPzoAxVONII
        VPN02Eptah1hMwEdxWhceN8jotm5ku9MuNq3dqe6fqnjOBrxWlq+hX3m5WXfj8iC
        Mbr1nNSsE9p/Qi1bt8fk2KtqVwxaGbcVf8l+Of16efwbPCC2supkbuBPkYMiolN+
        s05HqFH6r33bfDrpvnUjtqZ2gQqrLaFUN4pIgneVvpj02k24tzq1di8HdF9y0kma
        X6Hsgx6bQ7Blj7l4kExIzOaVl1+Yl400fUF9DamzLp5J+SfnC8aAaUceQJ9/usoc
        Rmh7H+Woj0q7bqF6MBffYaXbQaYVT1kYDOjgPmtBFD+uuZP58Y6sw==
X-ME-Sender: <xms:0s2kX1u4YDhZ5K4c3tiA4YdLJ1jnddHxdpdpzpNtP-5f0eZTUic1pQ>
    <xme:0s2kX-dcqgyv26Nk3tws83OwQvmHr3ZSzD6ckDfvin5KZT58xGpfo0yPnoggvJz7U
    rSA2yN_itfqCb1ZIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:0s2kX4xwVWKxwxtRsXvDXqnF72sUaC7-K5Vw5zj_txG4VAWkaJfWaA>
    <xmx:0s2kX8Mfcg-sU_QUR6e8CXaA2fR_cRKJ2xEsRelMiIN4wQbRj1KHuA>
    <xmx:0s2kX198KLqqVYUBqe__EQAtxcq84HLd5cSaY48Smaf5Ud7vvWuL-g>
    <xmx:082kX0a3qnHvQ57Mb3eJub0EjmfuAvJ2dPiwWCj-4oXeNfDttq6U2g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B0AC306005F;
        Thu,  5 Nov 2020 23:15:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/7] PinePhone BT audio bringup
Date:   Thu,  5 Nov 2020 22:15:06 -0600
Message-Id: <20201106041513.38481-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes use of the additional DAIs recently added to the
sun8i-codec driver to add hardware routing for BT SCO (headset) audio
on the PinePhone.

The BT audio connection is represented by the "dummy" bt-sco codec. The
connection to the Quectel EG-25G modem via AIF2 works as well, but I do
not include it here because there is no appropriate codec driver in
tree. We have been using an out-of-tree "dummy" codec driver similar to
bt-sco, and I'm not sure if such a driver would be desired upstream.

The modem has a similar amount of configurability as the rtl8723cs BT
chip. For the BT chip, the DAI format and PCM parameters are set in a
configuration firmware file and loaded at driver load time. For the
modem, the DAI format and PCM parameters are set by (and can be queried
from) an AT command. However, this AT command requires a modem restart
to take effect, so the parameters cannot feasibly be changed at runtime.

With a dummy driver, we pick some "standard" set of PCM parameters, e.g.
16 bit mono at 8 or 16 kHz, and assume the hardware agrees. Similarly,
we assume the DAI format pre-programmed in the remote hardware matches
what is configured in the DAI link (in this case, in the device tree).

Is that the right way to model this? Or does the modem (and maybe even
the BT chip) deserve a more featureful driver that reads and/or programs
the format and params at probe time?

Because of those unanswered questions, I'm sending BT SCO support
first/only.

Regards,
Samuel

Arnaud Ferraris (1):
  arm64: dts: allwinner: pinephone: Set audio card name

Samuel Holland (6):
  ASoC: dt-bindings: sun8i-codec: Increase #sound-dai-cells
  ARM: dts: sun8i-a33: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Allow using multiple codec DAIs
  arm64: dts: allwinner: a64: Add pinmux nodes for AIF2/AIF3
  arm64: dts: allwinner: a64: Allow multiple DAI links
  arm64: dts: allwinner: pinephone: Add support for Bluetooth audio

 .../sound/allwinner,sun8i-a33-codec.yaml      |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |  4 +-
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 25 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 ++++++++++++++-----
 4 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.26.2

