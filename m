Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361321F69A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGNP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:59:19 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:60680 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgGNP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:59:19 -0400
Date:   Tue, 14 Jul 2020 11:59:18 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200714155914.GA24404@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:31:00PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Christoph!
> 
> On 7/14/20 2:18 PM, Christoph Hellwig wrote:
> > can you take a look and possibly pick up the series below that untangles
> > and sorts out minor issues with the sh ioremap and dma code?
> > 
> > I sent this out a few times, but never got an answer.  If you don't
> > want to pick up the series I can also take it through one of my trees
> > if I get ACKs.
> 
> Rich already said he is fine with most of the changes but we need to test
> the DMA changes first to make sure they didn't break anything.
> 
> Thanks again for your continued efforts.

Yes. Sorry I didn't also reply in the original thread.

I'd like to have a way to test the DMA changes or testing feedback
from someone using an affected configuration just because they're
sufficiently nontrivial (Adrian might be able to do this? If so that'd
be great; if not let me know if it's testable in qemu), but the rest
look good to go.

Big thanks for your efforts to clean all this up!

Rich
