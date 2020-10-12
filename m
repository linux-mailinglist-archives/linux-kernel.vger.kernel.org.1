Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2A28BD10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbgJLQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:00:14 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33111 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726742AbgJLQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:00:14 -0400
Received: (qmail 634439 invoked by uid 1000); 12 Oct 2020 12:00:13 -0400
Date:   Mon, 12 Oct 2020 12:00:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
Message-ID: <20201012160013.GA632789@rowland.harvard.edu>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia>
 <20201012145710.GA631710@rowland.harvard.edu>
 <alpine.DEB.2.21.2010121659040.6487@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010121659040.6487@felia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> 
> 
> On Mon, 12 Oct 2020, Alan Stern wrote:
> > Real code contains so many assumptions, especially if you include ones 
> > which are obvious to everybody, that such a tool seems impractical.
> >
> 
> I fear that problem applies to all static code analysis tools I have seen; 
> at some point, the remaining findings are simply obviously wrong to 
> everybody but the tool does not get those assumptions and continues 
> complaining, making the tool seem impractical.

Indeed, it is well known that the problem of finding all errors or bugs 
by static code analysis is Turing complete.

> Alan, so would you be willing to take patches where _anyone_ simply adds 
> comments on what functions returns, depending on what this person might 
> consider just not obvious enough?

No.  I would take such patches from anyone, but depending on what _I_ 
consider not obvious enough.

> Or are you going to simply reject this 'added a comment' patch here?

I have already accepted it.  In fact, the patch was my suggestion in the 
first place.

When I originally wrote this code, I was aware that it was somewhat 
subtle, but at the time it didn't seem to warrant a comment or 
explanation.  Sudip's patch has changed my mind.

> I am not arguing either way, it is just that it is unclear to me what the 
> added value of the comment really is here.

As with many other comments, its purpose is to explain a somewhat 
obscure aspect of the code -- something which is there by design but 
isn't immediately obvious to the reader.  That is the added value.

> And for the static analysis finding, we need to find a way to ignore this 
> finding without simply ignoring all findings or new findings that just 
> look very similar to the original finding, but which are valid.

Agreed.  In this case, the new comment does a pretty good job of telling 
people using the tool that the finding is unjustified.

If you are suggesting some sort of special code annotation that the tool 
would understand, I am open to that.  But I'm not aware of any even 
vaguely standard way of marking up a particular function call to 
indicate it will not return an error.

Alan Stern
