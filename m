Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD028CC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgJMK6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgJMK6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:58:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DB62072C;
        Tue, 13 Oct 2020 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602586700;
        bh=eQMWAJg5c5/Xk4OQukQZyjkJ7g5KWKnsWMc0GtSgxiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPqn2sAbLhP8TG8uah7EKCC0ic2flaaE+vAaUqCrlanhF8FT4JiYYM/uY4YzT937A
         kJ89V1B86+wWcyiWOvjUo3RuZGi32j2IMKl70AkOlr5U0M8DWYl1NZUGeItDZSeSEf
         +mO5tCxurLCr3A1Q/qkXrCyvRmytJaNrk/Y0ONdA=
Date:   Tue, 13 Oct 2020 12:58:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     harshal chaudhari <harshalchau04@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
Message-ID: <20201013105857.GA1940039@kroah.com>
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com>
 <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
 <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:31:21PM +0530, harshal chaudhari wrote:
> On Sat, Oct 10, 2020 at 2:41 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > On Sat, Oct 10, 2020 at 1:08 AM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > On Fri, Oct 9, 2020 at 5:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Oct 08, 2020 at 11:57:13PM +0530, Harshal Chaudhari wrote:
> > > > > Checking the argument passed to the ioctl is valid
> > > > > or not. if not then return -EINVAL.
> > > >
> > > > Along the the comments that Arnd made, this is not the correct value to
> > > > be returning from an ioctl when you don't pass in the correct command.
> 
> Thanks Greg for the comment. i am checking with value
> -EFAULT now, i will get back to you with changes as consideration
> of Arnd comments.

-EFAULT is only used if there really is a memory fault, which I strongly
doubt is the case here.

> > > > And it doesn't match what your patch says, please be consistent.
> 
> I just want to perform the Argument check here only.  back then i
> was trying with access_ok() as well, but access_ok() return success
> even if i passed a NULL pointer. so that's why i removed it from here.

access_ok() should never be used in drivers anymore.

thanks,

greg k-h
