Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA62EEF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbhAHJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbhAHJVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:21:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19BF323372;
        Fri,  8 Jan 2021 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610097628;
        bh=oiPKPwrLUTXmyxEg4htGUPgFpzc+ZSlNsGuIlmxZcHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FmG54POPm2c2tiKdpWlDe940ivqmckLWEjMutD1Z9iWCYSH1oOGMajQcbIW3dJMec
         n9TFS+6rhKwqcvHge4pnOswKtWes6MxZUvil9oNN4hUhJyuCaofAqFpYXsdRw5Bjfy
         a7lkb0cRHVP+PxTQy62P2GE/d3k7oCBGoOFbXSRdjbzX9YcRRTZmhsLY/fdzw+pDMP
         HBtNNxb3lQEYayOFbkI7wAPEOuggq7xk3P2nSlM+c+P5n17w90rX9o5JJIUN8FE/KZ
         pzVGRvRLjOM4zY99FjwjvuyGp9rX8XwxhtEZmg3e5gL4IaT+QS0ONb9h/CXJOyxfo7
         cUblV5M4jCQoQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kxnwd-00019U-DK; Fri, 08 Jan 2021 10:20:31 +0100
Date:   Fri, 8 Jan 2021 10:20:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] usb: misc: emi26: update to use
 usb_control_msg_send()
Message-ID: <X/gj3yFkLjuLxTZs@hovoldconsulting.com>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130012847.2579463-1-anant.thazhemadam@gmail.com>
 <X8pKmmdvO0cIQXnL@localhost>
 <6806f8e4-c2f7-3c6a-b855-3f87ab8d9e22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6806f8e4-c2f7-3c6a-b855-3f87ab8d9e22@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 07:43:54PM +0530, Anant Thazhemadam wrote:
> On 04/12/20 8:11 pm, Johan Hovold wrote:
> > On Mon, Nov 30, 2020 at 06:58:47AM +0530, Anant Thazhemadam wrote:
> >> The newer usb_control_msg_{send|recv}() API are an improvement on the
> >> existing usb_control_msg() as it ensures that a short read/write is treated
> >> as an error,
> > Short writes have always been treated as an error. The new send helper
> > only changes the return value from the transfer size to 0.
> >
> > And this driver never reads.
> >
> > Try to describe the motivation for changing this driver which is to
> > avoid the explicit kmemdup().

> >>  /* thanks to drivers/usb/serial/keyspan_pda.c code */
> >> @@ -77,11 +67,7 @@ static int emi26_load_firmware (struct usb_device *dev)
> >>  	int err = -ENOMEM;
> >>  	int i;
> >>  	__u32 addr;	/* Address to write */
> >> -	__u8 *buf;
> >> -
> >> -	buf = kmalloc(FW_LOAD_SIZE, GFP_KERNEL);
> >> -	if (!buf)
> >> -		goto wraperr;
> >> +	__u8 buf[FW_LOAD_SIZE];
> > As the build bots reported, you must not put large structures like this
> > on the stack.
> 
> Understood. 
> But I'm considering dropping this change (and the one proposed for
> emi62) altogether in v3 - since these would end up requiring memory to
> dynamically allocated twice for the same purpose.  However, if you
> still think the pros of updating this (and emi62) outweigh the cons,
> please let me know, and I'll make sure to send in another version
> fixing it.

The redundant memdup() is already there for the firmware buffer and
changing to usb_control_msg_send() will only make it slightly harder to
get rid of that, if anyone would bother.

But yeah, it's probably not worth switching usb_control_msg_send() for
these drivers.

Johan
