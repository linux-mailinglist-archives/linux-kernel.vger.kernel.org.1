Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5028BB6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgJLO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:57:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58117 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729667AbgJLO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:57:11 -0400
Received: (qmail 632421 invoked by uid 1000); 12 Oct 2020 10:57:10 -0400
Date:   Mon, 12 Oct 2020 10:57:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
Message-ID: <20201012145710.GA631710@rowland.harvard.edu>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010121550300.6487@felia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:11:38PM +0200, Lukas Bulwahn wrote:
> 
> 
> On Sun, 11 Oct 2020, Sudip Mukherjee wrote:
> 
> > Add a comment explaining why find_tt() will not return error even though
> > find_tt() is checking for NULL and other errors.
> > 
> > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> I get the intent of the comment but there is a large risk that somebody 
> could remove the find_tt() call before the calling the function and there 
> is no chance to then see later that the comment is actually wrong.

Why would anybody do that?  Who would deliberately go change a driver in 
a way that is obviously wrong and would break it?  Especially when such 
changes are likely to cause compile errors?

There are tons of changes one might make to any program that will leave 
it syntactically valid but will cause it to fail.  What's special about 
removing the early calls to find_tt()?

> I guess you want to link this comment here to a code line above and
> request anyone touching the line above to reconsider the comment then.

That really seems unnecessary.

> But there is no 'concept' for such kind of requests to changes and 
> comments.
> 
> So, the comment is true now, but might be true or wrong later.
> 
> I am wondering if such comment deserves to be included if we cannot check 
> its validity later...
> 
> I would prefer a simple tool that could check that your basic assumption 
> on the code is valid and if it the basic assumption is still valid, 
> just shut up any stupid tool that simply does not get that these calls 
> here cannot return any error.

Real code contains so many assumptions, especially if you include ones 
which are obvious to everybody, that such a tool seems impractical.

Alan Stern
