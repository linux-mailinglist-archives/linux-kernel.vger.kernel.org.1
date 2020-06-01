Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E001EA80A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFAQ5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 12:57:08 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:37840 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFAQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:57:05 -0400
Date:   Mon, 1 Jun 2020 12:57:00 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit
 get_user()
Message-ID: <20200601165700.GU1079@brightrain.aerifal.cx>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
 <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
 <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
 <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
 <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
 <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
 <20200601030300.GT1079@brightrain.aerifal.cx>
 <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
 <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:13:26AM +0200, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> On 6/1/20 11:02 AM, Geert Uytterhoeven wrote:
> >> Can I propose a different solution? For archs where there isn't
> >> actually any 64-bit load or store instruction, does it make sense to
> >> be writing asm just to do two 32-bit loads/stores, especially when
> >> this code is not in a hot path?
> >>
> >> What about just having the 64-bit versions call the corresponding
> >> 32-bit version twice? (Ideally this would even be arch-generic and
> >> could replace the m68k asm.) It would return EFAULT if either of the
> >> 32-bit calls did.
> > 
> > Yes, that's an option, too.
> 
> That's the solution that Michael Karcher suggested to me as an alternative
> when I talked to him off-list.
> 
> While I understand that it works, I don't like the inconsistency and I also
> don't see why we should opt for a potentially slower solution when we can
> used the fastest one.
> 
> I'm also not sure how the exception handling would properly work when you
> have two invocations of __get_user_asm().
> 
> My current approach is consistent with the existing code, so I think it's
> the natural choice. I just need someone with more experience in SH assembler
> than me that the solution is correct.
> 
> I have already pinged Niibe-san in private, he'll hopefully get back to me
> within the next days.

I don't have an objection to doing it the way you've proposed, but I
don't think there's any performance distinction or issue with the two
invocations.
