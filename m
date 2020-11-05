Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05E12A7556
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgKECUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:20:01 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:54536 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbgKECT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:19:58 -0500
Received: from srv.home ([10.8.0.1] ident=heh15339)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kaUqj-0008Oh-5u; Thu, 05 Nov 2020 10:18:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=vXqxBfoqZAruzaZDVKhWxMWIKn/cNae40lgzEG5AYdI=;
        b=I2gzvtYgS0dBsqCOVu97nC8RsEGrPO3biP95W0L9CulixFvuN7pzF5EvcJ6FpFoan/WNB3D//0pbbC3MLbvczoAaLSY8Dov6EjBF4EtU5BJ69Rak+l4d5tT0bds13UeGE1FZdkWV+ocpY+Mj/LnfXzZX7vPQxXTLBAwPBgA6xZA=;
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Andreas Kemnade <andreas@kemnade.info>,
        Guenter Roeck <linux@roeck-us.net>,
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
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
Date:   Thu, 5 Nov 2020 13:18:03 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20201104142057.62493c12@aktux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 12:20 am, Andreas Kemnade wrote:
> On Tue, 3 Nov 2020 16:56:32 +1100
> Brad Campbell <brad@fnarfbargle.com> wrote:

>> If anyone with a Mac having a conventional SMC and seeing issues on 5.9 could test this it'd be appreciated. I'm not saying this code is "correct", but it "works for me".
>>
> Seems to work here.
>   dmesg  | grep applesmc
> 
> [    1.350782] applesmc: key=561 fan=1 temp=33 index=33 acc=0 lux=2 kbd=1
> [    1.350922] applesmc applesmc.768: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [   17.748504] applesmc: wait_status looping 2: 0x4a, 0x4c, 0x4f
> [  212.008952] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> [  213.033930] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> [  213.167908] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> [  219.087854] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> 
> Tested it on top of 5.9

Much appreciated Andreas.

I'm not entirely sure where to go from here. I'd really like some wider testing before cleaning this up and submitting it. It puts extra checks & constraints on the comms with the SMC that weren't there previously.

I guess given there doesn't appear to have been a major outcry that the driver broke in 5.9 might indicate that nobody is using it, or that it only broke on certain machines?

Can we get some guidance from the hwmon maintainers on what direction they'd like to take? I don't really want to push this forward without broader testing only to find it breaks a whole heap of machines on the basis that it fixes mine.

Regards,
Brad
