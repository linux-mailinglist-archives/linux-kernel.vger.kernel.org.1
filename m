Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8001C5AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgEEPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:13:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42868 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgEEPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/qO1lATGS9lr30c0r7Ux+K/eDJUDQRQ9Je/mQTvrCAk=; b=H307mnwYEziysPatqs3YdxPWW2
        ImRftMGlfNCsgQbI9G7oIZPhMxECq7g/9i7HogcGZjNvfbhpA8pTAWu8kucvPedlhHKE0HE2IaCGq
        jquU1hSMTmVUDsKx5R4c0kTqFWduOU8wXzc87ikdifv/HGNE/th3d25gLdw/mofw1YP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jVzGU-000x3L-7B; Tue, 05 May 2020 17:13:46 +0200
Date:   Tue, 5 May 2020 17:13:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 11/15] ARM: mvebu: Drop unneeded select of HAVE_SMP
Message-ID: <20200505151346.GB224913@lunn.ch>
References: <20200505150722.1575-1-geert+renesas@glider.be>
 <20200505150722.1575-12-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505150722.1575-12-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:07:18PM +0200, Geert Uytterhoeven wrote:
> Support for Marvell Armada 375, 380, 385, and 39x SoCs depends on
> ARCH_MULTI_V7.
> As the latter selects HAVE_SMP, there is no need for MACH_ARMADA_375,
> MACH_ARMADA_38X, and MACH_ARMADA_39X to select HAVE_SMP.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
