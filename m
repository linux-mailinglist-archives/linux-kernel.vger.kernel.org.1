Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEFE267E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgIMITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgIMITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:19:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B91C061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:19:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so18992038ejo.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 01:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JTKNL3SAmNHKeei1RZzkVvOMmOlCapOPSJPDjjnYcso=;
        b=gt3G012Fk9LsL8CBSfPNsHZSvpO7B2EiWQ3Urw2pp8MvAVpChF2/+f2uh2WJzoDug8
         oAA6HDYFyXo+43hr3C0/JuHLIOU8BjJVvQPWqqwpntS7LaVywo/fV1Uv/6vFVTJJ+s2+
         QCclrN0G2AGKJPEp4RR+G1lzeNXkPjJg964+QAtc5oMageZU7PBobhvuwQewWNbaYFLN
         k/YqUogC6hNkZdwCorn0QxNUQkYJktWksXB0TdJXt/8rIa3uIReIeVR1s1vmcfwfbyre
         D1oO+N7FBEdSYxx6wQ2tgFD5gT3feQ+m0LSWXpbblKZIVi4t6dRJT8Fod+yarCEjcv3O
         0hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTKNL3SAmNHKeei1RZzkVvOMmOlCapOPSJPDjjnYcso=;
        b=VXval44eCpdE2N6kt4MS3Y5AdV7sRgNUOlv9Zs+PYcriMNVFvnRBhoibbH89EFd43R
         8y1e7Z9+/fEhNA0z60RJ3+hJtZX0L8bpLyBJVP3OpEYrcfdPP98F9tBRtQ0gQUG509Yt
         0BR5MFwtrPNYwoDdz/8QcAI3JQdjbAP88CtXXLo94+WsH24ouEEAAWgHD036+Z3lkBId
         Av1AJx3poPqP8bwYNVkcZ+usPcJd89YzCCbNFPwSH7d15Cyq2VUyBN2sc3QmjrO1FPKX
         K+FwR/XLsd/gD2i81atzUrN1CQhOEcfoyLdHVc9qn6FqmRKZ1zylD8tNILV31ZjbyFqp
         uydA==
X-Gm-Message-State: AOAM5320D844sy2ucienStxjYJS2G94OSgQ7HaHU/B7SG4wvpRDOuYeR
        HxEyBLwEOwAh3qtjgyD84FVLkWr/CUA=
X-Google-Smtp-Source: ABdhPJypyUpgAp8jm8ENIIoF0lNg+ji5zjKNJqUavIkE6xyq4R8JfjD2bwaHFXdKICqbBNNssXpK5g==
X-Received: by 2002:a17:906:4a51:: with SMTP id a17mr9172003ejv.381.1599985184917;
        Sun, 13 Sep 2020 01:19:44 -0700 (PDT)
Received: from [192.168.178.22] (dslb-002-204-143-192.002.204.pools.vodafone-ip.de. [2.204.143.192])
        by smtp.gmail.com with ESMTPSA id dm22sm6455855edb.49.2020.09.13.01.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 01:19:44 -0700 (PDT)
Subject: Re: [PATCH 1/5] staging: rtl8723bs: refactor cckrates{only}_included
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200912084520.8383-1-straube.linux@gmail.com>
 <f5fdb27843143dfefb1a1a416dab63931fef6d41.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <30b4b012-61ed-18e4-4c0f-bc9f247f2dbf@gmail.com>
Date:   Sun, 13 Sep 2020 10:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f5fdb27843143dfefb1a1a416dab63931fef6d41.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-12 20:22, Joe Perches wrote:
> On Sat, 2020-09-12 at 10:45 +0200, Michael Straube wrote:
>> Refactor cckrates_included() and cckratesonly_included() to simplify
>> the code and improve readability.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
>> index a5790a648a5b..4e0d86b2e2e0 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
>> @@ -56,11 +56,12 @@ static u8 rtw_basic_rate_ofdm[3] = {
>>   
>>   int cckrates_included(unsigned char *rate, int ratelen)
>>   {
>> -	int	i;
>> +	int i;
>>   
>>   	for (i = 0; i < ratelen; i++) {
>> -		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
>> -		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
>> +		u8 r = rate[i] & 0x7f;
>> +
>> +		if (r == 2 || r == 4 || r == 11 || r == 22)
>>   			return true;
>>   	}
>>   
>> @@ -69,11 +70,12 @@ int cckrates_included(unsigned char *rate, int ratelen)
>>   
>>   int cckratesonly_included(unsigned char *rate, int ratelen)
>>   {
>> -	int	i;
>> +	int i;
>>   
>>   	for (i = 0; i < ratelen; i++) {
>> -		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
>> -		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
>> +		u8 r = rate[i] & 0x7f;
>> +
>> +		if (r != 2 && r != 4 && r != 11 && r != 22)
>>   			return false;
> 
> It would be simpler to add and use an inline like:
> 
> static bool is_cckrate(unsigned char rate)
> {
> 	rate &= 0x7f;
> 	return rate == 2 || rate == 4 || rate == 11 || rate == 22;
> }
> 
> so these could be
> 
> bool cckrates_included(unsigned char *rate, int ratelen)
> {
> 	int i;
> 
> 	for (i = 0; i < ratelen; i++) {
> 		if (is_cckrate(rate[i])
> 			return true;
> 	}
> 
> 	return false;
> }
> 
> bool cckratesonly_included(unsigned char *rate, int ratelen)
> {
> 	int i;
> 
> 	if (i <= 0)
> 		return false;
> 
> 	for (i = 0; i < ratelen; i++) {
> 		if (!is_cckrate(rate[i])
> 			return false;
> 	}
> 
> 	return true;
> }
> 
> 

I've just seen that there are already rtw_is_cckrates_included and rtw_is_cckratesonly_included
in rtw_ieee80211.c that can be used here.

I will send another series removing the functions from rtw_wlan_util.c and use the ones from
rtw_ieee80211.c.

So please don't merge this series, thanks.

Michael

