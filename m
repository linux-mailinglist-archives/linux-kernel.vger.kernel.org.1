Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60F300F26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbhAVVqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729722AbhAVVee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611351184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvWX/CFGSihQRjsLbay3juv/HcaiKfTaRyJu5DpVCsw=;
        b=E7zMwF2kvRbwV4Gt0AR1E44Pksh/huxiSCe9TFdmjWoAj59K2o+/tq5aiZj8ToGJgz0ViH
        Z6TDIYGHSKmCx54ZTN8hWge5HfM3PhTX0VCB86FMsajKXxQGYaWvgh12S1qv0mGY8cKiup
        5NgBefhs84Tym0EIvcA7cn4OzL89CZo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-sMWXEHl1PTWdCjngopEVGQ-1; Fri, 22 Jan 2021 16:33:03 -0500
X-MC-Unique: sMWXEHl1PTWdCjngopEVGQ-1
Received: by mail-ej1-f70.google.com with SMTP id f26so2728416ejy.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvWX/CFGSihQRjsLbay3juv/HcaiKfTaRyJu5DpVCsw=;
        b=rRbYlueZV7CQrLVSeT5ijqI+KvT20xcYTj760KLVYP9CnSMuX/ktIdKwJFpN5E9GP8
         1U5Vb7GHTHQuPqa5QwbW/Ou9H1ofJO/UpZj3io2amGIVfjoo5k3gWgW3bjQ96p8+Ra4L
         vi0h8bfD1cTznuLhhB6IXi1WvF/GOzyBWz0yud6BKcTeqDtvgqFS7lGvy56kzWEnqR3y
         1fNzLnH3rfX3VhWUaSj3aSjAooQxhC+d+gIgbTl9rJmsrIYauKDAg38AH6GPOxQRQPOH
         fYX3NXQMlwhTWi7WQyEs119CFVbQPUeyMt2vOJHuOTSypbbSyo7RYi6s6q1FPWpMKeUq
         XyLg==
X-Gm-Message-State: AOAM5338duag+HTHlpk+sm2Btgi3HZkGzsnQA/WL/77ZpK8CLM5kQPqi
        /JY1bxegNOUh8SOmxi4JMFBDNGdCiQFxvPHtOhBX+8KDn9ABH+JtXqIgeLkFKaIC5h/nhTwxwsg
        xi9cty9RZMGYD0YWv2ZvNHMYY
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr4441166ejn.214.1611351182008;
        Fri, 22 Jan 2021 13:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/FeHvpIwV/TbzHI/VBnHx0waeIY6CaKZcDNGJy7Ojizzfy6JS0vUHdP2Yo/HYZkvjr+TuSw==
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr4441148ejn.214.1611351181816;
        Fri, 22 Jan 2021 13:33:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id cf26sm2826989edb.14.2021.01.22.13.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 13:33:01 -0800 (PST)
Subject: Re: [PATCH v3 11/13] ASoC: arizona-jack: Cleanup logging
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
References: <20210122164107.361939-1-hdegoede@redhat.com>
 <20210122164107.361939-12-hdegoede@redhat.com>
 <CAHp75VcP6NXn8gAze3B=b1m2sRZnrV=dL456D0QAGzON21etFQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e5742738-dd83-e1df-1789-ab75761d7600@redhat.com>
Date:   Fri, 22 Jan 2021 22:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcP6NXn8gAze3B=b1m2sRZnrV=dL456D0QAGzON21etFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 1/22/21 9:56 PM, Andy Shevchenko wrote:
> On Fri, Jan 22, 2021 at 6:41 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Cleanup the use of dev_foo functions used for logging:
>>
>> 1. Many of these are unnecessarily split over multiple lines
>> 2. Use dev_err_probe() in cases where we might get a -EPROBE_DEFERRED
> 
> s/RED$//

Ack, will fix for v4.


>>    return value
> 
> ...
> 
>> +               if (ret != 0)
> 
> Since you are touching it if (ret) would work already. Ditto for the
> similar cases below.

Ack.

> ...
> 
>>         if (IS_ERR(info->micvdd)) {
>>                 ret = PTR_ERR(info->micvdd);
>> -               dev_err(arizona->dev, "Failed to get MICVDD: %d\n", ret);
>> +               dev_err_probe(arizona->dev, ret, "getting MICVDD\n");
>>                 return ret;
>>         }
> 
> Seems like your first dev_err_probe use :-)

Erm, nope. I did this on purpose.

> Can be even more optimized, i.e.
> 
>   if (IS_ERR(info->micvdd))
>     return dev_err_probe(arizona->dev, PTR_ERR(info->micvdd), "getting
> MICVDD\n");

Ok, so that works here, but I deliberately kept it as is because it does
not work below and I wanted to be consistent.

On second thought. That is not really a good reason, so I've
made this a 1-lines as you suggest for v4.

> 
> ...
> 
>>                 if (IS_ERR(info->micd_pol_gpio)) {
>>                         ret = PTR_ERR(info->micd_pol_gpio);
>> -                       dev_err(arizona->dev,
>> -                               "Failed to get microphone polarity GPIO: %d\n",
>> -                               ret);
>> +                       dev_err_probe(arizona->dev, ret, "getting microphone polarity GPIO\n");

This new line is 96 chars as-is if I turn this into a one-liner it goes significantly
over the 100 chars line-length limit.

So I've kept this as is for v4.

Regards,

Hans

