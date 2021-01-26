Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024730456A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392009AbhAZRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbhAZHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 02:40:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C503222DFB;
        Tue, 26 Jan 2021 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611646168;
        bh=EeYd7CB89GWAcW8uYhjNeyGSFBIHZRdbLk/gleJ31F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNaZz2CRyrqkmqEJ1L1MkcmfJ1EYBiqHIz1t+RsnXvcu8flhZMFUTbYNSpfAd0EQN
         vC6l8OFAzqdw7q/Yp3BZc0vofaA1B32DcMVvtkoNgXWVbaB+2EnOzBIowUGEbtfyW0
         E8r5zyzAOjHkbbqCg+ndL2FzVJpzXyWa5muasrNQ=
Date:   Tue, 26 Jan 2021 08:29:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YA/E1bHRmZb50MlS@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
> Hi All,
> 
> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.

Because they want to use all of the latest stuff that 5.10 provides
them.  Don't you want faster and more secure kernels for your devices?

> Yet, various unofficial reports indicate it will be supported for 6 years.

Rumors are nice, aren't they :)

>  And AOSP has already declared the use
> of 5.10 kernel in their Android S and T releases.

Publically?  Where?  And is that really the name of the new Android
releases, I thought they switched to numbers now (hence the naming of
the current android-common kernel branches, marketing is fun...)

> Is there some way we could make the LTS support more clear.
> A 2 year declaration is not LTS any more.

Not true at all, a "normal" stable kernel is dropped after the next
release happens, making their lifespan about 4 months long.  2 years is
much longer than 4 months, so it still is a "long term supported" kernel
in contrast, correct?

> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
> https://www.kernel.org/category/releases.html

Why?  What would that change?

Ok, seriously, this happens every year, and every year we go through the
same thing, it's not like this is somehow new, right?

I want to see companies _using_ the kernel, and most importantly,
_updating_ their devices with it, to know if it is worth to keep around
for longer than 2 years.  I also, hopefully, want to see how those
companies will help me out in the testing and maintenance of that kernel
version in order to make supporting it for 6 years actually possible.

So, are you planning on using 5.10?  Will you will be willing to help
out in testing the -rc releases I make to let me know if there are any
problems, and to help in pointing out and backporting any specific
patches that your platforms need for that kernel release?

When I get this kind of promises and support from companies, then I am
glad to bump up the length of the kernel support from 2 to 6 years, and
I mark it on the web site.  Traditionally this happens in Febuary/March
once I hear from enough companies.  Can I count on your support in this
endeavor?

Also, a meta-comment.  Please reconsider using a single kernel version
for longer than 2 years on systems that you actively support and
maintain.  It's generally a bad idea unless you are stuck with millions
of out-of-tree code that something like a customer-unfriendly SoC vendor
provides.  If you are stuck in that type of situation, well they have
decided to spend extra money to keep their out-of-tree code alive, so
why are they forcing you to also spend extra money and energy?

I can go on about this topic at length if you want me to, I have lots of
examples of how to, and not to, maintain a kernel for a device for a
long period of time...

thanks,

greg k-h
