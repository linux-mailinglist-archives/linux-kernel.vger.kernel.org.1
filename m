Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA483226297
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 16:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGTOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 10:53:28 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34338 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:53:28 -0400
Date:   Mon, 20 Jul 2020 10:53:26 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200720145325.GK14669@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <20200720133800.GA3084@lst.de>
 <661f7d56-bffc-f688-54e3-291cd5e7e18d@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661f7d56-bffc-f688-54e3-291cd5e7e18d@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 03:42:38PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christoph!
> 
> On 7/20/20 3:38 PM, Christoph Hellwig wrote:
> > On Wed, Jul 15, 2020 at 01:12:33AM +0200, John Paul Adrian Glaubitz wrote:
> >> Hello!
> >>
> >> I have applied Christoph's full series on top of Linus' tree and I can confirm that
> >> the kernel boots fine on my SH-7785LCR board.
> >>
> >> Thus, for the whole series of patches:
> >>
> >> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > 
> > Any chance we get the patches queue up while you're all sorting out
> > totally independent issues?
> 
> I would love to buy only Rich can do that. I'm fine with your patches
> and would much appreciate if Rich could queue them up.
> 
> I'm also still waiting for my patch to be queued as well.

I saw it looked like this is solved and I'm going to look at it later
today. Thanks!

Rich
