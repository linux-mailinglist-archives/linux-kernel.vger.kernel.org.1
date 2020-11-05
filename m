Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05F2A7725
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgKEFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:38 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36461 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728301AbgKEFli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C6615C013F;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=B5rhuolbMWbbNshLnD0r/wn+jI
        1LORCjicwWoKNXtLw=; b=H4dbtZNI0+zWDx54ymgACSKKOHr1lHQk1XaaIjwlU0
        g2LnzbJhXPrmb5mJVl3xWR5bldQjmezWhkUIzCcX5EWgBHfvtnTa5HFVMyaGUYaX
        JQI1dyMy0ZtuUuletUrUcGEXhf6ZZVFcgrwIuJGni48MVoLM1mS66qrRrXLuhCG/
        zASehZ7rky038IUi5OvDnZ6+/f7kQc9zPsmkAuNPVvKz8Mo3luTpax1mXc85iUB1
        u1n9GAV4NggwTiWS9NQ9Ra8aIKbiVYbwJZ2+SWmAi5m7DwOwC2zjbQwr2+eRwfk9
        MkjvFpecKVW6l9I8o7X7oST1N46QCPYHg+TFFi9f3PjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B5rhuolbMWbbNshLn
        D0r/wn+jI1LORCjicwWoKNXtLw=; b=dqF+SvdW2Vw4n4LeGjW1Of8Vp2QHEWAIj
        G2G45Hn1/dN7QKJyYDa6/YUnrec1+r38Uspi4QPHgowUA9/SDjmnrdEZtMzplX5N
        bU0SWnw8PLa76sQloa6Q6nTNNeLUwkl2Le+IvtamvE/aX2otlUvRMC5dR6MnLivL
        Ql6fGrxFtHXht4bb1Yo+VbJTktZSxmlAukqde9WfxPaLZ/LPwMojxnkxTfUGm/sz
        dSrHzX1ZhUbr9jnyBPTTIMHsOP28qzWtGh9C1l54WKFU/gu9rUD2cTwAJ1ap4enY
        MCGFZU8xgj3ZFoia8Xc8QwqiCfPrCZVS6gzr1cALilbT+qjWRsqiA==
X-ME-Sender: <xms:kJCjX1rRIGzkMkQFBM5zYqRJ98S8oDQ2kTBnfwBZfT-SU9Bx-4DGHA>
    <xme:kJCjX3ob_tg10xt6LDtLIOMKqNAjISJ3d-iNpSbLLE-1XY6pyyiyIQ0kTDrA6fx1m
    vFlFFeqeR5Agx6ypA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:kJCjXyOnuchXDnwpDEEkww_EpdxQ0Sgn6eIEaxLkPZVxwU-WwOFOnA>
    <xmx:kJCjXw4IXfZo9THFhf6ZFXJtM4wAsegtegx1hwF_lUm153MNSuxIuA>
    <xmx:kJCjX07GBEj74mRHFmHLpBBC-W8e7iL3QA2ehBJKIPpnKPnM6TD7ZQ>
    <xmx:kZCjXxtBLf4pnavRMXFmhyVT9KCXiHtn62QJyf_8OS1oxt9a6hAs4w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05FE232801F2;
        Thu,  5 Nov 2020 00:41:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/6] PinePhone Device Tree Enhancements
Date:   Wed,  4 Nov 2020 23:41:29 -0600
Message-Id: <20201105054135.24860-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a couple of small issues with the PinePhone device
tree, and collects some patches adding support for peripherals that
recently received driver or DT binding support.

Luca Weiss (1):
  arm64: dts: allwinner: pinephone: Add LED flash

Ondrej Jirman (3):
  arm64: dts: allwinner: pinephone: Add light/proximity sensor
  arm64: dts: allwinner: pinephone: Add WiFi support
  arm64: dts: allwinner: pinephone: Add Bluetooth support

Samuel Holland (2):
  arm64: dts: allwinner: pinephone: Remove AC power supply
  arm64: dts: allwinner: pinephone: Set ALDO3 to exactly 3v0

 .../allwinner/sun50i-a64-pinephone-1.0.dts    |  5 ++
 .../allwinner/sun50i-a64-pinephone-1.1.dts    |  5 ++
 .../allwinner/sun50i-a64-pinephone-1.2.dts    | 14 ++++
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 64 +++++++++++++++++--
 4 files changed, 82 insertions(+), 6 deletions(-)

-- 
2.26.2

