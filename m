Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597791A76E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437348AbgDNJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 05:02:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437340AbgDNJCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:02:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D7F21FB;
        Tue, 14 Apr 2020 02:02:06 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9703F6C4;
        Tue, 14 Apr 2020 02:02:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200225073731.465270-1-avagin@gmail.com>
 <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
 <CANaxB-xUYOrVnfLPRYVBiASzCH89sZkD6vTdy8EFjT16ZJhLfg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1d9c4c56-af16-e54f-08ca-76c6570b2d53@arm.com>
Date:   Tue, 14 Apr 2020 10:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CANaxB-xUYOrVnfLPRYVBiASzCH89sZkD6vTdy8EFjT16ZJhLfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 4/11/20 8:33 AM, Andrei Vagin wrote:
> On Thu, Apr 9, 2020 at 6:23 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Andrei,
>>
[...]

>> Sorry for the delay, I completed this morning the review of your patches and I
>> do not have anymore comments on them. Thank you for making the effort and
>> bringing the time namespace support to arm64.
> 
> Thank you for the review of these patches.
> 
>>
>> I have though a question on something I encountered during the testing of the
>> patches: I noticed that all the tests related to CLOCK_BOOTTIME_ALARM fail on
>> arm64 (please find the results below the scissors). Is this expected?
> 
> static int alarm_clock_get_timespec(clockid_t which_clock, struct
> timespec64 *tp)
> {
>         struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
> 
>         if (!alarmtimer_get_rtcdev())
>                 return -EINVAL;
> 
> It is probably that you get EINVAL from here ^^^. I will send a
> separate patch to handle this case in tests properly.
>

This makes sense :) Please let me know when you post the fix so I can test it again.

Are you planning as well to rebase this set?

> Thanks,
> Andrei
> 

-- 
Regards,
Vincenzo
