Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9609821FD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgGNTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgGNTbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:31:43 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0598122AB9;
        Tue, 14 Jul 2020 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594755102;
        bh=8KHF2h/g6QZX6HAOpadCNV8iYbCZQg/UJbT2TwRfoDA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RLMI3IT5XftXXkKdJdfZsBqaY7vC7WmySxrU00Iq19joSNpzUzYKyJ5+HiRNXmn4c
         u6BLKnNZHXJ0zOf4bzdB62cA9aOppH4ZRIA0Nvmj4saPt7OWS39IHBXfdGDcTwExaA
         cE1tifWjTvatN0qcRSK0DHnMEXO5WTQfaKQ4jfuU=
Message-ID: <a9444792fd48b67493902b50a66a287fda0fb2c6.camel@kernel.org>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
From:   Tom Zanussi <zanussi@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>
Date:   Tue, 14 Jul 2020 14:31:41 -0500
In-Reply-To: <20200714183512.GA18816@duo.ucw.cz>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
         <20200714183512.GA18816@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, 2020-07-14 at 20:35 +0200, Pavel Machek wrote:
> Hi!
> 
> > 
> > I'm pleased to announce the 4.19.132-rt59 stable release.
> > 
> > This release is just an update to the new stable 4.19.132
> > version and no RT specific changes have been made.
> > 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-
> > rt.git
> > 
> >   branch: v4.19-rt
> >   Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe
> > 
> > Or to build 4.19.132-rt59 directly, the following patches should be
> > applied:
> 
> Thanks a lot.
> 
> But now I am confused, I completely missed announcements for
> v4.19.127-rt55 to v4.19.131-rt58.
> 
> And for example -rt56 is not listed in
> 
> 
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/older/sha256sums.asc
> 

Right, this is because we up the rt version every time we merge a
stable version and have conflicts, and in this release there were a
lot, so it jumped from -rt55 to -rt59.  We only announce the releases
and not the intervening version bumps, which is why you couldn't find
any announcements for them. 

There are more details about exactly how the version numbers change
here:

  https://wiki.linuxfoundation.org/realtime/documentation/start

> ...aha, and the versions do not have signed tags, either:
> 
> pavel@amd:~/cip/k$ git show v4.19.131-rt58
> fatal: ambiguous argument 'v4.19.131-rt58': unknown revision or path
> not in the working tree.
> 

Yeah, thanks for pointing that out.  Looks like my script doesn't push
the intervening tags correctly, but I've pushed them out now.

> Is that because they were created just as quick steps towards -rt59?
> 

Yeah, pretty much.

Thanks,

Tom

> Best regards,
> 							Pavel

