Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41F325B2AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIBRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 13:07:20 -0400
Received: from mx4.wp.pl ([212.77.101.11]:19387 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIBRHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:07:19 -0400
Received: (wp-smtpd smtp.wp.pl 26334 invoked from network); 2 Sep 2020 19:07:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1599066435; bh=xLtgJOPrL3YCDxm2GC4sjGv1t6OcXxeRsL5vC9/BygE=;
          h=Subject:To:Cc:From;
          b=aMnt9GgTmjxjQ055lVFx4ljD8w3szBanRD+4tgF+j5h/xuyEZmEQeAK5JR4LGIEPd
           8vUC47ZduHt0I9C6YYEeZLI0VwglgyHcbuBIa0LLq0BE9jqeSStO32tHpJJAJKA82i
           msxD3ye6EV/H0FZHJtRsM+QAHkUnNtZHi/Sf1a3U=
Received: from 188.146.102.178.nat.umts.dynamic.t-mobile.pl (HELO [192.168.1.110]) (antoni.przybylik@wp.pl@[188.146.102.178])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 2 Sep 2020 19:07:15 +0200
Subject: Re: [PATCH v2 2/2] staging: gdm724x: gdm_tty: replaced macro with a
 function
To:     Randy Dunlap <rdunlap@infradead.org>
References: <20200902161627.64686-1-antoni.przybylik@wp.pl>
 <14c3b5c1-a5d8-3843-6538-5f76c4b8d6df@infradead.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From:   "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
Message-ID: <eb24f7d2-0460-dd3b-1ab3-a9748fa193fe@wp.pl>
Date:   Wed, 2 Sep 2020 19:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <14c3b5c1-a5d8-3843-6538-5f76c4b8d6df@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WP-MailID: 1a2205470018b49782a34339a2a5f8d5
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [gRN0]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.2020 18:21, Randy Dunlap wrote:
> On 9/2/20 9:16 AM, Antoni Przybylik wrote:
>> Changed return type to bool and removed inline specifier. Also added
>>   static specifier.
> why remove the inline specifier?

Greg KH wrote to me:

And really, no need to make it inline, just make it a normal function
and the compiler will inline it if needed.

> thanks.
>
>> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
>> ---
>>   drivers/staging/gdm724x/gdm_tty.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
>> index 34a13d98c029..179fc9b9400b 100644
>> --- a/drivers/staging/gdm724x/gdm_tty.c
>> +++ b/drivers/staging/gdm724x/gdm_tty.c
>> @@ -34,7 +34,7 @@ static DEFINE_MUTEX(gdm_table_lock);
>>   static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
>>   static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
>>   
>> -inline int gdm_tty_ready(struct gdm *gdm)
>> +static bool gdm_tty_ready(struct gdm *gdm)
>>   {
>>   	return (gdm && gdm->tty_dev && gdm->port.count);
>>   }
>>
>
Antoni Przybylik
