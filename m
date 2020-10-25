Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C802980DF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414642AbgJYIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:52:58 -0400
Received: from mailoutvs16.siol.net ([185.57.226.207]:36483 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731184AbgJYIw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:52:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2F76F52A1ED;
        Sun, 25 Oct 2020 09:52:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rclmetWNgezp; Sun, 25 Oct 2020 09:52:55 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DF5C752A1EC;
        Sun, 25 Oct 2020 09:52:55 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 9FBFE52A1DD;
        Sun, 25 Oct 2020 09:52:55 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 09:58:25 +0100
Message-ID: <8812121.50fYm5rlzb@kista>
In-Reply-To: <20201024162515.30032-2-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-2-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 18:25:07 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: c220aec2bb79 ("ARM: dts: sun6i: Add Merrii A31 Hummingbird support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


