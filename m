Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686641E9AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 02:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgFAAFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 20:05:10 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52114 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgFAAFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:05:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8810C28F67;
        Sun, 31 May 2020 20:05:06 -0400 (EDT)
Date:   Mon, 1 Jun 2020 10:05:05 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Mac IOP driver fixes
In-Reply-To: <CAMuHMdVb2C7asip_-_zbc3JP+nqn6siKqmikOK98tM5=2BYqcQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.22.394.2006010931070.8@nippy.intranet>
References: <cover.1590880333.git.fthain@telegraphics.com.au> <CAMuHMdVb2C7asip_-_zbc3JP+nqn6siKqmikOK98tM5=2BYqcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 31 May 2020, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Sun, May 31, 2020 at 1:16 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > This patch series has several bug fixes for the IOP driver and some 
> > improvements to the debug level log messages.
> 
> Thanks for your series!
> 

Thanks for your review and for your diligence in the performance of all of 
your duties as maintainer.

> > Geert, please consider pushing these fixes for v5.8, if not the whole 
> > series.
> 
> I'm afraid it's a bit too late for that, as I expect the v5.8 merge 
> window to open tonight.

Well, it's not that important.

> Unless the fix is for a regression in v5.7.

AFAICT these bugs are as old as the original driver. But I don't think 
that disqualifies them from backporting, which I plan to do that once they 
hit mainline.

> BTW, how does the issue being fixed manifest itself? That's not clear to 
> me from the patch description.
> 

The bugs in the iop driver were found by inspection, in the course of 
debugging adb-iop driver failures that Stan encountered. It's possible 
that the adb-iop driver is not badly affected by these bugs (I don't 
know). It's possible that the iop driver bugs are among the reasons why 
the swim_iop driver was never stabilized. That driver was removed in 
b21a323710e7 ("[PATCH] remove the broken BLK_DEV_SWIM_IOP driver").
