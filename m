Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28BA2E8BDC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbhACLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:07:46 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:40599 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbhACLHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:07:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BEE85535;
        Sun,  3 Jan 2021 06:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 06:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=I8bA8POhoxBrZwP2mHoKBA4QcX
        NrGGkh7u7Vm2y3qK0=; b=suJ0O+DlQQt7VUpGv39R5vtBklwfzxI++e37SCrR54
        pvstXhqJUf+U1c1NMQXgK9yF0diqGYW/K988GKnIXN7xd3f8LFuTY1NKTnYyonOD
        Wb3U1xA/34F9G/aTipjB59b6RV9NWaWuv9lTlbzadJI//dXGujwju6d14xWIKysr
        v4dC9sCD83gXkal8Yf5DhShl33roxu2o5KRQU/loNGhf26MO81ZSmrE4JBZLJvJy
        yc8G98OrJb+u1fk5kMDgUwkC3w8/5ceZk4AaoC+ijMVlyNFmVaOzJ93G18npIIMy
        q/Yptk9AlT2tOtfULDu5nM8p186hwc2wwAgb2dLoBvpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=I8bA8POhoxBrZwP2m
        HoKBA4QcXNrGGkh7u7Vm2y3qK0=; b=cjfeJ+alReVKZnbAFnKtZyGIfg0FkE95r
        9KXkA3giJzrCUc+7uYYJfn8Kf45UPKFulGgeLRVBYtROX1JIGMP+sp2v5VTSq7KT
        gGY3TmSoVWJKyIm0H/vOei2AO1CdrHy+5fTXXRriQUwuPoXkB5OJLq3oRKFQDAGf
        Re5Ygy5PiUhXHkZguUZqZCW8PVQdyy4YnOvFa8s9khDYKRSjV54Xn75yMikzZuVg
        3ZZ1ftPk/aoQTx9RQb8FbUrALW3Y3QSGztBJx+3SP22yXUGvA2Qbf2Yl0ZM8RfKX
        cmt83sIx2Z95Td2RqUhYRAk7ZmKq9mPlfa84sf5Q+5ipGNBeNeOdA==
X-ME-Sender: <xms:PKXxX2JLCp1LeTN3iI-jLaIuZpzZsvSltL9lt8ynbfSXa4QlXyiuiQ>
    <xme:PKXxX-JAat_VgbE88eA-PdZYmASSp-rJOZ-4dAhlkTHohUKOKRQXBr-fz5J8-3h5D
    MWNW10rLBJkCTLbaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:PKXxX2sEQVpbs93FZWX2FIKff4N-rAJhy-MqpCNVpviSYpfMWI952Q>
    <xmx:PKXxX7ZvLvlzjrMDMN5kWKLfsCM3VApU8FBCfJgsrlz2E3UHuZb_Fw>
    <xmx:PKXxX9bYLt3zcbi6b1HPp1WZpC8lV98zkhxwFaLvCS8t5k7k_HpLRg>
    <xmx:PqXxXwyzDqY2E0eiUSQE-g88Wvq4YKUJVNgk1gJd8E6sT9twfTLh1Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 005F324005A;
        Sun,  3 Jan 2021 06:06:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/4] bus: sunxi-rsb: Implement power managment
Date:   Sun,  3 Jan 2021 05:06:31 -0600
Message-Id: <20210103110635.34823-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds system (complete power down) and runtime (clock gate)
PM hooks to the RSB controller driver. Tested on A64 and H6.

Samuel Holland (4):
  bus: sunxi-rsb: Move OF match table
  bus: sunxi-rsb: Split out controller init/exit functions
  bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks
  bus: sunxi-rsb: Implement runtime power management

 drivers/bus/sunxi-rsb.c | 211 ++++++++++++++++++++++++++++------------
 1 file changed, 150 insertions(+), 61 deletions(-)

-- 
2.26.2

