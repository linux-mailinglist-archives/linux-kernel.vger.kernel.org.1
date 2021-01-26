Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC970304F87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhA0DOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395549AbhAZTeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:34:46 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 11:34:05 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4U5x-006N5F-Hr; Tue, 26 Jan 2021 19:33:45 +0000
Date:   Tue, 26 Jan 2021 19:33:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] teach sendfile(2) to handle send-to-pipe directly
Message-ID: <20210126193345.GK740243@zeniv-ca>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
 <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de>
 <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
 <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
 <20210118194545.GB736435@zeniv-ca>
 <CAHk-=wgrkX4KM-kbEzs+Bap4v13RQ-ymwwAxgwjhTz6VVtp8Cw@mail.gmail.com>
 <20210126060720.GJ740243@zeniv-ca>
 <20210126060932.GC1461355@zeniv-ca.linux.org.uk>
 <CAHk-=wiWRjNwmyBXcLWSiHiLgG5jNxeFskSgTzdj=r9yn3Nbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWRjNwmyBXcLWSiHiLgG5jNxeFskSgTzdj=r9yn3Nbig@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:57:38AM -0800, Linus Torvalds wrote:
> On Mon, Jan 25, 2021 at 10:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > no point going through the intermediate pipe
> 
> Ok, this series looks fine to me.
> 
> Al - do you want me to apply this as patches for 5.11 (and I'll revert
> the then unnecessary one-liner), or should I expect a pull request or
> what?

I'm going to put it into #for-next for a few days, then send a pull request
your way (assuming no problems show up, obviously).
