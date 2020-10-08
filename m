Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4584E286C0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgJHA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:26:26 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48936 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJHA0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:26:25 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kQJlF-000cLX-2X; Thu, 08 Oct 2020 02:26:21 +0200
Date:   Thu, 8 Oct 2020 02:26:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
Message-ID: <20201008002621.GF112961@lunn.ch>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201007210134.GD112961@lunn.ch>
 <20201007214633.GA1972@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007214633.GA1972@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 05:46:33PM -0400, Vivek Unune wrote:
> On Wed, Oct 07, 2020 at 11:01:34PM +0200, Andrew Lunn wrote:
> > On Wed, Oct 07, 2020 at 03:01:50PM -0400, Vivek Unune wrote:
> > > Forgo the use of mmioreg mdio mux infavor of the pinctrl
> > 
> > Hi Vivek
> > 
> > Could you add some more details please. I don't know this
> > hardware. I'm assuming there are two MDIO busses, external as talked
> > about in the comments, and an internal one? And for this hardware you
> > only need one of them? But i don't see what pinmux has to do with
> > this?
> Hi Andrew,
> 
> There are indeed two mdio busses. To access the external bus, 9th bit
> of the mdio register has to be set. And to enable mii function,
> one has to set the registers 6 & 7 which is part of the pin controller.
> Earlier the pin controller was not defined and I resorted to use a
> combination of memory mapped io mux to change desired bits.
> 
> Now that we have a pin controller - which is resposnsible for other 
> functionality such as pwm, i2c, uart2, it makes sense to have a consistent
> device tree

What makes it confusing is that you make multiple changes at once. It
would be easier to follow if you added the pinmux and removed the
mmioreg mux, and move the switch into the mdio-bus-mux node. Then in a
second patch rearrange the mdio-bus-mux. Small simple steps, with good
commit messages are much easier to follow and say, Yes, this is
correct.

	Andrew
