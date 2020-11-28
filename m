Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330742C7092
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgK1SB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 13:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730367AbgK1R6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 12:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606586245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/9VexrUXidVf4QsQ16eTGDTHqzpzizO8gV9HIQyFVI=;
        b=DMsjDQbzmuo8mBFek0hJwBSwM1c/LDa7wyPaXKyrZCZkiaIJNhbrGZFqkhHcZjd3Iqj3VA
        nAqAECwr0lr9RrMx39RCwPpaRpzkEgp26JHclgrjgRZtenLCBC3aVgcspmjqV/Zcbk25o2
        xECRV6ae1L4FlEp8Pm5K7zOhQ4MH5I4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-9I_8MLt_P2OOHMdi8Ql3jQ-1; Sat, 28 Nov 2020 11:57:03 -0500
X-MC-Unique: 9I_8MLt_P2OOHMdi8Ql3jQ-1
Received: by mail-qv1-f71.google.com with SMTP id e13so4971771qvl.19
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 08:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D/9VexrUXidVf4QsQ16eTGDTHqzpzizO8gV9HIQyFVI=;
        b=H0z47S2v9178Q5BVYLVGjKN3f5fSnduIEbGCgoMQ2sOFEYlmmEYhZFNYKzA2ngEOYb
         lRNiADTKHucKWOCFmVKezI9wFWGfysnt/VXBrPRzZf2OA+HLk6aOCQipIG9UGtfvcZWZ
         XMAqocZYa477Iy6dILTPRt2XjcamqHFq8SDptt3o3+k5j0n33s0bGZp2ktUvWEaevfEh
         +BoenveG72OtZ3pRIwdM4mQ96wx3Xw6Q//YVmZzKetiJ03ZDbm9MwAZ7h7KxwkV4mYJ/
         S/2UMS1EJHN2WZ8vYRTruCJjI+8C9nCOWSy+cx3Rqt0IY/mlxvBdSlgUmIOTzU17Tzfd
         21sQ==
X-Gm-Message-State: AOAM5317SHE92q+r82ejl9DsNPBZSJUMwIdagWUq2yErbSInyzav0qTS
        DRCuryIL5wW9OqTkEK2Gg2JQIQzSmAQ0via4RYRqzh2fDOqKwJ8a0vJG583oh1Od4+LhReQ9Zww
        UbqkusjFDbtoUPPm8g87+t4Ser+SCVL1wbEnHkYh04U7y3M/pqBdtdfTy8izbvacjyiptJq8=
X-Received: by 2002:aed:31a6:: with SMTP id 35mr12863350qth.370.1606582622331;
        Sat, 28 Nov 2020 08:57:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybuxgW8vuzFsf3oEDQU16R4OXWF1s7TI71ejtZyY/hsyyjl1E/TPwbX+JvdnksoJzw7b7yQw==
X-Received: by 2002:aed:31a6:: with SMTP id 35mr12863329qth.370.1606582622083;
        Sat, 28 Nov 2020 08:57:02 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n21sm10283881qke.21.2020.11.28.08.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 08:57:01 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20201127214316.3045640-1-trix@redhat.com>
 <a4e796f8c0bfdb2c0a2816fa706d13cc0ae06d40.camel@perches.com>
 <f96ff56c-7c39-2fed-dd8b-11971f8965bf@redhat.com>
 <6e9917257cfd6774066446014051d39b784ba497.camel@perches.com>
 <8a48dbc8-59cc-5fff-e9ea-e68ffb9e698a@redhat.com>
 <1e0ffe90dc73d45e3e2c3bdd8686aa8e9afa8b23.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7d1474bf-ae4f-0ca0-d282-ca12071f353b@redhat.com>
Date:   Sat, 28 Nov 2020 08:56:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1e0ffe90dc73d45e3e2c3bdd8686aa8e9afa8b23.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/20 8:44 AM, Joe Perches wrote:
> On Sat, 2020-11-28 at 08:30 -0800, Tom Rix wrote:
>> On 11/28/20 8:00 AM, Joe Perches wrote:
>>> On Sat, 2020-11-28 at 07:36 -0800, Tom Rix wrote:
>>>> On 11/27/20 2:10 PM, Joe Perches wrote:
>>> []
>>>>> I think an exception mechanism would be better than a specific
>>>>> mechanism added to various entries.
>>>> Can you give an example of what you mean ?
>>> Inherit the parent prefix then add the basename(dirname) as a default.
>>>
>>> For instance, changes to any subsystem of drivers/staging starts as
>>> "staging: " and with "$basename(path): " appended.
>> Ah, this is quite a bit different.
>>
>> As far as I can tell there is no default.
> The idea is to avoid adding a D: entry to each subsystem section.
Yeah, having looked at 2000+ on my initial populating of D's, it was not great
>
>> MAINTAINERS would only have the exceptions, obviously needing drivers/foo to be 'foo:'
>>
>> Without the full prefix, the user would be need to use get_maintainer.pl to figure it out.
> True.  Or some other script.

I am ok with another script, maybe get_subsystem.py

>  
>> Are the ""'s in the D value necessary ?
> Maybe not.  I did that for clarity with the space after colon.
> My recollection is some systems used "[subsystem]" separators
> and other use / without space and not colons, but I'm for
> whatever approriate changes that support standarization
>
> I think most developer/maintainers don't care one way or
> another about patch commit prefixes, but those that do care
> seem to care a lot.
>
>
Yes, i agree.

Tom

