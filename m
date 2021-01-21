Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4A2FF540
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAUT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbhAUTzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:55:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7754323A56;
        Thu, 21 Jan 2021 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258872;
        bh=EP1snMm+Xlof0Ui6e/5e3S7pxlCggQLH3+hl2fl2Heg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sSD5NrYI7cevdO+TTyY4saO86jvRh37/iqfjVn7J5zBOSMMbjy6TCQ7yZmyEzbkrQ
         JkkBkZowH3eCo1A/DZ1GFykNWiiHPtq8lTwV/+vz1Wv4fYSCs0TiVrpm2KmBara/YT
         hHmliBoDrhKY/7rTNaG4i9sjI0wJXJ8j8A0vY9io5DvHxxhHwokkhKNbQqWM9XTOwP
         cnn2limdZzXzGOCGNrL2EH5kwD+FvtYNmw60LD/CMidcRqRhJKlD9w3Jiw1BKaEY6R
         eEZw4o4e739xIP8/R3dZf+0T25U3Ns5aX4kZfUXY4qBsKKE3EYXhQCAjpMwyzZvx96
         NqQVBW0Cs3PSg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1741D35214EB; Thu, 21 Jan 2021 11:54:32 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:54:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] tools/nolibc: fix build issues on aarch64 after
 unistd cleanup
Message-ID: <20210121195432.GS2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121072031.23777-1-w@1wt.eu>
 <20210121111117.GA48431@C02TD0UTHF1T.local>
 <20210121141809.GC24174@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121141809.GC24174@1wt.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:18:09PM +0100, Willy Tarreau wrote:
> On Thu, Jan 21, 2021 at 11:11:17AM +0000, Mark Rutland wrote:
> > So FWIW:
> > 
> > Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Thank you all!

> Perfect, thanks! Paul, may I let you copy-paste the tested-by yourself ?
> If you prefer I'm fine with resending a series to you, I just don't want
> to needlessly spam you :-)

Done, with Valentin's and Mark's Tested-by.

> > It would be great if this could be applied soon so that it's possible to
> > use the rcutorture scripts without applying local hacks.
> 
> Makes sense. I was wondering, should we mark them for stable ? I don't
> know if anyone relies on these tests to validate stable kernels in
> fact.

I added Fixes tags that should make this happen, and they are now visible
at -rcu branch "dev".  Could you please check them for me?

c261145 tools/nolibc: Add the definition for dup()
79f220e tools/nolibc: Make dup2() rely on dup3() when available
c0c7c10 tools/nolibc: Make getpgrp() fall back to getpgid(0)
be60ca4 tools/nolibc: Implement fork() based on clone()
5b1c827 tools/nolibc: Implement poll() based on ppoll()
70ca7ae tools/nolibc: Get timeval, timespec and timezone from linux/time.h
f65d711 tools/nolibc: Remove incorrect definitions of __ARCH_WANT_*
35635d7 tools/nolibc: Emit detailed error for missing alternate syscall number definitions
3c6ce7a tools/nolibc: Fix position of -lgcc in the documented example
26cec81 tools/rcutorture: Fix position of -lgcc in mkinitrd.sh

> > Willy, thanks for sorting this out, especially so quickly!
> 
> You're welcome, and thanks to you for the detailed report and explanations.

Again, thank you all!

On getting this upstream quickly, if all goes well I expect to include
this in my pull request for the upcoming merge window.

							Thanx, Paul
