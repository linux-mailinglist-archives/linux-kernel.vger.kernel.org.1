Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697CB2B98C1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgKSQ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKSQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:57:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:57:58 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so7137425wrc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VgsP72To0S6P6LjSFrFEu/q6VWFU/2fLtO7eA/BuD/w=;
        b=VPkHqNszemyXCM0oDcC7/lAhEeKaZgYrJZibfeTl3naGFT9IowbR00MRnBpwcfFZhU
         4TLRwEWBcOEZhCIvPtlfp7E6lP8oPrHAOabwGmFa3qBo7wBOezo/YOoVvX6ijSC5Siwu
         SHbQGDF6aoQ2XwJdHnskC/FTnGLezn3z0SVFmvsg649IXc2qxUyuTKOjZAsuW40dvvkV
         NICWYN5qDNALrUFb8S7JiCzQRdP4F7vhf1oYoU94k2PthOFrI9a8sTT6Wdi/nZNX/YaU
         kyOo+NeRhLoI/KlPSCnGSbczcX/4cN+V4aZ+u2wBOu9vHYO7loH2PQvmZflYrWEQkJ6q
         HxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VgsP72To0S6P6LjSFrFEu/q6VWFU/2fLtO7eA/BuD/w=;
        b=ll4gA5bnASEG/Oa1tODaH3kRK7lsj0dyHru+K4WOR8JDW5Cwarm84M+P/LphcR5yhV
         DgvpFIjtKK3AzHR/32zj3kQdHuQ4pKSheJhoYWXe24XcFW4mTAr7+VEAmQmX72KAUA8t
         XSb8XHRWYTs82wasE62+8qbay2tPPVu97P0a595oqaVKyuVhM5W1n3Y9BdV9hVD12B3t
         nh1lKupPyPvOU2NuhagDEYvzIsh2AfJmZsZi8h3hRtnyraOY7tQJym7DVKqemZiEY4mo
         Qm2K1aC+fTJQEiwtd9S+LslK3eA1RIGE5hxin2AUrXrMfWorvK1m4AKhrIk1nkfj+4gO
         wRVA==
X-Gm-Message-State: AOAM531+YzRgvCSAX60KHgiQuqa8rzNTbw9jkGf0uldlxPONByvh0kPJ
        IkvKpBYFlVVzGExpNT+YsMC2/3gMASwvGQ==
X-Google-Smtp-Source: ABdhPJxFRTadoCh/KqHF4beIbXuQHmlWJGUdLaeEodpn85xuPN0Q+98c4lqYkrsTJoRkBOBrbi25vg==
X-Received: by 2002:adf:dd08:: with SMTP id a8mr11266161wrm.344.1605805075463;
        Thu, 19 Nov 2020 08:57:55 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id c4sm744705wrd.30.2020.11.19.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:57:54 -0800 (PST)
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
 <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
 <20201117123741.GH1869941@dell>
 <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
 <20201117160501.GJ1869941@dell>
 <CAK8P3a3mPQzDr3gzdKAoWKLVKDzysfTvJuFNKR7FM7NWLZ0dDg@mail.gmail.com>
 <42e50578-c122-e23b-f21f-c4723d008333@gmail.com>
 <20201119083213.GV1869941@dell>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <49006f32-bf85-8d1c-67ac-07e3b3b195b3@gmail.com>
Date:   Thu, 19 Nov 2020 17:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119083213.GV1869941@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2020 09:32, Lee Jones wrote:
> On Wed, 18 Nov 2020, Matthias Brugger wrote:
> 
>>
>>
>> On 17/11/2020 17:40, Arnd Bergmann wrote:
>>> On Tue, Nov 17, 2020 at 5:07 PM Lee Jones <lee.jones@linaro.org> wrote:
>>>> On Tue, 17 Nov 2020, Matthias Brugger wrote:
>>>>> On 17/11/2020 13:37, Lee Jones wrote:
>>>>>> On Tue, 17 Nov 2020, Matthias Brugger wrote:
>>>>>
>>>>> If you want to go the route for me rebasing my tree on top of for-mfd-next
>>>>> then I'd like to have at least a stable tag, so that it will be easier to
>>>>> provide the pull-request later on. Would that be a compromise?
>>>>
>>>> I don't usually provide immutable branches/tags unless I'm sharing
>>>> topic branches for other maintainers to pick-up, in order to avoid
>>>> merge conflicts.
>>>
>>> I think that's what Matthias is planning to do though. If he wants
>>> to send me a Mediatek specific branch for the soc tree, it needs to
>>> be based on a stable commit in the mtd tree to avoid duplicating
>>> the commit.
>>>
>>
>> Exactly, I'm the maintainer of MediaTek SoCs and I would need to pull this
>> patch into my tree to be able to accept the series I mentioned [1]. Can you
>> provide me a stable tag/branch, against just that patch or against your
>> whole tree?
> 
> Oh, I see.  I thought you wanted to develop on top of it.  Apologies.
> 
> PR to follow (I'll reply directly to the patch).
> 

No problems. Thanks a lot!

Matthias
