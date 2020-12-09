Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBD2D4BD5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgLIU3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388534AbgLIU3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:29:39 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs
Date:   Wed,  9 Dec 2020 21:28:50 +0100
Message-Id: <160754569544.2327087.13212837000849434739.b4-ty@arndb.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207084752.1665-1-thunder.leizhen@huawei.com>
References: <20201207084752.1665-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On Mon, 7 Dec 2020 16:47:51 +0800, Zhen Lei wrote:
> v1 --> v2:
> Update the patch description and subject.
> 
> I'm going to describe the detailed analysis here, because I don't want the
> patch description to be too long.
> 
> 0) make ARCH=arm CROSS_COMPILE=arm-linux-gnu- dtbs -j24 2>err.txt
>    vim err.txt
> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #address-cells for SPI bus
>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
> arch/arm/boot/dts/mmp2.dtsi:472.23-480.6: Warning (spi_bus_bridge): /soc/apb@d4000000/spi@d4037000: incorrect #size-cells for SPI bus
>   also defined at arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:225.7-237.3
> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
> 
> [...]

I picked your version instead of my own.

Applied to arm/fixes, thanks!

[1/1] ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs
      commit: a0cab089baf3048020de7bee53bccd598747126a

       Arnd
