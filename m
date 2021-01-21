Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471742FE5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbhAUI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbhAUI7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:59:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0609422473;
        Thu, 21 Jan 2021 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219520;
        bh=iG/p8IPpLy3M6vDZscRB0uVFF8bOLLGuF5E029FCRrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VouRAkUKPYjeh8sVdry+sMtFaKD66UYrlb5pmdczL+3C2bDbfha/9Ls28ZPBax5OR
         biQOdQjkxceiGUlwCD/eqlFL825Qh+Oiz7bGr9Ln75yFLwEQRUxsNLDBB0juGLv0ZM
         Nhhrd+pytYDRHCeyrL02S18sXLUEDXeUzboOBfcU=
Date:   Thu, 21 Jan 2021 09:58:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: tty splice branch (was "Re: Splicing to/from a tty")
Message-ID: <YAlCPZF/tA08l/+4@kroah.com>
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
 <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
 <CAHk-=wiw=+A3Lnru7cvTbEka0QTpt14QBA06C49n+SJ_WQ1VFw@mail.gmail.com>
 <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1230bd-e310-9b2a-a1ed-1547bd7181e7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:50:39AM +0100, Jiri Slaby wrote:
> On 21. 01. 21, 2:18, Linus Torvalds wrote:
> > On Tue, Jan 19, 2021 at 8:44 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > 
> > > I'll come back to this tomorrow and do the line-buffered icanon case
> > > too (unless pull requests pile up), and then I'll be happy with the
> > > tty changes, and I think I can submit this series for real to Greg.
> > 
> > Greg, I don't know how you want to handle this.
> > 
> > I have a branch with my tty splice patches at
> > 
> >      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git tty-splice
> > 
> > and that now includes doing that "cookie continuation" thing even for
> > the N_TTY icanon modes.
> > 
> > It passes my local tests, and I did try a few rather odd things. And
> > Oliver tested an ealier version without that final commit on his load.
> > But...
> 
> Hm, I would like to review this first. I noticed the changes only because a
> new branch appeared when I grabbed your tree and the branch has "tty" in its
> name.
> 
> So for example:
> 
> > @@ -1038,18 +1045,15 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
> >         if (tty->ops->write_room == NULL)
> >                 tty_err(tty, "missing write_room method\n");
> >         ld = tty_ldisc_ref_wait(tty);
> > -       if (!ld)
> > -               return hung_up_tty_write(file, buf, count, ppos);
> > -       if (!ld->ops->write)
> > +       if (!ld || !ld->ops->write)
> >                 ret = -EIO;
> >         else
> > -               ret = do_tty_write(ld->ops->write, tty, file, buf, count);
> > +               ret = do_tty_write(ld->ops->write, tty, file, from);
> >         tty_ldisc_deref(ld);
> 
> if ld == NULL => crash here.
> 
> So can you send the patches to the list and Cc me too?

I'll send them out right now, I've already merged them to my branches.

greg k-h
