Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79830155A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbhAWNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 08:13:57 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52037 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAWNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 08:13:56 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10NDCq9j031838;
        Sat, 23 Jan 2021 22:12:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Sat, 23 Jan 2021 22:12:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10NDCql2031834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jan 2021 22:12:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>
References: <c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru>
 <CACT4Y+Z+kwPM=WUzJ-e359PWeLLqmF0w4Yxp1spzZ=+J0ekrag@mail.gmail.com>
 <6af41136-4344-73da-f821-e831674be473@i-love.sakura.ne.jp>
 <70d427e8-7281-0aae-c524-813d73eca2d7@ozlabs.ru>
 <CACT4Y+bqidtwh1HUFFoyyKyVy0jnwrzhVBgqmU+T9sN1yPMO=g@mail.gmail.com>
 <eb71cc37-afbd-5446-6305-8c7abcc6e91f@i-love.sakura.ne.jp>
 <6eaafbd8-1c10-75df-75ae-9afa0861f69b@i-love.sakura.ne.jp>
 <20210123060145.18356-1-hdanton@sina.com>
 <8b1fff6b-1acc-4582-0abe-86f948ac4b4a@ozlabs.ru>
 <0bfad7f4-550a-0645-d24b-940e399e9c2c@i-love.sakura.ne.jp>
 <dc1e9f3a-b40f-8db3-bce3-07c3c12af8ea@ozlabs.ru>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2f15f5ec-a3b0-1d64-0517-3e06da8f27bb@i-love.sakura.ne.jp>
Date:   Sat, 23 Jan 2021 22:12:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <dc1e9f3a-b40f-8db3-bce3-07c3c12af8ea@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/01/23 20:26, Alexey Kardashevskiy wrote:
> Should not the first 8192 from "grep lock-classes /proc/lockdep_stats" decrease
> after time (it does not), or once it has failed, it is permanent?

Since lockdep_unregister_key() becomes a no-op because graph_lock() returns 0
due to debug_locks being changed from 1 to 0 by __debug_locks_off() from
debug_locks_off() from debug_locks_off_graph_unlock(), lock-classes value in
/proc/lockdep_stats will not decrease after "BUG: MAX_LOCKDEP_KEYS too low!"
is printed.

