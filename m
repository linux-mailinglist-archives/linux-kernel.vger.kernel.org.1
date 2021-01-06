Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838EA2EC04A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbhAFPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbhAFPU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:20:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109BC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 07:20:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so2792607wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=u9BfJw9bwODVGWCy/LjRuDollmtVrULB9sLGdsTMFog=;
        b=iSKYKqg3EPV9zohrHs4gWOkHtNCORtYsqfgfDl5RhqX/1KKvbLxhUa4ZdE4RfD0s0L
         A9HXrWQI6CgTBpGzMsV86U3ZM8Y++2zDRI0oUO1C+1OxixGQGryf8xjndjwK8dmRai15
         9LPjyH3wdpiXGWCg959H5TZ85pV/nhyigUgExw/UhLSc7AgWJ1g/3yCht7Bh+D3ZzIr0
         ClW3+EJ6XQwb55bEIEgNjTLXV8ySl0vKkUIjnokEtiFrORX6jOlQFzhgbV+N3u6hDdxV
         OvVpGMdLww8P5heIjJqoP+m30hOEOfdGQD8ObIgR2rdjvuKmIay6k7Le5JAfKh9aJpt3
         942g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=u9BfJw9bwODVGWCy/LjRuDollmtVrULB9sLGdsTMFog=;
        b=j+iEIwEg4R9Nl28NuEt0K3mSMHcxb+WqnECJD0nMwwr7uK9gAzY2KEszH0Gcaxd+2o
         hbUq2ZlW4qL/3XqNK25t4/cjbdshGuVablF2wiZeWjXZ4cMVc7b5rpnA75UA9zC9xSaq
         2SzhFov6bQMKvxEqwFcfPlvEO1Xd3PXGaNo5H3WUPy6QLbQsDdgwhy3WVLggMOlJSesk
         NVs/MGomb9EbOqFbKDgDxBhoamaImMOACxm3Blo+gGRv/OkMGXO3K5tx+iymFiGPufTM
         3WyLjBuXq4fKYJtw/0kPZ1M+vhXdkp3Rd+EhHR655xgbE7HKTf+fbLhcpLym5tqD+34p
         YTSw==
X-Gm-Message-State: AOAM532C98itDJMOi70Miklk71M60EkPJylx/W5FidYQ5LioxnlqHR6P
        XEWg48kUL6ys0HuoMNxgKAOP2XAZv7Q=
X-Google-Smtp-Source: ABdhPJx0D91P/ffwLygXmqp38D4DN2Dtv5gYGoKn7qC6szDZYAwuPY6qLtPHWN6jM0R7EBvCnJbO1g==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr4609164wrt.136.1609946416649;
        Wed, 06 Jan 2021 07:20:16 -0800 (PST)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id 138sm3673962wma.41.2021.01.06.07.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 07:20:16 -0800 (PST)
To:     linux-mm@kvack.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Subject: Very slow unlockall()
Message-ID: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
Date:   Wed, 6 Jan 2021 16:20:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
and someone tried to use it with hardened memory allocator library.

Execution time was increased to extreme (minutes) and as we found, the problem
is in munlockall().

Here is a plain reproducer for the core without any external code - it takes
unlocking on Fedora rawhide kernel more than 30 seconds!
I can reproduce it on 5.10 kernels and Linus' git.

The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
The real code of course does something more useful but the problem is the same.

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>

int main (int argc, char *argv[])
{
        void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

        if (p == MAP_FAILED) return 1;

        if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
        printf("locked\n");

        if (munlockall()) return 1;
        printf("unlocked\n");

        return 0;
}

In traceback I see that time is spent in munlock_vma_pages_range.

[ 2962.006813] Call Trace:
[ 2962.006814]  ? munlock_vma_pages_range+0xe7/0x4b0
[ 2962.006814]  ? vma_merge+0xf3/0x3c0
[ 2962.006815]  ? mlock_fixup+0x111/0x190
[ 2962.006815]  ? apply_mlockall_flags+0xa7/0x110
[ 2962.006816]  ? __do_sys_munlockall+0x2e/0x60
[ 2962.006816]  ? do_syscall_64+0x33/0x40
...

Or with perf, I see

# Overhead  Command  Shared Object      Symbol                               
# ........  .......  .................  .....................................
#
    48.18%  lock     [kernel.kallsyms]  [k] lock_is_held_type
    11.67%  lock     [kernel.kallsyms]  [k] ___might_sleep
    10.65%  lock     [kernel.kallsyms]  [k] follow_page_mask
     9.17%  lock     [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
     6.73%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
...


Could please anyone check what's wrong here with the memory locking code?
Running it on my notebook I can effectively DoS the system :)

Original report is https://gitlab.com/cryptsetup/cryptsetup/-/issues/617
but this is apparently a kernel issue, just amplified by usage of munlockall().

Thanks,
Milan
