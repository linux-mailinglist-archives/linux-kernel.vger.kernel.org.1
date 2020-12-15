Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BC2DAA97
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgLOKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgLOKE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:04:27 -0500
Date:   Tue, 15 Dec 2020 10:03:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] arm64 updates for 5.11
Message-ID: <20201215100342.GA2511@gaia>
References: <20201214182854.14862-1-catalin.marinas@arm.com>
 <CAHk-=wi2WOYHcrZ+8gnwa6PR14LxDe3PMfqsPYyyoRTysyheUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi2WOYHcrZ+8gnwa6PR14LxDe3PMfqsPYyyoRTysyheUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 04:29:37PM -0800, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 10:29 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> >  114 files changed, 2392 insertions(+), 1401 deletions(-)
> 
> My diffstat looked quite different, but that turns out to be because
> you use "-C" to generate your patches with not just renames, but file
> copies as well.

Ah, I have diff.renames=copies in my .gitconfig (I don't remember why I
added it; I'll change it to the default in case I forget the "--summary"
option next time).

> That's all fine, but can I ask you to also use "--summary" for your
> diffstat, so that the end oif the diffstat also ends up explaining
> that part (and you end up with a line that says
> 
>  copy arch/arm64/include/asm/{alternative.h => alternative-macros.h} (69%)
> 
> because as it was, it took me a while to realize why your diffstat
> numbers didn't match mine at all.

Thanks for the hint. I actually did a "git show --stat" on my local
merge commit. This doesn't seem to honour the "--summary" option (at
least the git version I have, 2.20.1). The "git diff --stat --summary"
works as expected.

-- 
Catalin
