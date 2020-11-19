Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5302B9593
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgKSO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:57:43 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62550 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgKSO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:57:42 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0AJEvefs079100;
        Thu, 19 Nov 2020 23:57:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Thu, 19 Nov 2020 23:57:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0AJEve44079096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Nov 2020 23:57:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
 <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
 <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
 <20201118142357.GW3121392@hirez.programming.kicks-ass.net>
 <1778f2e5-0a0c-2c6e-2c83-fe51d938e8a2@i-love.sakura.ne.jp>
 <20201118151038.GX3121392@hirez.programming.kicks-ass.net>
 <9bc4e07d-2a58-077b-b4c7-ab056ba33cf1@i-love.sakura.ne.jp>
 <CACT4Y+ZJNkssAQLuwfcKPTTKLZhHRAo0POGOMVsGFGizoHaNMg@mail.gmail.com>
 <CACT4Y+Zh10241gchu6e_=LwxPSEzXT-0HSmhnTtkXFZevKi_yQ@mail.gmail.com>
 <CACT4Y+a8TjV+Pe6mwne777RV+xB+aHT6GxuMLAVBn5mtK4P0Lw@mail.gmail.com>
 <CACT4Y+ZSsKjvojD8iFVFv9F5X5BvZR8vLyaKrgxUxyknma04Sg@mail.gmail.com>
 <5e8342c4-702f-80a9-e669-8a7386ce0da1@i-love.sakura.ne.jp>
 <CACT4Y+a4X4MNkWsvRySokKE=gO8AH1kegtUQk9T0M37EfWtN-w@mail.gmail.com>
 <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <7ff5e5db-4fbd-00ff-d264-cf80e52bb1b6@i-love.sakura.ne.jp>
Date:   Thu, 19 Nov 2020 23:57:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aNJmuhk0KicX4FzKW6PhawFBgvrC2gSJcWwUkR8VSSmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/19 23:30, Dmitry Vyukov wrote:
> p.s. it's indeed huge, full log was 11MB, this probably won't be
> chewed by syzbot.

Is "cat /proc/lockdep*" output written from userspace?
Then, we could try "xz -9" + "base64" for recording.

> Peter, are these [hex numbers] needed? Could we strip them during
> post-processing? At first sight they look like derivatives of the
> name.

kernel/locking/lockdep.c uses %px (raw address) whereas
kernel/locking/lockdep_proc.c uses %p (__ptr_to_hashval() value).
I think saving these [hashed hex numbers] is unlikely useful.
At least for this testing, we can strip leading 00000000 part.
