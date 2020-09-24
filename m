Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977E1276B92
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgIXIPh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Sep 2020 04:15:37 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:64079 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgIXIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:15:36 -0400
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE4C840009;
        Thu, 24 Sep 2020 08:15:33 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch aliases
In-Reply-To: <20200923161929.2qiqvlnxoj45jzjg@pali>
References: <20200907112718.5994-1-pali@kernel.org> <20200907144228.GV3112546@lunn.ch> <20200907145213.fwlyz4k6scible7x@pali> <20200907154353.GW3112546@lunn.ch> <20200907161316.xd5svvahi5xusdlw@pali> <20200907172345.GB3254313@lunn.ch> <20200908074733.f33pwtreojzobivq@pali> <20200923161929.2qiqvlnxoj45jzjg@pali>
Date:   Thu, 24 Sep 2020 10:15:33 +0200
Message-ID: <87sgb7h9p6.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> On Tuesday 08 September 2020 09:47:33 Pali Rohár wrote:
>> On Monday 07 September 2020 19:23:45 Andrew Lunn wrote:
>> > On Mon, Sep 07, 2020 at 06:13:16PM +0200, Pali Rohár wrote:
>> > > On Monday 07 September 2020 17:43:53 Andrew Lunn wrote:
>> > > > > I would not say it is a "new feature". But rather that patch in this
>> > > > > email fixes issue that Linux kernel did not set correct MAC address for
>> > > > > DSA slave ports. I think it is something which could be backported also
>> > > > > to stable releases as "ignoring" vendor/factory MAC address is not
>> > > > > correct behavior.
>> > > > 
>> > > > Hi Pali
>> > > > 
>> > > > The rules for stable are here:
>> > > > 
>> > > > https://www.kernel.org/doc/html/v5.8/process/stable-kernel-rules.html
>> > > > 
>> > > > Do you think it fits?
>> > > > 
>> > > >    Andrew
>> > > 
>> > > Hello Andrew! I think it fits into those rules. As I wrote it fixes real
>> > > bug that Linux kernel does not use correct MAC address for particular
>> > > DSA slaves / ethernet ports.
>> > 
>> > O.K, then:
>> > 
>> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> > 
>> >     Andrew
>> 
>> Ok! Andrew, I would like to ask another question, how to correctly
>> define that this patch depends on a2c7023f7075c? I specified it in
>> human-readable part of commit description, but for backporting it would
>> also need some machine-readable format. So patch would not be
>> occasionally backported to older/stable kernel where a2c7023f7075c is
>> not available.
>
> Based on stable-kernel-rules.html document I think that following line
> should define this dependency in machine readable format:
>
> Cc: <stable@vger.kernel.org> # a2c7023f7075c: dsa: read mac address
>
> Gregory, if it is correct, would you add that line into commit sign-off
> area where is existing Fixes: line?

I amended the commit log with this change.

Thanks,

Gregory

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
