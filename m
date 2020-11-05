Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDC2A7BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgKEKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:31:48 -0500
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com ([46.30.212.1]:46044
        "EHLO mailrelay2-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgKEKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20191106;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=E/Pff/B07dXKxlEt4by3cKElbeA6Phi+MNFJDeXUMiE=;
        b=ASEgTDKFF5yC5T1J3GdA3B07v02y8G2hrkbnhTp0Y9oRASgOHZiR2u5bdcZvw+SEiCwTY5j54gBmg
         p4fVwVutMi6KC7ArbY9Twbe5c1QniIjbAGvTjPy35Rc5cRTauwdTco2ObCjKGq4OTJLcdTesHldwV8
         yEIUvqAlUGiaZRcFTFG4vT8mqjC2tshh63cpsJgrE5Hy+3YR0zTOuRNdw4E5Krvc0tCHKe5JvGXV0Z
         R07aB5CSrxHIKhurGaU9HddAqqbk90rucw/5ws4GI5GLDuekTZM6lX67i/fULL94QTHEB0nRV6WFgm
         i6IriY2sKr/YS88I4P3NONVIbMc0Asg==
X-HalOne-Cookie: cfcf971154434c981b222b5b215374cfdaf36976
X-HalOne-ID: 195d10c5-1f52-11eb-84b8-d0431ea8a290
Received: from [192.168.19.13] (h-155-4-128-97.na.cust.bahnhof.se [155.4.128.97])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 195d10c5-1f52-11eb-84b8-d0431ea8a290;
        Thu, 05 Nov 2020 10:31:44 +0000 (UTC)
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
Date:   Thu, 5 Nov 2020 11:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 09:30, Brad Campbell wrote:
> On 5/11/20 6:56 pm, Henrik Rydberg wrote:
>> Hi Brad,
>>
>> Great to see this effort, it is certainly an area which could be improved. After having seen several generations of Macbooks while modifying much of that code, it became clear that the SMC communication got refreshed a few times over the years. Every tiny change had to be tested on all machines, or kept separate for a particular generation, or something would break.
>>
>> I have not followed the back story here, but I imagine the need has arisen because of a new refresh, and so this patch only needs to strictly apply to a new generation. I would therefore advice that you write the patch in that way, reducing the actual change to zero for earlier generations. It also makes it easier to test the effect of the new approach on older systems. I should be able to help testing on a 2008 and 2011 model once we get to that stage.
> 
> G'day Henrik,
> 
> Unfortunately I didn't make these changes to accommodate a "new generation". Changes made in kernel 5.9 broke it on my machine and in looking at why didn't identify any obvious causes, so I re-worked some of the comms.
> 
> I can't guarantee it won't break older machines which is why I've asked for help testing it. I only have a MacbookPro 11,1 and an iMac 12,2. It fixes both of those.
> 
> Help testing would be much appreciated.

I see, this makes much more sense. I may be able to run some tests 
tonight. Meanwhile, looking at the patch, the status variable in 
send_command looks superfluous now that there is a wait_status() before it.

Thanks,
Henrik
