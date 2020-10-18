Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6801F291791
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgJRNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 09:03:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53657 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgJRNC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 09:02:59 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 09ID2Uma037582;
        Sun, 18 Oct 2020 22:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Sun, 18 Oct 2020 22:02:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 09ID2M1L037395
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 18 Oct 2020 22:02:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
Message-ID: <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
Date:   Sun, 18 Oct 2020 22:02:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, what do you think? Can we apply this patch?

A potential for-now workaround for syzkaller would be to allow syzkaller
not to encounter the BUG: message (by masking BUG: message on the kernel
side) when hitting these limits, for continue testing until the kernel
crashes (due to other bugs like UAF) would be to some degree useful.

On 2020/10/10 21:58, Tetsuo Handa wrote:
> Since syzkaller continues various test cases until the kernel crashes,
> syzkaller tends to examine more locking dependencies than normal systems.
> As a result, syzbot is reporting that the fuzz testing was terminated
> due to hitting upper limits lockdep can track [1] [2] [3].
> 
> Peter Zijlstra does not want to allow tuning these limits via kernel
> config options, for such change discourages thinking. But currently we
> are not actionable, for lockdep does not report the culprit for hitting
> these limits [4].
> 
> Therefore, I propose this patch again, with a caveat that this patch is
> expected to be reverted after lockdep becomes capable of reporting the
> culprit, for I consider that "postpone fixing lock related problems in
> existing code" is less painful than "not detecting lock related problems
> introduced by new patches".
> 
> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
> [4] https://lkml.kernel.org/r/CACT4Y+agTiEF-1i9LbAgp-q_02oYF0kAPZGAAJ==-wx2Xh7xzQ@mail.gmail.com
> 
> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  kernel/locking/lockdep.c           |  2 +-
>  kernel/locking/lockdep_internals.h |  8 +++---
>  lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
