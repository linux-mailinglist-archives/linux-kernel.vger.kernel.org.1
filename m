Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC6429A655
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443627AbgJ0IPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:15:34 -0400
Received: from casper.infradead.org ([90.155.50.34]:34296 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508872AbgJ0IO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kCOSijagaKHmxK8MwdcwWXCr1ds42cJ2bvuNXMSRJ+Q=; b=BAKNOWrKdIS16rOuIDrwnFnYtw
        +0vM81xocuZYvzDI1+ofCWovX/n++Hva5QwkcXHXltvw+3DeJbn9T8h15JGsBuZyfNyJZpuu12GqN
        K5cYvxE041kStCr3HbfysoocNtmoEaKI0rdCtxALK2LMQ39OybJyL0NrSvPo4odMKnt+HsN9IOufH
        iRTY9mr1alLwsiD0r71KmWYaN3xGLVp5CRU5BfBUt5Dw0rNNMi+9O6Zl9yyvpEF5PsMfyT1z3iLzO
        7ihvEqPK6NU0136cwcZaoTBm3r78SFAu1lsUjMMYTQE7s68wR6EBg9cC6YULPldZx9QdZ8eRTTrNa
        RFgV4XGw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXK88-00016s-60; Tue, 27 Oct 2020 08:14:56 +0000
Date:   Tue, 27 Oct 2020 08:14:56 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with splice from /proc (was Linux 5.10-rc1)
Message-ID: <20201027081456.GA4146@infradead.org>
References: <CAHk-=whcRFYSm0jj3Xh3xCyBaxCHA1ZMNO0h_gZso_WZFDUtiQ@mail.gmail.com>
 <20201027064832.GA209538@kroah.com>
 <20201027074911.GB29565@infradead.org>
 <20201027075541.GA24429@kroah.com>
 <20201027080745.GA31045@infradead.org>
 <20201027081420.GA30177@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027081420.GA30177@kroah.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:14:20AM +0100, Greg KH wrote:
> Luckily /proc/cpuinfo seems to use the seq_file interface, so this
> series would work for that.
> 
> What's the odds of this series getting into 5.10-final?  I'll go run it
> through the Android build system right now to see if it fixes the issue
> or not...

It contained a few bits people didn't like too much, and we had no
practical need for it.  I'll try to respin it to be a little more
palatable, and will update you once I have results.
