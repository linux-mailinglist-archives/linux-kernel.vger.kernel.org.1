Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9652EFC97
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAIBE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:04:26 -0500
Received: from casper.infradead.org ([90.155.50.34]:59684 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbhAIBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T8SDUdzx1DLheCzLoyrLEGQyCwv1obD1Uy5JaUB9koY=; b=ove/+5YPf0ph6VbbaIh8SgBgZ/
        wTZMNLJKHfcsw5nbz1aGCH26z+191Xwrf0ZjWda9sJ33DfnlHK/Su30766+YuvNgNji35EZeKzK+Q
        5hnDf1loYj6GuHI80JD+RzQPQX2BdbwSqG0p/mopEKQ6GPdC5EOm0zdgTGHFCbvknqz3diVPuUYX7
        Py/UsgnwHw/zoNAfRciyLJtuzy0dUpHMb5qz9emRxNsjdmbxC1+42/cEyjj6VR/xwnoCa/L00aGri
        uPOsX2LfGEXBuEkreG7RxW9QpMYS/gOmzYAzkPOMK28soX2rW+YnYjIxe7dr8gV3avPmZJxZYntw8
        PDNo2ELg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxW7m-00070I-Cg; Thu, 07 Jan 2021 14:19:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72BAA3003E5;
        Thu,  7 Jan 2021 15:18:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D50D2B88A082; Thu,  7 Jan 2021 15:18:47 +0100 (CET)
Date:   Thu, 7 Jan 2021 15:18:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     paulmck@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <X/cYR474/PiTvjfC@hirez.programming.kicks-ass.net>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
 <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 01:16:50PM -0800, Yury Norov wrote:
> On Wed, Jan 6, 2021 at 1:50 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Aside from the comments Yury made, on how all this is better in
> > bitmap_parselist(), how about doing s/last/N/ here? For me something
> > like: "4-N" reads much saner than "4-last".
> >
> > Also, it might make sense to teach all this about core/node topology,
> > but that's going to be messy. Imagine something like "Core1-CoreN" or
> > "Nore1-NodeN" to mean the mask all/{Core,Node}0.
> 
> If you just want to teach bitmap_parselist() to "s/Core0/0-4",  I think
> it's doable if we add a hook to a proper subsystem in bitmap_parselist().
> 
> > And that is another feature that seems to be missing from parselist,
> > all/except.
> 
> We already support groups in a range. I think it partially covers the
> proposed all/except.
> 
> Can you share examples on what you miss?

The obvious one is the "all/Core0" example above, which would be
equivalent to "Core1-CoreN".

Another case that I don't think we can do today is something like, give
me SMT0 of each core.

I don't really see the use of the ranges thing, CPU enumeration just
isn't sane like that. Also, I should really add that randomization pass
to the CPU enumeration :-)

