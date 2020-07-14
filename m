Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929D921FDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgGNTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgGNTsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:48:11 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EA722B51;
        Tue, 14 Jul 2020 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594756091;
        bh=J+234yXnA6j89pE+F8uW9diFc8PSR+Bl4nU7j/ItEUI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DL42HUeMiKm0aVeXdFdBsJbBbQBteBQNgpFb0Kz/Z5agrJEAt8nVy5p8m/gb+j5Iv
         MbMerZXqO4EY76kcIE3GctunwSJnqVfPwaPSRvxSERciHEnwXXJpuhScw5kDfIq1k6
         U7/PkqVNvHMD8sTDa/sgSZREn2VbnSuKgjn65TW0=
Message-ID: <0faffeb615b74212f65b813ffde0b096fa7451be.camel@kernel.org>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Tue, 14 Jul 2020 14:48:09 -0500
In-Reply-To: <20200714154352.04794760@oasis.local.home>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
         <20200714183512.GA18816@duo.ucw.cz>
         <20200714154352.04794760@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 2020-07-14 at 15:43 -0400, Steven Rostedt wrote:
> On Tue, 14 Jul 2020 20:35:12 +0200
> Pavel Machek <pavel@denx.de> wrote:
> 
> > Hi!
> > 
> > > 
> > > I'm pleased to announce the 4.19.132-rt59 stable release.
> > > 
> > > This release is just an update to the new stable 4.19.132
> > > version and no RT specific changes have been made.
> > > 
> > > You can get this release via the git tree at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-
> > > rt.git
> > > 
> > >   branch: v4.19-rt
> > >   Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe
> > > 
> > > Or to build 4.19.132-rt59 directly, the following patches should
> > > be
> > > applied:  
> > 
> > Thanks a lot.
> > 
> > But now I am confused, I completely missed announcements for
> > v4.19.127-rt55 to v4.19.131-rt58.
> > 
> > And for example -rt56 is not listed in
> > 
> > 
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/older/sha256sums.asc
> > 
> > ...aha, and the versions do not have signed tags, either:
> > 
> > pavel@amd:~/cip/k$ git show v4.19.131-rt58
> > fatal: ambiguous argument 'v4.19.131-rt58': unknown revision or
> > path not in the working tree.
> > 
> > Is that because they were created just as quick steps towards
> > -rt59?
> > 
> 
> Ah, I was about to say this is something that Kate keeps reminding me
> to add to the wiki, but looking, I already did!
> 
> https://wiki.linuxfoundation.org/realtime/documentation/start
> 
> "Tagging policy of the PREEMPT_RT stable releases. Each PREEMPT_RT
> stable release is tagged with the version number of the upstream
> Linux
> stable kernel as well as its own “-rt” counter that is appended. The
> -rt counter will increment for the following:
> 
>  - When forward ported to the latest upstream Linux stable version.
>  - When any merge with a upstream Linux stable causes a conflict.
>  - When a backport of the PREEMPT_RT development branch is done.
> 
> A backport will not be done with a forward port of a stable version.
> They will be done separately, and tagged separately."
> 
> Tom, I sign all tags, we probably should be consistent with that too.
> 

Yeah, so do I, it's just that the srt script doesn't push the
intervening tags (but does push the release tags).

Tom

> -- Steve

