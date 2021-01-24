Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B259301EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhAXVOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 16:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbhAXVOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 16:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611522798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kv9jicTdTocjJxmYHF8RW7pmq0CcKS9rS4Zkv6lNt9I=;
        b=YhoMIAc4hoUmDr7vKTGi2sPUonh16zXcooQLuAJlDGQgwWuKbf0dsPQbsikjcslBD1/dM0
        8B0MpZo/k1ISQJagsaFaguZq2/AQonrdWYMXaQ1neRujBa42wfOdYUoZfdoR94pkkbMoy7
        PgDzox8930TwMTte5xuz/svaKWvdvp0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-zNNMy-oAOIa68JVMLz9fDw-1; Sun, 24 Jan 2021 16:13:16 -0500
X-MC-Unique: zNNMy-oAOIa68JVMLz9fDw-1
Received: by mail-ed1-f69.google.com with SMTP id j11so5485085edy.20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 13:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kv9jicTdTocjJxmYHF8RW7pmq0CcKS9rS4Zkv6lNt9I=;
        b=qYK+rFgA9oZEwEJkzY1TRdr0tzdLEo1CCpoRkDKcrRl1qSJdxfU1ng9DhkXg9AkgO3
         K6jNccPrRCtd1zmHH3qeIYHFpGNcJO1lseoQzYn0D5wbAEzRvyp65ch9MZ3mqNSgYoXC
         zqH3bsdMpM1dvM2pBI3fQUWnrQTkHM0FInqbD5jARPbN4MqCC1ZvsiSPgu+x5b16yTSS
         lEu1Z2eq9wcINUdfXUdD7RdQFkLg2a9J78HjChVhBpi4/bl+6fRntQ0jye1xgfmduE7A
         QsSNZUKTqKKuoRpLnn6IinXBczI5OKf5SHmxgCoFDU2/TEslIBX/HJnS7FWPcdYBGAb/
         IJHg==
X-Gm-Message-State: AOAM5335yOzysbnLF7S+bZ8GOw9SoSGyxQ1jYrHS+xCmQdMj7wUet/TD
        GZLUaW68iJu1sFewrKS0wfkU/Dy6NoP6Kr1MfvBr3koeP4vcg/AuDMFlHPuMADLzFThUQNrk/8F
        3yueZ160tVkiFxFOmue0Phftk
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr289359edq.276.1611522795544;
        Sun, 24 Jan 2021 13:13:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUqliddwpe2eSvzpgHkPyxmGc61u3ckFkUrt683DQ8oDfJny77NWrBhfgz1/vMdO9EbBaCog==
X-Received: by 2002:aa7:d40f:: with SMTP id z15mr289349edq.276.1611522795418;
        Sun, 24 Jan 2021 13:13:15 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id g2sm7379705ejk.108.2021.01.24.13.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 13:13:14 -0800 (PST)
Subject: Re: [PATCH v4 11/13] ASoC: arizona-jack: Cleanup logging
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121720.79863-1-hdegoede@redhat.com>
 <20210123121720.79863-2-hdegoede@redhat.com>
 <CAHp75VdOhXMBb9t8GEA3qrjyuRzNSXFZ--QuaVMUAaNh-=DnGA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5aefbd9b-6e98-6cd7-bb98-80df88109a40@redhat.com>
Date:   Sun, 24 Jan 2021 22:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOhXMBb9t8GEA3qrjyuRzNSXFZ--QuaVMUAaNh-=DnGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/21 8:53 PM, Andy Shevchenko wrote:
> On Sat, Jan 23, 2021 at 2:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Cleanup the use of dev_foo functions used for logging:
>>
>> 1. Many of these are unnecessarily split over multiple lines
>> 2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFER
>>    return value
> 
> ...
> 
>>                 if (IS_ERR(info->micd_pol_gpio)) {
>>                         ret = PTR_ERR(info->micd_pol_gpio);
>> -                       dev_err(arizona->dev,
>> -                               "Failed to get microphone polarity GPIO: %d\n",
>> -                               ret);
>> +                       dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");
>>                         return ret;
>>                 }
> 
> I still think that using dev_err_probe() naturally, i.e. as a part of
> the return statement is better.

Just because it can be used that way does not mean that it must be used that way.

More importantly I don't think that this small tihng is worth doing a v5 of
this large series for. But if a v5 is necessary for other reasons,
then I'll change this into:

 return dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");

Regards,

Hans

