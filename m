Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A424B2AFC64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgKLBgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:09 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:54336 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgKKXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:30:59 -0500
Received: from srv.home ([10.8.0.1] ident=heh4648)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kczXn-00057Q-J0; Thu, 12 Nov 2020 07:28:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From; bh=aDZuAoa5pHuOQbtSVm+Q62xoeuPrqmcgO4MplIKPrUA=;
        b=iLRvYT1IO4cvaDXMLUgjDx/6OnwR+uLCmN8f7ZhB5B1R8hhJRWoSU5ezjPEqZXIAQVtzYU9uO9LL7kSj3sbMMmtIUv/N0oHpBsR0pOkZ3CIjNHMZt9fRdiqFuMBk53PXRsCO9LuL+eu5RECXuHFlpQLePtGV2BIhy/PP0eYvunQ=;
From:   Brad Campbell <brad@fnarfbargle.com>
Subject: Re: [PATCH v5 1/1] applesmc: Re-work SMC comms
To:     Henrik Rydberg <rydberg@bitmath.org>, linux-hwmon@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20200930105442.3f642f6c@aktux> <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
 <4eca09dc-7b32-767c-eab0-b9ad8b41efcc@fnarfbargle.com>
 <b6345525-c4d0-6949-1231-a47c3053e343@roeck-us.net>
 <8c525b3b-b4a6-8ee4-8128-a20e0ad408e4@fnarfbargle.com>
 <29b03865-f00a-f121-b7a5-c4b9179a27cb@bitmath.org>
Message-ID: <c6122194-2024-f6cf-7a45-cf3eb1a97171@fnarfbargle.com>
Date:   Thu, 12 Nov 2020 10:28:50 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <29b03865-f00a-f121-b7a5-c4b9179a27cb@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 7:05 am, Henrik Rydberg wrote:
> On 2020-11-11 14:06, Brad Campbell wrote:
>> Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
>> introduced an issue whereby communication with the SMC became
>> unreliable with write errors like :
>>
>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.378621] applesmc: LKSB: write data fail
>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>> [  120.512787] applesmc: LKSB: write data fail
>>
>> The original code appeared to be timing sensitive and was not reliable
>> with the timing changes in the aforementioned commit.
>>
>> This patch re-factors the SMC communication to remove the timing
>> dependencies and restore function with the changes previously
>> committed. Logic changes based on inspection of the Apple SMC kext.
>>
>> Tested on : MacbookAir6,2 MacBookPro11,1 iMac12,2, MacBookAir1,1,
>> MacBookAir3,1
>>
>> Fixes: fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()")
>> Reported-by: Andreas Kemnade <andreas@kemnade.info>
>> Tested-by: Andreas Kemnade <andreas@kemnade.info> # MacBookAir6,2
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Brad Campbell <brad@fnarfbargle.com>
>> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
>>
>> ---
>> Changelog :
>> v1 : Initial attempt
>> v2 : Address logic and coding style
>> v3 : Removed some debug hangover. Added tested-by. Modifications for MacBookAir1,1
>> v4 : Re-factored logic based on Apple driver. Simplified wait_status loop
>> v5 : Re-wrote status loop. Simplified busy check in send_byte(). Fixed formatting
> 
> Hi Brad,
> 
> This version is still working fine on the MBA1,1, at 50 reads per second.
> 

Cheers Henrik,

I did 5.6 million reads overnight and had 3 failures.
I suspect it's this :
	status = inb(APPLESMC_CMD_PORT) & SMC_STATUS_BUSY;
	if (!status)
		return -EIO;

When I used wait_status() previously I didn't see any read errors.
With hindsight I probably shouldn't have made that simplification.

I'll do some more testing and probably submit a v6 with just this change.
I think it's just about right provided that wait_status loop gets across the
line.

Regards,
Brad
