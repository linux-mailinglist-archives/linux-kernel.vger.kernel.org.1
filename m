Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA829A652
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508865AbgJ0IN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394916AbgJ0IN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:13:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901F320878;
        Tue, 27 Oct 2020 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603786406;
        bh=LtbZI7NLMcSqAsXLYcdS4AQ+IWDRLZon++yZ/6HSoJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzMTh6hFDEjvi4Iy0KjBM5a0jSKuUuUiW4Qg+5qfos+zzAq/mWubTXx439BNuQoZN
         Uvzs/Xbtgn6lwyMBo40h8KNxTcvA8GPu+3r+fea00WvXhA8aGw9zScdoAM4K9jd2kR
         HKKnLkHb7lclql91meNPAKaGFUIt3/lOYodbsACI=
Date:   Tue, 27 Oct 2020 09:14:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027081420.GA30177@kroah.com>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080745.GA31045@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:07:45AM +0000, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 08:55:41AM +0100, Greg KH wrote:
> > This is just a test, part of the bionic test suite to verify that bionic
> > is working properly, and is run on new kernels as a verification that
> > nothing functional broke in the kernel update.
> > 
> > I don't know about "real applications" yet.
> > 
> > Do you have to implement this on a per-proc-file-basis, or will it work
> > for the whole filesystem?
> > 
> > And are the patches public anywhere that I could test them out?
> 
> This all branch has the last posted version:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-rw.2
> 
> with tthe proc:, sysctl: and seq_file: patches related to it.  It did
> switch over all seq_file instances, but non-seq_file instances and write
> operations will need manual per-instance work.

Luckily /proc/cpuinfo seems to use the seq_file interface, so this
series would work for that.

What's the odds of this series getting into 5.10-final?  I'll go run it
through the Android build system right now to see if it fixes the issue
or not...

thanks,

greg k-h
