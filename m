Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2026025A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgIGRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:24:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47994 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgIGRXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:23:50 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFKrp-00DegK-TH; Mon, 07 Sep 2020 19:23:45 +0200
Date:   Mon, 7 Sep 2020 19:23:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907172345.GB3254313@lunn.ch>
References: <20200907112718.5994-1-pali@kernel.org>
 <20200907144228.GV3112546@lunn.ch>
 <20200907145213.fwlyz4k6scible7x@pali>
 <20200907154353.GW3112546@lunn.ch>
 <20200907161316.xd5svvahi5xusdlw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907161316.xd5svvahi5xusdlw@pali>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:13:16PM +0200, Pali Roh�r wrote:
> On Monday 07 September 2020 17:43:53 Andrew Lunn wrote:
> > > I would not say it is a "new feature". But rather that patch in this
> > > email fixes issue that Linux kernel did not set correct MAC address for
> > > DSA slave ports. I think it is something which could be backported also
> > > to stable releases as "ignoring" vendor/factory MAC address is not
> > > correct behavior.
> > 
> > Hi Pali
> > 
> > The rules for stable are here:
> > 
> > https://www.kernel.org/doc/html/v5.8/process/stable-kernel-rules.html
> > 
> > Do you think it fits?
> > 
> >    Andrew
> 
> Hello Andrew! I think it fits into those rules. As I wrote it fixes real
> bug that Linux kernel does not use correct MAC address for particular
> DSA slaves / ethernet ports.

O.K, then:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
