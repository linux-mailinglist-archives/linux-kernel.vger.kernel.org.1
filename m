Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03EE2980B8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767820AbgJYHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 03:48:14 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:34196 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1765977AbgJYHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 03:48:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 24D3652ABB8;
        Sun, 25 Oct 2020 08:48:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JnqKbIAQjfG6; Sun, 25 Oct 2020 08:48:10 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D5BA352ABC8;
        Sun, 25 Oct 2020 08:48:10 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 7E43E52ABB8;
        Sun, 25 Oct 2020 08:48:09 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] ARM: dts: sun8i: h3: orangepi-plus2e: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 25 Oct 2020 08:53:39 +0100
Message-ID: <30257881.11H8UbXcPh@kista>
In-Reply-To: <20201024162515.30032-5-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-5-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 18:25:10 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Ethernet PHY on the Orange Pi Plus 2E has the RX and TX delays
> enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
> Fixes: 7a78ef92cdc5 ("ARM: sun8i: h3: Enable EMAC with external PHY on 
Orange Pi Plus 2E")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>
Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


