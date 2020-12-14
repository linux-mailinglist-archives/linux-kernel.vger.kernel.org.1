Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB232DA1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502905AbgLNUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:37:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35785 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503212AbgLNUg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:36:57 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BEKa8vk008684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 15:36:09 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4DB4B420136; Mon, 14 Dec 2020 15:36:08 -0500 (EST)
Date:   Mon, 14 Dec 2020 15:36:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
Message-ID: <20201214203608.GJ575698@mit.edu>
References: <20201210023638.GP52960@mit.edu>
 <00000000000024030c05b61412e6@google.com>
 <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
 <20201210182821.GS52960@mit.edu>
 <CACT4Y+bqDdidJpYimvzY5UkrXzw7JuefHndOM0+c6Y8e56vBjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bqDdidJpYimvzY5UkrXzw7JuefHndOM0+c6Y8e56vBjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Dropping off-topic lists)

On Mon, Dec 14, 2020 at 03:37:37PM +0100, Dmitry Vyukov wrote:
> > It's going to make everyone else's tags who pull from ext4.git messy,
> > though, with gobs of tags that probably won't be of use to them.  It
> > does avoid the need to use git fetch --tags --force, and I guess
> > people are used to the need to GC tags with the linux-repo.

(I had meant to say linux-next repo above.)

> syzbot is now prepared and won't fail next time, nor on other similar
> trees. Which is good.
> So it's really up to you.

I'm curious --- are you having to do anything special in terms of
deleting old tags to keep the size of the repo under control?  Git
will keep a tag around indefinitely, so if you have huge numbers of
next-YYYYMMDD tags in your repo, the size will grow without bound.
Are you doing anything to automatically garbage collect tags to preven
this from being a problem?

(I am not pulling linux-next every day; only when I need to debug a
bug reported against the -next tree, so I just manually delete the
tags as necessary.  So I'm curious what folks who are following
linux-next are doing, and whether they have something specific for
linux-next tags, or whether they have a more general solution.)

Cheers,

					- Ted
