Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC923D0F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgHETyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:54:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37584 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgHEQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:40 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k3LLj-0002l2-D3; Wed, 05 Aug 2020 15:29:03 +0000
Date:   Wed, 5 Aug 2020 17:29:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] fork cleanup for v5.9
Message-ID: <20200805152902.heabiv7zjvawi4j6@wittgenstein>
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
 <20200805083128.GA27209@infradead.org>
 <20200805151707.boubg3h4vetewxow@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805151707.boubg3h4vetewxow@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:17:08PM +0200, Christian Brauner wrote:
> On Wed, Aug 05, 2020 at 09:31:28AM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 04, 2020 at 01:28:01PM +0200, Christian Brauner wrote:
> > > High-level this does two main things:
> > > 1. Remove the double export of both do_fork() and _do_fork() where do_fork()
> > >    used the incosistent legacy clone calling convention. Now we only export
> > >    _do_fork() which is based on struct kernel_clone_args.
> > 
> > Can we retire the _do_fork name as well please?  For one we really don't
> > use single underscore prefix in the kernel, and we also try to avoid our
> > normal __ prefixes if there is no non-prefixed vesion.  Also the name
> > feels wrong, as this implements all of clone and not just fork.
> > What about kernel_clone to match the name of the args structure?
> 
> Yep, sounds good. I actually had a patch for that but it introduced a
> lot of jitter into the series because there's quite a few odd places
> where _do_fork() is used.

In other words: I'll send a patch soon.

Christian
