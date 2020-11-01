Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F52A1C8F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 08:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgKAHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 02:24:10 -0500
Received: from mailoutvs7.siol.net ([185.57.226.198]:56923 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgKAHYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 02:24:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 909F7527D65;
        Sun,  1 Nov 2020 08:24:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0qNdl4zg7BF8; Sun,  1 Nov 2020 08:24:07 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5097B527D68;
        Sun,  1 Nov 2020 08:24:07 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id DD437527D65;
        Sun,  1 Nov 2020 08:24:06 +0100 (CET)
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
Subject: Re: [PATCH] ARM: dts: sun8i: v40: bananapi-m2-berry: Fix ethernet node
Date:   Sun, 01 Nov 2020 08:29:41 +0100
Message-ID: <3146564.MpAvnlqq7C@kista>
In-Reply-To: <1604190857-3078-3-git-send-email-pgreco@centosproject.org>
References: <1604190857-3078-1-git-send-email-pgreco@centosproject.org> <1604190857-3078-3-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 01. november 2020 ob 01:34:17 CET je Pablo Greco napisal(a):
> Ethernet PHY on BananaPi M2 Berry provides RX and TX delays. Fix ethernet
> node to reflect that fact.
> 
> Fixes: 27e81e1970a8 ("ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMAC 
ethernet controller")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Jernej


