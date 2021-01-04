Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22D2E925A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbhADJJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbhADJJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:09:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A416321D79;
        Mon,  4 Jan 2021 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609751347;
        bh=q/nhawxLNc5Shs/4y+izVkXG0MR/QhpLQAscJnTvUJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJeC2WnUaEbjWCIPGIoxkhIyxI4eBKFT5f0TVzbP+GpYQsuSzNsh8s8CdnJ5GLuaV
         X0LP/6UhlFnmLWmguKnLD9+jwKNcKRlzWQmo9pkgNinHFu6jl9JwC7//oFk82kCzoT
         Z0A+XhFa9Fhl483kY2qWIkLkHtDNySwBK2peE+wWMMJA1IgDKB/M9ixObuBpLwKYPR
         zQGyYNW8ovDckNQZm6KPEFtJa0Pa0PY4d1cdHQzFYPcCToGapjiIRXlj1hFax2co+J
         G/qe33Jjdwl7+FwX10Y1GO7SIhneCjecjkEsPcYFdlNUiokGoY129J7uoSZfSVOKA4
         q4dMUDWD9B6AA==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kwLrM-0005qF-2I; Mon, 04 Jan 2021 10:09:04 +0100
Date:   Mon, 4 Jan 2021 10:09:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangqiumiao1@huawei.com, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: resolve loopback wait problem for aging serial
 port
Message-ID: <X/LbMCeNbjedkIiy@hovoldconsulting.com>
References: <1609335929-13463-1-git-send-email-zhangqiumiao1@huawei.com>
 <X+yHOr6Q5fsuQhSy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X+yHOr6Q5fsuQhSy@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 02:57:14PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 30, 2020 at 09:45:29PM +0800, zhangqiumiao1@huawei.com wrote:
> > From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> > 
> > Because serial port is low-speed device, serial port writing will be suspended
> > when the buffer of driver layer is full due to serial port aging.
> 
> What do you mean here exactly?  What is "serial port aging"?
> 
> And since when is a serial port a low-speed device?  Compared to what?
> 
> > The concrete
> > representation is n_tty_write blocking in the process of wait_woken, the process
> > of writing serial port exists without feedback, and becomes a zombie process.
> 
> I do not understand this sentance, sorry.  Can you rephrase it?
> 
> > So for serial port, set the timeout value of wait_woken function to 60s. Wake up
> > and flush the buffer after timeout.
> 
> Where did the 60 second number come from?  Why that value and not any
> other specific value?
> 
> 
> > 
> > Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> > ---
> > v3:
> >  add changes from v1 to v2
> > 
> > v2:
> >  change to use "real name"
> >  fix wrong expression in path description
> >  remove config option
> >  use driver type to judge tty device type

Note that no mails from zhangqiumiao1@huawei.com appears to make it to
the lists so anyone not in CC only sees your replies, Greg. 

Qiumiao Zhang, you need to check your mail setup so that you can post to
the lists.

Johan
