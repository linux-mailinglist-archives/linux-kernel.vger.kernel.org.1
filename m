Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F309530458C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392980AbhAZRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:41:52 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3367 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbhAZIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:07:05 -0500
X-Originating-IP: 90.2.82.147
Received: from windsurf.home (aputeaux-654-1-223-147.w90-2.abo.wanadoo.fr [90.2.82.147])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8D4A8240016;
        Tue, 26 Jan 2021 08:05:25 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:05:25 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?R3LDqWdvcnk=?= Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with
 ioremap()
Message-ID: <20210126090525.4d085080@windsurf.home>
In-Reply-To: <7c0fd747-3ea1-2aa1-0c05-12ae4477a860@alliedtelesis.co.nz>
References: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
        <20201112090202.638c0c13@windsurf>
        <7c0fd747-3ea1-2aa1-0c05-12ae4477a860@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 01:48:23 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> Hi All,
> 
> On 12/11/20 9:02 pm, Thomas Petazzoni wrote:
> > On Thu, 12 Nov 2020 16:21:49 +1300
> > Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> >  
> >> make coccicheck complains:
> >>
> >>    ./drivers/bus/mvebu-mbus.c:1113:2-8: ERROR: missing iounmap; ioremap on line 1106 and execution via conditional on line 1111
> >>
> >> It took some staring but I don't think there is a problem because the
> >> file global `mbus_state` is passed mvebu_mbus_common_init() as the
> >> `mbus` parameter so `mbus_state.mbuswins_base` and `mbus->mbuswins_base`
> >> are the same thing. But this is confusing for anyone reading the code
> >> and one less complaint from coccicheck would be nice so lets fix it.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>  
> > Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>  
> 
> Just going through some old branches. This doesn't seem to have been 
> picked up. Have I missed a maintainer?

+Gregory Clement in Cc. Greg, the original patch from Chris is touching
drivers/bus/mvebu-mbus.c, so I think you should be taking that patch.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
