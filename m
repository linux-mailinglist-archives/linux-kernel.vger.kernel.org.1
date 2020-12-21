Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC32DF9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 09:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLUINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 03:13:39 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:41220 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgLUINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 03:13:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 07E23FB03;
        Mon, 21 Dec 2020 09:12:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fd5r-H-sfBqX; Mon, 21 Dec 2020 09:12:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 331B743FDC; Mon, 21 Dec 2020 09:12:54 +0100 (CET)
Date:   Mon, 21 Dec 2020 09:12:54 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regulators: bd718x7: Add enable times
Message-ID: <20201221081254.GA2984@bogon.m.sigxcpu.org>
References: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
 <7c8457166ec3a69d7999f751fef54413c5c2ed5f.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c8457166ec3a69d7999f751fef54413c5c2ed5f.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Dec 21, 2020 at 06:08:15AM +0000, Vaittinen, Matti wrote:
> 
> On Fri, 2020-12-18 at 19:38 +0100, Guido Günther wrote:
> > Use the typical startup times from the data sheet so boards get a
> > reasonable default. Not setting any enable time can lead to board
> > hangs
> > when e.g. clocks are enabled too soon afterwards.
> > 
> > This fixes gpu power domain resume on the Librem 5.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > 
> > ---
> > v2
> > - As per review comment by Matti Vaittinen
> >   
> > https://lore.kernel.org/lkml/beba25e85db20649aa040fc0ae549895c9265f6f.camel@fi.rohmeurope.com/
> >   Use defines instead of plain values
> > - As per review comment by Mark Brown
> >   https://lore.kernel.org/lkml/20201216130637.GC4861@sirena.org.uk/
> >   Drop cover letter
> > ---
> >  drivers/regulator/bd718x7-regulator.c | 27 ++++++++++++++++++++++++
> >  include/linux/mfd/rohm-bd718x7.h      | 30 
> 
> Thanks again Guido.
> I might have preferred having the defines in bd718x7-regulator.c as
> they are not likely to be used outside this file. That would have

In fact that's where I had them first, then noticing other regulator
related defines in the mfd header. I can shift those around need be.
Cheers,
 -- Guido

> strictly limited the change to regulator subsystem. Having them in the
> header is still fine with me if it works for Mark & others. (I don't
> think these defines need much of changes in the future).
> 
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> 
> Best Regards
>  Matti Vaittinen
> 
