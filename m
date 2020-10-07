Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEF2865F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgJGRaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgJGRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602091821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mn8qhkF/UQEJzqV3x7unCgeZITrfss35bxaFGr6YI30=;
        b=TTNsOeRynSbjyfUb0zUCx5c/Y5bZs+QhwFxzMTrYwWzoh/CZxRyrzjuOCL4OJT0FDUVpBk
        uqfwRDjr1v4NrkmyoREW6hdiapnD31VnQc7HGv0wZNL/yMuQS59PcguYRtDgfpl7c3HCbX
        waxuz0HhfMlyCZl27M8Umv95rRYmxFE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-O5i6Vr24MIWKzO8XF_31zQ-1; Wed, 07 Oct 2020 13:30:19 -0400
X-MC-Unique: O5i6Vr24MIWKzO8XF_31zQ-1
Received: by mail-ej1-f71.google.com with SMTP id c10so1078592ejm.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mn8qhkF/UQEJzqV3x7unCgeZITrfss35bxaFGr6YI30=;
        b=a8lQ+a8nuiY3kWCgW2MISWkg/gPQNe6h3qsdp8ZIlDO/x9xcvTHodVt8aL/j15yfiB
         JwG4PzmygmBl9r1rK2RUP6ZrE9Qr97kq4UfFPoTCEf6WGlBk9MfLvpoD7hmR4zWEIOED
         Y+kkBiORTg4f5RZ4CAhUPAPsT7re1xcJqWb2YCr2PFBZ3trRIefLCFsG9p4ssVV+XNBt
         9Hg2UmETG+E5FU8VdhIeHZ2gxscWwNHRfyu8mVs6v17qco0CypUb7bFyf9ROnPhrck8L
         WNRAskxQYqvUohOskJnkzCX7rVySFqu0p2RSHsaS7gtKcg0mEx3TGGby3twkD+r87J7L
         +hIA==
X-Gm-Message-State: AOAM5314lhO61YTNk+AS+7TOl1yNqAKsIOu4oOC24msasP6yuyF2afDj
        S+kY9/dGMjLGO6wdFvGk1+lz2DIcGSh2U53QkBLYHpYOnOW3O8I1RKfeL0vnepvfCPsLc/25FAY
        0w2LbURGYCBG0X5rLXVGguMzb
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr4618272edb.127.1602091818265;
        Wed, 07 Oct 2020 10:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjJHPa3INkuheoMTk446PsJmwdW/gSEDi1ZRRxEU+gBCBe4Nr92QxJI6odQucdV4YA52cmPg==
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr4618253edb.127.1602091818075;
        Wed, 07 Oct 2020 10:30:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id bt16sm1950049ejb.89.2020.10.07.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 10:30:16 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: hp-wmi: add support for thermal policy
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Elia Devito <eliadevito@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200917214957.GD29136@mtg-dev.jf.intel.com>
 <20201004211305.11628-1-eliadevito@gmail.com>
 <CAHp75VfbK226a-SsNj=Bnpfc3wWyT9K_D4XzAMOu9of1_g+8-A@mail.gmail.com>
 <5d60709b-e3cb-685f-2b3e-07381b9855e5@redhat.com>
 <zm1oBveg0S9L-MagzWnleGj5ZfQg8cV95Ugbzz6WZbnv-nzpF8_9Fghwj8P8V-ZAmVF6kRBWF-blVcOFirhSN3xxmE_8cOUycONWZMJP5xE=@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <37a0a8b8-6792-8ed7-2e66-da0fa1d6302a@redhat.com>
Date:   Wed, 7 Oct 2020 19:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <zm1oBveg0S9L-MagzWnleGj5ZfQg8cV95Ugbzz6WZbnv-nzpF8_9Fghwj8P8V-ZAmVF6kRBWF-blVcOFirhSN3xxmE_8cOUycONWZMJP5xE=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 6:21 PM, Barnabás Pőcze wrote:
> Hi
> 
> 2020. október 7., szerda 16:02 keltezéssel, Hans de Goede írta:
>> [...]
>> Elia, Thank you for your patch, I've applied this patch to me review-hans branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>> [...]
> 
> I don't know if the problem is on my end, but opening that url
> results in an "Invalid branch: review-hans" error.

Since I'm just getting up2speed in my new role today, I have never pushed
that branch out yet, hence the error.

I've pushed it out now, the mirrors which actually serve
the http interface can lag a bit, so give it 10 minutes and
then it should be there.

Regards,

Hans

