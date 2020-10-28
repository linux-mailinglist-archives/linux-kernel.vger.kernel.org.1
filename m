Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDB29D2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgJ1ViB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJ1VhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7301F247D2;
        Wed, 28 Oct 2020 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603900760;
        bh=OE9B93Si8p6/W+xc0eorfXOV0Lb9RB8Kq4ShAassmtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nr1CvdOzeT5TtRP18a29BpxOw87yG6CxtBgIGUHzp4hls/TbD5eLbhkCmvLslPUTs
         PTNX95CoOk1b6jawjnHuYeVtEbzVlv3WxLtlmds9siAXv4tFHQ4OMrtu3iGH5sKoZH
         XCz2WmghEKAzdfJ1ht+OQb9qUBcQTyBqO0yz0giE=
Date:   Wed, 28 Oct 2020 17:00:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201028160011.GA2784447@kroah.com>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
 <20201027081420.GA30177@kroah.com>
 <20201027091725.GA42707@kroah.com>
 <20201027163213.GA25390@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027163213.GA25390@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 04:32:13PM +0000, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 10:17:25AM +0100, Greg KH wrote:
> > Ok, I couldn't get a clean merge of that old branch on top of your
> > 5.10-rc1 tree, so I can't give it a run-through.  If you have an updated
> > series you want me to test, I'll be glad to do so.
> 
> Can you give this branch a spin?
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-proc

Sorry for the delay, took a while to get results due to other testing
errors...

Anyway, yes, this worked!

So feel free to add:

	Tested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If you send those out.

Now I ran into a fnctl test that is failing when reading trying to run
splice on /proc/version (crazy tests), let me go see if I can do the
same thing you did for cpuinfo for all proc "single data" files...

thanks,

greg k-h
