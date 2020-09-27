Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151D227A170
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgI0O5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 10:57:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgI0O5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 10:57:50 -0400
Received: from zn.tnic (p200300ec2f2492004b5aa76b10805eb1.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:9200:4b5a:a76b:1080:5eb1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C64CD1EC026F;
        Sun, 27 Sep 2020 16:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601218669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CFJCCuderP9O1B05vn4MreLrTvlEZtAqEG1hDiK3BkQ=;
        b=oATQHPSujtIHRVWxdZiQhDxsoFA3P4hCxNLkK+cG7BabD/AwJj+wMc8PLGXrVec6v62sdl
        B3ajOQCpcyMEawY0Is2vxXBSQIMQicoyLtqLtieX6ALd6tWi1Du4+EY2nTmvAap2ZU73Xg
        F5uDQVMRz4arjOzvYZS1q9ZU65qFcq8=
Date:   Sun, 27 Sep 2020 16:57:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200927145737.GA4746@zn.tnic>
References: <00000000000052569205afa67426@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000052569205afa67426@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 01:32:14AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92ab97ad Merge tag 'sh-for-5.9-part2' of git://git.libc.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1069669b900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62
> dashboard link: https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

All below is AFAICT:

This compiler you're using is not some official release but some random
commit before the v10 release:

$ git show c2443155a0fb245c8f17f2c1c72b6ea391e86e81
Author: Hans Wennborg <hans@chromium.org>
Date:   Sat Nov 30 14:20:11 2019 +0100

    Revert 651f07908a1 "[AArch64] Don't combine callee-save and local stack adjustment when optimizing for size"
...

$ git describe c2443155a0fb245c8f17f2c1c72b6ea391e86e81
llvmorg-10-init-10900-gc2443155a0fb

The v10 release is:

$ git show llvmorg-10.0.0
tag llvmorg-10.0.0
Tagger: Hans Wennborg <hans@chromium.org>
Date:   Tue Mar 24 12:58:58 2020 +0100

Tag 10.0.0

and v10 has reached v10.0.1 in the meantime:

$ git log --oneline c2443155a0fb245c8f17f2c1c72b6ea391e86e81~1..llvmorg-10.0.1 | wc -l
7051

so can you please update your compiler and see if you can still
reproduce with 10.0.1 so that we don't waste time chasing a bug which
has been likely already fixed in one of those >7K commits.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
