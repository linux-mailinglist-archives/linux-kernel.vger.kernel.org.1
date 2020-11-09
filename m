Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E522AC8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgKIWyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:54:03 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:38586 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:54:02 -0500
Received: from srv.home ([10.8.0.1] ident=heh9587)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kcG18-00030h-Ju; Tue, 10 Nov 2020 06:52:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From; bh=pNbZC2H0hQDv1qeMH/s/pyxn640YnlXS6c4hfzQzgbo=;
        b=BwbGv2fAYMuzgjIbp8kS4TPxq3Xci/bdV0Skjf2lq7wutKet6SLVe0ZD1MPKJ4K8gaFGaF4Q/LBUCfXz24NUgy5h6TxXYDG7L+SKhNEB6tl2gO5CyQIKjphnGxnDLIsAIuXTpYKvwAcjl+U+VzaI8yrtlOKmOEJ8oA+fOf8/CMY=;
From:   Brad Campbell <brad@fnarfbargle.com>
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
 <d4e53a42-d86b-ce2b-7422-22b5ff5593e8@fnarfbargle.com>
 <d091286d-00ac-bd96-b1ea-0e789f02fa07@bitmath.org>
Message-ID: <a59218a3-63ff-f08d-5d3c-96e4cebb76af@fnarfbargle.com>
Date:   Tue, 10 Nov 2020 09:52:07 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <d091286d-00ac-bd96-b1ea-0e789f02fa07@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 4:08 am, Henrik Rydberg wrote:
> Hi Brad,
> 
>> Out of morbid curiosity I grabbed an older MacOS AppleSMC.kext (10.7) and ran it through the disassembler.
>>
>> Every read/write to the SMC starts the same way with a check to make sure the SMC is in a sane state. If it's not, a read command is sent to try and kick it back into line :
>> Wait for 0x04 to clear. This is 1,000,000 iterations of "read status, check if 0x04 is set, delay 10uS".
>> If it clears, move on. If it doesn't, try and send a read command (just the command 0x10) and wait for the busy flag to clear again with the same loop.
>>
>> So in theory if the SMC was locked up, it'd be into the weeds for 20 seconds before it pushed the error out.
>>
>> So, lets say we've waited long enough and the busy flag dropped :
>>
>> Each command write is :
>> Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
>> Send command
>>
>> Each data byte write is :
>> Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
>> Immediate and single status read, check 0x04. If not set, abort.
>> Send data byte
>>
>> Each data byte read is :
>> read staus, wait for 0x01 and 0x04 to be set. delay 10uS and repeat. Abort if fail.
>>
>> Each timeout is 1,000,000 loops with a 10uS delay.
>>
>> So aside from the startup set which occurs on *every* read or write set, status checks happen before a command or data write, and not at all after.
>> Under no circumstances are writes of any kind re-tried, but these timeouts are up to 10 seconds!
> 
> Great findings here. But from this, it would seem we are doing almost the right thing already, no? The essential difference seems to be that where the kext does a read to wake up the SMC, while we retry the first command until it works. If would of course be very interesting to know if that makes a difference.

It does make a significant difference here. It doesn't use the read to wake up the SMC as such. It appears to use the read to get the SMC in sync with the driver. It only performs the extra read if the busy line is still active when it shouldn't be and provided the driver plays by the rules it only seems to do it once on init and only if the SMC thinks it's mid command (so has been left in an undefined state).

Re-working the driver to use the logic described my MacbookPro11,1 goes from 40 reads/sec to 125 reads/sec. My iMac12,2 goes from 17 reads/sec to 30.

I have one issue to understand before I post a patch.

If the SMC is in an inconsistent state (as in busy persistently high) then the driver issues a read command and waits for busy to drop (and it does, and bit 0x08 goes high on my laptop but nothing checks that). That is to a point expected based on the poking I did early on in this process.
On the other hand, when we perform a read or a write, the driver issues a read or write command and the following commands to send the key rely on the busy bit being set.

Now, in practice this works, and I've sent spurious commands to get things out of sync and after a long wait it syncs back up. I just want to try and understand the state machine inside the SMC a bit better before posting another patch.

 
>> That would indicate that the requirement for retries on the early Mac means we're not waiting long enough somewhere. Not that I'm suggesting we do another re-work, but when I get back in front of my iMac which does 17 transactions per second with this driver, I might re-work it similar to the Apple driver and see what happens.
>>
>> Oh, and it looks like the 0x40 flag that is on mine is the "I have an interrupt pending" flag, and the result should be able to be read from 0x31F. I'll play with that when I get time. That probably explains why IRQ9 screams until the kernel gags it on this machine as it's not being given any love.
> 
> Sounds good, getting interrupts working would have been nice.

I've put it on my list of things to look at. There's a lot of magic constants in the interrupt handler.

Regards,
Brad

