Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B52EF40E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAHOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbhAHOjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:39:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BAC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 06:39:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r7so9225763wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XOO4wVb3Y58B3RJRLwkxGLbFOdHHzra+zEXjO8FjfrI=;
        b=Ql/1LeIpfqgWmTYmOAAt44Dlbt9O802bQuS0Bb3JZwlQpGSC1OjV36OX8tc+lPSB3j
         lPfzFVRdsFAiDAyJqC1ChfVFHCrCmDLIDrRHj5zVllmFGtA7K1NWneSNntRdOq2Hl6pa
         HRLSfiYvmKi8JMHjc3Se8A/DPE3l8QCJpvJmE22nU0Aec1BBQhGv6Z6r2AX4qqB1xPVc
         UgnXRX6M3EWLZ4js8tvil0phVcuA987AcgpD59GQmEDwgDTov6x8kwvD4KlQ40tTIIuc
         lBBwGKjWuBcdm4Qpg8pERsP4JT9cMyDMMfK8PoiKgnEOSYPUoSy/nixyvr838KtWD8ZH
         iPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOO4wVb3Y58B3RJRLwkxGLbFOdHHzra+zEXjO8FjfrI=;
        b=ihWlaHo8eeSIQdfeDrKukNMTm6rlgwVp3rS22R4fxLo+cFAmmd7v54SJJOSrW8t6C8
         +0DL49w8LbCvl/kIP0z9VVEGMqO7a74nMR3aJ+WGnFCI778FkkPqeSh8alkTEzcY2SoL
         u64w3uPTKmEbrptpDyMk6d3+BGy6mMWLR1Jo3vLmErrninw07VxCC+U4GtAzq5qRr+IW
         YJKGxOWQdhEGBHPgoaW8M6bHtSJvCeCtRlK3RA8hgnRtGOcn2k7IfP5E+igNNSIsCoaH
         D49YAHBEus/D/aHGR2Xp+VfvgW5oe5KUszXRzMyDbNV9yEYptf9gq8Nb78rPPPrWFO8V
         k6KQ==
X-Gm-Message-State: AOAM533pwMd3p4b1nzyct+V2z78l1HbA0akxoEPcMD6FWwUDj6cNCqXk
        7XatQ3O9iA47hiO8A4GJiCc=
X-Google-Smtp-Source: ABdhPJweKZ8Sy6xZY9JR/1EpSH6+u+nm+aIQbkTWEFv1MpDKYPLlXOcF7f/eHIye7n7DKDTEZMl6pQ==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr3958014wrn.333.1610116746557;
        Fri, 08 Jan 2021 06:39:06 -0800 (PST)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id y2sm11930811wma.6.2021.01.08.06.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 06:39:05 -0800 (PST)
Subject: Re: Very slow unlockall()
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <70885d37-62b7-748b-29df-9e94f3291736@gmail.com>
 <20210108134140.GA9883@dhcp22.suse.cz>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <abb752ce-4447-74cb-dfbc-03af1b38edfc@gmail.com>
Date:   Fri, 8 Jan 2021 15:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108134140.GA9883@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2021 14:41, Michal Hocko wrote:
> On Wed 06-01-21 16:20:15, Milan Broz wrote:
>> Hi,
>>
>> we use mlockall(MCL_CURRENT | MCL_FUTURE) / munlockall() in cryptsetup code
>> and someone tried to use it with hardened memory allocator library.
>>
>> Execution time was increased to extreme (minutes) and as we found, the problem
>> is in munlockall().
>>
>> Here is a plain reproducer for the core without any external code - it takes
>> unlocking on Fedora rawhide kernel more than 30 seconds!
>> I can reproduce it on 5.10 kernels and Linus' git.
>>
>> The reproducer below tries to mmap large amount memory with PROT_NONE (later never used).
>> The real code of course does something more useful but the problem is the same.
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <fcntl.h>
>> #include <sys/mman.h>
>>
>> int main (int argc, char *argv[])
>> {
>>         void *p  = mmap(NULL, 1UL << 41, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>
>>         if (p == MAP_FAILED) return 1;
>>
>>         if (mlockall(MCL_CURRENT | MCL_FUTURE)) return 1;
>>         printf("locked\n");
>>
>>         if (munlockall()) return 1;
>>         printf("unlocked\n");
>>
>>         return 0;
>> }
>>
>> In traceback I see that time is spent in munlock_vma_pages_range.
>>
>> [ 2962.006813] Call Trace:
>> [ 2962.006814]  ? munlock_vma_pages_range+0xe7/0x4b0
>> [ 2962.006814]  ? vma_merge+0xf3/0x3c0
>> [ 2962.006815]  ? mlock_fixup+0x111/0x190
>> [ 2962.006815]  ? apply_mlockall_flags+0xa7/0x110
>> [ 2962.006816]  ? __do_sys_munlockall+0x2e/0x60
>> [ 2962.006816]  ? do_syscall_64+0x33/0x40
>> ...
>>
>> Or with perf, I see
>>
>> # Overhead  Command  Shared Object      Symbol                               
>> # ........  .......  .................  .....................................
>> #
>>     48.18%  lock     [kernel.kallsyms]  [k] lock_is_held_type
>>     11.67%  lock     [kernel.kallsyms]  [k] ___might_sleep
>>     10.65%  lock     [kernel.kallsyms]  [k] follow_page_mask
>>      9.17%  lock     [kernel.kallsyms]  [k] debug_lockdep_rcu_enabled
>>      6.73%  lock     [kernel.kallsyms]  [k] munlock_vma_pages_range
>> ...
>>
>>
>> Could please anyone check what's wrong here with the memory locking code?
>> Running it on my notebook I can effectively DoS the system :)
>>
>> Original report is https://gitlab.com/cryptsetup/cryptsetup/-/issues/617
>> but this is apparently a kernel issue, just amplified by usage of munlockall().
> 
> Which kernel version do you see this with? Have older releases worked
> better?

Hi,

I tried 5.10 stable and randomly few kernels I have built on testing VM (5.3 was the oldest),
it seems to be very similar run time, so the problem is apparently old...(I can test some specific kernel version if it make any sense).

For mainline (reproducer above):

With 5.11.0-0.rc2.20210106git36bbbd0e234d.117.fc34.x86_64 (latest Fedora rawhide kernel build - many debug options are on)

# time ./lock 
locked
unlocked

real    0m32.287s
user    0m0.001s
sys     0m32.126s


Today's Linus git - 5.11.0-rc2+ in my testing x86_64 VM (no extensive kernel debug options):

# time ./lock
locked
unlocked

real    0m4.172s
user    0m0.000s
sys     0m4.172s

m.
