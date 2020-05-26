Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64C1D7204
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgERHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 03:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgERHib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:38:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD51A207F5;
        Mon, 18 May 2020 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589787511;
        bh=y0GkUKU5r7lGD9yRHVFJviUMzEKMAbqxRbSrU/nSEHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+aG48dwSqg2HtDhF+oWwgSRz5uEQipMEaqgdwq5UgtW5MOh1bNaMocJI0g5Kdx2N
         49cR+FLxEd9j5trV+mLCufssiIoM22dAtnRdYUfKyo5TS/C5ZhxA+umfLpIBq5dhKV
         2ikN0SwjMcvC2WiQ1hfa7+eqi+2rY+mTImu/yTJM=
Date:   Mon, 18 May 2020 09:38:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: Improve debug output
Message-ID: <20200518073829.GA3055513@kroah.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com>
 <20200512115323.1447922-2-gregory.clement@bootlin.com>
 <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com>
 <87tv0dg0ii.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv0dg0ii.fsf@FE-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:33:57AM +0200, Gregory CLEMENT wrote:
> Hello Jiri,
> 
> > On 12. 05. 20, 13:53, Gregory CLEMENT wrote:
> >> Use appropriate print helpers for debug messages.
> >> 
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> ---
> >>  drivers/tty/n_gsm.c | 14 ++------------
> >>  1 file changed, 2 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> >> index d77ed82a4840..67c8f8173023 100644
> >> --- a/drivers/tty/n_gsm.c
> >> +++ b/drivers/tty/n_gsm.c
> >> @@ -504,18 +504,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
> >>  	else
> >>  		pr_cont("(F)");
> >>  
> >> -	if (dlen) {
> >> -		int ct = 0;
> >> -		while (dlen--) {
> >> -			if (ct % 8 == 0) {
> >> -				pr_cont("\n");
> >> -				pr_debug("    ");
> >> -			}
> >> -			pr_cont("%02X ", *data++);
> >> -			ct++;
> >> -		}
> >> -	}
> >> -	pr_cont("\n");
> >> +	if (dlen)
> >
> > This test is superfluous. print_hex_dump_* won't write anything when
> > zero length is passed to it.
> 
> As I will send a v3 due to the issue found on the last patch, I am also
> going to fix this.

Ugh, as I already applied this series, should I just revert them all, or
are you going to send fix-ups on top of what I have applied instead?

thanks,

greg k-h
