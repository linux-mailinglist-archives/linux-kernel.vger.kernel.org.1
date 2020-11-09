Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB02AC1CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgKIRIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:08:38 -0500
Received: from mailrelay3-2.pub.mailoutpod1-cph3.one.com ([46.30.212.2]:54663
        "EHLO mailrelay3-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730103AbgKIRIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=8WkeL/6Obia5iGe0PEgUkq1rnWgBWM4eJz++BJCuECY=;
        b=XBhGmXcthbsXR9ONVJpA8kLO2pdJSB512455S6J3FhUbIG8df+oxzXy3NzsThJQH+TAh7BgiTRovE
         KqGkBOmv38dB70n9ndzGEZLspWc9qS/pBPRZUM2zfKrgFgcRBNuFigW/jtjUEByWzTT98h4XWRh+96
         seLRbifQKLuu5hENbZaj+xA5gFhwnLNC7x3FHEbOT3pJ3z72OwR56dC6OBnv7lwI9b1S3V+buXoksb
         7IwkkKul3mTd68RQ+xEvRl0s0wTgVsNrTWCjAog9RllpdKLDaAwPQLq2koBkKWuogyfVwHHxrK7vBs
         vtd5SkHA9qMfLy6jammpeNMIyabIgZQ==
X-HalOne-Cookie: 63cb47a66e693f08a3ac8867ab094fba82142490
X-HalOne-ID: 319dc5e4-22ae-11eb-a80d-d0431ea8bb03
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 319dc5e4-22ae-11eb-a80d-d0431ea8bb03;
        Mon, 09 Nov 2020 17:08:32 +0000 (UTC)
Subject: Re: [PATCH v3] applesmc: Re-work SMC comms
To:     Brad Campbell <brad@fnarfbargle.com>
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
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <d091286d-00ac-bd96-b1ea-0e789f02fa07@bitmath.org>
Date:   Mon, 9 Nov 2020 18:08:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d4e53a42-d86b-ce2b-7422-22b5ff5593e8@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

> Out of morbid curiosity I grabbed an older MacOS AppleSMC.kext (10.7) and ran it through the disassembler.
> 
> Every read/write to the SMC starts the same way with a check to make sure the SMC is in a sane state. If it's not, a read command is sent to try and kick it back into line :
> Wait for 0x04 to clear. This is 1,000,000 iterations of "read status, check if 0x04 is set, delay 10uS".
> If it clears, move on. If it doesn't, try and send a read command (just the command 0x10) and wait for the busy flag to clear again with the same loop.
> 
> So in theory if the SMC was locked up, it'd be into the weeds for 20 seconds before it pushed the error out.
> 
> So, lets say we've waited long enough and the busy flag dropped :
> 
> Each command write is :
> Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
> Send command
> 
> Each data byte write is :
> Wait for 0x02 to clear. This is 1,000,000 iterations of "read status, check if 0x02 is set, delay 10uS".
> Immediate and single status read, check 0x04. If not set, abort.
> Send data byte
> 
> Each data byte read is :
> read staus, wait for 0x01 and 0x04 to be set. delay 10uS and repeat. Abort if fail.
> 
> Each timeout is 1,000,000 loops with a 10uS delay.
> 
> So aside from the startup set which occurs on *every* read or write set, status checks happen before a command or data write, and not at all after.
> Under no circumstances are writes of any kind re-tried, but these timeouts are up to 10 seconds!

Great findings here. But from this, it would seem we are doing almost 
the right thing already, no? The essential difference seems to be that 
where the kext does a read to wake up the SMC, while we retry the first 
command until it works. If would of course be very interesting to know 
if that makes a difference.

> That would indicate that the requirement for retries on the early Mac means we're not waiting long enough somewhere. Not that I'm suggesting we do another re-work, but when I get back in front of my iMac which does 17 transactions per second with this driver, I might re-work it similar to the Apple driver and see what happens.
> 
> Oh, and it looks like the 0x40 flag that is on mine is the "I have an interrupt pending" flag, and the result should be able to be read from 0x31F. I'll play with that when I get time. That probably explains why IRQ9 screams until the kernel gags it on this machine as it's not being given any love.

Sounds good, getting interrupts working would have been nice.

Henrik
