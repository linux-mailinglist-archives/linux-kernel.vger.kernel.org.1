Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91E257266
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 05:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgHaDtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 23:49:05 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47103 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgHaDs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:48:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D27C8580535;
        Sun, 30 Aug 2020 23:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=xeWOte1Ts6wwOUtqKOVkgDpqDp
        6peOxWUO9K5MecHaM=; b=oOTWbThO0fOCflpcrx9HSCzTUPFxvgy6/2gTe5pIU4
        ykYxXvQknqai+NKjOsRR8kI1Sj5xdmJjgUVe3jWo13WHntTzKOGe1K0SQvX8V33+
        MuiidPXxlJaeFJOedBDRO8ZEOOljbsT7D8nmpC2tuH2uzhxTuwIPDN3maJrIek8i
        w2o4gNxmPw43VzUcpBZA5OnoXKPe2sGlIqxNf4Cfp1SS5tvWfqpuMSWxrywPMEPW
        0lzF/F+bpy4NwUd/HEwX9MlwelKgxGdzVnt3NCmoOD74rj7UY1lI4Po800yiEmJw
        3yjfdJVpT/R2JmrcgBVqCiT9K2Q9Px7UPgI/uAS7D/EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xeWOte1Ts6wwOUtqK
        OVkgDpqDp6peOxWUO9K5MecHaM=; b=D4ph+k6Axrxs0dvQ0ihVE94ahP0vbU1cc
        7ubCnCtblTUPWE5u7j3HMMTiVuTL5x0XBVzqQZ3+ibCwsGTd1yX04AblXfLECD8U
        iLiXdy0jNQ+TMrep12Pzyg/mWRx6wfv4bajw5+U5nStwLmsyPb5I7MSjNesnZwwR
        q7/9ntUS6lSWqQhZM/rQIaGIfV7PVnYvENOysgtK4W/2cH8I1wYBVNlOpU3iqJAT
        OeAPNfLaVMwqzm+TTTWts40niODeN4T0JI/2+j6U3Ol46V3RpcBWDRwakQNQ2mI7
        hsnywgAaLJDaL7GUPLKe2Wf0SYw4YaxwzhrBsaETVr1XfvOfPDRcQ==
X-ME-Sender: <xms:JnNMX62M67LkYfnWgbWpKBvgAiIKtPOcCgUrzLWbhsfO7i4WZjcBYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:JnNMX9FvIMztCn-Dmys24DRhrEQtLHKqLhDezJ94ZFJz1NsYyI41RA>
    <xmx:JnNMXy66UVgmwH1B33qnjBEL0SRHpPjQgvdNGxNWcD1h9huBC1MBhQ>
    <xmx:JnNMX70FXdMs6gFIz340nJyTrTN2OVyll9zBZ5oXJ-McMyBk7iqEwQ>
    <xmx:J3NMX02QORIthQyCzObB74J1Nu_vNbNKcb1SMRWx3VqpfQu_usgxRQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2C923280063;
        Sun, 30 Aug 2020 23:48:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/9] ASoC: sun8i-codec driver cleanup
Date:   Sun, 30 Aug 2020 22:48:43 -0500
Message-Id: <20200831034852.18841-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the fixes series is merged, here is a series of small cleanups
to the sun8i-codec driver. These help shorten the patch stack for the
next series, which will add support for the other two DAIs in this
codec: AIF2 and AIF3.

Samuel Holland (9):
  ASoC: sun8i-codec: Remove extraneous widgets
  ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
  ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
  ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
  ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
  ASoC: sun8i-codec: Fix field bit number indentation
  ASoC: sun8i-codec: Sort masks in a consistent order
  ASoC: sun8i-codec: Attach the bus clock to the regmap
  ASoC: sun8i-codec: Manage module clock via DAPM

 sound/soc/sunxi/sun8i-codec.c | 104 ++++++++++++----------------------
 1 file changed, 37 insertions(+), 67 deletions(-)

-- 
2.26.2

