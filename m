Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50641E9AE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgFAAPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 20:15:02 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52364 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgFAAPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:15:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8048828F67;
        Sun, 31 May 2020 20:14:56 -0400 (EDT)
Date:   Mon, 1 Jun 2020 10:14:56 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
In-Reply-To: <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.22.394.2006011006080.8@nippy.intranet>
References: <cover.1590880623.git.fthain@telegraphics.com.au> <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au> <CAMuHMdUjrFDob01EWC4e04tAkj5JTm_2Ei5WsPqN1eGDz=x3+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Sun, May 31, 2020 at 1:20 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > The adb_driver.autopoll method is needed during ADB bus scan and device
> > address assignment. Implement this method so that the IOP's list of
> > device addresses can be updated. When the list is empty, disable SRQ
> > autopolling.
> >
> > Cc: Joshua Thompson <funaho@jurai.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Thanks for your patch!
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 

Thanks for your tag.

> >  arch/m68k/include/asm/adb_iop.h |  1 +
> >  drivers/macintosh/adb-iop.c     | 32 ++++++++++++++++++++++++++------
> 
> As this header file is used by a single source file only, perhaps it 
> should just be absorbed by the latter?

Sure, it could be absorbed by both asm/mac_iop.h and 
drivers/macintosh/adb-iop.c but I don't see the point...

> Then you no longer need my Acked-by for future changes ;-)
> 

But you shouldn't need to ack this kind of change in the first place.

IMHO, the arch/m68k/mac maintainer should be the one to ack changes to 
both arch/m68k/include/asm/adb_iop.h and drivers/macintosh/adb-iop.c.

Not that I'm complaining (thanks again for your ack!)
