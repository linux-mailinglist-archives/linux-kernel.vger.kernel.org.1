Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B92B9492
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKSOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbgKSOY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:24:56 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303E8238E6;
        Thu, 19 Nov 2020 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605795894;
        bh=hI3CwxFoM3ubkyrrewfwBRZFiwj/CI/nK3tQ07ldTb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0epg9t00js0qu4wAvN+A/n9gyarevXCFaELqlaPDb60k/oSnfF38vpv/f3/gv7/Ud
         mwiFOkAOLPBHsdQvCPucKouMBv9kSNzMgknRkkKjZvgppUEKlkzA1AFU0a1djqkFq9
         JQyH892hgY8DICjJT7CpDOCH6JDcwGDdNj5ZXnwo=
Date:   Thu, 19 Nov 2020 15:25:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Message-ID: <X7aAYlgx0ZvUELlX@kroah.com>
References: <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
 <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7T7TgGGgxx9j2Rl@kroah.com>
 <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAGETcx-zaHa8DXocLsZ==MAZNCtGvuLcvDMLnjHGfd-KOoK+0A@mail.gmail.com>
 <AM6PR04MB4966237C99CCABD85638B22B80E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7Zut1JGd+9yET2W@kroah.com>
 <AM6PR04MB49662EB50652F3BC6FE67C9980E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49662EB50652F3BC6FE67C9980E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:09:42PM +0000, Aisheng Dong wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, November 19, 2020 9:10 PM
> > 
> > On Thu, Nov 19, 2020 at 04:13:34AM +0000, Aisheng Dong wrote:
> > > > Long story short, either
> > > >
> > > > * Don't care about the power domain in your clock driver.
> > > >
> > > > Or,
> > > >
> > > > * List the power domain in the clock controller's DT node and then
> > > > use the normal APIs to get the power domain. And defer like any
> > > > other driver if you can't get the power domain.
> > > >
> > >
> > > Yes, I understand those are for normal cases. But our case is a bit
> > > different and we don't want
> > > imx_clk_scu() API return PROBE_DEFER which is unnecessary for a hundred of
> > clocks.
> > > Even we want to defer probe, we prefer to defer in imx_clk_scu_init() rather
> > than in imx_clk_scu().
> > 
> > What is wrong with PROBE_DEFER, that is what it is there for.
> 
> Yes, we can use PROBE_DEFER, just not want to defer in imx_clk_scu_init() when creating
> sub clock devices. Instead, we want to defer at the beginning of clock driver probe which
> can save tens of defer probes due to the same reasons that PD driver is not ready.

There's nothing wrong with deferring that many times until your proper
driver is loaded, what does it cost you to do so?

> > > Maybe the things can be simplified as a simple requirement:
> > > How users can make Driver A (CLK) to be probed after Driver B (PD)
> > > without explicit firmware function dependency description (e.g. phandle in
> > DT)?
> > >
> > > As kernel core does not want to support it, then the left way may be
> > > change scu-pd driver Inicall level or provide a private callback to query the
> > readiness.
> > 
> > No, do not mess with that, as it totally breaks when things are built as a module.
> > 
> 
> Can't this be addressed by proper module dependency? E.g clock module depends
> on power domain module. Then clock driver can only be loaded after power domain.

Sure, if you can do that, make your modules load properly by symbol
dependency and all should be fine.  Have you done that?

thanks,

greg k-h
