Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB32ACF39
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgKJFmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 00:42:01 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:57368 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgKJFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:41:59 -0500
Received: from srv.home ([10.8.0.1] ident=heh7021)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kcMOF-0003IB-4d; Tue, 10 Nov 2020 13:40:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=/hA2oDkpe+AaUcx7FRwO1/3LzO7NflBudjmN8PhR+o8=;
        b=RSRj0hsJ53juGSNKNAViagqwz8PqzN4P7HYi0fY+82RyZHxUS9zTFdY/MAdtTojQo+c8HgjYI35RTPjIIaWRNhsQ4PMx+hPTBPJ+W1xPNOip7MihSeGS35FQostIyFRSbNTP7upNB4YIRi5Tb8dA+CLRmdyYXuYtPlbApInTMAw=;
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <41909045-9486-78d9-76c2-73b99a901b83@bitmath.org>
 <20201108101429.GA28460@mars.bitmath.org>
 <db65e8ba-80fd-2142-56f2-8f625defb160@roeck-us.net>
 <daa34876-55b6-1a85-2532-976934d2fbb1@fnarfbargle.com>
 <20201110045554.GA106049@roeck-us.net>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <e1ed07e1-eb3a-eb61-37ca-875a4aa5c700@fnarfbargle.com>
Date:   Tue, 10 Nov 2020 16:40:23 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20201110045554.GA106049@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 3:55 pm, Guenter Roeck wrote:
> On Tue, Nov 10, 2020 at 01:04:04PM +1100, Brad Campbell wrote:
>> On 9/11/20 3:06 am, Guenter Roeck wrote:
>>> On 11/8/20 2:14 AM, Henrik Rydberg wrote:
>>>> On Sun, Nov 08, 2020 at 09:35:28AM +0100, Henrik Rydberg wrote:
>>>>> Hi Brad,
>>>>>
>>>>> On 2020-11-08 02:00, Brad Campbell wrote:
>>>>>> G'day Henrik,
>>>>>>
>>>>>> I noticed you'd also loosened up the requirement for SMC_STATUS_BUSY in read_smc(). I assume
>>>>>> that causes problems on the early Macbook. This is revised on the one sent earlier.
>>>>>> If you could test this on your Air1,1 it'd be appreciated.
>>>>>
>>>>> No, I managed to screw up the patch; you can see that I carefully added the
>>>>> same treatment for the read argument, being unsure if the BUSY state would
>>>>> remain during the AVAILABLE data phase. I can check that again, but
>>>>> unfortunately the patch in this email shows the same problem.
>>>>>
>>>>> I think it may be worthwhile to rethink the behavior of wait_status() here.
>>>>> If one machine shows no change after a certain status bit change, then
>>>>> perhaps the others share that behavior, and we are waiting in vain. Just
>>>>> imagine how many years of cpu that is, combined. ;-)
>>>>
>>>> Here is a modification along that line.
>>>>
>>>
>>> Please resend this patch as stand-alone v4 patch. If sent like it was sent here,
>>> it doesn't make it into patchwork, and is thus not only difficult to apply but
>>> may get lost, and it is all but impossible to find and apply all tags.
>>> Also, prior to Henrik's Signed=off-by: there should be a one-line explanation
>>> of the changes made.
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> Compared to your latest version, this one has wait_status() return the
>>>> actual status on success. Instead of waiting for BUSY, it waits for
>>>> the other status bits, and checks BUSY afterwards. So as not to wait
>>>> unneccesarily, the udelay() is placed together with the single
>>>> outb(). The return value of send_byte_data() is augmented with
>>>> -EAGAIN, which is then used in send_command() to create the resend
>>>> loop.
>>>>
>>>> I reach 41 reads per second on the MBA1,1 with this version, which is
>>>> getting close to the performance prior to the problems.
>>>>
>>
>> Can I get an opinion on this wait statement please?
>>
>> The apple driver uses a loop with a million (1,000,000) retries spaced with a 10uS delay.
>>
>> In my testing on 2 machines, we don't busy wait more than about 2 loops.
>> Replacing a small udelay with the usleep_range kills performance.
>> With the following (do 10 fast checks before we start sleeping) I nearly triple the performance
>> of the driver on my laptop, and double it on my iMac. This is on an otherwise unmodified version of
>> Henriks v4 submission.
>>
>> Yes, given the timeouts I know it's a ridiculous loop condition.
>>
>> static int wait_status(u8 val, u8 mask)
>> {
>> 	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>> 	u8 status;
>> 	int i;
>>
>> 	for (i=1; i < 1000000; i++) {
> 
> The minimum wait time is 10 us, or 16uS after the first 10
> attempts. 1000000 * 10 = 10 seconds. I mean, it would make
> some sense to limit the loop to APPLESMC_MAX_WAIT /
> APPLESMC_MIN_WAIT iterations, but why 1,000,000 ?

I had to pick a big number and it was easy to punch in 6 zeros as that is what is in
the OSX driver. In this instance it's more a proof of concept rather than sane example
because it'll either abort on timeout or return the correct status anyway.
Could also have been a while (true) {} but then I'd need to manually increment i.

>> 		status = inb(APPLESMC_CMD_PORT);
>> 		if ((status & mask) == val)
>> 			return status;
>> 		/* timeout: give up */
>> 		if (time_after(jiffies, end))
>> 			break;
>> 		if (i < 10)
>> 			udelay(10);
>> 		else
>> 			usleep_range(APPLESMC_MIN_WAIT, APPLESMC_MIN_WAIT * 16);
> 
> The original code had the exponential wait time increase.
> I don't really see the point of changing that. I'd suggest
> to keep the exponential increase but change the code to
> something like
> 		if (us < APPLESMC_MIN_WAIT * 4)
> 			udelay(us)
> 		else
> 			usleep_range(us, us * 16);

The main reason I dropped the exponential was best case on this laptop the modified code with exponential
wait as described above increase increases the performance from ~40 -> 62 reads/sec, whereas the version 
I posted with the first 10 loops at 10uS goes from ~40 -> 100 reads/sec.

About 95% of waits never get past a few of iterations of that loop (so ~30-60uS). With a
modified exponential starting at 8uS a 30uS requirement ends up at 56uS. If it needed 60us with
the original we end up waiting 120uS.

If it needs longer than 120uS it's rare enough that a bigger sleep isn't going to cause much
of a performance hit.

Getting completely pathological and busy waiting with a fixed 10uS delay like the OSX driver
does give about 125 reads/sec but I was trying to find a balance and 10 loops seemed to hit that mark.
 
> Effectively that means the first wait would be 16 uS,
> followed by 32 uS, followed by increasingly larger sleep
> times. I don't know the relevance of APPLESMC_MIN_WAIT
> being set to 16, but if you'd want to start with smaller
> wait times you could reduce it to 8. If you are concerned
> about excessively large sleep times you could reduce
> the span from us..us*16 to, say, us..us*4 or us..us*2.

I was tossing up here between the overhead required to manage a tighter usleep_range
vs some extra udelays. 

It's not exactly a performance sensitive driver, but I thought there might be a balance to be
struck between performance and simplicity. The exponential delay always struck me as odd.

If the preference is to leave it as is or modify as suggested I'm ok with that too.
Appreciate the input.

Regards,
Brad
