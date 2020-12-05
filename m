Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F42CF923
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLEDK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:10:58 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40126 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgLEDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:10:58 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 7137B2B617;
        Fri,  4 Dec 2020 22:10:15 -0500 (EST)
Date:   Sat, 5 Dec 2020 14:10:21 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joshua Thompson <funaho@jurai.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/adb-iop: Send correct poll command
In-Reply-To: <CAMuHMdVYf83+y1aUR6HqCgr-CLfWYvbuynpfogLrt3cXA-9_aA@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2012051340490.6@nippy.intranet>
References: <58bba4310da4c29b068345a4b36af8a531397ff7.1605847196.git.fthain@telegraphics.com.au> <CAMuHMdVYf83+y1aUR6HqCgr-CLfWYvbuynpfogLrt3cXA-9_aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Fri, Nov 20, 2020 at 5:54 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > The behaviour of the IOP firmware is not well documented but we do know
> > that IOP message reply data can be used to issue new ADB commands.
> > Use the message reply to better control autopoll behaviour by sending
> > a Talk Register 0 command after every ADB response, not unlike the
> > algorithm in the via-macii driver. This poll command is addressed to
> > that device which last received a Talk command (explicit or otherwise).
> >
> > Cc: Joshua Thompson <funaho@jurai.org>
> > Fixes: fa3b5a9929fc ("macintosh/adb-iop: Implement idle -> sending state transition")
> 
> WARNING: Unknown commit id 'fa3b5a9929fc', maybe rebased or not pulled?
> 
> 32226e817043?
> 

Yes, that's the one. I accidentally gave a commit id from one of my 
backport branches.

> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Thanks, will queue in the m68k for-v5.11 branch.
> 

Thanks.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
