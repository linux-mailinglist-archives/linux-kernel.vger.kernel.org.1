Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C201C2ABC04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgKINc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:32:59 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:47282 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgKINGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:06:54 -0500
Received: from srv.home ([10.8.0.1] ident=heh32137)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kc6s3-0002Mu-Q5; Mon, 09 Nov 2020 21:06:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=VMiyDlkWpAv2YnBIs82qS5WRSYusKaUZBc3FHs9wQbY=;
        b=fc+ED8hEoiMcUKgJ9xC5DrfiaLF2JgD/cZn+Vwvj7LxWekZ7a8shYkcVcbNk8OuQh//UJjXMQTyE9pcNaXXVUucq6XvmZulaCTOqaP+ifViRZ65s/eoiMO30pcl8GO6BBiQlPAGsQI2HfFknQ4g2zOgpqHURIt6lAmRnf+yWBd0=;
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-hwmon@vger.kernel.org,
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
 <af08ee3b-313d-700c-7e70-c57d20d3be5d@bitmath.org>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <d4e53a42-d86b-ce2b-7422-22b5ff5593e8@fnarfbargle.com>
Date:   Tue, 10 Nov 2020 00:06:04 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <af08ee3b-313d-700c-7e70-c57d20d3be5d@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 11:04 pm, Henrik Rydberg wrote:
> On 2020-11-08 12:57, Brad Campbell wrote:
>> On 8/11/20 9:14 pm, Henrik Rydberg wrote:
>>> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
>>>> Hi Brad,
>>>>
>>>> On 2020-11-08 02:00, Brad Campbell wrote:
>>>>> G'day Henrik,
>>>>>
>>>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
>>>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
>>>>> If you could test this on your Air1,1 it'd be appreciated.
>>>>
>>>> No, I managed to screw up the patch; you can see that I carefully added the
>>>> same treatment for the read argument, being unsure if the BUSY state would
>>>> remain during the AVAILABLE data phase. I can check that again, but
>>>> unfortunately the patch in this email shows the same problem.
>>>>
>>>> I think it may be worthwhile to rethink the behavior of wait_status() here.
>>>> If one machine shows no change after a certain status bit change, then
>>>> perhaps the others share that behavior, and we are waiting in vain. Just
>>>> imagine how many years of cpu that is, combined. ;-)
>>>
>>> Here is a modification along that line.
>>>
>>> Compared to your latest version, this one has wait_status() return the
>>> actual status on success. Instead of waiting for BUSY, it waits for
>>> the other status bits, and checks BUSY afterwards. So as not to wait
>>> unneccesarily, the udelay() is placed together with the single
>>> outb(). The return value of send_byte_data() is augmented with
>>> -EAGAIN, which is then used in send_command() to create the resend
>>> loop.
>>>
>>> I reach 41 reads per second on the MBA1,1 with this version, which is
>>> getting close to the performance prior to the problems.
>>
>> G'day Henrik,
>>
>> I like this one. It's slower on my laptop (40 rps vs 50 on the MacbookPro11,1) and the same 17 rps on the iMac 12,2 but it's as reliable
>> and if it works for both of yours then I think it's a winner. I can't really diagnose the iMac properly as I'm 2,800KM away and have
>> nobody to reboot it if I kill it. 5.7.2 gives 20 rps, so 17 is ok for me.
>>
>> Andreas, could I ask you to test this one?
>>
>> Odd my original version worked on your Air3,1 and the other 3 machines without retry.
>> I wonder how many commands require retries, how many retires are actually required, and what we are going wrong on the Air1,1 that requires
>> one or more retries.
>>
>> I just feels like a brute force approach because there's something we're missing.
> 
> I would think you are right. There should be a way to follow the status changes in realtime, so one can determine handshake and processing from that information. At least, with this change, we are making the blunt instrument a little smaller.

G'day Henrik,

Out of morbid curiosity I grabbed an older MacOS AppleSMC.kext (10.7) and ran it through the disassembler.

Every read/write to the SMC starts the same way with a check to make sure the SMC is in a sane state. If it's not, a read command is sent to try and kick it back into line :
Wait for 0x04 to clear. This is 1,000,000 iterations of "read status, check if 0x04 is set, delay 10uS".
If it clears, move on. If it doesn't, try and send a read command (just the command 0x10) and wait for the busy flag to clear again with the same loop.

So in theory if the SMC was locked up, it'd be into the weeds for 20 seconds before it pushed the error out.

So, lets say we've waited long enough and the busy flag dropped :

Each command write is :
Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
Send command

Each data byte write is :
Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
Immediate and single status read, check 0x04. If not set, abort.
Send data byte

Each data byte read is :
read staus, wait for 0x01 and 0x04 to be set. delay 10uS and repeat. Abort if fail.

Each timeout is 1,000,000 loops with a 10uS delay.

So aside from the startup set which occurs on *every* read or write set, status checks happen before a command or data write, and not at all after.
Under no circumstances are writes of any kind re-tried, but these timeouts are up to 10 seconds!

That would indicate that the requirement for retries on the early Mac means we're not waiting long enough somewhere. Not that I'm suggesting we do another re-work, but when I get back in front of my iMac which does 17 transactions per second with this driver, I might re-work it similar to the Apple driver and see what happens.

Oh, and it looks like the 0x40 flag that is on mine is the "I have an interrupt pending" flag, and the result should be able to be read from 0x31F. I'll play with that when I get time. That probably explains why IRQ9 screams until the kernel gags it on this machine as it's not being given any love.

Regards,
Brad
