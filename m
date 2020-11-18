Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724F12B7FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgKRO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgKRO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:56:51 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CDC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:56:51 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so2439908wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9nBoGTToDjyjN3yrD172aQaUVvgiFN/qCO5NtJVgmDg=;
        b=lZkoeCTOIaeKNitMqjW9ACjCjQpkVTwSrdE0SauMqVjPzUk88ujurZb7iOstN/Jkv0
         Cl98AYhVL33MW5cVCNfnc+LJdabAHa5UknwADeFK7AggGtYIp9bw9qsjNz9wfp5m4paB
         JghqYYLJwh58sJu8EgTgzcsplxWcMNGOcUUl+e0F6toVH6M2B5rVCK/zgSzkX+s0ChZj
         ZgskqUhGDqmBw5YTKDiCad8VaJIlrPK5zk0Qe4mQiR+fSg/ztqYmcHtnpRdxZDeYrRZM
         daMOAywf28el74ulcD61MAa984zTFB9XorgQJfbLkoBWLNp+cyis2jfC354QewVeh85j
         N9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nBoGTToDjyjN3yrD172aQaUVvgiFN/qCO5NtJVgmDg=;
        b=lnxRlw8qkxvYFZV8yQEjbO+B3CdOJoKKdBTXfFSW11LJp+hUlmx6OXMzC/qNAtywEb
         eadEq9CmwXdqiDzcgKUOrTU7GCKyuDcJaX7f7XkYzSlYBYuctwdWbe1IaTk7zY8SDpKp
         RHa5aBZFFmBZVb6Of3TpccEX/hEmXPKc0aprcF44wY6HkI6x2X2Pic6lK8IX7XsnzR3F
         KoMFF9Fjs2SUzaQD25HGixhrBLdvhPew4m5vHYh987VWcQrShMaU4byQmFSf52WQ0UvP
         fVa96ExiHYVRZY0AhhEPy4HYlGP5GGXFrnFaVfVhMWMJlMNqBM23FaLlBI9QV0EDU3b7
         FJDg==
X-Gm-Message-State: AOAM5302S0jzFiN2+CjeXd986PRJTmc4GOd2/OOHp9p97IDfLd/SUrOH
        KrFhpW/+IDLoLYi+mPoxZC0=
X-Google-Smtp-Source: ABdhPJxzBrD0Pz2Vzd9LhWo9qE8AxucFXAe7agPcg7bRrDxCURKSgrP+6C+HO2cuShJZEEzUZb0I/w==
X-Received: by 2002:adf:e789:: with SMTP id n9mr5197556wrm.211.1605711409845;
        Wed, 18 Nov 2020 06:56:49 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o10sm4551685wma.47.2020.11.18.06.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 06:56:48 -0800 (PST)
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
To:     Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <42e50578-c122-e23b-f21f-c4723d008333@gmail.com>
Date:   Wed, 18 Nov 2020 15:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3mPQzDr3gzdKAoWKLVKDzysfTvJuFNKR7FM7NWLZ0dDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2020 17:40, Arnd Bergmann wrote:
> On Tue, Nov 17, 2020 at 5:07 PM Lee Jones <lee.jones@linaro.org> wrote:
>> On Tue, 17 Nov 2020, Matthias Brugger wrote:
>>> On 17/11/2020 13:37, Lee Jones wrote:
>>>> On Tue, 17 Nov 2020, Matthias Brugger wrote:
>>>
>>> If you want to go the route for me rebasing my tree on top of for-mfd-next
>>> then I'd like to have at least a stable tag, so that it will be easier to
>>> provide the pull-request later on. Would that be a compromise?
>>
>> I don't usually provide immutable branches/tags unless I'm sharing
>> topic branches for other maintainers to pick-up, in order to avoid
>> merge conflicts.
> 
> I think that's what Matthias is planning to do though. If he wants
> to send me a Mediatek specific branch for the soc tree, it needs to
> be based on a stable commit in the mtd tree to avoid duplicating
> the commit.
> 

Exactly, I'm the maintainer of MediaTek SoCs and I would need to pull this patch 
into my tree to be able to accept the series I mentioned [1]. Can you provide me 
a stable tag/branch, against just that patch or against your whole tree?

Regards,
Matthias

[1] 
https://lore.kernel.org/linux-mediatek/20201030113622.201188-1-enric.balletbo@collabora.com/ 

