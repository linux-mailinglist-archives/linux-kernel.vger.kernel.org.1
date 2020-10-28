Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD4129E197
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgJ1VtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:06 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:35016 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727313AbgJ1VlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id AE38B52873A;
        Wed, 28 Oct 2020 22:41:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hXfzRahJB74D; Wed, 28 Oct 2020 22:41:05 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 6851F528723;
        Wed, 28 Oct 2020 22:41:05 +0100 (CET)
Received: from jernej-laptop.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id C19BC52873A;
        Wed, 28 Oct 2020 22:41:04 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org, Nenad Peric <nperic@gmail.com>
Cc:     Nenad Peric <nperic@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h5: OrangePi Prime: Fix ethernet node
Date:   Wed, 28 Oct 2020 22:41:04 +0100
Message-ID: <37301167.v0AoEIc9Pk@jernej-laptop>
In-Reply-To: <20201028115817.68113-1-nperic@gmail.com>
References: <20201028115817.68113-1-nperic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 28. oktober 2020 ob 12:58:17 CET je Nenad Peric napisal(a):
> RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
> node.
> 
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> Signed-off-by: Nenad Peric <nperic@gmail.com>

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Best regards,
Jernej


