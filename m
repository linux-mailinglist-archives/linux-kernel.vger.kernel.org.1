Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE251FCF05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFQOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 10:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgFQOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:01:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C031220776;
        Wed, 17 Jun 2020 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592402491;
        bh=hUnhfUy8ysZi64MArixITUGcfaJ7UN86JMKaLY6gF8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBjmziXM0RwF2Wh2pT1HiesB3wYDz+I+AmA15dofUucLUfWp0L5baq6hsyufDvDlf
         wSye0eINt1vlm1AJjwZsiogcpo5wnrCWidFhYpkl4v6jljvwjAUOO1932SYSh8H4ck
         idVZC7pEb9tONm4p2szkvINVGNCEJK1I6D47A7iM=
Date:   Wed, 17 Jun 2020 16:01:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jim.cromie@gmail.com
Cc:     Petr Mladek <pmladek@suse.com>, Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and
 file=bar
Message-ID: <20200617140123.GA2588750@kroah.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-20-jim.cromie@gmail.com>
 <20200616115727.GN31238@alley>
 <CAJfuBxwmMNzt6ffQkYX7vU1qRa12=mCbO9T4SMzF7RXV5UwkYQ@mail.gmail.com>
 <20200617121156.GV31238@alley>
 <CAJfuBxwip11Ps_0HYTDqOTNsjixFFP_yTPMV3ca8f7vak9AWqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwip11Ps_0HYTDqOTNsjixFFP_yTPMV3ca8f7vak9AWqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 07:32:44AM -0600, jim.cromie@gmail.com wrote:
> hi Petr
> 
> > You made to do some research and I was wrong. For example, getopt()
> > operates with options and their arguments. So, 'keyword' and 'arg' names
> > look good after all.
> >
> > Well, I still think that only one syntax should be supported. And it
> > is better to distinguish keywords and arguments, so I prefer keyword=arg.
> >
> 
> hehe, Im gonna cite some RFC wisdom to convince you  ;-)
> 
>      Be strict in what you emit, and permissive in what you accept.
> 
> I see no potential for real ambiguity that would override that bias.

No, the kernel should be strict in what it accepts, otherwise it is a
huge maintance burden for no good reason at all.

Only one syntax is a wise idea, stick with that please.

thanks,

greg k-h
