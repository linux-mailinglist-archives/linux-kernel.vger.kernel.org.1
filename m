Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682612321E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG2PsW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jul 2020 11:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2PsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:48:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C89C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:48:22 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0oJB-0001x3-1O; Wed, 29 Jul 2020 17:47:57 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k0oJ7-0005C1-FL; Wed, 29 Jul 2020 17:47:53 +0200
Message-ID: <6501768cd96f88a65fd15d93433203c203b28b45.camel@pengutronix.de>
Subject: Re: [PATCH V3 1/3] reset: imx7: Support module build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, bjorn.andersson@linaro.org, leoyang.li@nxp.com,
        vkoul@kernel.org, geert+renesas@glider.be, olof@lixom.net,
        amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        vidyas@nvidia.com, hayashi.kunihiko@socionext.com,
        jonnyc@amazon.com, eswara.kota@linux.intel.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Linux-imx@nxp.com
Date:   Wed, 29 Jul 2020 17:47:53 +0200
In-Reply-To: <20200728105345.GC905@e121166-lin.cambridge.arm.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
         <e89fa4f3ba2b1b6fe94e662c6ab3cfbaa25867fa.camel@pengutronix.de>
         <20200728105345.GC905@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 11:53 +0100, Lorenzo Pieralisi wrote:
> On Fri, Jul 24, 2020 at 10:03:11AM +0200, Philipp Zabel wrote:
> > On Mon, 2020-07-20 at 22:21 +0800, Anson Huang wrote:
> > > Use module_platform_driver(), add module device table, author,
> > > description and license to support module build, and
> > > CONFIG_RESET_IMX7 is changed to default 'y' ONLY for i.MX7D,
> > > other platforms need to select it in defconfig.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > Changes since V2:
> > > 	- use module_platform_driver() instead of builtin_platform_driver().
> > 
> > Thank you, applied to reset/next.
> 
> I think you should pick up patch (3) as well please if PCI_IMX6
> maintainers ACK it - merging just patch(1) will trigger regressions
> AFAICS.

Thank you for raising this, I'll put these patches on hold until the
PCI_IMX6 issue is resolved.

regards
Philipp
