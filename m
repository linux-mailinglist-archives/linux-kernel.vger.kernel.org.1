Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7D2831BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJEIS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:18:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49382075A;
        Mon,  5 Oct 2020 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601885935;
        bh=a3hZG38nYuH7ILLCqeYIKDVFUN9qdL0tXSCBnJt0vzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGsi91aD4lBD6yc0gsiR25lvFINWAXfZpxfZCc5MjxthOts5lTbemiXU1Hp9+Ubow
         uqQAJ15FB4S6M0w2JRwpjK9QMRHsAXI88AvRmCQYBmu5CAJdYfMAkpd41p7cBVYICA
         /z/Iy6BZzchFaIQnVREfWDwuvwTAM1RWJXIO2XTs=
Date:   Mon, 5 Oct 2020 10:19:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tammo Block <tammo.block@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 0/6] vt: Add SRG mouse reporting features
Message-ID: <20201005081939.GA407265@kroah.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
 <20201002123002.GA3346488@kroah.com>
 <CAEHKo2nK+S42FmjN3NDh8g8+yNvcpeBAbY8sq+wUxbRmZcbCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHKo2nK+S42FmjN3NDh8g8+yNvcpeBAbY8sq+wUxbRmZcbCGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 10:06:38AM +0200, Tammo Block wrote:
> Hi Greg,
> 
> Am Fr., 2. Okt. 2020 um 14:30 Uhr schrieb Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>:
> >
> > On Mon, Jul 06, 2020 at 12:57:22PM +0200, Tammo Block wrote:
> > > Hi everybody,
> > >
> > > this patchset adds xterm like mouse reporting features to the console.
> > >
> > > The linux virtual console has support for mouse reporting since 1994 or so,
> > > but the kernel only supports the original X10/X11 style standard protocols.
> > > To support more protocols these patches expand the kernel structures in a
> > > up- and downwards compatible way, see the last patch for detailed
> > > documentation and pointers to even more detailed docs.
> > >
> > > The main goal is to become compatible with xterm, as most TUI software today
> > > is tested in xterm or another compatible terminal.
> > >
> > > Support by the mouse daemons (consolation, gpm) will be needed too.
> >
> > What happened to this feature.  Was there a new set of patches or was
> > this the last one?
> 
> This was the last set, there were no further comments in any direction.
> 
> > mouse support for the console feels odd these dyas, who would use this?
> >
> Well .... at least i am using it .. ;-)
> 
> This is in fact not a really new feature, but an improvement of an old feature.
> The patch just tries to be compatible with xterm and other modern terminals
> to be able to run stuff like midnight commander or similar programs.
> 
> I am personally using console tty's for long running or controlling stuff
> and being able to use the mouse (especially for cut n' paste) seems useful.
> At least for me. But my personal habits might be odd ...
> 
> Feel free to ignore the patches if you don't consider this feature useful.
> If you do consider it useful I can rebase against whatever you like.

Rebasing against 5.10-rc1 comes out in a few weeks, and resending it
then seems like a good idea.

thanks,

greg k-h
