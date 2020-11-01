Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E272A1C91
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKAHZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:25:48 -0500
Received: from mailoutvs41.siol.net ([185.57.226.232]:60692 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgKAHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:25:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 12A9B525F62;
        Sun,  1 Nov 2020 08:25:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sXJFsGxcfjXn; Sun,  1 Nov 2020 08:25:45 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id AC482526032;
        Sun,  1 Nov 2020 08:25:45 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 470F5525F62;
        Sun,  1 Nov 2020 08:25:45 +0100 (CET)
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
Subject: Re: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-berry: Fix dcdc1 regulator
Date:   Sun, 01 Nov 2020 08:31:19 +0100
Message-ID: <5571237.0xROHNpPic@kista>
In-Reply-To: <1604190857-3078-2-git-send-email-pgreco@centosproject.org>
References: <1604190857-3078-1-git-send-email-pgreco@centosproject.org> <1604190857-3078-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 01. november 2020 ob 01:34:16 CET je Pablo Greco napisal(a):
> DCDC1 regulator powers many different subsystems. While some of them can
> work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
> between 3.24 V and 3.36 V. According to OS images provided by the board
> manufacturer this regulator should be set to 3.3 V.
> 
> Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.
> 
> Fixes: 23edc168bd98 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2 
Berry")
> Fixes: 27e81e1970a8 ("ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMAC 
ethernet controller")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Jernej


