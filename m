Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B082B9331
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgKSNJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgKSNJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:09:32 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41302222A;
        Thu, 19 Nov 2020 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605791371;
        bh=mKyD0D4431+nPSkk1K26j6VGYlbjIjI6ELP6HkusNrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSSDqbZCQ5v7X2wlgIUjU2Riz+C+rxLpL4dHIKhhPWENu18CO82dFxdg8wRr3/w2X
         U1lHs2UyjN0Il/aNTGwTziobLF636uCxzzjuCjp/tBXlalXMcqomU+aP8USl2gf43w
         QNYMm1Gfne6Bn9fhq9qG3dCSeFGqPCeMNCXb8NKk=
Date:   Thu, 19 Nov 2020 14:10:15 +0100
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
Message-ID: <X7Zut1JGd+9yET2W@kroah.com>
References: <20201109114125.GC1769924@kroah.com>
 <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com>
 <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109124801.GA1890488@kroah.com>
 <AM6PR04MB4966375933A2644C8A52119D80E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <X7T7TgGGgxx9j2Rl@kroah.com>
 <AM6PR04MB4966360584616AEEFFB9A4A780E10@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAGETcx-zaHa8DXocLsZ==MAZNCtGvuLcvDMLnjHGfd-KOoK+0A@mail.gmail.com>
 <AM6PR04MB4966237C99CCABD85638B22B80E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB4966237C99CCABD85638B22B80E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:13:34AM +0000, Aisheng Dong wrote:
> > Long story short, either
> > 
> > * Don't care about the power domain in your clock driver.
> > 
> > Or,
> > 
> > * List the power domain in the clock controller's DT node and then use the
> > normal APIs to get the power domain. And defer like any other driver if you
> > can't get the power domain.
> > 
> 
> Yes, I understand those are for normal cases. But our case is a bit different and we don't want
> imx_clk_scu() API return PROBE_DEFER which is unnecessary for a hundred of clocks. 
> Even we want to defer probe, we prefer to defer in imx_clk_scu_init() rather than in imx_clk_scu().

What is wrong with PROBE_DEFER, that is what it is there for.

> Maybe the things can be simplified as a simple requirement:
> How users can make Driver A (CLK) to be probed after Driver B (PD) without explicit
> firmware function dependency description (e.g. phandle in DT)?
> 
> As kernel core does not want to support it, then the left way may be change scu-pd driver
> Inicall level or provide a private callback to query the readiness.

No, do not mess with that, as it totally breaks when things are built as
a module.

Rely on the deferred probing, that is what it was designed for, and it
should not take very long at all, and it keeps you from having to dig
into the driver core in ways that no one else has to.

Please just fix up your DT file (sorry I didn't know ordering wouldn't
solve this), and you should be fine.

thanks,

greg k-h
