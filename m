Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB52CD314
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgLCKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgLCKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:00:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79658C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 01:59:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b23so849272pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q69KsiFydwKCuMI7D00S2So//GnJB60DE1anI6+oqlc=;
        b=MaGLUSpxokzJi81vFpAWPMRHIXOfWZ+f4BaMrGtcSlOO1g15+I9n3VBwa4gW7xeHby
         j3GA9BK/+Za3GqZhBjE8/DQ+GgU5VAWDV/Dm2SA5PZGAN4Kk5zAaA4IWyvoB4YzjNlX4
         4LxLhaAbnGMWSKlLjNYsiaJD3/FSzHWDZgCCRzofgUh+zCq6mirH+GQm+GZfB9k7Nd9S
         2BtpHrhhEifZ511+WmUT8Z7RMcGT3m3PLhe3dTGsvj05iFgrxvkDOdfULSvFypHJk6FN
         wwJLopNippi+Vc1OmaJ7Xkp65aeLIapydugivjp7h1wCBEprx0x50J6PlfL3EfYo6hrF
         B1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q69KsiFydwKCuMI7D00S2So//GnJB60DE1anI6+oqlc=;
        b=WzgyDmZgh3nGEdIvwMOwN5DYHudJZ7vKxNk/Rb3Mfsq6D+1QbRp9LqxzNvOC11//Z2
         15tjY4iWYTzzg0VMr5yLlOCcLLb9kFUxpgvAMsi/QQKedsy8gZatwbe2B1EggDf0kuPF
         3UN7pCQlAvqk0wuqREh/BwjiTcCCZv8rXHUOz1J57qH0wB5tJRruddVR6Rq9iRhQOQgY
         7fpETah9tw/8smej5YmdvZHIzqCboz9hODKZbOJgFt2JeIpi6hHNK3u/YqUknZRIrAau
         PZVENnIMMEXfrW1CcGdQ4fArKTspgKM75pMxhpu/PdwlinsnkRbtnhrffBTOkbBezHfl
         p3Ow==
X-Gm-Message-State: AOAM5330OGClHGRF4DU9A9nXp7I45GyNY6/pcgkf2v9GJ9IJcJIaIRUX
        EBx9NGEtHy0h5givip1rUIA=
X-Google-Smtp-Source: ABdhPJxf0qUiN0aXVwqbckesUIXrKA0YgpGp5M6GYDjpW/ZR2y1xB66cxWMDy1bx3pidWl8u+WCguQ==
X-Received: by 2002:a17:90b:a53:: with SMTP id gw19mr2355333pjb.216.1606989579772;
        Thu, 03 Dec 2020 01:59:39 -0800 (PST)
Received: from [192.168.43.245] ([42.111.136.176])
        by smtp.gmail.com with ESMTPSA id y24sm1258100pfn.176.2020.12.03.01.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 01:59:39 -0800 (PST)
From:   Aditya <yashsri421@gmail.com>
Subject: Re: [PATCH -mmots] checkpatch: add fix for non-standard signature -
 co-authored-by
To:     Joe Perches <joe@perches.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
 <20201202183045.9309-1-yashsri421@gmail.com>
 <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
Message-ID: <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
Date:   Thu, 3 Dec 2020 15:29:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 12:26 am, Joe Perches wrote:
> On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
>> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
>> non-standard signatures.
>>
>> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
>> non-standard signatures, 43 are due to the use of 'Co-authored-by'
>> tag, which may seem correct, but is not standard.
>>
>> The standard signature equivalent for 'Co-authored-by' is
>> 'Co-developed-by'.
> 
> I'm not going to ack this as I don't mind non-standard signatures.
> 

What do you suggest?
Should I drop this patch and move on?

> You should also always use patch subject versioning and include
> a changelog after the --- line.
> 

Ok, will do. Actually I had not included the version changelogs and
versioning from our previous patch, as the subject for the patch had
changed. Will keep in mind for future though.

Thanks
Aditya

>> Provide a fix by suggesting users with this signature alternative and
>> replacing.
>>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>>  scripts/checkpatch.pl | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 4a026926139f..fc036d545d2d 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2832,6 +2832,9 @@ sub process {
>>  
>>
>>  			if ($sign_off !~ /$signature_tags/) {
>>  				my $suggested_signature = find_standard_signature($sign_off);
>> +				if ($sign_off =~ /co-authored-by:/i) {
>> +					$suggested_signature = "Co-developed-by:";
>> +				}
>>  				if ($suggested_signature eq "") {
>>  					WARN("BAD_SIGN_OFF",
>>  					     "Non-standard signature: $sign_off\n" . $herecurr);
> 
> 

