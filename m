Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53D73004A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAVN63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:58:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbhAVN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611323813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JI98cuo61T5iHBclSh2mvvuL/8A1Wnp+VCQzU86Xq28=;
        b=ZwbRgzgB1K0x4+Ieok0UceUuJICDu+OD3Dw5AUp2cNhT3sEtcaYjsWzPw9xi8wMKDIwtGR
        RxANDSVDgPMqG050uqnBv9J88/dpDL8G4+54lIovIWa/7MjQyoGbYfwsXtbQP90XPd6gGB
        8zzV/h8SV/p3zcmltUMJmKb+VcOy3U4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-_Nu6a2TpMP-qH5TGUWyQIw-1; Fri, 22 Jan 2021 08:56:50 -0500
X-MC-Unique: _Nu6a2TpMP-qH5TGUWyQIw-1
Received: by mail-ed1-f69.google.com with SMTP id j11so2184580edy.20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JI98cuo61T5iHBclSh2mvvuL/8A1Wnp+VCQzU86Xq28=;
        b=Vt0a04RNZA8pQFFsK5XRR/EcPfCK1BQidA7Jg4NSZutFeCrjQTBUGMvgxfe2eeO/Ly
         GfV/Nq+HwzXbUrYs9z6iMTmj1pu9wzp+8pgRxFJVmd5gC7ZLf4YwY9bQ+tSkx2Owy0w7
         obRe6qE5QS9xO6+flzB2Fd+KZIDiADkzWyslOSKIdSVh/FwDemoqkkkfQXYEOSMVl54f
         r/sAL+JTEcVwLSpNwYoiDdss5rbFwF1e7feGqXi0TF+GehaPJXs1seofw7+CMZcQhdV7
         A8gto+xJ5QA3rQa2HwNNqp+nKYejQDSBDyjP5tccIlNSnli5tyQ8vkngJcSYppxu6rKg
         irxw==
X-Gm-Message-State: AOAM532wTGaMuz5wM75DJdAjzta1YimkXzG0VW/JGX1/xOEWfJiffXli
        4TMmvVmG4Dju7FFwW2pmSvrDhjRepbRvUzbjeEhewx35Q/HpzqxZEcETVOoqrmBv+/N4NrTGTm1
        XKWqKwHVP4UfWzcE377MFmtyz
X-Received: by 2002:aa7:c849:: with SMTP id g9mr3255648edt.48.1611323809052;
        Fri, 22 Jan 2021 05:56:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl0clI+ZXuFxo9o1ewV0yt3mNz3W5XcEpO5OutifVV+ErUWOcrs1ovRdHSTzcsjcZByzZNCg==
X-Received: by 2002:aa7:c849:: with SMTP id g9mr3255644edt.48.1611323808938;
        Fri, 22 Jan 2021 05:56:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id e19sm5421577eds.79.2021.01.22.05.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 05:56:48 -0800 (PST)
Subject: Re: [PATCH v2 07/12] ASoC: arizona-jack: Use arizona->dev for
 runtime-pm
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
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-8-hdegoede@redhat.com>
 <CAHp75Vc92WoJm5T1jbF7UUjCNrVZr2as8ccEWxCZ9aP7z+ZyLA@mail.gmail.com>
 <d0189116-d110-f91a-afd9-70f323833e32@redhat.com>
 <CAHp75Vdzqx0XyykL8wxwxRNk=kBMHmUKDGXJQQtdhT_1CCa4_w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5c20be27-b083-0303-f29f-4ce8502178d3@redhat.com>
Date:   Fri, 22 Jan 2021 14:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdzqx0XyykL8wxwxRNk=kBMHmUKDGXJQQtdhT_1CCa4_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/21 10:38 AM, Andy Shevchenko wrote:
> On Fri, Jan 22, 2021 at 2:03 AM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 1/18/21 1:02 PM, Andy Shevchenko wrote:
>>> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>> Can you elaborate switchings from get() to get_sync() in few places
>>
>> Sorry, those 2 changes really should have been in a separate commit.
>> I've put the 2 get -> get_sync() changed in their own commit now
>> with the following commit-msg:
>>
>> """
>> extcon: arizona: Always use pm_runtime_get_sync() when we need the device to be awake
>>
>> Before this commit the extcon-arizona code was mixing pm_runtime_get()
>> and pm_runtime_get_sync() in different places. In all cases where
>> either function is called we make use of the device immediately
> 
> called and we

That changes the meaning of the sentence in ways which does not match
my intent. I've changed this to:

"""
In all cases where pm_runtime_get[_sync]() is called, the code
makes use of the device immediately after the call.
This means that we should always use pm_runtime_get_sync().
"""

Regards,

Hans

