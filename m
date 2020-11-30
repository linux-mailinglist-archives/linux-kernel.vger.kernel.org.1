Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A92C871D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgK3OuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:50:15 -0500
Received: from mout02.posteo.de ([185.67.36.66]:52457 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbgK3OuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:50:14 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 16CAC240101
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606747758; bh=j5eeyfAPUe9fI6d05dTrX8PAUimPSUijcPAOnrjGhDk=;
        h=Date:From:To:Cc:Subject:From;
        b=W0dPQXSfnzd2AOVcaNbOWOOZv/ZG73k9shIO9Nj09wuWXok2yRCWmdUPbBgi7Nkiq
         1n2AYVX3gDHeIN/L24Jd0fMVE52yTM+vCzPIzKeUdGS5ti15YpTUwmjLLIKM88E5Bs
         Ejqe453iKl0Emws92y4ec/D6mm7VZ4y7yMPP/UdTf1JHNid9r5xeea9Imc1qvss1K3
         AxiNN4HALVpHR8uLp8kguFFcjWieHcKC0MMCgejztTsGcLIfMtO8NdFELUin0VHxfE
         MgQ+ai8zCpnn4VZekB3i3ru/ze51mavU4ugd9iI8jHPawyX2jl8YCUfxHMnWczA76g
         lR2c/GvW8WLUw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Cl7RK19lGz9rxD;
        Mon, 30 Nov 2020 15:49:17 +0100 (CET)
Date:   Mon, 30 Nov 2020 15:49:15 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Thomas Backlund <tmb@iki.fi>
Cc:     Jonas Malaco <jonas@protocubo.io>, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: update supported devices
Message-ID: <20201130154915.760923fd@monster.powergraphx.local>
In-Reply-To: <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
References: <X7+T4aZSUuzfsf7H@monster.powergraphx.local>
        <CANS_-EN8rgFEyE5rDw3=JLUYNwLQexafn7efvMC_=+4s2h1R6Q@mail.gmail.com>
        <20201128113524.24f4f56f@monster.powergraphx.local>
        <4917cc59-aa35-7fb1-d2d0-75039523816f@iki.fi>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 14:43:44 +0200
Thomas Backlund <tmb@iki.fi> wrote:

> Den 28.11.2020 kl. 12:35, skrev Wilken Gottwalt:
> > On Sat, 28 Nov 2020 02:37:38 -0300
> > Jonas Malaco <jonas@protocubo.io> wrote:
> > 
> >> On Thu, Nov 26, 2020 at 8:43 AM Wilken Gottwalt
> >> <wilken.gottwalt@posteo.net> wrote:
> >>>
> >>> Adds support for another Corsair PSUs series: AX760i, AX860i, AX1200i,
> >>> AX1500i and AX1600i. The first 3 power supplies are supported through
> >>> the Corsair Link USB Dongle which is some kind of USB/Serial/TTL
> >>> converter especially made for the COM ports of these power supplies.
> >>> There are 3 known revisions of these adapters. The AX1500i power supply
> >>> has revision 3 built into the case and AX1600i is the only one in that
> >>> series, which has an unique usb hid id like the RM/RX series.
> >>
> >> Can I ask what AXi power supplies were tested?
> >>
> >> I ask because, based on the user-space implementations I am aware of,
> >> the AXi dongle protocol appears to be different from the RMi/HXi series.
> > 
> > I was not able to test this against the AX power supplies, they are really
> > hard to find (and are far to expensive). But I went through all these tools
> > and stuck to the most common commands, which all 3 series support. Not every
> > series supports all commands (there also seem to be different firmwares in
> > the micro-conrollers). But this is fine, some sensors will show up as N/A.
> > Even my HX850i does not support all commands covered in this driver.
> > 
> 
> What kind of tests do you want / need ?
> 
> I have an AX860i here.

Oh nice. Lets start with an usb info dump. Can you give me the full dump of
lsusb -vd <device> of the Corsair USB dongle?

greetings,
Wilken

> --
> Regards
> 
> Thomas Backlund
> 

