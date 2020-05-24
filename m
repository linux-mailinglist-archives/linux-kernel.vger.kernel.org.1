Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F861E02F3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 23:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgEXVMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 17:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbgEXVMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:12:23 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAE4E2076C;
        Sun, 24 May 2020 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590354743;
        bh=Flr026ZtzINe0Q7Gpmgcr+VZp7b/m6owt3uG5bFsaQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5EE6nGn1WgxJLQFbmLcD7DFe8/QvumGgHGpS+WC1MnwGJyRqfFE6hOLPxlS+K6oy
         Ae4BaEvjSh6Wk/IhmDstdeRQ+6L0fb2l4HwRqIC8pjtLi6KlRwsXj0/8ucNM9HrHDb
         dT5Af3/4Gz/PVwPWKizy/8TlGcYO7WTIoF9zWZm8=
Date:   Sun, 24 May 2020 17:12:21 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200524211221.GW33628@sasha-vm>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
 <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
 <20200524194550.GV33628@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524194550.GV33628@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:45:50PM -0400, Sasha Levin wrote:
>On Sun, May 24, 2020 at 10:05:28AM -0700, Linus Torvalds wrote:
>>Sasha mentioned "--follow", which also happens to show that commit,
>>but that's more of an incidental happenstance than anything else. "git
>>log --follow" is kind of a special case, where git stops doing some of
>>the pathname-based simplifying, because if the file shows up from
>>nothing, git will try to then figure out where it came from. The fact
>>that "--follow" this ends up not pruning irrelevant history as
>>aggressively is more of an implementation artifact than anything else.
>>
>>So generally, don't use "--follow". It's kind of a hack to emulate
>>"track changes to a file", but it is a hack, and it fundamentally is a
>>bogus operation (for all the same reasons that the CVS/SCCS/SVN/etc
>>notion of a "file identity" is complete garbage and leads to
>>fundamental problems).
>
>Interesting. My thinking around --follow was that it's like
>--full-history in the sense that it won't prune history, but it would
>also keep listing history beyond file renames.
>
>The --follow functionality is quite useful when looking at older
>branches and trying to understand where changes should go into on those
>older branches.
>
>We also do have some notion of "file identity" in the kernel; it's
>prevalent with "quirk files". Look at these for example:
>
> - drivers/mmc/core/quirks.h
> - sound/pci/hda/patch_*.c
> - drivers/hid/hid-quirks.c
>
>We know that patches to those files are likely to contain quirks (which
>we usually want to take into the Stable branches) so I might have a
>script that monitors a list of these "special" files in which case I
>need to see a complete list of commits that went into those files.

(and I'd like to see the reverts too, so that I could apply that revert
to Stable trees as well. If a revert doesn't show up in git log we might
miss doing a backport of it).

-- 
Thanks,
Sasha
