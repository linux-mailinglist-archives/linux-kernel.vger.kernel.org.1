Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191CE28F75F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbgJORAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388305AbgJORAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:00:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4047206CA;
        Thu, 15 Oct 2020 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602781251;
        bh=DM6q/p4qmHRCt+hKln8abCi1RFmqHpOO4oDZOapg6+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x+pWe4gfphCS1xKW8ELKqn83lTh5ZcRI+8Y+vhuODH2LP7BFIpAP6hx84DX8M2RMd
         C7JykakjiwC/1DUZzBVmz/3V1p1RF4a88W14DsN6Oy+Xp2Vhai/HBLKW/XdHxQH7jq
         z4PwV9/k06L04stmXifYakkfIyWFVWz0zKtfljLg=
Date:   Thu, 15 Oct 2020 19:01:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@linuxdriverproject.org
Subject: Re: [GIT PULL] Staging/IIO driver update for 5.10-rc1
Message-ID: <20201015170123.GA81179@kroah.com>
References: <20201015122713.GA4021230@kroah.com>
 <CAHk-=wiwi70PmzxNeNUBiGTgQMDnRhHToTkQrhL7GQKdJyUQAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwi70PmzxNeNUBiGTgQMDnRhHToTkQrhL7GQKdJyUQAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:49:56AM -0700, Linus Torvalds wrote:
> On Thu, Oct 15, 2020 at 5:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Included in here are:
> >         - new IIO drivers
> [...]
> >         - no new drivers added or removed
> 
> So which one is it?
> 
> New drivers, or no new drivers, that is the question: Whether 'tis
> nobler in the mind to suffer..
> 
> I do understand what I think you meant (no _staging_ drivers added or
> removed), but it really reads very oddly.

Yes, you are right, I meant "no new staging drivers" were added or
removed.  I forgot what I wrote above by the time I got to the bottom :)

thanks,

greg k-h
