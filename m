Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B832A2831
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgKBKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:25:33 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:56318 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgKBKZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:25:32 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id B79A4C0121;
        Mon,  2 Nov 2020 11:25:28 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 048E3C1D6F; Mon,  2 Nov 2020 11:25:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        autolearn=disabled version=3.4.2
Received: from aptenodytes (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 220ACC1D6C;
        Mon,  2 Nov 2020 11:25:23 +0100 (CET)
Date:   Mon, 2 Nov 2020 11:25:22 +0100
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 6/9] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Message-ID: <20201102102522.GB11809@aptenodytes>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-7-contact@paulk.fr>
 <20201102101211.wtkmgfm2rcm5gdyp@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201102101211.wtkmgfm2rcm5gdyp@gilmour.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon 02 Nov 20, 11:12, Maxime Ripard wrote:
> On Sat, Oct 31, 2020 at 07:21:34PM +0100, Paul Kocialkowski wrote:
> > The V3s/V3 has a NMI interrupt controller, mainly used for the AXP209.
> > Its address follows the sytsem controller block, which was previously
> > incorrectly described as spanning over 0x1000 address bytes.
> 
> Is it after, or right in the middle of it?

That's up for interpretation actually:
- The V3 datasheet mentions that System Control is 0x01C00000 --- 0x01C00FFF;
- In practice, sunxi_sram.c uses a regmap with max_reg set to 0x30 for the
  V3s/H3 so this gives us some room.

Looking at other SoCs with the same setup (take sun8i-r40 for instance),
system-control is limited to 0x30 and the NMI controller follows it.
In the case of R40, the SRAM controlled is also said to be 4K-long in the
Allwinner docs.

So all in all, this leads me to believe that the system-controller instance
stops well before 0x1c000d0 on the V3s as well. Otherwise, we should also
make the R40 consistent.

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
