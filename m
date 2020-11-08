Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E436D2AAAC6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgKHMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 07:04:24 -0500
Received: from mailrelay4-2.pub.mailoutpod1-cph3.one.com ([46.30.212.3]:59702
        "EHLO mailrelay4-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbgKHMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 07:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=cK24sQlDTwMS0988AqreL/OWkybNBUC25kHUvCli+HA=;
        b=kams2iYmdueo/9rlztHCPnuUJfdIS1d/rrC/v0zF5KzH9h9TCEecofobzM998Y95gzuJhKYr0ee9C
         ehg4X/k7RSvfU73+Rkyo2B6YegYS7u/xh+iNeXTY+Z1QHMFgjXR7ri/IjfXQ9jySAfpuG2XSloRMHh
         cYlu4KLFyprQIEfzpUFpbGGKZZyc46OQBYfKWGBqFok22JjUxFNCz7D/5ksxvSBMDRgXQkbE06M/Xm
         +4kvHfAQa8FUdPAxUczsSLsnu7oEqL5/XfzRjdmXTQdregCkjRNap3HD0zfWJ5ZkzT4Alhswn8NBjh
         Iol9yVTDZHGhZaNUku6UL+oIccj5S4Q==
X-HalOne-Cookie: 893d880919a1bc3da693fb6cde4714added48034
X-HalOne-ID: 887ff14d-21ba-11eb-bb7e-d0431ea8bb10
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 887ff14d-21ba-11eb-bb7e-d0431ea8bb10;
        Sun, 08 Nov 2020 12:04:20 +0000 (UTC)
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Brad Campbell <brad@fnarfbargle.com>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
References: <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
 <20201108101429.GA28460@mars.bitmath.org>
 <bdabe861-8717-8948-80a0-ca2173c2e22a@fnarfbargle.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <af08ee3b-313d-700c-7e70-c57d20d3be5d@bitmath.org>
Date:   Sun, 8 Nov 2020 13:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bdabe861-8717-8948-80a0-ca2173c2e22a@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-08 12:57, Brad Campbell wrote:
> On 8/11/20 9:14 pm, Henrik Rydberg wrote:
>> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
>>> Hi Brad,
>>>
>>> On 2020-11-08 02:00, Brad Campbell wrote:
>>>> G'day Henrik,
>>>>
>>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
>>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
>>>> If you could test this on your Air1,1 it'd be appreciated.
>>>
>>> No, I managed to screw up the patch; you can see that I carefully added the
>>> same treatment for the read argument, being unsure if the BUSY state would
>>> remain during the AVAILABLE data phase. I can check that again, but
>>> unfortunately the patch in this email shows the same problem.
>>>
>>> I think it may be worthwhile to rethink the behavior of wait_status() here.
>>> If one machine shows no change after a certain status bit change, then
>>> perhaps the others share that behavior, and we are waiting in vain. Just
>>> imagine how many years of cpu that is, combined. ;-)
>>
>> Here is a modification along that line.
>>
>> Compared to your latest version, this one has wait_status() return the
>> actual status on success. Instead of waiting for BUSY, it waits for
>> the other status bits, and checks BUSY afterwards. So as not to wait
>> unneccesarily, the udelay() is placed together with the single
>> outb(). The return value of send_byte_data() is augmented with
>> -EAGAIN, which is then used in send_command() to create the resend
>> loop.
>>
>> I reach 41 reads per second on the MBA1,1 with this version, which is
>> getting close to the performance prior to the problems.
> 
> G'day Henrik,
> 
> I like this one. It's slower on my laptop (40 rps vs 50 on the MacbookPro11,1) and the same 17 rps on the iMac 12,2 but it's as reliable
> and if it works for both of yours then I think it's a winner. I can't really diagnose the iMac properly as I'm 2,800KM away and have
> nobody to reboot it if I kill it. 5.7.2 gives 20 rps, so 17 is ok for me.
> 
> Andreas, could I ask you to test this one?
> 
> Odd my original version worked on your Air3,1 and the other 3 machines without retry.
> I wonder how many commands require retries, how many retires are actually required, and what we are going wrong on the Air1,1 that requires
> one or more retries.
> 
> I just feels like a brute force approach because there's something we're missing.

I would think you are right. There should be a way to follow the status 
changes in realtime, so one can determine handshake and processing from 
that information. At least, with this change, we are making the blunt 
instrument a little smaller.

Cheers,
Henrik
