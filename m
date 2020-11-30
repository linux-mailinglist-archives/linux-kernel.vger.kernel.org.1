Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8F2C85E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgK3Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:51:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44534 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgK3Nv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:51:59 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjjaE-0002ZS-9I; Mon, 30 Nov 2020 14:51:14 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Tom Cubie <tom@radxa.com>, linux-kernel@vger.kernel.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] arm64: defconfig: Enable RTC_DRV_HYM8563
Date:   Mon, 30 Nov 2020 14:51:13 +0100
Message-ID: <2124337.iCxCd0tNoN@diego>
In-Reply-To: <160674371009.1066509.16638501077486662468.b4-ty@sntech.de>
References: <20201023181814.220974-1-jagan@amarulasolutions.com> <160674371009.1066509.16638501077486662468.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. November 2020, 14:50:21 CET schrieb Heiko Stuebner:
> On Fri, 23 Oct 2020 23:48:13 +0530, Jagan Teki wrote:
> > RTC HYM8563 used in the ARM64 Rockchip SoC's SDIO power
> > sequence enablement.
> > 
> > Enable it as module.
> 
> Applied both patches, thanks!

I've also split the hym8563 addition out into a separate patch in front.


