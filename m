Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A181EFD21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgFEP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 11:59:56 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:41472 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgFEP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:59:56 -0400
Date:   Fri, 5 Jun 2020 11:59:54 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200605155954.GV1079@brightrain.aerifal.cx>
References: <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
 <0af28795-b27a-2dd9-0d0f-c2a8d4b8d512@physik.fu-berlin.de>
 <20200605154343.GU1079@brightrain.aerifal.cx>
 <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4900bf6-99b3-c9b9-4fd0-7f491bd46de6@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:47:34PM +0200, John Paul Adrian Glaubitz wrote:
> On 6/5/20 5:43 PM, Rich Felker wrote:
> >> Can you include the patch as well?
> > 
> > This one is outside arch/sh and I'm not sure it's permissible to go up
> > through my tree. I was also under the impression that only part 1 was
> > needed to fix the immediate problem on sh and tha part 2 was for
> > completeness and to make sure the same doesn't happen on other archs
> > in the future, but maybe my understanding here is incorrect.
> 
> Ah, sorry, I missed that. You're right, it should probably go through
> someone else's tree then.

Do you know if it's needed to un-break sh4? If so we should push to
get whoever has jurisdiction over it to include it; otherwise I'm
indifferent.

> >> And would it be okay to send a PR to Linus
> >> after that?
> > 
> > Sure, will do right away once we resolve what to do with the above,
> > and provided you don't have anything else you want me to evaluate for
> > inclusion.
> 
> Since we haven't agreed on the __get_user_64() patch yet, I would be
> in favor of getting the changes pulled in that have already been
> reviewed and acknowledged. I rather don't want the other contributors
> to wait any longer. Arnd in particular has done a tremendous job to
> untangle all the SH-5 code and I think we should finally get this
> in :).

Absolutely agreed.

Rich
