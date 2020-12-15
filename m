Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCD2DAA23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgLOJeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:34:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgLOJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:34:07 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kp6hx-0000qh-1U; Tue, 15 Dec 2020 09:33:25 +0000
Date:   Tue, 15 Dec 2020 10:33:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Some fixes for v5.11
Message-ID: <20201215093324.ep7uawi6zlf7etqh@wittgenstein>
References: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
 <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
 <20201215153751.5150e00a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215153751.5150e00a@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 03:37:51PM +1100, Stephen Rothwell wrote:
> Hi Linus,
> 
> On Mon, 14 Dec 2020 16:45:50 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Dec 14, 2020 at 5:27 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > /* Conflicts */
> > > At the time of creating this PR no merge conflicts were reported from
> > > linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
> > > pulling the tag.  
> > 
> > Really? It conflicted with your own time namespace fixes.. Was one or
> > the other not in linux-next?
> > 
> > Not that the conflicts were big or bad (free_time_ns() prototype
> > changed right next to timens_on_fork() prototype), I'm just surprised
> > you saw no conflicts..
> 
> The time namespace changes appear in linux-next for the first time
> today - where I reported that 3 of them have no Signed-off-by from their
> committer :-(.

This was my bad. I'm adding a script to verify that all commits are
signed-off by me when I commit them.

Christian
