Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFA2FE246
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbhAUGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:06:54 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49239 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbhAUGGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:06:15 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L65MM9023443;
        Thu, 21 Jan 2021 07:05:22 +0100
Date:   Thu, 21 Jan 2021 07:05:22 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Splicing to/from a tty
Message-ID: <20210121060522.GA23430@1wt.eu>
References: <20210118195400.GC736435@zeniv-ca>
 <20210120162608.GB740243@zeniv-ca>
 <20210120191116.GC740243@zeniv-ca>
 <CAHk-=wjtTC_jNL+K1Ey_wY_KpTYZOR5XwhkZ+Eu7vviVi5itDQ@mail.gmail.com>
 <20210120231439.GE740243@zeniv-ca>
 <CAHk-=widQ+oLHbm=wSrewpLgXJg_FWCZV3BERmaEAx+ZCMfmZg@mail.gmail.com>
 <20210121003835.GF740243@zeniv-ca>
 <CAHk-=whWGwcZXpqDFv-j2fcChtT1jE0ZMFCmQHp3BrSkp+XZ6A@mail.gmail.com>
 <20210121014528.GG740243@zeniv-ca>
 <CAHk-=whqZbEPt2WC6WRWrMNPqaTsx99dp74vB6FQfM4aO6biQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqZbEPt2WC6WRWrMNPqaTsx99dp74vB6FQfM4aO6biQQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 07:38:38PM -0800, Linus Torvalds wrote:
> On Wed, Jan 20, 2021 at 5:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > splice() triggers an error for seekable destination with O_APPEND and
> > with NULL off_out.
> 
> Ok, that's just broken.
> 
> > Same for splice() to socket with
> >         fcntl(sock_fd, F_SETFL, O_APPEND);
> > done first.
> 
> Same.
> 
> As long as you don't pass a position pointer, I think both should just work.
> 
> Not that I imagine it matters for a lot of people..

I think that most users of splice() on sockets got used to falling back
to recv/send on splice failure due to various cases not being supported
historically (UNIX family sockets immediately come to my mind but I seem
to remember other combinations). Thus I guess that most users of splice()
detect that it doesn't work either due to lower than expected performance
or while running strace.

Willy
