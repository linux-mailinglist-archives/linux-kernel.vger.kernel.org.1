Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDA2E83D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 14:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhAAN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 08:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727005AbhAAN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 08:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609507479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NlUf3RFrTX25sJTt0DKiuNwG0dF3j8VQJM9/nMs04SU=;
        b=WgYUE9OT9xoy6yeFdIlkqZtni9/iNJ4hCGuJ+JdNP3p91nuK2NlFTsuGGC/8vYXpuPy/Bk
        GWn3JMuzXNGdjHQQBjhLE6+JdCjNQyKkH08X0nG5yTI1UDSDwJT659G78Ec5vdrH+Jd+fG
        sNFDdGOHZS80CJBQFF5rQ8vAO+aPqDk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-qNX_sdWDMZabIIQnAdrG-g-1; Fri, 01 Jan 2021 08:24:37 -0500
X-MC-Unique: qNX_sdWDMZabIIQnAdrG-g-1
Received: by mail-ed1-f69.google.com with SMTP id dh21so8250231edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jan 2021 05:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NlUf3RFrTX25sJTt0DKiuNwG0dF3j8VQJM9/nMs04SU=;
        b=DTsIkCaP9eU9TzFNzrHs2tTSE4GmrKgwCEXKgothcNXbmFDDrO6pkxjgoRvaIuy6dB
         ozRPL6N16V8XYJ0D6ue3VjKoeJRENz34EeEE6Ql2yGeUa1CCuyiDYawoKNNwOf2RAOkE
         G4wUcSh9htDYVipEJ+AoIrByZJLFuo8Dy4JAB5Lu4EwOWKLp4bhUdwOOblroV08S34UJ
         TWwjpv7Qkccz1k/YFy9QVeqWki/n/cpdeDHL4C3pRVQFeVeYV6yYlCd1nM57mokjSoOg
         WTWhqZF0+6VBJym3gdCvf/TckepEpRhJzT8x+ehJwB46AZvgkE4Cwoq8NjZuYcTZAlaQ
         GCiw==
X-Gm-Message-State: AOAM532YszUMr8l4RBMhxzyNgP8563QXPvMh1Me3Vu2/BbNvKpu83kur
        YRTwMmBJbGV9mXZTY1VAoRyCWqH4exZsDkZ7yegPMSTCDTxYs3hO36BgT5QPSK888rH8Pb8A8iy
        78A+GLNnh2JysOVA+JhnaEfk+
X-Received: by 2002:a17:906:2c54:: with SMTP id f20mr57560680ejh.318.1609507476425;
        Fri, 01 Jan 2021 05:24:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOkcdqEPEYFudNaC7S3egmI6FCqsKLaZbnzjTvYAnMq7f7U8r4OTu9efaWXmITnAXsrwDSCQ==
X-Received: by 2002:a17:906:2c54:: with SMTP id f20mr57560669ejh.318.1609507476213;
        Fri, 01 Jan 2021 05:24:36 -0800 (PST)
Received: from x1.localdomain ([185.200.132.250])
        by smtp.gmail.com with ESMTPSA id r23sm20864486ejd.56.2021.01.01.05.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 05:24:35 -0800 (PST)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150807.GF4786@sirena.org.uk>
 <07037a8a-1d35-362e-1b82-b73b81f7c6ac@redhat.com>
 <20201230133803.GC4428@sirena.org.uk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fca91ed2-408b-bb31-f6e8-4391f06b0ccc@redhat.com>
Date:   Fri, 1 Jan 2021 14:24:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201230133803.GC4428@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/30/20 2:38 PM, Mark Brown wrote:
> On Tue, Dec 29, 2020 at 04:33:09PM +0100, Hans de Goede wrote:
>> On 12/29/20 4:08 PM, Mark Brown wrote:

<snip>
 
>>> The whole purpose of creating sound/core/jack.c is to abstract away the
>>> userspace interfaces from the drivers, most audio devices shouldn't be
>>> working with extcon directly just as they shouldn't be creating input
>>> devices or ALSA controls directly.  The missing bit there is to add
>>> extcon into jack.c.
> 
>> So what you are suggesting is making sound/core/jack.c register the
>> extcon device and then have arizona-extcon.c talk to sound/core/jack.c
>> and no longer do any extcon stuff itself.
> 
> Yes.

Ok, so this seems to be the same solution as which the opensource.cirrus.com
folks want in that both you and the opensource.cirrus.com people want to
change the arizona-extcon.c driver to be changed to stop reporting extcon
info directly itself and instead do all the reporting through sound/core/jack.c.

Where the thoughts on this seem to differ is that the opensource.cirrus.com
folks seem to be fine with dropping extcon support, where as you suggest
to extend sound/core/jack.c to register an extcon device and have it report
extcon events.

I'm with the opensource.cirrus.com folks here that ATM it seems best to just
drop extcon support since the only user is Android, which also supports the
input_dev API.

If the need arises we can always add extcon-support to sound/core/jack.c
later.

So I'll start on reworking this patch-series to change the arizona-extcon.c
driver to stop it reporting extcon info directly itself and instead do all
the reporting through sound/core/jack.c.

Regards,

Hans

