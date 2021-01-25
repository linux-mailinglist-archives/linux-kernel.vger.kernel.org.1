Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB775302C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbhAYT6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731401AbhAYTwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:52:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4B2620684;
        Mon, 25 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611604326;
        bh=NoqcUmQ2x4d1F0svAB08rO+q5EnnHU95cXTCU4BxOCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7bAu9EOuvqDURDp+svJ6TbeajtWedt5eynAFeYirMeZgVlx4osfE7OfMGC5OGNxi
         aLrimKkNv3Ul2/37anCW9pn+0n4jiSTQgPyT9CV4JIbcalkyOLDyJJXq2KznqpFqfU
         x3IHCCYyZMhs3PqicapV5frhhfJtK3QvTxk+SlGE=
Date:   Mon, 25 Jan 2021 20:52:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter
 conversion
Message-ID: <YA8hYxasFC9VarRq@kroah.com>
References: <20210125190925.3655829-1-samitolvanen@google.com>
 <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
 <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:45:12AM -0800, Linus Torvalds wrote:
> On Mon, Jan 25, 2021 at 11:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Obvious ACK from me.
> 
> Greg - if you have nothing else lined up in the tty tree, I can take
> this fix directly if it's easier.

I have nothing else that I know of, so yes, it is easier for you to take
it directly, thanks!

greg k-h
