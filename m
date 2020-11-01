Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC392A1C95
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKAH3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:29:10 -0500
Received: from mailoutvs16.siol.net ([185.57.226.207]:43182 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgKAH3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:29:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3A616527D5B;
        Sun,  1 Nov 2020 08:29:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id K5hw_EhnKM7t; Sun,  1 Nov 2020 08:29:08 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E885B527DC1;
        Sun,  1 Nov 2020 08:29:07 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 8A264527D5B;
        Sun,  1 Nov 2020 08:29:07 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com,
        Pablo Greco <pgreco@centosproject.org>
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on Ethernet PHY
Date:   Sun, 01 Nov 2020 08:34:41 +0100
Message-ID: <2511553.tmk64t66L6@kista>
In-Reply-To: <1604190857-3078-1-git-send-email-pgreco@centosproject.org>
References: <1604190857-3078-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 01. november 2020 ob 01:34:15 CET je Pablo Greco napisal(a):
> The Ethernet PHY on the Bananapi M1 has the RX and TX delays enabled on
> the PHY, using pull-ups on the RXDLY and TXDLY pins.
> 
> Fix the phy-mode description to correct reflect this so that the
> implementation doesn't reconfigure the delays incorrectly. This
> happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> rx/tx delay config").
> 
> Fixes: 8a5b272fbf44 ("ARM: dts: sun7i: Add Banana Pi board")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Jernej


