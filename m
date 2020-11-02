Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B482A2FDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgKBQbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:31:23 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3710C0617A6;
        Mon,  2 Nov 2020 08:31:22 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b9so4766310edu.10;
        Mon, 02 Nov 2020 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p2fcTDg/av4TCztE3uRH2/liGORQajJn+isGnpmMdBU=;
        b=kY5mbNmx5yYsUCy667eOxt3+IdZsjVD9gKrFGNoy2hqgQalZQTs3AeSk3vWJ5kQ2JN
         Atd1Tu//NE2Y4wDfZTpy99zYc+8UhHBP03uRgZhDOzKBqz+0U3GSi2IATShIfo2BRUdT
         ItzlZJ41MdCQUOf8LlN7ui9eSmjaeYJZkHfcBrEQUmIxesPKW9udwp2hwwFr5c2sfhUO
         w7otYYN49qCn3xTYxBFIDHRdBCywzIOMGL9RQBQOs/99bFeaG+gaVEznCwid33k9DfiV
         xGBzhP1xoifpkUj7MqIkdMy3LnoJqcxbmVX0Pc3WsbbvE/hgCYyGB+zThFVjMcCozSqZ
         r7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p2fcTDg/av4TCztE3uRH2/liGORQajJn+isGnpmMdBU=;
        b=GQ5COLeSdgfVW4+0RAgg3DI/wtBWW1inN36Ht8AaRDF/u35WeiupvoKtAIsOXvWR32
         br/zDKOj+9Zcu0A/I/Mfxabz3htdPArcNZcL9DfCdHtNNVw+8zsleXAEPmgKXIQXMUrM
         GBi3fTAsgzaBrnGPD3RR2P76moIwcW8zED5aLEKCtfpYv47QFGZ5890XFPJ2csRSeYsP
         2ENufGykMAtUns2d1Om1+U8z/es5q78oG5Stv+5przs+8lpNEvubRp7oVPvqELbIaHo4
         irdMByvPyflDchqndZctsll1vt64VHWil1AxLa36FQ2pG1Y9ryLOMbTOsjbEByTYBwec
         h4yQ==
X-Gm-Message-State: AOAM533nl2JVPK5lwvENHvKBT05iBOwpdEL3w0rwpxRd7nlnzzXY7TeG
        q3yZOdr6gApx7P7OYHSDsa0uIpMD1OwWdg==
X-Google-Smtp-Source: ABdhPJz5SCEMJfRJkGN5UBh8LBj3bCYDuwePlFY7wzirzd964nNtuX6Oo4fBvx6TOeQNE5GdH/PtxQ==
X-Received: by 2002:aa7:d709:: with SMTP id t9mr2388615edq.305.1604334681706;
        Mon, 02 Nov 2020 08:31:21 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id rl1sm9752463ejb.36.2020.11.02.08.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:31:20 -0800 (PST)
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
From:   Johan Jonker <jbx6244@gmail.com>
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
Message-ID: <803e291f-67e0-f66c-6c9e-041db1b3847c@gmail.com>
Date:   Mon, 2 Nov 2020 17:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5ad70fa0-05a9-e1e7-32cc-32933ff25ae9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 2:11 PM, Johan Jonker wrote:
> Hi,
> 
> On 11/2/20 2:07 PM, Miquel Raynal wrote:
>> Hi Johan, Yifeng
>>
>> Johan Jonker <jbx6244@gmail.com> wrote on Mon, 2 Nov 2020 13:57:56
>> +0100:
>>
>>> Hi Yifeng,
>>>
>>> Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
>>> will not be noted by the MTD frame work or userspace. I think there's
>>> currently no way to let the user know that a different ECC must be used.
>>> Neither can the user set ECC on the fly.
>>>
>>> Example R/W flow:
>>>
>>>         nand_select_target()
>>> 	chip->ecc.write_page_raw()
>>> 	chip->ecc.write_page()
>>>
>>> [..]
>>>
>>> 	chip->ecc.read_page_raw()
>>> 	chip->ecc.read_page()
>>>         nand_deselect_target()
>>>
>>> A write/read with:
>>>
>>> rk_nfc_read_page_hwecc()
>>> rk_nfc_write_page_hwecc()
>>>
>>> or
>>>
>>> rk_nfc_read_page_raw()
>>> rk_nfc_write_page_raw()
>>>
>>> must end up with the same result. If we can't archive that, then we
>>> shouldn't offer RAW mode to the user for now. If Miquel agrees you
>>> should just get the driver ready now without these 2 functions and round
>>> things up.
>>
>> What about just not supporting the BootROM area if it was marked
>> "reserved" by the BRom in the DT?
> 
> Should we just fill the buffers with '0xff' for boot blocks?

(part 2) ;)
My fault....
Better use:

    if ((chip->options & NAND_IS_BOOT_MEDIUM) &&
        (page < (pages_per_blk * rknand->boot_blks))) {

	return -EIO;

    }


> 
>>
>> Raw accessors is really a nice and basic feature that I would like to
>> have in every new driver.
>>
>> Thanks,
>> Miquèl
>>
> 

