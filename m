Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C71AAE73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416160AbgDOQfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:35:10 -0400
Received: from foss.arm.com ([217.140.110.172]:49794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416090AbgDOQfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:35:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725901FB;
        Wed, 15 Apr 2020 09:35:03 -0700 (PDT)
Received: from [10.37.9.9] (unknown [10.37.9.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430EC3F6C4;
        Wed, 15 Apr 2020 09:35:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
 <CANaxB-xUYOrVnfLPRYVBiASzCH89sZkD6vTdy8EFjT16ZJhLfg@mail.gmail.com>
 <1d9c4c56-af16-e54f-08ca-76c6570b2d53@arm.com>
 <CANaxB-w+_4BUOYb-5+w1xBPoZGOzBh-LYOFCY-WSysgbAAcn_w@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5f60bff9-0fe1-7f1f-2dcc-2a7363801897@arm.com>
Date:   Wed, 15 Apr 2020 17:35:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANaxB-w+_4BUOYb-5+w1xBPoZGOzBh-LYOFCY-WSysgbAAcn_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 4/15/20 5:14 PM, Andrei Vagin wrote:
> On Tue, Apr 14, 2020 at 2:02 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Andrei,
>>
>> On 4/11/20 8:33 AM, Andrei Vagin wrote:
>>> On Thu, Apr 9, 2020 at 6:23 AM Vincenzo Frascino
>>> <vincenzo.frascino@arm.com> wrote:
>>>>
>>>> I have though a question on something I encountered during the testing of the
>>>> patches: I noticed that all the tests related to CLOCK_BOOTTIME_ALARM fail on
>>>> arm64 (please find the results below the scissors). Is this expected?
>>>
>>> static int alarm_clock_get_timespec(clockid_t which_clock, struct
>>> timespec64 *tp)
>>> {
>>>         struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
>>>
>>>         if (!alarmtimer_get_rtcdev())
>>>                 return -EINVAL;
>>>
>>> It is probably that you get EINVAL from here ^^^. I will send a
>>> separate patch to handle this case in tests properly.
>>>
>>
>> This makes sense :) Please let me know when you post the fix so I can test it again.
> 
> I have sent this fix: https://lkml.org/lkml/2020/4/15/72
>

That's good, I will try it by the end of this week or beginning of next and let
you know the results.

>>
>> Are you planning as well to rebase this set?>
> What is the right tree to rebase on?
> 

I guess master, I was asking because it would make easier my testing :)

> Thanks,
> Andrei
> 

-- 
Regards,
Vincenzo
