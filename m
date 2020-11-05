Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A82A768F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgKEEnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgKEEnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:43:45 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADCC0613CF;
        Wed,  4 Nov 2020 20:43:45 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id j7so366420oie.12;
        Wed, 04 Nov 2020 20:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NuaCgPLO84fIGLTE4ZfFEYueemW9uiaI61yao06Rho0=;
        b=gp5bSAvBj34hoAaqmic1PO0x/kAQAtie25DnxqYhOAOSdI+EzVxRY6zcTqI62hcHlu
         O0F1D4zXveOVyy2k9rGZZVLKasoT1HZpN4xfJD728YSDCODIha4SMRhnzhEFRgY2fXcz
         2XrXCINHNmxPXjqY+bKY29vHK0ZaOm+jFe6Ik4Jv9KLwI4XiGugBLnjTkGvNcsLDV4KY
         H/xvehjNU7GtV6eSTRnfg7PT+Aiy3ELs43q1hJMc13169sRI+PRkkzZxku0NM3qoibv1
         ApGXddCUqclsyn9/FA3X2VwctwY8GI6QOQo55iISrtZcdizm+gjKfb73haUQzwVzKm8J
         3E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NuaCgPLO84fIGLTE4ZfFEYueemW9uiaI61yao06Rho0=;
        b=GpC6H17Ij/0X/7eUvyaM2chlzwPjyXIONWlk/eU5HF1GpA+OsVgboUsTWTvg7FKUvR
         GaipChNxXsCf/jg8Vm9ZFBDWDhPvPAbjPZXXXshxqMq0yOEta1NtlFy0ALlM3QVJMtxv
         vKeoS3IypD80JH/8Y+Q0Z4OVNki9ZYi2c3BHdvp+wMmy0mmKnNeTKLKL/mohQ5SNw98F
         h8XE8uWXAbtx3Vso6xq5Ot3rIkm2zPY3zY3hmfOd10SUGhUSURjtmEq7eXlXP1d094fk
         mspfVTlIQM4obKGK/fdlFq90Cs0EJBeK3Ob6j1HLe7UxXzwG4cOt7c+8DBXYApXNvmc7
         Qrpw==
X-Gm-Message-State: AOAM531C19fLUb0JVMx4oq+9n80BNpRsk5MNJ73q517OnifWOi4020aQ
        7pLiJp7Ky15L4XTalBuTxS8mxMOPkFs=
X-Google-Smtp-Source: ABdhPJxdoYJcijeRo6x21uQsilcHQ3SnpKODvB+2XfpB3yPxA1Jj79VI3A9pW+HFxxR7DX7tC1xDKA==
X-Received: by 2002:aca:2405:: with SMTP id n5mr511577oic.9.1604551424560;
        Wed, 04 Nov 2020 20:43:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k21sm97514otr.27.2020.11.04.20.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 20:43:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Brad Campbell <brad@fnarfbargle.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
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
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
Date:   Wed, 4 Nov 2020 20:43:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/20 6:18 PM, Brad Campbell wrote:
> On 5/11/20 12:20 am, Andreas Kemnade wrote:
>> On Tue, 3 Nov 2020 16:56:32 +1100
>> Brad Campbell <brad@fnarfbargle.com> wrote:
> 
>>> If anyone with a Mac having a conventional SMC and seeing issues on 5.9 could test this it'd be appreciated. I'm not saying this code is "correct", but it "works for me".
>>>
>> Seems to work here.
>>   dmesg  | grep applesmc
>>
>> [    1.350782] applesmc: key=561 fan=1 temp=33 index=33 acc=0 lux=2 kbd=1
>> [    1.350922] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>> [   17.748504] applesmc: wait_status looping 2: 0x4a, 0x4c, 0x4f
>> [  212.008952] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>> [  213.033930] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>> [  213.167908] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>> [  219.087854] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>>
>> Tested it on top of 5.9
> 
> Much appreciated Andreas.
> 
> I'm not entirely sure where to go from here. I'd really like some wider testing before cleaning this up and submitting it. It puts extra checks & constraints on the comms with the SMC that weren't there previously.
> 
> I guess given there doesn't appear to have been a major outcry that the driver broke in 5.9 might indicate that nobody is using it, or that it only broke on certain machines?
> 
> Can we get some guidance from the hwmon maintainers on what direction they'd like to take? I don't really want to push this forward without broader testing only to find it breaks a whole heap of machines on the basis that it fixes mine.
> 

Trick question ;-).

I'd suggest to keep it simple. Your patch seems to be quite complicated
and checks a lot of bits. Reducing that to a minimum would help limiting
the risk that some of those bits are interpreted differently on other
systems.

Guenter

