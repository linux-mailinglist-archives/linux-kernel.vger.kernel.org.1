Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AA629D622
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgJ1WME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbgJ1WL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E5C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zvwmyLmUQNLER8L4Ls2HMYjn8izTkstS/5L2LxIUcOY=; b=DFLRK9mt3AkffjO5/oDmnBiY7h
        /ow3Ja23yP2lx7ZLQYFqj5Lsw3KlfVan0mVV6jxUuTwolJvT7R8KNmIjscwQs7ivq00rRKWv23LZN
        Jz/mpvWSdciCaiFNs0T1gBBMfjc70zT5m0kFvt9TOYN8PPaTS7jReINLNRE9Amc6D4UzHsvj054Ri
        nKqpNcozY+KrOZDuPMCAdAdxb+Ez7Vu3kutReEr4QWqsy+/05XF2YspEqSeFPwprS8QbH5wd705JV
        JdJxynde0uE/D9ic+M/uztCDoD17RQXheYaOtF7CsZMr+Jw3yqgZ3Lr/nVafwt1L51uyx9L0kpAZg
        4sKvfa6g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXqHR-0002En-8Z; Wed, 28 Oct 2020 18:34:41 +0000
Date:   Wed, 28 Oct 2020 18:34:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201028183441.GA8461@infradead.org>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
 <20201027081420.GA30177@kroah.com>
 <20201027091725.GA42707@kroah.com>
 <20201027163213.GA25390@infradead.org>
 <20201028160011.GA2784447@kroah.com>
 <20201028183359.GA2957431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028183359.GA2957431@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:33:59PM +0100, Greg KH wrote:
> That worked too, I'll send a patch for this for the top of your branch
> to resolve this issue as a response to this email.

In the old branch I had a scripted conversion of all proc_read instances
that point to seq_read to use seq_read_iter.  I can probably do that
as well here.
