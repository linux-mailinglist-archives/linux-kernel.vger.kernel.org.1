Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EEF2DBD74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLPJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbgLPJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608110485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=95kYYHdF7tbuazCEyR7ifHABrdX2cTEKUmvLOcIl4M4=;
        b=DnfYUSuMYq/5ZCZmZAQdM+qWccq/SL09ool0UieH2xfVRv7/XH+JTW100n/Nu8zGpFeIxc
        cW5ONrsGqUPr8CaJtSYmy7yjjG0M2TCc0l4TC3oFagmhkmiXh/7q+eUqoB4FhJK2BXJncj
        B6RHw31S/ee+eOmbEYytW0igm2UQyIE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-8BU2xI_JNP2Un4FclR4qnA-1; Wed, 16 Dec 2020 04:21:23 -0500
X-MC-Unique: 8BU2xI_JNP2Un4FclR4qnA-1
Received: by mail-ed1-f70.google.com with SMTP id g25so11430289edu.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95kYYHdF7tbuazCEyR7ifHABrdX2cTEKUmvLOcIl4M4=;
        b=TBH35NnzoLBn5QBiwDXriM5skfx2yWwehTtvvPsiC7zG/cCfKm8FOQV8td9EuMVyT6
         VC0m3Cdg7iBHOz5nsiyU36ReCDQUSBJtaAaiMc7UwQ+UNTBBbqspc6Xk6zjZ9TwqwSLi
         93TBrnVmk2DD2BELRJXsWsjG2QRhRNTkZL+ff+e3cuXA6ptSAwWQvwWfs0vDZeSBxRhA
         Z9ul5VeP1e+nuS8XlSjhGXkDDz3agHfoteP8rN24XZ44T7l7GvLiV3ZwPQQZMyQuK75F
         J+PtRuqsf54RGkjTg60NpIYVOigiFYCC2Ds6ho02V4LQzekzo7Wrzy3no+bMILCsfV+d
         Hm8g==
X-Gm-Message-State: AOAM532oLSE7VrxzQ2XjhMW6MaCuo63TY0CuwB9EzDpIua8zsafr5sV5
        Dpdf6JcSrSdcvqh1IGw5yLKeupPJEx9553TUMjU4cn4NeKZixRaQnxJSFTZyyLVIu2WkDsj/lA4
        mPf0ZkmlsQwJxg5LAwqLubyJ40r4rfPekPE+8Z9Q7Utv2h81DnlOrm2b1naQ6dviRk7N41T2D09
        TW
X-Received: by 2002:a17:906:edd1:: with SMTP id sb17mr29625970ejb.118.1608110482382;
        Wed, 16 Dec 2020 01:21:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPl9vRNS46IusutfIHF0aRM43sgaWmPQp10m5prjhTFktaVV3lrQt8mLX56NUjFj3QL3KjEw==
X-Received: by 2002:a17:906:edd1:: with SMTP id sb17mr29625948ejb.118.1608110482139;
        Wed, 16 Dec 2020 01:21:22 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ot18sm932007ejb.54.2020.12.16.01.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 01:21:21 -0800 (PST)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.11-1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
 <CAHk-=wiMs5Q9VwEP_gfGmUR3R+_xDRA5pprbgznaFuq48pY+wQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c24d791c-1f2f-7f94-84cd-450cbdba6ce3@redhat.com>
Date:   Wed, 16 Dec 2020 10:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiMs5Q9VwEP_gfGmUR3R+_xDRA5pprbgznaFuq48pY+wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/20 1:17 AM, Linus Torvalds wrote:
> On Mon, Dec 14, 2020 at 4:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> - New Intel PMT telemetry and crashlog drivers
> 
> These have _very_ annoying Kconfig setups.
> 
> First it asks about INTEL_PMT support.
> 
> If you say no, it then asks about INTEL_PMT_CLASS, INTEL_PMT_TELEMETRY
> and INTEL_PMT_CRASHLOG support.

Yeah that is bad, sorry for not spotting that (I answer M/Y everywhere
so that I at least compile test everything).

> I've pulled this,

Thanks.

> but I really wish the PMT support understood that
> whole "No means no" thing.

Agreed. I will make sure to get a fix to you for this sometime
during the 5.11 cycle.

Alexander and/or David I believe that the best solution for this
would be to replace the:

        select INTEL_PMT_CLASS

In the INTEL_PMT_TELEMETRY and INTEL_PMT_CRASHLOG Kconfig entries
with "depends on". Also as a general comment for the future, select
should typically be used with non-user-selectable options. E.g.
you could also have made INTEL_PMT_CLASS non-user-selectable by
changing:

config INTEL_PMT_CLASS
        tristate "Intel Platform Monitoring Technology (PMT) Class driver"

To:

config INTEL_PMT_CLASS
        tristate

Having both INTEL_PMT_CLASS user-selectable and using select on
it is bad. I believe that in this case changing the 2 "select"-s
to "depend on"-s is best.

Regards,

Hans

