Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896352B1A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKMMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:03:41 -0500
Received: from foss.arm.com ([217.140.110.172]:36778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgKMLoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:44:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0C6914BF;
        Fri, 13 Nov 2020 03:44:33 -0800 (PST)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D532F3F6CF;
        Fri, 13 Nov 2020 03:44:30 -0800 (PST)
Subject: Re: [PATCH v9 44/44] kselftest/arm64: Check GCR_EL1 after context
 switch
To:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1605046192.git.andreyknvl@google.com>
 <bd6825832c0cb376fc68ad61ffec6d829401ed0e.1605046192.git.andreyknvl@google.com>
 <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a83f3883-cef8-ec88-0411-d9638dd4b4ae@arm.com>
Date:   Fri, 13 Nov 2020 11:47:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=XpB5ZQagAm6bqR1z+6hWdmk_shH0x8ShAx0qpmjMsp5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

thank you for the review.

On 11/12/20 3:59 PM, Alexander Potapenko wrote:
> On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> This test is specific to MTE and verifies that the GCR_EL1 register
>> is context switched correctly.
>>
>> It spawn 1024 processes and each process spawns 5 threads. Each thread
> 
> Nit: "spawns"
> 

I will fix it in the next iteration.

> 
>> +       srand(time(NULL) ^ (pid << 16) ^ (tid << 16));
>> +
>> +       prctl_tag_mask = rand() % 0xffff;
> 
> Nit: if you want values between 0 and 0xffff you probably want to use
> bitwise AND.
> 

The main goal here is to have a good probability of having a different setting
to the GCR_EL1 register. Hence the difference in between 0xffff and 0xffff-1 is
negligible. Anyway I agree that we should aim to cover all the possible
combinations.

> 
>> +
>> +int execute_test(pid_t pid)
>> +{
>> +       pthread_t thread_id[MAX_THREADS];
>> +       int thread_data[MAX_THREADS];
>> +
>> +       for (int i = 0; i < MAX_THREADS; i++)
>> +               pthread_create(&thread_id[i], NULL,
>> +                              execute_thread, (void *)&pid);
> 
> It might be simpler to call getpid() in execute_thread() instead.
> 

Yes it might, but I would like to avoid another syscall if I can.

>> +int mte_gcr_fork_test()
>> +{
>> +       pid_t pid[NUM_ITERATIONS];
>> +       int results[NUM_ITERATIONS];
>> +       pid_t cpid;
>> +       int res;
>> +
>> +       for (int i = 0; i < NUM_ITERATIONS; i++) {
>> +               pid[i] = fork();
>> +
>> +               if (pid[i] == 0) {
> 
> pid[i] isn't used anywhere else. Did you want to keep the pids to
> ensure that all children finished the work?
> If not, we can probably go with a scalar here.
> 

Yes, I agree, I had some debug code making use of it, but I removed it in the end.

> 
>> +       for (int i = 0; i < NUM_ITERATIONS; i++) {
>> +               wait(&res);
>> +
>> +               if(WIFEXITED(res))
>> +                       results[i] = WEXITSTATUS(res);
>> +               else
>> +                       --i;
> 
> Won't we get stuck in this loop if fork() returns -1 for one of the processes?
> 

Yes I agree, I forgot to check a condition. We should abort the test in such a
case returning KSFT_FAIL directly.

>> +       }
>> +
>> +       for (int i = 0; i < NUM_ITERATIONS; i++)
>> +               if (results[i] == KSFT_FAIL)
>> +                       return KSFT_FAIL;
>> +
>> +       return KSFT_PASS;
>> +}
>> +
> 
> 

-- 
Regards,
Vincenzo
