Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAA2A3105
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKBRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgKBRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:11:56 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0137C0617A6;
        Mon,  2 Nov 2020 09:11:55 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id w1so13980201edv.11;
        Mon, 02 Nov 2020 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UDsVWn4E2MasI/jljtk38Wk49KhSUU+c+WkmrZoymUA=;
        b=JdryO2LBa69B5Z1yfJ8xP1QMzeLwOBKBVduKKsX5ZfldhdqNSFevqa/l0+6rw0tb8p
         z328dJrsyHglYerX+8jGqgRYmjT2MJvlKwThlkQsQCvptHSbLajvph/JJJOl7UPIVCzQ
         69qHNZfloYeV++cOSiWnR+Uw4wLRJF3sd4bPEURUW+04pMxYxjGwV/G4n85BlAsxDINp
         bSJRXgcVsWMhbWPL1HN63C5zSBzUBqci3cru3Ttt4yQ0FfMTDOEMyneQDz3rOIlzMwuh
         7iwXhrJ4no+e6rzywAK+Bt5Q1loZ5WvYCkxjuHYE0tlUfQY0EbE0IporoD40c5b2tMw8
         /jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UDsVWn4E2MasI/jljtk38Wk49KhSUU+c+WkmrZoymUA=;
        b=Kd2ZI/lqWHR4BQyVckWDAav3CFJxS3O7hDmYkVZ/EAmzyDB1XgSeQUM4xTGq8QJF3K
         c8Dgi+378BXiv3jcbPzFLCw3PKtBFg15YpP6NXViCZcVl2CShmiVq3xrNGTgX3QbE2tl
         kHb5aAv4jsneM5ibGh9b4/hi9NcjqIWIJncjpeEBqfnO1MmPGYWNtZwd+NuekLUQhk6A
         /r+7jeAyafQG1SsLTy/atXyGmhMk/7Nc4Hvh8HSvlYhW7gF/GV5tNziNzZj9Sc7vVk5L
         Ro6uzmuMQgtumHED+pgDAsk4k96kACDLJvv6Id2lDDQFTDNvn3XaoqG2GNgYcHlu9V9+
         Maxg==
X-Gm-Message-State: AOAM530jAy8VnvXcME+QvC5MI59gemZezQ1DBsl25a8/2OeVWWu/rcFM
        LqHvZN85YR2Zm5xHyVPt+oGS28jnCY9LwA==
X-Google-Smtp-Source: ABdhPJxy8egjrPYM8QyvbDqSYMiE4M0MTlh3z+5zxkzuEWmJX/3AKyXY6VLzEBi4sE0mU7wlirqLHA==
X-Received: by 2002:a05:6402:1d13:: with SMTP id dg19mr17902988edb.217.1604337114670;
        Mon, 02 Nov 2020 09:11:54 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id pw17sm9811284ejb.116.2020.11.02.09.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 09:11:54 -0800 (PST)
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Yifeng <yifeng.zhao@rock-chips.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
 <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
 <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
 <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
 <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
 <20201102140725.66e7dcb1@xps13>
 <5ad70fa0-05a9-e1e7-32cc-32933ff25ae9@gmail.com>
 <803e291f-67e0-f66c-6c9e-041db1b3847c@gmail.com>
 <20201102180039.757d3234@xps13>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <cd349a1f-773d-096a-f0ae-90c5eb847769@gmail.com>
Date:   Mon, 2 Nov 2020 18:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201102180039.757d3234@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 6:00 PM, Miquel Raynal wrote:
> Hi Johan,
> 
> Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 17:31:18
> +0100:
> 
>> On 11/2/20 2:11 PM, Johan Jonker wrote:
>>> Hi,
>>>
>>> On 11/2/20 2:07 PM, Miquel Raynal wrote:
>>>> Hi Johan, Yifeng
>>>>
>>>> Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 13:57:56
>>>> +0100:
>>>>
>>>>> Hi Yifeng,
>>>>>
>>>>> Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
>>>>> will not be noted by the MTD frame work or userspace. I think there's
>>>>> currently no way to let the user know that a different ECC must be used.
>>>>> Neither can the user set ECC on the fly.
>>>>>
>>>>> Example R/W flow:
>>>>>
>>>>>         nand_select_target()
>>>>> 	chip->ecc.write_page_raw()
>>>>> 	chip->ecc.write_page()
>>>>>
>>>>> [..]
>>>>>
>>>>> 	chip->ecc.read_page_raw()
>>>>> 	chip->ecc.read_page()
>>>>>         nand_deselect_target()
>>>>>
>>>>> A write/read with:
>>>>>
>>>>> rk_nfc_read_page_hwecc()
>>>>> rk_nfc_write_page_hwecc()
>>>>>
>>>>> or
>>>>>
>>>>> rk_nfc_read_page_raw()
>>>>> rk_nfc_write_page_raw()
>>>>>
>>>>> must end up with the same result. If we can't archive that, then we
>>>>> shouldn't offer RAW mode to the user for now. If Miquel agrees you
>>>>> should just get the driver ready now without these 2 functions and round
>>>>> things up.
>>>>
>>>> What about just not supporting the BootROM area if it was marked
>>>> "reserved" by the BRom in the DT?
>>>
>>> Should we just fill the buffers with '0xff' for boot blocks?
>>
>> (part 2) ;)
>> My fault....
>> Better use:
>>
>>     if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
>>         (page < (pages_per_blk * rknand->boot_blks))) {
>>
>> 	return -EIO;
>>
>>     }
> 
> Yup, I was about to tell you that I would prefer returning a nice
> error, this is fine I guess.
> 
> Anyway, I think reading bad block markers is done in raw mode, so if
> raw accessors refuse to return valid values for boot blocks, you won't
> be able to access it neither with raw nor corrected hooks.
> 
> Perhaps refusing the access to the regular page access is ok, but maybe
> we should be able to at least read these pages in raw mode
> (and move the BBM to its right location). What do you think?

I think that the problem with asymmetric read and write access is that a
user reads data successful, but that it can't write it back after it's
block is erased. You shouldn't give the illusion that the boot ROM
blocks can be accessed in RAW mode. Something with perception...does
user space known that Rockchip's NFC is special...


> 
> Thanks,
> Miquèl
> 
>>
>>
>>>
>>>>
>>>> Raw accessors is really a nice and basic feature that I would like to
>>>> have in every new driver.
>>>>
>>>> Thanks,
>>>> Miquèl
>>>>
>>>
>>

