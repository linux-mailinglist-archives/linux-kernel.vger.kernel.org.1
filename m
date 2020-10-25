Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5852980A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 08:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767788AbgJYH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 03:29:55 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:48966 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1737437AbgJYH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 03:29:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E50DB524901;
        Sun, 25 Oct 2020 08:29:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UNIJcn0pZV9N; Sun, 25 Oct 2020 08:29:51 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A174752352F;
        Sun, 25 Oct 2020 08:29:51 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 11403524901;
        Sun, 25 Oct 2020 08:29:50 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] Revert "arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high"
Date:   Sun, 25 Oct 2020 08:35:20 +0100
Message-ID: <2494995.jnrXR15XKO@kista>
In-Reply-To: <20201024162515.30032-1-wens@kernel.org>
References: <20201024162515.30032-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 24. oktober 2020 ob 18:25:06 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> This reverts commit 75ee680cbd2e4d0156b94f9fec50076361ab12f2.
> 
> Turns out the activity and link LEDs on the RJ45 port are active low,
> just like on the Orange Pi PC.
> 
> Revert the commit that says otherwise.
> 
> Fixes: 75ee680cbd2e ("arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs 
to active high")
> Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> If you have this board, please help test it.
> 
> For me, the correct lighting of the LEDs is both LEDs should be lit
> when connected at 100 Mbps.

Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>
Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


