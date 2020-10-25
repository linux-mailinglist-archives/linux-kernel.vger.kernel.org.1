Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B191B2980D5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414566AbgJYIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:43:30 -0400
Received: from mailoutvs44.siol.net ([185.57.226.235]:60932 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730760AbgJYIna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:43:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 68315529C22;
        Sun, 25 Oct 2020 09:43:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OjagYDs5MP9s; Sun, 25 Oct 2020 09:43:27 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 24A37529C56;
        Sun, 25 Oct 2020 09:43:27 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id D57CF529C22;
        Sun, 25 Oct 2020 09:43:26 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM: dts: sun8i: a83t: Enable both RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 09:48:56 +0100
Message-ID: <12058304.OfRq56rs3M@kista>
In-Reply-To: <20201024162515.30032-6-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-6-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 18:25:11 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the Bananapi M3 and Cubietruck Plus have the RX
> and TX delays enabled on the PHY, using pull-ups on the RXDLY and
> TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: 039359948a4b ("ARM: dts: sun8i: a83t: Enable Ethernet on two boards")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


