Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B242F253249
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgHZOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 10:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgHZOxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAB98221E2;
        Wed, 26 Aug 2020 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453616;
        bh=2keurcFsfkeACh52+4p5T0ngZFhF0/cvWdgnziyfZAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+jQFBX9Y2cFQQnnBpOO8pRXn7pkU3ktYS6fim4jFRisgluZ5eT/WDBaaLAjzeXDT
         WvB6ehRk9ClWtUh6A8MwBFdceThH+yepXYWz0ahlL0dj01Yciozp4zN36CSyrhd+W2
         3+ktczweQwjZoa/4RGN1dY0ACA98suwt+CZGrbFY=
Date:   Wed, 26 Aug 2020 16:53:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David K. Kahurani" <k.kahurani@gmail.com>
Cc:     linux-kernel@vger.kernel.org, admin@rapidseedbox.com,
        gichini.ngaruiya@gmail.com
Subject: Re: [PATCH 5.7 00/15] 5.7.19-rc1 review
Message-ID: <20200826145351.GA4181729@kroah.com>
References: <20200826114849.295321031@linuxfoundation.org>
 <20200826144915.GD16589@metal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826144915.GD16589@metal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 05:49:15PM +0300, David K. Kahurani wrote:
> On Wed, Aug 26, 2020 at 02:02:28PM +0200, Greg Kroah-Hartman wrote:
> > -------------------
> > Note, ok, this is really going to be the final 5.7.y kernel release.  I
> > mean it this time....
> > -------------------
> 
> Hello,
> 
> This is probably not very relevant but let me just bring this up here
> since your manner of posting mail on the list seems to differ quite a
> bit from what most people on the list are doing.

It's not all that relevant as what I am doing here is not what anyone
else on this list is doing :)

> From my understanding, an email regarding to a certain patch or kernel
> issue should be sent to a list and not to a maintainer. This is
> however not the habit that people are in, though but instead, most
> people will send the email to the maintainers, then cc a few probably
> random mailing lists. This leads to emails flooding on the mailing
> list and consequently, beats the purpose of one ever having sent the
> mail to a list because lists will get increasingly difficult to
> follow.

So is the complaint that these stable -rc emails are drowning out seeing
other patches that are relevant?

If so, there are some wonderfully helpfuly headers that I add to all of
these emails so you can easily filter them away to /dev/null if you so
desire.

If not, then I don't understand the complaint.

> Is it just me who has made this observation? From your mail, it
> clearly looks and seems like you are following the above. Not
> following the above could make it very hard for a new kernel developer
> to pick up working on the kernel.

Have you read the Documentation/process/1.Intro.rst file?  If not,
please start there, as trying to read the firehose that is lkml all at
once is _not_ how anyone does kernel development.

thanks,

greg k-h
