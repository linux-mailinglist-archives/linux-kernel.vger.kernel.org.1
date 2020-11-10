Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE22ACADC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgKJCEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:04:50 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:36088 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKJCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:04:50 -0500
Received: from srv.home ([10.8.0.1] ident=heh10015)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kcJ0t-00033z-2n; Tue, 10 Nov 2020 10:04:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=wUHE6ncYEApyoTUS8SHmnwhaXCXQFt3Ni5HWVeDrsCk=;
        b=y2qM8sEPo/UqaqSh80aNlR4XzOH/6zcjQ0ikMecHw43IHjuDKcaiIgc9De8gJdLB2suU72+bN1Shmgj70D7SX9ztQ7bWX5qdsx7MmFY9IdSIm7ae/9laUxZkq0jUn7HFwK03rLYvOS8BiCH7cTQPHeviYL0SkW7ZRduIZmUmx7k=;
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Guenter Roeck <linux@roeck-us.net>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
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
 <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <daa34876-55b6-1a85-2532-976934d2fbb1@fnarfbargle.com>
Date:   Tue, 10 Nov 2020 13:04:04 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 3:06 am, Guenter Roeck wrote:
> On 11/8/20 2:14 AM, Henrik Rydberg wrote:
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
> 
> Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
> it doesn't make it into patchwork, and is thus not only difficult to apply but
> may get lost, and it is all but impossible to find and apply all tags.
> Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
> of the changes made.
> 
> Thanks,
> Guenter
> 
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
>>

Can I get an opinion on this wait statement please?

The apple driver uses a loop with a million (1,000,000) retries spaced with a 10uS delay.

In my testing on 2 machines, we don't busy wait more than about 2 loops.
Replacing a small udelay with the usleep_range kills performance.
With the following (do 10 fast checks before we start sleeping) I nearly triple the performance
of the driver on my laptop, and double it on my iMac. This is on an otherwise unmodified version of
Henriks v4 submission.

Yes, given the timeouts I know it's a ridiculous loop condition.

static int wait_status(u8 val, u8 mask)
{
	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
	u8 status;
	int i;

	for (i=1; i < 1000000; i++) {
		status = inb(APPLESMC_CMD_PORT);
		if ((status & mask) == val)
			return status;
		/* timeout: give up */
		if (time_after(jiffies, end))
			break;
		if (i < 10)
			udelay(10);
		else
			usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
	}
	return -EIO;
}

Regards,
Brad
